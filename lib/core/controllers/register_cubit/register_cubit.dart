import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:e_commerce_app/core/network/api_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import '../../../models/user_model.dart';
import '../../managers/app_strings.dart';
import '../../network/remote/dio_helper.dart';
part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {

  RegisterCubit() : super(RegisterInitialState());
  static RegisterCubit get(context)=> BlocProvider.of(context);


  IconData icon = Icons.visibility_outlined;
  bool isObsecure = true;
  late UserModel registerModel;
  final ImagePicker picker = ImagePicker();
  File? image;
  Uint8List? bytes;
  String? userImage;
  String? gender = AppStrings.female;

  //change gender method
  void selectGender({String? genderSelected}){
    gender = genderSelected;
    emit(ChangeGenderSuccessState());
  }

  //Register method to post register data to api by using dio
  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String nationalId,
    String lang = 'en',
  }) {
    emit(RegisterLoadingState());
    DioHelper.postData(
      url: ApiConstants.registerPath,
      data: {
        "name": name,
        "email": email,
        "password": password,
        "gender" : gender,
        "phone": phone,
        "nationalId" : nationalId,
        "profileImage" : userImage,
      },
         lang: lang,
    ).then((value) {
      registerModel = UserModel.fromJson(value.data);
      emit(RegisterSuccessState(registerModel));
    }).catchError((error) {
      print(error.toString());
      emit(RegisterErrorState(error.toString()));
    });
  }

  ///pick image from gallery
  Future<void> pickImage() async {
    await picker.pickImage(source: ImageSource.gallery).then((value) {
      if (value != null) {
        image = File(value.path);
        bytes = File(image!.path).readAsBytesSync();
        userImage = base64Encode(bytes!);
        emit(ChangePhotoSuccessState());
      }
      else {
        print(AppStrings.noImageSelected);
      }
    }).catchError((error) {
      print('${AppStrings.errorIsOccurred}${error.toString()}');
      emit(ChangePhotoErrorState());
    });
  }



//change visibility method
  void changePasswordVisibility(){
    isObsecure = !isObsecure;
    icon =
    isObsecure ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangePasswordVisibilityState());
  }





}
