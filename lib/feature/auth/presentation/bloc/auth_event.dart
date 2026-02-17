part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthSingIn extends AuthEvent {}

final class AuthSingUp extends AuthEvent {
  final String name;
  final String email;
  final String password;

  AuthSingUp({required this.name, required this.email, required this.password});
}
