import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:e_commerce_app/core/controllers/register_cubit/register_cubit.dart';
import 'package:e_commerce_app/core/managers/images.dart';
import 'package:e_commerce_app/screens/modules/login_screen.dart';
import 'package:e_commerce_app/screens/widgets/default_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/managers/values.dart';
import '../../core/network/local/cache_helper.dart';
import '../widgets/default_form_field.dart';
import '../widgets/navigator.dart';
import '../widgets/show_toast.dart';
import 'home_screen.dart';

class RegisterScreen extends StatelessWidget {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final nationalIdController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterSuccessState) {
          if (state.registerModel.status == "success") {
            CacheHelper.savaData(
              key: 'token',
              value: state.registerModel.user!.token,
            ).then((value) {
              token = state.registerModel.user!.token;
              print("token is  $token");
              navigateAndFinishThisScreen(context, HomeScreen());
            });
          } else {
            print(state.registerModel.message!);
            showToast(
              message: state.registerModel.message!,
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
                      'Register',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                    ///// End of title of page /////
                    const SizedBox(
                      height: 25.0,
                    ),

                    /// profile  image  ///
                    ConditionalBuilder(
                      condition: (cubit.image != null),
                      builder: (context) {
                        return  Padding(
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
                                  errorWidget: (context, url,
                                      error) => const Icon(Icons.error),
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
                      height: 9.0,
                    ),
                    /////******* form fields ******////////
                    DefaultFormField(
                      controller: nameController,
                      type: TextInputType.name,
                      label: 'Name',
                      preficon: Icons.person_outline,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'please enter your name';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    DefaultFormField(
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      label: 'Email Address',
                      preficon: Icons.email_outlined,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'please enter your email';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    DefaultFormField(
                      controller: passwordController,
                      type: TextInputType.visiblePassword,
                      label: 'Password',
                      sufficon: cubit.icon,
                      suffixPreesed: () {
                        cubit.changePasswordVisibility();
                      },
                      preficon: Icons.lock_outline,
                      isObsecure: cubit.isObsecure,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "password can't be blank";
                        } else if (value.length < 8) {
                          return 'password is too short';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    DefaultFormField(
                      controller: phoneController,
                      type: TextInputType.phone,
                      label: 'Phone',
                      preficon: Icons.phone_outlined,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'please enter your phone';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    DefaultFormField(
                      controller: nationalIdController,
                      type: TextInputType.number,
                      label: 'National Id',
                      preficon: Icons.numbers_outlined,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'please enter your national Id';
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
                          alignment: AlignmentDirectional.bottomEnd,
                          text: 'Register',
                          function: () {
                            if (formKey.currentState!.validate()) {
                              cubit.userRegister(
                                name: nameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                                phone: phoneController.text,
                                nationalId: nationalIdController.text,
                              );
                            }
                          },
                        );
                      },
                      fallback: (context) {
                        return Container(
                          width: double.infinity,
                          height: 50.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6.0),
                            color: Colors.purple,
                          ),
                          child: MaterialButton(
                            onPressed: () {},
                            child: const CircularProgressIndicator(
                              color: Colors.white,
                              backgroundColor: Colors.purple,
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
                        const Text('Already have an account?'),
                        TextButton(
                          onPressed: () {
                            navigateAndFinishThisScreen(
                                context, LoginScreen());
                          },
                          child: const Text('Login'),
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
