part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {}

class ProfileInitialState extends ProfileState {}
class ProfileSuccessState extends ProfileState {}
class ProfileErrorState extends ProfileState {}
class UpdateProfileLoadingState extends ProfileState {}
class UpdateProfileSuccessState extends ProfileState {}
class UpdateProfileErrorState extends ProfileState {}
class ChangeProfilePhotoSuccessState extends ProfileState {}
class ChangeProfilePhotoErrorState extends ProfileState {}

