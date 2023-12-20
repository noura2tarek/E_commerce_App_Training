import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:e_commerce_app/core/controllers/login_cubit/login_cubit.dart';
import 'package:e_commerce_app/core/controllers/profile_cubit/profile_cubit.dart';
import 'package:e_commerce_app/models/user_model.dart';
import 'package:e_commerce_app/screens/modules/edit_profile_screen.dart';
import 'package:flutter/materiaL.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/managers/app_strings.dart';
import '../../core/managers/navigator.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {},
      builder: (context, state) {
        UserModel? model = ProfileCubit.get(context).profileModel;
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              AppStrings.profile,
            ),
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  navigateToNextScreenNoAni(
                      context: context,
                      widget: EditProfile());
                },
                icon: const Icon(Icons.edit_outlined),
              ),
            ],
          ),
          body: ConditionalBuilder(
            condition: model != null,
            builder: (context) {
              return Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      surfaceTintColor: Colors.white.withOpacity(0.7),
                      child: SizedBox(
                        height: 180.0,
                        child: Align(
                          alignment: AlignmentDirectional.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 58.0,
                                child: ClipOval(
                                  child: CachedNetworkImage(
                                    height: 150.0,
                                    width: 150.0,
                                    fit: BoxFit.cover,
                                    imageUrl: model!.user!.profileImage!,
                                    placeholder: (context, url) =>
                                        Container(color: Colors.grey[300]),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 12.0,
                              ),
                              Text(
                                model.user!.name!,
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
                    /////// Email /////
                    SizedBox(
                      height: 60.0,
                      child: Card(
                        surfaceTintColor: Colors.white.withOpacity(0.7),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              const Icon(Icons.email_outlined,
                                  color: Colors.black38),
                              const SizedBox(
                                width: 12.0,
                              ),
                              Text(
                                model.user!.email!,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(fontSize: 17.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    /////// Phone /////
                    SizedBox(
                      height: 60.0,
                      child: Card(
                        surfaceTintColor: Colors.white.withOpacity(0.7),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.phone_outlined,
                                color: Colors.black38,
                              ),
                              const SizedBox(
                                width: 12.0,
                              ),
                              Text(
                                model.user!.phone!,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(fontSize: 17.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    /////// National Id /////
                    SizedBox(
                      height: 60.0,
                      child: Card(
                        surfaceTintColor: Colors.white.withOpacity(0.7),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              const Icon(Icons.perm_identity_outlined,
                                  color: Colors.black38),
                              const SizedBox(
                                width: 12.0,
                              ),
                              Text(
                                model.user!.nationalId!,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(fontSize: 17.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),

                    /////*** Log out button *** /////
                    BlocConsumer<LoginCubit, LoginState>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        return Padding(
                          padding: const EdgeInsetsDirectional.only(start: 2.0),
                          child: SizedBox(
                            width: 125.0,
                            child: OutlinedButton(
                              onPressed: () {
                                LoginCubit.get(context).logOut(context: context);
                              },
                              child: const Text("Log Out"),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
            fallback: (BuildContext context) {
              return Container();
            },
          ),
        );
      },
    );
  }
}
