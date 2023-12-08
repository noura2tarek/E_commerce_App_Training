part of 'products_cubit.dart';

@immutable
abstract class ProductsState {}

class ProductsInitialState extends ProductsState {}
class GetProductsLoadingState extends ProductsState {}
class GetProductsSuccessState extends ProductsState {}
class GetProductsErrorState extends ProductsState {}
