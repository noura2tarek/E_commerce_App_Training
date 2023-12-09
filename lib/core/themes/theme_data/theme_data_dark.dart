

import 'package:e_commerce_app/core/themes/app_colors.dart';
import 'package:flutter/materiaL.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  primaryColor: AppColors.primaryColor,
  colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
  dividerTheme: DividerThemeData(
    color: Colors.grey[200],
  ),
  inputDecorationTheme: const InputDecorationTheme(
    hintStyle: TextStyle(
      color: Colors.white,
    ),
    labelStyle: TextStyle(
      color: Colors.white,
    ),
    prefixIconColor: Colors.white,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey,
      ),
    ),

  ),
  scaffoldBackgroundColor: HexColor('333739'),

  textTheme: const TextTheme(
      bodySmall: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18.0,
        color: Colors.white,
      )
  ),
  appBarTheme: AppBarTheme(
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      backgroundColor: HexColor('333739'),
      elevation: 0.0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: HexColor('333739'),
        statusBarIconBrightness: Brightness.light,
      )
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: HexColor('333739'),
    type: BottomNavigationBarType.fixed,
    showUnselectedLabels: true,
    showSelectedLabels: true,
    elevation: 8.0,
    selectedItemColor: AppColors.primaryColor,
    unselectedItemColor: Colors.grey,
  ),
  floatingActionButtonTheme:  FloatingActionButtonThemeData(
    backgroundColor: AppColors.floatingActionButtonColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(9.0),
    ),
    elevation: 7.0,
  ),
);
