import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/core/managers/app_strings.dart';
import 'package:e_commerce_app/core/themes/app_colors.dart';
import 'package:flutter/material.dart';
import '../../core/controllers/cart_cubit/cart_cubit.dart';
import '../../models/cart_model.dart';

Widget buildCartItem(CartProducts cartProduct, context) => Card(
      surfaceTintColor: AppColors.primaryColor.withOpacity(0.4),
      child: Padding(
        padding: const EdgeInsets.all(7.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 122.0,
              height: 124.0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor.withOpacity(0.6),
                        borderRadius: const BorderRadiusDirectional.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      height: 120.0,
                      width: 120.0,
                      child: CachedNetworkImage(
                        placeholder: (context, url) {
                          return const Center(
                              child: CircularProgressIndicator());
                        },
                        errorWidget: (context, url, error) =>
                            const Center(child: Icon(Icons.error)),
                        imageUrl: cartProduct.image!,
                      ),
                    ),
                    if (cartProduct.status == AppStrings.newt)
                      Align(
                        alignment: AlignmentDirectional.bottomCenter,
                        child: Container(
                          decoration:  BoxDecoration(
                            color: AppColors.secondColor,
                            borderRadius: const BorderRadiusDirectional.only(
                              bottomStart: Radius.circular(10.0),
                              bottomEnd: Radius.circular(10.0),
                            ),
                          ),
                          width: double.infinity,
                          height: 23.0,
                          child: const Center(
                            child: Text(
                              AppStrings.sale15,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cartProduct.name!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 17.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 13.0,
                    ),
                    Row(
                      children: [
                        Text(
                          '\$${cartProduct.totalPrice!}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.symmetric(
                              horizontal: 15.0),
                          child: Container(
                            width: 1,
                            height: 20,
                            color: Colors.black,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(3)),
                          height: 13,
                          width: 13,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          AppStrings.black,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 13,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () {
                            CartCubit.get(context)
                                .deleteFromCart(cartProduct.sId!);
                          },
                          icon: const Icon(
                            Icons.delete_outlined,
                            color: Colors.red,
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        // minus button
                        InkWell(
                          onTap: () {
                            cartProduct.quantity == 1
                                ? null
                                : CartCubit.get(context).updateQuantity(
                                    productId: cartProduct.sId!,
                                    quantity: --cartProduct.quantity,
                                  );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: cartProduct.quantity != 1
                                    ? AppColors.primaryColor
                                    : AppColors.primaryColor.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(3)),
                            height: 26.0,
                            width: 26.0,
                            child: const Icon(
                              Icons.remove,
                              color: Colors.white,
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsetsDirectional.symmetric(
                              horizontal: 10.0),
                          child: Text(
                            '${cartProduct.quantity!}',
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        //add quantity button
                        InkWell(
                          onTap: () {
                            CartCubit.get(context).addToCart(
                              productId: cartProduct.sId!,
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius: BorderRadius.circular(3)),
                            height: 26,
                            width: 26,
                            child: const Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
