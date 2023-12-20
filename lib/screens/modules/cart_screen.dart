import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:e_commerce_app/screens/widgets/default_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/controllers/cart_cubit/cart_cubit.dart';
import '../../core/managers/app_strings.dart';
import '../widgets/build_cart_item.dart';

class CartScreen extends StatelessWidget {
  CartScreen({super.key});

  final couponController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = CartCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text(AppStrings.cart),
              centerTitle: true,
              leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_ios),
              ),
            ),
            body: ConditionalBuilder(
              condition: cubit.cartModel != null,
              builder: (context) {
                return Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        if (cubit.cartModel!.products!.isNotEmpty)
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) => buildCartItem(
                                cubit.cartModel!.products![index], context),
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              height: 5.0,
                            ),
                            itemCount: cubit.cartModel!.products!.length,
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                        if (cubit.cartModel!.products!.isEmpty)
                         Text(
                          AppStrings.emptyCart,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontSize: 20.0),
                        ),
                        if (cubit.cartModel!.products!.isEmpty)
                        const SizedBox(
                          height: 15.0,
                        ),

                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                              height: 59.0,
                              padding: const EdgeInsetsDirectional.all(8.0),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Form(
                                      key: formKey,
                                      child: DefaultFormField(
                                        height: 58.0,
                                        border: InputBorder.none,
                                        type: TextInputType.text,
                                        controller: couponController,
                                        hint: AppStrings.applyCode,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                                fontSize: 15.0,
                                                color: Colors.grey[900]),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return AppStrings.emptyCoupon;
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {
                                       // print("coupon is empty");
                                      }
                                    },
                                    child: const Text(
                                      AppStrings.apply,
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                );
              },
              fallback: (context) {
                return const Scaffold(
                    body: Center(child: CircularProgressIndicator()));
              },
            ),
          );
        });
  }
}
