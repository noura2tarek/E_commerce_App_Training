import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce_app/core/controllers/favourites_cubit/favourites_cubit.dart';
import 'package:e_commerce_app/core/controllers/products_cubit/products_cubit.dart';
import 'package:e_commerce_app/core/managers/app_strings.dart';
import 'package:e_commerce_app/core/themes/app_colors.dart';
import 'package:e_commerce_app/models/products_model.dart';
import 'package:e_commerce_app/screens/widgets/default_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                //////////// product name //////
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
                      InkWell(
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
                          child: const Icon(
                            Icons.favorite,
                            color: Colors.grey,
                            size: 22.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                /////****************     Carousel Slider    **************////////
                CarouselSlider(
                  items: product.images
                      ?.map(
                        (e) => CachedNetworkImage(
                          imageUrl: e,
                          placeholder: (context, url) =>
                              Container(color: Colors.grey[300]),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                          width: double.infinity,
                        ),
                      )
                      .toList(),
                  options: CarouselOptions(
                    height: 230.0,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    autoPlay: false,
                    autoPlayInterval: const Duration(
                      seconds: 3,
                    ),
                    autoPlayAnimationDuration: const Duration(
                      seconds: 1,
                    ),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    scrollDirection: Axis.horizontal,
                    viewportFraction: 1.0, // the image takes the full width
                  ),
                ),

                // SmoothPageIndicator(
                //   controller: boardController,
                //   count: product.images!.length,
                //   effect: ExpandingDotsEffect(
                //     activeDotColor: AppColors.primaryColor,
                //     dotColor: Colors.grey,
                //     dotHeight: 10.0,
                //     dotWidth: 11.0,
                //   ),
                // ),

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
                      DefaultButton(
                        backgroundColor: AppColors.primaryColor,
                        text: AppStrings.addToCart,
                        function: () {
                          CartCubit.get(context).addToCart(
                            productId: product.sId!,
                          );
                        },
                        alignment: AlignmentDirectional.bottomCenter,
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
