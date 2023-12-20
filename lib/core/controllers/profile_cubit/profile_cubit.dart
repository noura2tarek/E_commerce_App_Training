import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:e_commerce_app/core/network/api_constants.dart';
import 'package:e_commerce_app/core/network/remote/dio_helper.dart';
import 'package:e_commerce_app/models/update_profile_model.dart';
import 'package:e_commerce_app/models/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import '../../managers/values.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitialState());

  static ProfileCubit get(context) => BlocProvider.of(context);

  UserModel? profileModel;

//Get User Data to show it in profile
  void getUserData() {
    DioHelper.postData(
      url: ApiConstants.profileApi,
      data: {
        "token": token,
      },
    ).then((value) {
      profileModel = UserModel.fromJson(value.data);
      print(profileModel!.user!.name!);
      emit(ProfileSuccessState());
    }).catchError((error) {
      print("error occured in profile $error");
      emit(ProfileErrorState());
    });
  }

  ///pick image from gallery
  final ImagePicker picker = ImagePicker();
  File? image;
  Uint8List? bytes;
  String? userImage;

  Future<void> pickProfileImage() async {
    await picker.pickImage(source: ImageSource.gallery).then((value) {
      if (value != null) {
        image = File(value.path);
        bytes = File(image!.path).readAsBytesSync();
        userImage = base64Encode(bytes!);
        // call update method to update photo
        emit(ChangeProfilePhotoSuccessState());
      } else {
        print('no image selected');
      }
    }).catchError((error) {
      print('Error is occurred =>>  ${error.toString()}');
      emit(ChangeProfilePhotoErrorState());
    });
  }

  UpdateUserDataModel? updateModel;

//Update User profile Data
  void updateUserData({
    String? name,
    String? email,
    String? phone,
  }) {
    emit(UpdateProfileLoadingState());
    DioHelper.putData(
      url: ApiConstants.updateProfileApi,
      data: {
        "name": name,
        "email": email,
        "gender": profileModel?.user!.gender!,
        "phone": phone,
        "password": "123456",
        "token": token,
        // "profileImage" : profileModel?.user?.profileImage,
      },
    ).then((value) {
      print("value of update is ${value.data} ");
     // profileModel = UserModel.fromJson(value.data);
      getUserData();
      emit(UpdateProfileSuccessState());
    }).catchError((error) {
      print("error in update is ${error.toString()}");
      emit(UpdateProfileErrorState());
    });
  }
}
