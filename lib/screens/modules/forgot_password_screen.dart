import 'package:e_commerce_app/core/controllers/login_cubit/login_cubit.dart';
import 'package:e_commerce_app/core/managers/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/default_form_field.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          AppStrings.forgetPassword,
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = LoginCubit.get(context);
          return Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (state is ChangePasswordLoadingState)
                  const LinearProgressIndicator(),
                const SizedBox(
                  height: 20.0,
                ),
                ///////   New Password   /////
                Text(
                  AppStrings.enterNewPassword,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 16.0),
                ),
                const SizedBox(
                  height: 13.0,
                ),
                Card(
                  surfaceTintColor: Colors.white.withOpacity(0.7),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                      key: formKey,
                      child: DefaultFormField(
                        height: 40.0,
                        controller: passwordController,
                        border: InputBorder.none,
                        type: TextInputType.visiblePassword,
                        preficon: Icons.lock_outline,
                        isObsecure: cubit.isObsecure,
                        sufficon: cubit.icon,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return AppStrings.emptyPassword;
                          } else if (value.length < 8) {
                            return AppStrings.shortPassword;
                          } else {
                            return null;
                          }
                        },
                        suffixPreesed: () {
                          cubit.changePasswordVisibility();
                        },
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(fontSize: 17.0, color: Colors.grey[900]),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),

                /// ** Change password button **///
                OutlinedButton(
                  child: const Text(
                    AppStrings.changePassword,
                  ),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      cubit.changePassword(
                          newPassword: passwordController.text);
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
