import 'package:flutter/material.dart';
import 'package:taskati_app/core/utils/text_style.dart';

import 'colors.dart';

class AppTheme {
  static final lightMode = ThemeData(

      timePickerTheme: const TimePickerThemeData(
          backgroundColor: AppColors.whiteColor,
          dialBackgroundColor: AppColors.whiteColor),
      datePickerTheme:
          const DatePickerThemeData(backgroundColor: AppColors.whiteColor),
      colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primaryColor, onSurface: AppColors.darkColor,onSecondary: AppColors.whiteColor),
      scaffoldBackgroundColor: AppColors.whiteColor,
      inputDecorationTheme: InputDecorationTheme(
        hintStyle:
            getSmallTextStyle(color: AppColors.darkColor, fontSize: 14),
        labelStyle: getSmallTextStyle(color: AppColors.darkColor),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide:
                const BorderSide(width: 1, color: AppColors.primaryColor)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide:
                const BorderSide(width: 3, color: AppColors.primaryColor)),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(width: 3, color: AppColors.redColor),
        ),
      ),
      appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primaryColor,
          foregroundColor: AppColors.whiteColor));

  static final darkMode=ThemeData(
      timePickerTheme: const TimePickerThemeData(
          backgroundColor: AppColors.darkColor,
          dialBackgroundColor: AppColors.darkColor
      ),
      datePickerTheme: const DatePickerThemeData(
          backgroundColor: AppColors.darkColor
      ),
      colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primaryColor,
          onSurface: AppColors.whiteColor,
          onSecondary: AppColors.darkColor
      ),
      scaffoldBackgroundColor: AppColors.darkColor,
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: getSmallTextStyle(
            color: AppColors.whiteColor, fontSize: 14),
        labelStyle: getSmallTextStyle(color: AppColors.whiteColor),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
                width: 1, color: AppColors.primaryColor)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
                width: 3, color: AppColors.primaryColor)),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide:
          const BorderSide(width: 3, color: AppColors.redColor),
        ),
      ),
      appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primaryColor
      )
  );
}
