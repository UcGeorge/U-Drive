import 'dart:convert';
import 'dart:io';

import '../../../data/models/server_log.dart';
import '../../classes/api_response.dart';
import '../../classes/client.dart';
import '../../classes/request_handler.dart';
import '../../cubit/authenticator_cubit.dart';
import '../../cubit/server_cubit.dart';
import '../../errors/check.dart';
import '../../errors/exception.dart';

/// [RequestHandler] for handling requests on the `POST /request-access/...` route
class PostRequestAccessHandler extends RequestHandler {
  PostRequestAccessHandler(HttpRequest request,
      AuthenticatorCubit authenticator, ServerCubit serverCubit,
      [RequestHandler? parent])
      : super(request, authenticator, serverCubit, parent);

  @override
  Future<void> handle(HttpRequest request) async {
    await super.handle(request);
    bool valid = await validateRequest(
      request,
      onError: (e) {
        request.response
          ..statusCode = HttpStatus.badRequest
          ..write(ApiResponse.bad(e.message))
          ..close();
      },
    );

    if (!valid) {
      return;
    }

    JsonType jsonType = jsonDecode(body);

    if (authenticator.state.isPublic) {
      Client client = authenticator.addClient(jsonType['name']);
      request.response
        ..statusCode = HttpStatus.created
        ..reasonPhrase = "Access Granted"
        ..write(ApiResponse.good(data: client.toMap()))
        ..close();
      serverCubit.log(NetworkRequestLog(
          "${client.name} requested and was granted access."));
    } else {
      String clientName = jsonType['name'];
      serverCubit.log(NetworkRequestLog("$clientName requested access."));
      await authenticator.requestAccess(clientName, ((client) {
        if (client != null) {
          serverCubit
              .log(ServerMessageLog("${client.name} was granted access."));
          request.response
            ..statusCode = HttpStatus.created
            ..reasonPhrase = "Access Granted"
            ..write(ApiResponse.good(data: client.toMap()))
            ..close();
        } else {
          serverCubit.log(WarningServerLog("$clientName was denied access."));
          request.response
            ..statusCode = HttpStatus.unauthorized
            ..reasonPhrase = "Access Denied"
            ..write(ApiResponse.bad('The server admin denied your request.'))
            ..close();
        }
      }));
    }
  }

  @override
  Future<bool> validateRequest(HttpRequest request,
      {required ErrorCallback onError}) async {
    List<String> pathSegments = request.uri.pathSegments;
    try {
      check(
        pathSegments.length == 1,
        "Invalid route information",
        exceptionType: ApiExceptionType.invalidRouteException,
      );
      check(
        !request.uri.hasQuery,
        'This endpoint has no queries',
        exceptionType: ApiExceptionType.badRequestException,
      );
      check(
        body.isNotEmpty,
        'Request is missing a body',
        exceptionType: ApiExceptionType.badRequestException,
      );

      Set<String> requiredFields = {'name'};
      try {
        JsonType jsonBody = jsonDecode(body);
        check(
          jsonBody.keys.toSet().intersection(requiredFields).length ==
              requiredFields.length,
          'Required Fields: $requiredFields',
          exceptionType: ApiExceptionType.badRequestException,
        );
      } on FormatException catch (_) {
        throw BadRequestException('Body must be a json object');
      }
      return true;
    } on ApiException catch (e) {
      onError(e);
      return false;
    }
  }
}
