import 'dart:convert';

class AuthResponse {
  final String authKey;
  final String status;

  AuthResponse({
    required this.authKey,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'authKey': authKey,
      'status': status,
    };
  }

  factory AuthResponse.fromMap(Map<String, dynamic> map) {
    return AuthResponse(
      authKey: map['key'] ?? '',
      status: map['status'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthResponse.fromJson(String source) =>
      AuthResponse.fromMap(json.decode(source));
}
