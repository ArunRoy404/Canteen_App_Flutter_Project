import 'package:canteen_app/core/theme/pallet.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static  _border([Color color = AppPallete.borderColorWhite]) => OutlineInputBorder(
      borderSide: BorderSide(
        color: color,
        width: 1,
      ),
      borderRadius: BorderRadius.circular(5));
  static final darkThemeMode = ThemeData.dark().copyWith(
      scaffoldBackgroundColor: AppPallete.backgroundColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppPallete.backgroundColor
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: const TextStyle(color: AppPallete.whiteColor),
        enabledBorder: _border(),
        focusedBorder:_border(AppPallete.gradient2)
      ));

      static final lightThemeMode = ThemeData.dark().copyWith(
      scaffoldBackgroundColor: const Color.fromARGB(255, 209, 196, 233),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color.fromARGB(255, 179, 136, 255),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: const TextStyle(color: AppPallete.blackColor),
        fillColor: AppPallete.whiteColor,
        filled: true,
        enabledBorder: _border(),
        focusedBorder:_border(AppPallete.deepPurple)
      ));
}
