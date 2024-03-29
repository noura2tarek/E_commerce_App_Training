import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:e_commerce_app/core/controllers/profile_cubit/profile_cubit.dart';
import 'package:e_commerce_app/screens/widgets/default_form_field.dart';
import 'package:e_commerce_app/screens/widgets/default_text_button.dart';
import 'package:flutter/materiaL.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/managers/app_strings.dart';

class EditProfile extends StatelessWidget {
  EditProfile({super.key});

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ProfileCubit.get(context);
        var userModel = cubit.profileModel;
        nameController.text = (userModel!.user!.name) ?? ' ';
        emailController.text = (userModel.user!.email) ?? ' ';
        phoneController.text = (userModel.user!.phone) ?? ' ';

        return Scaffold(
          appBar: AppBar(
            title: const Text(
              AppStrings.editProfile,
            ),
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios),
            ),
            centerTitle: true,
            actions: [
              /* ---------- Update user Button ---------- */
              Padding(
                padding: const EdgeInsetsDirectional.only(end: 5.0),
                child: DefaultTextButton(
                  text: AppStrings.edit,
                  fontSize: 16.0,
                  function: () {
                    cubit.updateUserData(
                      phone: phoneController.text,
                      email: emailController.text,
                      name: nameController.text,
                    );
                  },
                ),
              ),
            ],
          ),
          body: ConditionalBuilder(
            condition: true,
            builder: (context) {
              return Padding(
                padding: const EdgeInsets.all(15.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /* ---------- Update user loading ---------- */
                      if (state is UpdateProfileLoadingState)
                        const LinearProgressIndicator(),
                      if (state is UpdateProfileLoadingState)
                        const SizedBox(
                          height: 7.0,
                        ),

                      /* ----------- User Image----------- */
                      Card(
                        surfaceTintColor: Colors.white.withOpacity(0.7),
                        child: SizedBox(
                          height: 180.0,
                          child: Align(
                            alignment: AlignmentDirectional.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Stack(
                                  alignment: AlignmentDirectional.bottomEnd,
                                  children: [
                                    CircleAvatar(
                                      radius: 58.0,
                                      child: ClipOval(
                                        child: CachedNetworkImage(
                                          height: 150.0,
                                          width: 150.0,
                                          fit: BoxFit.cover,
                                          imageUrl:
                                              userModel.user!.profileImage!,
                                          placeholder: (context, url) =>
                                              Container(
                                                  color: Colors.grey[300]),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 3.0),
                                      child: CircleAvatar(
                                        backgroundColor:
                                            Colors.grey[350]?.withOpacity(0.8),
                                        //change color here according to theme mode
                                        radius: 17.0,
                                        child: IconButton(
                                          onPressed: () {
                                            cubit.pickProfileImage();
                                          },
                                          splashRadius: 21.0,
                                          icon: const Icon(
                                            Icons.camera_alt_outlined,
                                            color: Colors.black38,
                                            size: 20.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 12.0,
                                ),
                                Text(
                                  userModel.user!.name!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(fontSize: 20.0),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      /* ----------- User Name----------- */
                      Padding(
                        padding: const EdgeInsetsDirectional.only(start: 5.0),
                        child: Text(
                          AppStrings.name,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontSize: 15.0),
                        ),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      /* ----------- User Name form field ----------- */
                      Card(
                        surfaceTintColor: Colors.white.withOpacity(0.7),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DefaultFormField(
                            height: 32.0,
                            controller: nameController,
                            border: InputBorder.none,
                            type: TextInputType.text,
                            preficon: Icons.person_outline,
                            prefixColor: Colors.black38,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(fontSize: 17.0),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      /* ----------- User Email ----------- */
                      Padding(
                        padding: const EdgeInsetsDirectional.only(start: 5.0),
                        child: Text(
                          AppStrings.email,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontSize: 15.0),
                        ),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      /* ---------- User Email form field ---------- */
                      Card(
                        surfaceTintColor: Colors.white.withOpacity(0.7),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DefaultFormField(
                            height: 32.0,
                            controller: emailController,
                            border: InputBorder.none,
                            type: TextInputType.emailAddress,
                            preficon: Icons.email_outlined,
                            prefixColor: Colors.black38,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(fontSize: 17.0),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      /* ----------- User Phone ----------- */
                      Padding(
                        padding: const EdgeInsetsDirectional.only(start: 5.0),
                        child: Text(
                          AppStrings.phone,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontSize: 15.0),
                        ),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      /* ---------- User Phone form field ---------- */
                      Card(
                        surfaceTintColor: Colors.white.withOpacity(0.7),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DefaultFormField(
                            height: 32.0,
                            controller: phoneController,
                            border: InputBorder.none,
                            type: TextInputType.phone,
                            preficon: Icons.phone_outlined,
                            prefixColor: Colors.black38,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(fontSize: 17.0),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                    ],
                  ),
                ),
              );
            },
            fallback: (context) {
              return Container();
            },
          ),
        );
      },
    );
  }
}
