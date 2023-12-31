part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitialState extends LoginState {}
class LChangePasswordVisibilityState extends LoginState {}

class LoginLoadingState extends LoginState {}
class LoginSuccessState extends LoginState {
  final LoginModel loginModel;

  LoginSuccessState(this.loginModel);
}
class LoginErrorState extends LoginState {
  final String error;

  LoginErrorState(this.error);
}
class ChangePasswordLoadingState extends LoginState {}
class ChangePasswordSuccessState extends LoginState {}
class ChangePasswordErrorState extends LoginState {}

class LogOutLoadingState extends LoginState {}
class LogOutSuccessState extends LoginState {}
class LogOutErrorState extends LoginState {}