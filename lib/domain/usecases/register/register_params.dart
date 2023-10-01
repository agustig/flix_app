part of 'register.dart';

class RegisterParams {
  final String name;
  final String email;
  final String password;
  final String? photoUrl;

  RegisterParams({
    required this.name,
    required this.email,
    required this.password,
    this.photoUrl,
  });
}
