import 'dart:io';

import '../cubit/authenticator_cubit.dart';
import '../cubit/server_cubit.dart';
import '../errors/check.dart';
import '../errors/exception.dart';

typedef ErrorCallback = void Function(ApiException e);
typedef JsonType = Map<String, dynamic>;

abstract class RequestHandler {
  final AuthenticatorCubit authenticator;
  final ServerCubit serverCubit;
  final RequestHandler? parent;
  late String _requestBody;

  String get body {
    if (bodyIsLate && parent == null) {
      return '';
    } else if (bodyIsLate && parent != null) {
      return parent!.body;
    } else {
      return _requestBody;
    }
  }

  bool get bodyIsLate {
    try {
      var _ = _requestBody.length;
      return false;
    } catch (e) {
      return true;
    }
  }

  RequestHandler(HttpRequest request, this.authenticator, this.serverCubit,
      [this.parent]) {
    handle(request);
  }

  /// Predefined test for checking authentication of request
  void authenticate(HttpRequest request) {
    String? token = request.headers.value('authorization');
    check(
      authenticator.state.isPublic || token != null,
      'Missing authorization token',
      exceptionType: ApiExceptionType.unauthorizedException,
    );
    check(
      authenticator.isAuthenticated(token!),
      'Unauthorized token',
      exceptionType: ApiExceptionType.unauthorizedException,
    );
  }

  /// Handle all [HttpRequest] within the context,
  /// - Call `super.handle(request)` to get the request body fron the [HttpRequest].
  /// This action is usually performed at the end of the route.
  Future<void> handle(HttpRequest request) async {
    try {
      _requestBody = String.fromCharCodes(await request.first);
    } catch (_) {}
  }

  /// Generally a series of check functions within a try-catch block used to confirm
  /// the validity of a [HttpRequest] based on the context
  /// - NEVER TRUST USER INPUTS!!
  /// ---
  /// eg.
  /// ```dart
  /// bool validateRequest(HttpRequest request, {required ErrorCallback onError}) {
  /// List<String> pathSegments = request.uri.pathSegments;
  ///   try {
  ///     check(
  ///       pathSegments.length == 1,
  ///       "Invalid route information",
  ///       exceptionType: ApiExceptionType.invalidRouteException,
  ///     );
  ///     check(
  ///       request.headers.contentType?.value.contains('application/json') ??
  ///           false,
  ///       "Please set content-type header to application/json",
  ///       exceptionType: ApiExceptionType.badRequestException,
  ///     );
  ///     return true;
  ///   } on ApiException catch (e) {
  ///     onError(e);
  ///     return false;
  ///   }
  /// }
  /// ```
  Future<bool> validateRequest(
    HttpRequest request, {
    required ErrorCallback onError,
  });
}
