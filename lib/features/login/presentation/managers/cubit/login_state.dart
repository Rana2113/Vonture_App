part of 'login_cubit.dart';

sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {
  final UserModel user;
  LoginSuccess(this.user);
}

final class LoginFailure extends LoginState {
  final String message;
  LoginFailure(this.message);
}

final class ChangePasswordVisibility extends LoginState {
  final bool isPasswordVisible;
  ChangePasswordVisibility(this.isPasswordVisible);
}
