part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoding extends LoginState {}

final class LoginSuccess extends LoginState {
  final LoginEntity loginEntity;

  LoginSuccess(this.loginEntity);
}

final class LoginFailure extends LoginState {
  final String message;

  LoginFailure(this.message);
}
