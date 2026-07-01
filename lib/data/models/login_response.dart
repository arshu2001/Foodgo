class LoginResponse {
  final String access;
  final String refresh;
  final String email;

  LoginResponse({
    required this.access,
    required this.refresh,
    required this.email,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      access: json['access'] ?? '',
      refresh: json['refresh'] ?? '',
      email: json['email'] ?? '',
    );
  }
}
