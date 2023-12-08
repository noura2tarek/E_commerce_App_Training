import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:e_commerce_app/core/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/controllers/products_cubit/products_cubit.dart';
import '../../core/managers/navigator.dart';
import '../widgets/build_product_item.dart';
import 'cart_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
              drawer: Drawer(
                child: ListView(
                  children: [
                    ListTile(
                      title: const Text('Cart'),
                      leading: const Icon(Icons.person),
                      onTap: () {
                        navigateToNextScreen(
                            context: context, widget: CartScreen());
                      },
                    ),
                  ],
                ),
              ),
              appBar: AppBar(
                title: const Text('Products'),
              ),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      color: Colors.transparent,
                      child: GridView.count(
                        childAspectRatio: 1 / 1.3,
                        mainAxisSpacing: 1.0,
                        crossAxisSpacing: 1.0,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        crossAxisCount: 2,
                        children: List.generate(
                          cubit.laptopsModel!.product!.length,
                          (index) => buildProductItem(
                              cubit.laptopsModel!.product![index], context),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          fallback: (context) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Products'),
              ),
              body: const Center(
                  child:
                      CircularProgressIndicator(color: AppColors.primaryColor)),
            );
          },
        );
      },
    );
  }
}
