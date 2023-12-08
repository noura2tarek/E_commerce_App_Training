import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/core/network/api_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../models/products_model.dart';
import '../../network/remote/dio_helper.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit() : super(ProductsInitialState());

  static ProductsCubit get(context) => BlocProvider.of(context);

  LaptopsModel? laptopsModel;

  void getHomeProducts() {
    emit(GetProductsLoadingState());
    DioHelper.getData(url: ApiConstants.productsPath).then((value) {
      laptopsModel = LaptopsModel.fromJson(value.data);
      print(laptopsModel!.product!.length);
      emit(GetProductsSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetProductsErrorState());
    });
  }
}
