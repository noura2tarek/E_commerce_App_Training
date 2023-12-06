import 'package:e_commerce_app/core/network/api_constants.dart';
import 'package:e_commerce_app/models/user_register_model.dart';
import 'package:flutter/materiaL.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/user_login_model.dart';
import '../../network/remote/dio_helper.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState());
  static LoginCubit get(context)=> BlocProvider.of(context);

  IconData icon = Icons.visibility_outlined;
  bool isObsecure = true;
  LoginModel? loginModel;

  //Login method to post login data to api by using dio
  void userLogin({
    required String email,
    required String password,
    String lang = 'en',
  }) {
    emit(LoginLoadingState());
    DioHelper.postData(
      url: ApiConstants.LoginPath,
      data: {
        "email": email,
        "password": password,
      },
      lang: lang,
    ).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      emit(LoginSuccessState(loginModel!));
    }).catchError((error) {
      print(error.toString());
      emit(LoginErrorState(error.toString()));
    });
  }


  //change visibility method
  void changePasswordVisibility(){
    isObsecure = !isObsecure;
    icon =
    isObsecure ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(LChangePasswordVisibilityState());
  }

}
