import 'package:e_commerce_app/core/managers/values.dart';
import 'package:e_commerce_app/core/network/api_constants.dart';
import 'package:e_commerce_app/core/network/remote/dio_helper.dart';
import 'package:e_commerce_app/models/add_to%20favourites_model.dart';
import 'package:e_commerce_app/models/favourites_model.dart';
import 'package:flutter/materiaL.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'favourites_state.dart';

class FavouritesCubit extends Cubit<FavouritesState> {
  FavouritesCubit() : super(FavouritesInitialState());

  static FavouritesCubit get(context) => BlocProvider.of(context);
  FavoritesModel? favouritesModel;

//Get Favourites
  // Get Data of favourite products that user has using national id
  void getFavourites() {
    DioHelper.getData(
      url: ApiConstants.favouritesApi,
      data: {
        "nationalId": nationalId,
      },
    ).then((value) {
      print("value of get favourites is ${value.data} ");
      favouritesModel = FavoritesModel.fromJson(value.data);
      emit(GetFavouritesSuccessState());
    }).catchError((error) {
      emit(GetFavouritesErrorState());
    });
  }
AddToFavouritesModel? favModel;

//Add to favourites
  void addToFavourites({required String productId}) {
    DioHelper.postData(
      url: ApiConstants.favouritesApi,
      data: {
        "nationalId": nationalId,
        "productId": productId,
      },
    ).then((value) {
      print("value of add to favourites is ${value.data} ");
      favModel = value.data;
      //value of add to favourites is {status: success, message: Product added to favorites}
      emit(AddToFavouritesSuccessState(favModel?.status));
      changeColor(productId: productId);
      getFavourites();
    }).catchError((error) {
      emit(AddToFavouritesErrorState());
    });
  }

  //change item color favourite (when add to favourites)
  Color changeColor({required String productId}) {
    Color color = Colors.grey;
    if (favouritesModel?.favoriteProducts != null) {
      favouritesModel?.favoriteProducts?.forEach((element) {
        if (element.sId == productId) {
          color = Colors.red;
        }
      });
    }
    return color;
  }

//Delete from favourites
  void deleteFromFavourites({required String productId}) {
    DioHelper.deleteData(
      url: ApiConstants.favouritesApi,
      data: {
        "nationalId": nationalId,
        "productId": productId,
      },
    ).then((value) {
      print("value of delete from favourites is ${value.data} ");
      //value of delete from favourites is {status: success, message: Product removed from favorites}
      emit(DeleteFromFavouritesSuccessState());
      getFavourites();
    }).catchError((error) {
      emit(DeleteFromFavouritesErrorState());
    });
  }
}
