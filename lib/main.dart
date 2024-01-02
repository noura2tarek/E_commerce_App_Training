import 'package:e_commerce_app/core/controllers/cart_cubit/cart_cubit.dart';
import 'package:e_commerce_app/core/controllers/favourites_cubit/favourites_cubit.dart';
import 'package:e_commerce_app/core/controllers/login_cubit/login_cubit.dart';
import 'package:e_commerce_app/core/controllers/on_boarding_cubit/on_boarding_cubit.dart';
import 'package:e_commerce_app/core/controllers/products_cubit/products_cubit.dart';
import 'package:e_commerce_app/core/controllers/profile_cubit/profile_cubit.dart';
import 'package:e_commerce_app/core/controllers/register_cubit/register_cubit.dart';
import 'package:e_commerce_app/core/network/local/cache_helper.dart';
import 'package:e_commerce_app/core/themes/theme_data/theme_data_dark.dart';
import 'package:e_commerce_app/core/themes/theme_data/theme_data_light.dart';
import 'package:e_commerce_app/screens/modules/home_screen.dart';
import 'package:e_commerce_app/screens/modules/login_screen.dart';
import 'package:e_commerce_app/screens/modules/on_boarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/controllers/bloc_observer/bloc_observer.dart';
import 'core/managers/app_strings.dart';
import 'core/managers/values.dart';
import 'core/network/remote/dio_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  DioHelper.init();
  onBoarding = CacheHelper.getData(key: AppStrings.boardingKey) as bool?;
  token = CacheHelper.getData(key: AppStrings.tokenKey) as String?;
  nationalId = CacheHelper.getData(key: AppStrings.userIdKey) as String?;

  print("token is $token");
  print('boardingVar is $onBoarding');
  print('nationalId is $nationalId');
  if (onBoarding != null) {
    if (token != null) {
      startWidget = HomeScreen();
    } else {
      startWidget = LoginScreen();
    }
  } else {
    startWidget = OnBoardingScreen();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => OnBoardingCubit(),
        ),
        BlocProvider(
          create: (context) => RegisterCubit(),
        ),
        BlocProvider(
          create: (context) => LoginCubit(),
        ),
        BlocProvider(
          create: (context) => ProfileCubit()..getUserData(),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => ProductsCubit()..getHomeProducts(),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => FavouritesCubit()..getFavourites(),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => CartCubit()..getCartData(),
          lazy: false,
        ),
      ],
      child: MaterialApp(
        title: AppStrings.appTitle,
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.light,
        theme: lightTheme,
        darkTheme: darkTheme,
        home: startWidget,
      ),
    );
  }
}
