enum ApiExceptionType {
  defaultException,
  invalidRouteException,
  badRequestException
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
