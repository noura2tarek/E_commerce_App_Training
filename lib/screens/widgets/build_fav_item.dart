import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/core/managers/app_strings.dart';
import 'package:flutter/material.dart';
import '../../core/controllers/favourites_cubit/favourites_cubit.dart';
import '../../core/themes/app_colors.dart';
import '../../models/favourites_model.dart';

Widget buildFavItem(FavoriteProductModel favouriteProduct, context) => InkWell(
      borderRadius: BorderRadius.circular(5.0),
      onTap: () {
        // navigateToNextScreen(
        //   context: context,
        //   widget: ProductDetailsScreen(
        //     product: favouriteProduct,
        //   ),
        // );
      },
      child: Card(
        surfaceTintColor: AppColors.primaryColor.withOpacity(0.4),
        child: Padding(
          padding: const EdgeInsets.all(7.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
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
                              Radius.circular(10.0)),
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
                          imageUrl: favouriteProduct.image!,
                        ),
                      ),
                      if (favouriteProduct.status == AppStrings.newt)
                        Align(
                          alignment: AlignmentDirectional.bottomCenter,
                          child: Container(
                            decoration: BoxDecoration(
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
                        favouriteProduct.name!,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 17.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Text(
                            '\$${favouriteProduct.price!}',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 17.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          //Delete Button
                          Padding(
                            padding: const EdgeInsetsDirectional.all(5.0),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(10.0),
                              onTap: () {
                                FavouritesCubit.get(context)
                                    .deleteFromFavourites(
                                        productId: favouriteProduct.sId!);
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(7.0),
                                child: Icon(
                                  Icons.delete_outlined,
                                  color: Colors.red,
                                ),
                              ),
                            ),
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
      ),
    );
