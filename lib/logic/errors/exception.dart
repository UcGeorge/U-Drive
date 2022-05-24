enum ApiExceptionType {
  defaultException,
  invalidRouteException,
  badRequestException,
  unauthorizedException
}

class ApiException implements Exception {
  final String message;

  ApiException(this.message);
}

class InvalidRouteException extends ApiException {
  InvalidRouteException(String message) : super(message);
}

class BadRequestException extends ApiException {
  BadRequestException(String message) : super(message);
}

class UnauthorizedException extends ApiException {
  UnauthorizedException(String message) : super(message);
}
