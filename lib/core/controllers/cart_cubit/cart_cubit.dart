import 'package:e_commerce_app/core/managers/values.dart';
import 'package:e_commerce_app/core/network/api_constants.dart';
import 'package:e_commerce_app/core/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../../../models/cart_model.dart';
part 'cart_state.dart';

class CartCubit extends Cubit<CartStates> {
  CartCubit() : super(CartInitialState());

  static CartCubit get(context) => BlocProvider.of(context);
  CartModel? cartModel;

  // Get Data of products in user cart using national id
  void getCartData() {
    DioHelper.getData(
      url: ApiConstants.getCartApi,
      data: {
        "nationalId": nationalId,
      },
    ).then((value) {
      cartModel = CartModel.fromJson(value.data);
      print(" ${cartModel!.products!.length}  products in cart");
      emit(GetCartSuccessState());
    }).catchError((error) {
      print("error in get cart: ${error.toString()}");
      //status code : 404
      //error in get cart: DioException [bad response]: This exception was thrown because the response has a status code of 404
      // and RequestOptions.validateStatus was configured to throw for this status code.
      //The status code of 404 has the following meaning: "Client error - the request contains bad syntax or cannot be fulfilled"
      //In order to resolve this exception you typically have either to verify and fix your request code or you have to fix the server code.
      emit(GetCartErrorState());
    });
  }

// Add to cart
  void addToCart({required String productId}) {
    DioHelper.postData(
      url: ApiConstants.addToCartApi,
      data: {
        "nationalId": nationalId,
        "productId": productId,
        "quantity": "1",
      },
    ).then((value) {
      print("value of add to cart is ${value.data} ");
      //value of add to cart is {message: Product added to cart successfully,
      emit(AddToCartSuccessState());
      getCartData();
    }).catchError((error) {
      print(error.toString());
      emit(AddToCartErrorState());
    });
  }

  //Update Cart
  //increase or decrease an amount of product in cart
  void updateQuantity({required quantity, required String productId}) {
    DioHelper.putData(
      url: ApiConstants.updateCartApi,
      data: {
        "nationalId": nationalId,
        "productId": productId,
        "quantity": quantity
      },
    ).then((value) {
      emit(UpdateCartSuccessState());
      getCartData();
    }).catchError((error) {
      print(error.toString());
      emit(UpdateCartErrorState());
    });
  }

  //Delete product from cart
  void deleteFromCart(productId) {
    DioHelper.deleteData(
      url: ApiConstants.deleteFromCartApi,
      data: {
        "nationalId": nationalId,
        "productId": productId,
      },
    ).then((value) {
      emit(DeleteFromCartSuccessState());
      getCartData();
    }).catchError((error) {
      print(error.toString());
      emit(DeleteFromCartErrorState());
    });
  }
}
