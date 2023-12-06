import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/core/network/local/cache_helper.dart';
import 'package:e_commerce_app/screens/modules/home_screen.dart';
import 'package:e_commerce_app/screens/modules/login_screen.dart';
import 'package:e_commerce_app/screens/modules/on_boarding_screen.dart';
import 'package:e_commerce_app/screens/modules/register_screen.dart';
import 'package:flutter/material.dart';

import 'core/controllers/bloc_observer/bloc_observer.dart';
import 'core/managers/values.dart';
import 'core/network/remote/dio_helper.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  DioHelper.init();
  onBoarding = CacheHelper.getData(key: "boarding") as bool?;
  token = CacheHelper.getData(key: "token") as String?;
  loginToken = CacheHelper.getData(key: "loginToken") as String?;
  print(onBoarding);

  if(onBoarding != null){
    if(token != null || loginToken != null ){
      if (loginToken != null){
        startWidget = HomeScreen();
      } else{
        startWidget = LoginScreen();
      }
    } else {
      startWidget = RegisterScreen();
    }
  }else{
    startWidget = OnBoardingScreen();
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E_Commerce_App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
        useMaterial3: true,
      ),
     home:  LoginScreen(),
    );
  }
}

