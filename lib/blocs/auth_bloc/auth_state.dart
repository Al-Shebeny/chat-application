part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class LoginSuccess extends AuthState {}

class LoginLoding extends AuthState {}

class LoginFaliur extends AuthState {
  final String errMasage;

  LoginFaliur({required this.errMasage});
}

class RegisterSuccess extends AuthState {}

class RegisterLoding extends AuthState {}

class RegisterFaliur extends AuthState {
  final String errMasage;

  RegisterFaliur({required this.errMasage});
}
