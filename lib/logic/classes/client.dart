import 'dart:convert';

class Client {
  final String token;
  final String name;

  Client({required this.token, required this.name});

  Map<String, dynamic> toMap() {
    return {
      'token': token,
      'name': name,
    };
  }

  factory Client.fromMap(Map<String, dynamic> map) {
    return Client(
      token: map['token'] ?? '',
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Client.fromJson(String source) => Client.fromMap(json.decode(source));
}
