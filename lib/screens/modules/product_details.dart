import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/models/products_model.dart';
import 'package:e_commerce_app/screens/widgets/default_button.dart';
import 'package:flutter/materiaL.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product"),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Column(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              /////////// product image //////
              Container(
                padding: const EdgeInsetsDirectional.all(18.0),
                height: 250.0,
                width: double.infinity,
                child: CachedNetworkImage(
                  imageUrl: product.image!,
                  placeholder: (context, url) =>
                      Container(color: Colors.grey[300]),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              //////////// product name //////
              Container(
                padding: const EdgeInsetsDirectional.all(11.0),
                width: double.infinity,
                color: Colors.deepPurple.withOpacity(0.3),
                alignment: AlignmentDirectional.center,
                child: Text(
                  product.name!,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontSize: 18.0, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 40.0,
          ),
          Padding(
            padding: EdgeInsetsDirectional.only(top: 16.0 , start: 16.0, end: 16.0),
            child: Row(
              children: [
                Text(' Price -->>  ', style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith( fontSize: 17.0, ),
            ),
                Text(
                  '\$${product.price}',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontWeight: FontWeight.w500, fontSize: 17.0),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Text(' Company -->>  ', style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith( fontSize: 17.0, ),
                ),
                Text(
                  product.company!,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontWeight: FontWeight.w500, fontSize: 17.0),
                ),
              ],
            ),
          ),

          const SizedBox(
            height: 40.0,
          ),
          //////// Add to cart button ///////
          DefaultButton(
              text: 'ADD TO CART',
              function: () {},
              alignment: AlignmentDirectional.bottomCenter),
        ],
      ),
    );
  }
}