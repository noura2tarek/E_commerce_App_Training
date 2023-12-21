import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:e_commerce_app/core/controllers/register_cubit/register_cubit.dart';
import 'package:e_commerce_app/core/managers/images.dart';
import 'package:e_commerce_app/screens/modules/login_screen.dart';
import 'package:e_commerce_app/screens/widgets/default_button.dart';
import 'package:e_commerce_app/screens/widgets/default_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/managers/app_strings.dart';
import '../../core/managers/values.dart';
import '../../core/network/local/cache_helper.dart';
import '../../core/themes/app_colors.dart';
import '../widgets/default_form_field.dart';
import '../../core/managers/navigator.dart';
import '../widgets/show_toast.dart';
import 'home_screen.dart';

class RegisterScreen extends StatelessWidget {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final nationalIdController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterSuccessState) {
          if (state.userModel.status == AppStrings.success) {
            CacheHelper.savaData(
              key: AppStrings.userIdKey,
              value: state.userModel.user!.nationalId,
            ).then((value) {
              nationalId = state.userModel.user!.nationalId;
            });

            CacheHelper.savaData(
              key: AppStrings.tokenKey,
              value: state.userModel.user!.token,
            ).then((value) {
              token = state.userModel.user!.token;
              print("token is  $token");
              navigateAndFinishThisScreen(context, HomeScreen());
            });
          } else {
            print(state.userModel.message!);
            showToast(
              message: state.userModel.message!,
              state: ToastStates.ERROR,
            );
          }
        }
      },
      builder: (context, state) {
        var cubit = RegisterCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsetsDirectional.only(
                bottom: 25.0, top: 4.0, start: 25.0, end: 25.0),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ///// Title of page /////
                    Text(
                      AppStrings.register,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    ///// End of title of page /////
                    const SizedBox(
                      height: 25.0,
                    ),

                    /// profile  image  ///
                    ConditionalBuilder(
                      condition: (cubit.image != null),
                      builder: (context) {
                        return Padding(
                          padding:
                              const EdgeInsetsDirectional.only(bottom: 7.0),
                          child: GestureDetector(
                            onTap: () {
                              cubit.pickImage();
                            },
                            child: CircleAvatar(
                              radius: 40.0,
                              child: ClipOval(
                                child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: FileImage(cubit.image!)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      fallback: (context) {
                        return GestureDetector(
                          onTap: () {
                            cubit.pickImage();
                          },
                          child: CircleAvatar(
                            radius: 40.0,
                            child: ClipOval(
                              child: Container(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadiusDirectional.all(
                                      Radius.circular(10.0)),
                                ),
                                child: CachedNetworkImage(
                                  imageUrl: AppImages.defaultNetworkImage,
                                  placeholder: (context, url) =>
                                      Container(color: Colors.grey[300]),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                  width: 100.0,
                                  height: 100.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    /////******* form fields ******////////
                    DefaultFormField(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                      controller: nameController,
                      type: TextInputType.name,
                      label: AppStrings.name,
                      preficon: Icons.person_outline,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return AppStrings.enterName;
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
                      controller: emailController,
                      type: TextInputType.emailAddress,
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
                      controller: passwordController,
                      type: TextInputType.visiblePassword,
                      label: AppStrings.password,
                      sufficon: cubit.icon,
                      suffixPreesed: () {
                        cubit.changePasswordVisibility();
                      },
                      preficon: Icons.lock_outline,
                      isObsecure: cubit.isObsecure,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return AppStrings.emptyPassword;
                        } else if (value.length < 8) {
                          return AppStrings.shortPassword;
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
                      controller: phoneController,
                      type: TextInputType.phone,
                      label: AppStrings.phone,
                      preficon: Icons.phone_outlined,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return AppStrings.enterPhone;
                        } else if (value.length != 11) {
                          return AppStrings.validPhone;
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
                      controller: nationalIdController,
                      type: TextInputType.number,
                      label: AppStrings.nationalId,
                      preficon: Icons.numbers_outlined,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return AppStrings.enterNational;
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    /////******* end of form fields ******////////

                    ////////  Register Button   ///////
                    ConditionalBuilder(
                      condition: state is! RegisterLoadingState,
                      builder: (context) {
                        return DefaultButton(
                          backgroundColor: AppColors.primaryColor,
                          text: AppStrings.register,
                          function: () {
                            if (formKey.currentState!.validate()) {
                              cubit.userRegister(
                                name: nameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                                nationalId: nationalIdController.text,
                                phone: phoneController.text,
                              );
                            }
                          },
                          alignment: AlignmentDirectional.bottomEnd,
                        );
                      },
                      fallback: (context) {
                        return Align(
                          alignment: AlignmentDirectional.bottomEnd,
                          child: Container(
                            width: double.infinity,
                            height: 50.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6.0),
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
                      height: 5.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(AppStrings.haveAccount),
                        DefaultTextButton(
                          text: AppStrings.login,
                          function: () {
                            navigateAndFinishThisScreen(
                              context,
                              LoginScreen(),
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
        );
      },
    );
  }
}
