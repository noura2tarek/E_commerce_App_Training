import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/core/network/local/cache_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../managers/navigator.dart';

part 'on_boarding_state.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> {
  OnBoardingCubit() : super(OnBoardingInitialState());

 static OnBoardingCubit get(context)=> BlocProvider.of(context);

  bool isLastPage = false;
  int currentPageIndex = 0;

  void pageLast(int index){
    currentPageIndex = index;
    isLastPage = true;
    emit(BoardingChangeIndexState());
  }

  void notPageLast(int index){
    currentPageIndex = index;
    isLastPage = false;
    emit(BoardingChangeIndexState());
  }


  void submitToRegister({required BuildContext context, required Widget widgett}){

    CacheHelper.savaData(key: "boarding", value: true).then((value) {
      if(value) {
        navigateToNextScreen(context: context, widget: widgett);
      }
    });

  }

}
