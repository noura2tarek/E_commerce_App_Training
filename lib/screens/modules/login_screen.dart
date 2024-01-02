import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:e_commerce_app/core/controllers/login_cubit/login_cubit.dart';
import 'package:e_commerce_app/core/themes/app_colors.dart';
import 'package:e_commerce_app/screens/modules/forgot_password_screen.dart';
import 'package:e_commerce_app/screens/modules/register_screen.dart';
import 'package:e_commerce_app/screens/widgets/default_button.dart';
import 'package:e_commerce_app/core/managers/navigator.dart';
import 'package:e_commerce_app/screens/widgets/default_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/managers/app_strings.dart';
import '../../core/managers/values.dart';
import '../../core/network/local/cache_helper.dart';
import '../widgets/default_form_field.dart';
import '../widgets/show_toast.dart';
import 'home_screen.dart';

class LoginScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          if (state.loginModel.status == AppStrings.success) {
            CacheHelper.savaData(
              key: AppStrings.userIdKey,
              value: state.loginModel.user!.nationalId,
            ).then((value) {
              nationalId = state.loginModel.user!.nationalId;
            });
            print("national id is $nationalId");

            CacheHelper.savaData(
              key: AppStrings.tokenKey,
              value: state.loginModel.user!.token,
            ).then((value) {
              token = state.loginModel.user!.token;
              navigateAndFinishThisScreen(context, HomeScreen());
            });
          } else {
            showToast(
              message: state.loginModel.message!,
              state: ToastStates.ERROR,
            );
          }
        }
      },
      builder: (context, state) {
        var cubit = LoginCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ///// title of page /////
                      Text(
                        AppStrings.welcomeBack,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        AppStrings.loginNow,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      ///// End of title of page /////
                      const SizedBox(
                        height: 30.0,
                      ),

                      /////*******  form fields ******////////
                      DefaultFormField(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        type: TextInputType.emailAddress,
                        controller: emailController,
                        label: AppStrings.emailAddress,
                        preficon: Icons.email_outlined,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return AppStrings.enterEmail;
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      DefaultFormField(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        type: TextInputType.visiblePassword,
                        controller: passwordController,
                        label: AppStrings.password,
                        sufficon: cubit.icon,
                        isObsecure: cubit.isObsecure,
                        suffixPreesed: () {
                          cubit.changePasswordVisibility();
                        },
                        preficon: Icons.lock_outline,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return AppStrings.emptyPassword;
                          } else {
                            return null;
                          }
                        },
                      ),

                      /////*******  end of form fields  ******////////
                      /// forget password button
                      DefaultTextButton(
                        text: AppStrings.forgotPassword,
                        fontSize: 13.0,
                        function: () {
                          navigateToNextScreenNoAni(
                            context: context,
                            widget: ForgotPasswordScreen(),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),

                      /////////     login button    /////////////
                      ConditionalBuilder(
                        condition: state is! LoginLoadingState,
                        builder: (context) {
                          return DefaultButton(
                            alignment: AlignmentDirectional.bottomEnd,
                            backgroundColor: AppColors.primaryColor,
                            text: AppStrings.login,
                            function: () {
                              if (formKey.currentState!.validate()) {
                                cubit.userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                          );
                        },
                        fallback: (context) {
                          return Align(
                            alignment: AlignmentDirectional.bottomEnd,
                            child: Container(
                              width: 140.0,
                              height: 50.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: AppColors.primaryColor,
                              ),
                              child: MaterialButton(
                                onPressed: () {},
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  backgroundColor: AppColors.primaryColor,
                                ),
                              ),
                            ),
                          );
                        },
                      ),

                      const SizedBox(
                        height: 15.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(AppStrings.dontHaveAccount),
                          DefaultTextButton(
                            text: AppStrings.register,
                            function: () {
                              navigateAndFinishThisScreen(
                                context,
                                RegisterScreen(),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
