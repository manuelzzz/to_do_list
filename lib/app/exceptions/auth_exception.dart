class AuthException implements Exception {
  final String message;

  AuthException({
    required this.message,
  });
}
