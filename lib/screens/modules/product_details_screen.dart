import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/core/controllers/favourites_cubit/favourites_cubit.dart';
import 'package:e_commerce_app/core/controllers/products_cubit/products_cubit.dart';
import 'package:e_commerce_app/core/managers/app_strings.dart';
import 'package:e_commerce_app/core/themes/app_colors.dart';
import 'package:e_commerce_app/models/products_model.dart';
import 'package:e_commerce_app/screens/widgets/default_button.dart';
import 'package:e_commerce_app/screens/widgets/show_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../core/controllers/cart_cubit/cart_cubit.dart';

class ProductDetailsScreen extends StatelessWidget {
  ProductDetailsScreen({super.key, required this.product});

  final ProductModel product;
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductsCubit, ProductsState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(AppStrings.productInfo),
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /* ------------------- Product name & favourite icon ------------------- */
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      Text(
                        product.name!,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      BlocConsumer<FavouritesCubit, FavouritesState>(
                        listener: (context, state) {
                          if (state is AddToFavouritesSuccessState) {
                            if (state.status == "success") {
                              showToast(
                                message:
                                    " Item added to favourites successfully ",
                                state: ToastStates.SUCCESS,
                              );
                            } else {
                              showToast(
                                message: " There is an error",
                                state: ToastStates.ERROR,
                              );
                            }
                          }
                        },
                        builder: (context, state) {
                          return InkWell(
                            borderRadius: BorderRadius.circular(5.0),
                            onTap: () {
                              FavouritesCubit.get(context)
                                  .addToFavourites(productId: product.sId!);
                            },
                            child: Container(
                              padding: const EdgeInsetsDirectional.all(5.0),
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadiusDirectional.all(
                                    Radius.circular(5.0)),
                                color: Colors.grey[300],
                              ),
                              child: Icon(
                                Icons.favorite,
                                color: FavouritesCubit.get(context)
                                    .changeColor(productId: product.sId!),
                                size: 22.0,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                /* ------------------- Page View ------------------- */
                SizedBox(
                  height: 150.0,
                  child: PageView.builder(
                    controller: pageController,
                    itemBuilder: (context, index) {
                      return CachedNetworkImage(
                        imageUrl: product.images![index],
                        placeholder: (context, url) =>
                            Container(color: Colors.grey[300]),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        width: double.infinity,
                      );
                    },
                    physics: const BouncingScrollPhysics(),
                    itemCount: product.images?.length,
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                /* ------------------- Smooth Page Indicator ------------------- */
                Align(
                  alignment: Alignment.center,
                  child: SmoothPageIndicator(
                    controller: pageController,
                    count: product.images!.length,
                    effect: ScrollingDotsEffect(
                      activeDotColor: AppColors.primaryColor,
                      dotColor: Colors.grey,
                      dotHeight: 8.0,
                      dotWidth: 9.0,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40.0,
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                    end: 16.0,
                    bottom: 16.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.only(
                          start: 16.0,
                        ),
                        child: Text(
                          '\$${product.price}',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 17.0,
                                  color: AppColors.primaryColor),
                        ),
                      ),
                      const SizedBox(
                        height: 7.0,
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(
                          start: 16.0,
                        ),
                        child: Row(
                          children: [
                            Text(
                              "Count in Stock: ",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.0,
                                      color: Colors.red),
                            ),
                            Text(
                              '${product.countInStock}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.0,
                                      color: Colors.red),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(
                          start: 11.0,
                        ),
                        child: Row(
                          children: [
                            Text(
                              ' Company: ',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    fontSize: 14.0,
                                  ),
                            ),
                            Text(
                              product.company!,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(fontSize: 14.0),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(
                          start: 16.0,
                        ),
                        child: Text(
                          product.description!,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(fontSize: 15.0),
                        ),
                      ),

                      const SizedBox(
                        height: 40.0,
                      ),
                      ////////** Add to cart button **///////
                      BlocConsumer<CartCubit, CartStates>(
                        listener: (context, state) {
                          if (state is AddToCartSuccessState) {
                            if (state.status == "success") {
                              showToast(
                                message: " Item added to Cart successfully ",
                                state: ToastStates.SUCCESS,
                              );
                            } else {
                              showToast(
                                message: " There is an error",
                                state: ToastStates.ERROR,
                              );
                            }
                          }
                        },
                        builder: (context, state) {
                          return DefaultButton(
                            backgroundColor: AppColors.primaryColor,
                            text: AppStrings.addToCart,
                            function: () {
                              CartCubit.get(context).addToCart(
                                productId: product.sId!,
                              );
                            },
                            alignment: AlignmentDirectional.bottomCenter,
                          );
                        },
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
