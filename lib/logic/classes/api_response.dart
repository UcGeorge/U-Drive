import 'dart:convert';

class ApiResponse {
  final bool status;
  final Map<String, dynamic>? data;
  final String? message;

  ApiResponse({
    required this.status,
    this.data,
    this.message,
  });

  factory ApiResponse.good({
    String? message,
    Map<String, dynamic>? data,
  }) =>
      ApiResponse(
        status: true,
        message: message,
        data: data,
      );

  factory ApiResponse.bad(String message) => ApiResponse(
        status: false,
        message: message,
      );

  @override
  String toString() {
    return jsonEncode({
      "status": status,
      if (data != null) "data": data,
      if (message != null) "message": message,
    });
  }
}
