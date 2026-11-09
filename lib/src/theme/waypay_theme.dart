import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_style.dart';
import 'app_tokens.dart';

abstract final class WayPayTheme {
  static ThemeData get light {
    const primary = Color(AppColors.primary);
    final colorScheme = ColorScheme.fromSeed(
      seedColor: primary,
      brightness: Brightness.light,
      primary: primary,
      surface: const Color(AppColors.white),
      error: const Color(AppColors.red),
    );

    final outline = OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadii.control),
      borderSide: const BorderSide(color: Color(AppColors.borderColor)),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: const Color(AppColors.background),
      fontFamily: 'Manrope',
      appBarTheme: const AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Color(AppColors.background),
        foregroundColor: Color(AppColors.black),
        surfaceTintColor: Colors.transparent,
      ),
      textTheme:
          TextTheme(
            titleLarge: AppStyle.manrope(size: 22, weight: FontWeight.w700),
            titleMedium: AppStyle.manrope(size: 16, weight: FontWeight.w600),
            bodyLarge: AppStyle.manrope(size: 16, weight: FontWeight.w400),
            bodyMedium: AppStyle.manrope(size: 14, weight: FontWeight.w400),
            labelLarge: AppStyle.manrope(size: 16, weight: FontWeight.w600),
          ).apply(
            bodyColor: const Color(AppColors.black),
            displayColor: const Color(AppColors.black),
          ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(AppColors.white),
        border: outline,
        enabledBorder: outline,
        focusedBorder: outline.copyWith(
          borderSide: const BorderSide(color: primary, width: 1.5),
        ),
        errorBorder: outline.copyWith(
          borderSide: const BorderSide(color: Color(AppColors.red)),
        ),
        focusedErrorBorder: outline.copyWith(
          borderSide: const BorderSide(color: Color(AppColors.red), width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadii.control),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(AppColors.black),
          side: const BorderSide(color: Color(AppColors.borderColor)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadii.control),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadii.control),
          ),
        ),
      ),
      dividerTheme: const DividerThemeData(color: Color(0xFFE8ECF1)),
      progressIndicatorTheme: const ProgressIndicatorThemeData(color: primary),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Color(AppColors.white),
        surfaceTintColor: Colors.transparent,
        showDragHandle: false,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: const Color(AppColors.white),
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadii.modal),
        ),
      ),
    );
  }
}
