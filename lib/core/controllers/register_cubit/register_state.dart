part of 'register_cubit.dart';

@immutable
abstract class RegisterState {}

class RegisterInitialState extends RegisterState {}
class ChangePasswordVisibilityState extends RegisterState {}

class RegisterLoadingState extends RegisterState {}
class RegisterSuccessState extends RegisterState {
  final UserModel userModel;

  RegisterSuccessState(this.userModel);
}
class RegisterErrorState extends RegisterState {
  final String error;

  RegisterErrorState(this.error);
}

class ChangePhotoSuccessState extends RegisterState{}

class ChangePhotoErrorState extends RegisterState{}

class ChangeGenderSuccessState extends RegisterState{}
