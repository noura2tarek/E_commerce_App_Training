part of 'register_cubit.dart';

@immutable
abstract class RegisterState {}

class RegisterInitialState extends RegisterState {}
class ChangePasswordVisibilityState extends RegisterState {}

class RegisterLoadingState extends RegisterState {}
class RegisterSuccessState extends RegisterState {
  final RegisterModel registerModel;

  RegisterSuccessState(this.registerModel);
}
class RegisterErrorState extends RegisterState {
  final String error;

  RegisterErrorState(this.error);
}

class ChangePhotoSuccessState extends RegisterState{}

class ChangePhotoErrorState extends RegisterState{}
