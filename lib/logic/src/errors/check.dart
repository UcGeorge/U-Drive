import 'exception.dart';

void check(bool condition, String message, {ApiExceptionType? exceptionType}) {
  if (!condition) {
    switch (exceptionType ?? ApiExceptionType.defaultException) {
      case ApiExceptionType.badRequestException:
        throw BadRequestException(message);
      case ApiExceptionType.invalidRouteException:
        throw InvalidRouteException(message);
      default:
        throw ApiException(message);
    }
  }
}
