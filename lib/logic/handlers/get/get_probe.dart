import 'dart:io';

import '../../classes/api_response.dart';
import '../../classes/request_handler.dart';
import '../../cubit/authenticator_cubit.dart';
import '../../cubit/server_cubit.dart';
import '../../errors/check.dart';
import '../../errors/exception.dart';

/// [RequestHandler] for handling requests on the `GET /probe/...` route
class GetProbeHandler extends RequestHandler {
  GetProbeHandler(HttpRequest request, AuthenticatorCubit authenticator,
      ServerCubit serverCubit,
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

    request.response
      ..statusCode = HttpStatus.ok
      ..write(ApiResponse.good(
        data: {
          "serverName": "UcGeorge",
          "public": authenticator.state.isPublic,
        },
      ))
      ..close();
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
        body.isEmpty,
        'This endpoint has no body',
        exceptionType: ApiExceptionType.badRequestException,
      );
      return true;
    } on ApiException catch (e) {
      onError(e);
      return false;
    }
  }
}
