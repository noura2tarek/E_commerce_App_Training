import 'package:e_commerce_app/core/managers/values.dart';
import 'package:e_commerce_app/core/network/api_constants.dart';
import 'package:flutter/materiaL.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/user_login_model.dart';
import '../../../screens/modules/login_screen.dart';
import '../../managers/app_strings.dart';
import '../../managers/navigator.dart';
import '../../network/local/cache_helper.dart';
import '../../network/remote/dio_helper.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

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
      url: ApiConstants.loginPath,
      data: {
        "email": email,
        "password": password,
      },
      lang: lang,
    ).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      print("value of login is: ${value.data}");
      print(loginModel?.status);
      emit(LoginSuccessState(loginModel!));
    }).catchError((error) {
      print(error.toString());
      emit(LoginErrorState(error.toString()));
    });
  }

//change password is different called -->> reset password
  //Forget password
  void changePassword({
    required String newPassword,
  }) {
    emit(ChangePasswordLoadingState());
    DioHelper.postData(
      url: ApiConstants.forgetPasswordApi,
      data: {
        "nationalId": nationalId,
        "newPassword": newPassword,
      },
    ).then((value) {
      print("value of change password is ${value.data}");
      emit(ChangePasswordSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ChangePasswordErrorState());
    });
  }

  //Log out method
  void logOut({ required BuildContext context}){
    DioHelper.postData(
      url: ApiConstants.logOutApi,
      data: {
        "token": token,
      },
    ).then((value) {
      CacheHelper.removeData(key: AppStrings.tokenKey).then((value) {
        if (value) {
          navigateAndFinishThisScreen(context, LoginScreen());
        }
        emit(LogOutSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(LogOutErrorState());
      });
    });
  }


  //change visibility method
  void changePasswordVisibility() {
    isObsecure = !isObsecure;
    icon =
        isObsecure ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(LChangePasswordVisibilityState());
  }
}
