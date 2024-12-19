import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:e_commerce_app/core/controllers/profile_cubit/profile_cubit.dart';
import 'package:e_commerce_app/core/managers/app_strings.dart';
import 'package:e_commerce_app/core/themes/app_colors.dart';
import 'package:e_commerce_app/screens/modules/favourites_screen.dart';
import 'package:e_commerce_app/screens/modules/profile_screen.dart';
import 'package:e_commerce_app/screens/widgets/build_product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/controllers/products_cubit/products_cubit.dart';
import '../../core/managers/navigator.dart';
import 'cart_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductsCubit, ProductsState>(
      listener: (context, state) {},
      builder: (BuildContext context, ProductsState state) {
        var cubit = ProductsCubit.get(context);

        return ConditionalBuilder(
          condition: cubit.laptopsModel != null,
          builder: (context) {
            return Scaffold(
              /* ----------------Drawer ----------------- */
              drawer: Drawer(
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(top: 11.0),
                  child: ListView(
                    children: [
                      BlocConsumer<ProfileCubit, ProfileState>(
                        listener: (context, state) {},
                        builder: (context, state) {
                          var userModel =
                              ProfileCubit.get(context).profileModel;
                          return Container(
                            height: 83.0,
                            padding: const EdgeInsetsDirectional.all(9.0),
                            color: AppColors.primaryColor.withOpacity(0.2),
                            child: ListTile(
                              onTap: () => navigateToNextScreenNoAni(
                                  context: context,
                                  widget: const ProfileScreen()),
                              selectedTileColor: AppColors.primaryColor,
                              title: Text(
                                "Hello, Noura Tarek",
                                //"Hello, ${userModel?.user?.name}"
                                //the name of the user
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      fontSize: 17.0,
                                      color: Colors.black.withOpacity(0.7),
                                    ),
                              ),
                              subtitle: Text(
                                "nourat536@gmail.com",
                                //"${userModel?.user?.email}"
                                //the email of the user
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      fontSize: 13.0,
                                      color: Colors.grey,
                                    ),
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      ListTile(
                        title: const Text(AppStrings.cart),
                        leading: const Icon(Icons.shopping_cart_outlined),
                        onTap: () {
                          navigateToNextScreen(
                              context: context, widget: CartScreen());
                        },
                      ),
                      const SizedBox(
                        height: 4.0,
                      ),
                      ListTile(
                        title: const Text(AppStrings.profile),
                        leading: const Icon(Icons.person_outline),
                        onTap: () {
                          navigateToNextScreen(
                              context: context, widget: ProfileScreen());
                        },
                      ),
                      const SizedBox(
                        height: 4.0,
                      ),
                      ListTile(
                        title: const Text(AppStrings.favourites),
                        leading: const Icon(Icons.favorite_outline),
                        onTap: () {
                          navigateToNextScreen(
                              context: context, widget: FavouritesScreen());
                        },
                      ),
                    ],
                  ),
                ),
              ),
              /* ----------------App Bar ----------------- */
              appBar: AppBar(
                title: const Text(AppStrings.products),
                actions: [
                  // change theme mode button
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.brightness_4_outlined)),
                ],
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      /* --------------- List of products ---------------- */
                      GridView.count(
                        childAspectRatio: 1 / 1.3,
                        // width/height range of one element of grid view
                        mainAxisSpacing: 8.0,
                        crossAxisSpacing: 8.0,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        crossAxisCount: 2,
                        children: List.generate(
                          cubit.laptopsModel!.products!.length,
                          (index) => buildProductItem(
                            cubit.laptopsModel!.products![index],
                            context,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          fallback: (context) {
            return Scaffold(
              appBar: AppBar(
                title: const Text(AppStrings.products),
              ),
              body: const Center(child: CircularProgressIndicator()),
            );
          },
        );
      },
    );
  }
}
