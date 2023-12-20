part of 'cart_cubit.dart';

@immutable
abstract class CartStates {}

class CartInitialState extends CartStates {}
class GetCartSuccessState extends CartStates {}
class GetCartErrorState extends CartStates {}
class AddToCartSuccessState extends CartStates {}
class AddToCartErrorState extends CartStates {}
class UpdateCartSuccessState extends CartStates {}
class UpdateCartErrorState extends CartStates {}
class DeleteFromCartSuccessState extends CartStates {}
class DeleteFromCartErrorState extends CartStates {}