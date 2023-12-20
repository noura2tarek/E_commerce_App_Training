import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/core/managers/app_strings.dart';
import 'package:e_commerce_app/models/products_model.dart';
import 'package:flutter/materiaL.dart';
import '../../core/controllers/cart_cubit/cart_cubit.dart';
import '../../core/managers/navigator.dart';
import '../../core/themes/app_colors.dart';
import '../modules/product_details_screen.dart';

Widget buildProductItem(ProductModel productModel, BuildContext context) {
  return InkWell(
    borderRadius: BorderRadius.circular(20.0),
    onTap: () {
      navigateToNextScreen(
        context: context,
        widget: ProductDetailsScreen(
          product: productModel,
        ),
      );
    },
    child: SizedBox(
      height: 200.0,
      width: 180.0,
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 125.0,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadiusDirectional.only(
                          topStart: Radius.circular(20.0)),
                      color: AppColors.primaryColor,
                    ),
                    child: Center(
                      child: RotatedBox(
                        quarterTurns: 1,
                        child: Text(
                          "${productModel.status}",
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Container(
                    padding:
                        const EdgeInsetsDirectional.symmetric(horizontal: 20.0),
                    height: 125.0,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withOpacity(0.2),
                      borderRadius: const BorderRadiusDirectional.only(
                        topEnd: Radius.circular(20.0),
                      ),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: productModel.image!,
                      placeholder: (context, url) {
                        return const Center(child: CircularProgressIndicator());
                      },
                      errorWidget: (context, url, error) =>
                          const Center(child: Icon(Icons.error)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: const BorderRadiusDirectional.only(
                  bottomStart: Radius.circular(20.0),
                  bottomEnd: Radius.circular(20.0),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsetsDirectional.only(
                          top: 10.0, start: 10.0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              '${productModel.name}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          if (productModel.status == "New")
                            Expanded(
                              flex: 1,
                              child: Container(
                                alignment: AlignmentDirectional.center,
                                height: 30.0,
                                decoration:  BoxDecoration(
                                  color: AppColors.secondColor,
                                  borderRadius: const BorderRadius.horizontal(
                                    left: Radius.circular(20.0),
                                  ),
                                ),
                                child: const Text(
                                  AppStrings.ten,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.bold,
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
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        "${productModel.company}",
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding:
                                const EdgeInsetsDirectional.only(start: 10.0),
                            child: Text(
                              "\$${productModel.price}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 50.0,
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: const BorderRadiusDirectional.only(
                                topStart: Radius.circular(20.0),
                                bottomEnd: Radius.circular(20.0),
                              ),
                            ),
                            child: MaterialButton(
                              onPressed: () {
                                CartCubit.get(context).addToCart(productId: productModel.sId!,);
                              },
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadiusDirectional.only(
                                  topStart: Radius.circular(20.0),
                                  bottomEnd: Radius.circular(20.0),
                                ),
                              ),
                              child: Text(
                                AppStrings.buy.toUpperCase(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
