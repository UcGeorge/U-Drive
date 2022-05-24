import 'dart:io';

import '../../classes/api_response.dart';
import '../../classes/request_handler.dart';
import '../../cubit/authenticator_cubit.dart';
import '../../cubit/server_cubit.dart';
import '../../errors/check.dart';
import '../../errors/exception.dart';

/// [RequestHandler] for handling requests on the `GET /test-access/...` route
class GetTestAccess extends RequestHandler {
  GetTestAccess(HttpRequest request, AuthenticatorCubit authenticator,
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
          ..statusCode = e is UnauthorizedException
              ? HttpStatus.unauthorized
              : HttpStatus.badRequest
          ..write(ApiResponse.bad(e.message))
          ..close();
      },
    );

    if (!valid) {
      return;
    }

    request.response
      ..statusCode = HttpStatus.ok
      ..write(ApiResponse.good())
      ..close();
  }

  @override
  Future<bool> validateRequest(HttpRequest request,
      {required ErrorCallback onError}) async {
    String? token = request.headers.value('authorization');
    try {
      check(
        token != null,
        'Missing authorization token',
        exceptionType: ApiExceptionType.unauthorizedException,
      );
      check(
        authenticator.isAuthenticated(token!),
        'Unauthorized token',
        exceptionType: ApiExceptionType.unauthorizedException,
      );
      return true;
    } on ApiException catch (e) {
      onError(e);
      return false;
    }
  }
}
