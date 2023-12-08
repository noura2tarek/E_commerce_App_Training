import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:e_commerce_app/core/controllers/login_cubit/login_cubit.dart';
import 'package:e_commerce_app/core/themes/app_colors.dart';
import 'package:e_commerce_app/screens/modules/register_screen.dart';
import 'package:e_commerce_app/screens/widgets/default_button.dart';
import 'package:e_commerce_app/screens/widgets/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          if (state.loginModel.status == "success") {
            CacheHelper.savaData(
              key: 'loginToken',
              value: state.loginModel.user!.token,
            ).then((value) {
              loginToken = state.loginModel.user!.token;
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
                        'Welcome back!',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        'Login now to browse our hot offers',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(fontSize: 13.0, color: Colors.grey[600]),
                      ),
                      ///// End of title of page /////
                      const SizedBox(
                        height: 30.0,
                      ),

                      /////*******  form fields ******////////
                      DefaultFormField(
                        type: TextInputType.emailAddress,
                        controller: emailController,
                        label: 'Email Address',
                        preficon: Icons.email_outlined,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'please enter your email address';
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      DefaultFormField(
                        type: TextInputType.visiblePassword,
                        controller: passwordController,
                        label: 'Password',
                        sufficon: cubit.icon,
                        isObsecure: cubit.isObsecure,
                        suffixPreesed: () {
                          cubit.changePasswordVisibility();
                        },
                        preficon: Icons.lock_outline,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return "password can't be blank";
                          } else {
                            return null;
                          }
                        },
                      ),

                      /////*******  end of form fields  ******////////
                      ///
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Forgot password?',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  fontSize: 13.0, color: Colors.grey[600]),
                        ),
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),

                      /////////    login button   /////////////
                      ConditionalBuilder(
                        condition: state is! LoginLoadingState,
                        builder: (context) {
                          return DefaultButton(
                            alignment: AlignmentDirectional.bottomEnd,
                            text: 'Login',
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
                                child: const CircularProgressIndicator(
                                  color: Colors.white,
                                  backgroundColor:AppColors.primaryColor,
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
                          const Text('Don\'t have an account?'),
                          TextButton(
                              child: const Text('Register'),
                              onPressed: () {
                                navigateAndFinishThisScreen(
                                    context, RegisterScreen());
                              }),
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
