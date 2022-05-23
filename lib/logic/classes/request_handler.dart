import 'dart:io';

import 'package:u_drive/logic/cubit/authenticator_cubit.dart';
import 'package:u_drive/logic/cubit/server_cubit.dart';

import 'authenticator.dart';
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

  /// Handle all [HttpRequest] within the context,
  /// - Call `super.handle(request)` to get the request body fron the [HttpRequest].
  /// This action is usually performed at the end of the route.
  Future<void> handle(HttpRequest request) async {
    _requestBody = String.fromCharCodes(await request.first);
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
  ///     test(
  ///       pathSegments.length == 1,
  ///       "Invalid route information",
  ///       exceptionType: ApiExceptionType.invalidRouteException,
  ///     );
  ///     test(
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
