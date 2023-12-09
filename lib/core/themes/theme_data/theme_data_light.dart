import 'package:e_commerce_app/core/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  primaryColor: AppColors.primaryColor,
  primarySwatch: Colors.cyan,
  inputDecorationTheme: InputDecorationTheme(

    labelStyle: TextStyle(
      fontSize: 15.0,
      fontWeight: FontWeight.normal,
    ),
  ),

  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all(HexColor('#5DB3C2')),
      textStyle :MaterialStateProperty.all(TextStyle(
        color: HexColor('#5DB3C2'),
      )),
    ),
  ),
  buttonTheme: ButtonThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor)
  ),
  colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
  appBarTheme: const AppBarTheme(
    titleSpacing: 20.0,
    backgroundColor: Colors.white,
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20.0,
      fontWeight: FontWeight.w500,
    ),
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
  ),
  floatingActionButtonTheme:  FloatingActionButtonThemeData(
    backgroundColor: Colors.white,
    foregroundColor: AppColors.floatingActionButtonColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(9.0),
    ),
    elevation: 7.0,
  ),
  bottomNavigationBarTheme:  BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: AppColors.primaryColor,
    elevation: 20.0,
    backgroundColor: Colors.white,
  ),
  textTheme:  TextTheme(
    bodySmall: TextStyle(
      fontSize: 13.0,
      color: Colors.grey[600],
    ),
    headlineMedium: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w500,

    ),
    bodyLarge: const TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 18.0,
      color: Colors.black,
    ),

    titleMedium: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 14.0,
      color: Colors.black,
      height: 1.3,
    ),
  ),
  scaffoldBackgroundColor: Colors.white,
);
