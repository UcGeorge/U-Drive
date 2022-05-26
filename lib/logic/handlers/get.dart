import 'dart:io';

import 'package:u_drive/logic/handlers/get/get_test_access.dart';

import '../classes/api_response.dart';
import '../classes/request_handler.dart';
import '../cubit/authenticator_cubit.dart';
import '../cubit/server_cubit.dart';
import '../errors/check.dart';
import '../errors/exception.dart';
import 'get/get_probe.dart';

/// [RequestHandler] for handling requests on the `GET /...` route
class GetHandler extends RequestHandler {
  GetHandler(HttpRequest request, AuthenticatorCubit authenticator,
      ServerCubit serverCubit)
      : super(request, authenticator, serverCubit);

  @override
  Future<void> handle(HttpRequest request) async {
    bool valid = await validateRequest(request, onError: (e) {
      request.response
        ..statusCode = e is InvalidRouteException
            ? HttpStatus.notFound
            : HttpStatus.badRequest
        // ..reasonPhrase = e.message
        ..write(ApiResponse.bad(e.message))
        ..close();
    });

    if (!valid) {
      return;
    }

    List<String> pathSegments = request.uri.pathSegments;

    String rootPath = pathSegments.first;
    switch (rootPath) {
      case 'probe':
        GetProbeHandler(request, authenticator, serverCubit, this);
        break;
      case 'test-access':
        GetTestAccess(request, authenticator, serverCubit, this);
        break;
      default:
        request.response
          ..statusCode = HttpStatus.notFound
          ..write(ApiResponse.bad(
              "${request.method} ${request.uri.path} doesn't exist on this server"))
          ..close();
    }
  }

  @override
  Future<bool> validateRequest(HttpRequest request,
      {required ErrorCallback onError}) async {
    List<String> pathSegments = request.uri.pathSegments;
    try {
      check(
        pathSegments.isNotEmpty,
        "Path segments must not be empty",
        exceptionType: ApiExceptionType.invalidRouteException,
      );
      return true;
    } on ApiException catch (e) {
      onError(e);
      return false;
    }
  }
}
