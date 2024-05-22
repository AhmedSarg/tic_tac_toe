import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.gridLineColor,
    scaffoldBackgroundColor: AppColors.backgroundColor,
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: AppColors.lightModalBottomSheetColor,
      modalBackgroundColor: AppColors.lightModalBottomSheetColor,
    ),
    textTheme: TextTheme(
      headlineLarge: TextStyle(
        color: AppColors.primaryTextColor,
        fontFamily: GoogleFonts.zcoolKuaiLe().fontFamily,
        fontWeight: FontWeight.w700,
        fontSize: 50,
      ),
      headlineMedium: TextStyle(
        color: AppColors.primaryTextColor,
        fontWeight: FontWeight.w500,
        fontFamily: GoogleFonts.zcoolKuaiLe().fontFamily,
        fontSize: 30,
      ),
      headlineSmall: TextStyle(
        color: AppColors.primaryTextColor,
        fontWeight: FontWeight.w300,
        fontFamily: GoogleFonts.zcoolKuaiLe().fontFamily,
        fontSize: 20,
      ),
      bodyLarge: TextStyle(
        color: AppColors.primaryTextColor,
        fontFamily: GoogleFonts.abel().fontFamily,
        fontSize: 40,
        fontWeight: FontWeight.w700,
      ),
      bodyMedium: TextStyle(
        color: AppColors.primaryTextColor,
        fontFamily: GoogleFonts.abel().fontFamily,
        fontSize: 30,
        fontWeight: FontWeight.w500,
      ),
      bodySmall: TextStyle(
        color: AppColors.primaryTextColor,
        fontFamily: GoogleFonts.abel().fontFamily,
        fontSize: 20,
        fontWeight: FontWeight.w300,
      ),
      displayLarge: TextStyle(
        fontSize: 100,
        fontFamily: GoogleFonts.gabarito().fontFamily,
        fontWeight: FontWeight.w900,
      ),
      labelLarge: TextStyle(
        color: AppColors.buttonTextColor,
        fontFamily: GoogleFonts.zcoolKuaiLe().fontFamily,
        fontSize: 24,
        fontWeight: FontWeight.w600,
      ),
      labelMedium: TextStyle(
        color: AppColors.buttonTextColor,
        fontFamily: GoogleFonts.zcoolKuaiLe().fontFamily,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      labelSmall: TextStyle(
        color: AppColors.buttonTextColor,
        fontFamily: GoogleFonts.zcoolKuaiLe().fontFamily,
        fontSize: 12,
        fontWeight: FontWeight.w200,
      ),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: AppColors.buttonBackgroundColor,
      textTheme: ButtonTextTheme.primary,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.buttonBackgroundColor,
        foregroundColor: AppColors.buttonTextColor,
        disabledForegroundColor: AppColors.disabledTextColor,
      ),
    ),
    appBarTheme: const AppBarTheme(
      color: AppColors.gridLineColor,
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: AppColors.gridLineColor,
      secondary: AppColors.buttonHoverColor,
      surface: AppColors.backgroundColor,
      error: Colors.red,
      onPrimary: AppColors.buttonTextColor,
      onSecondary: AppColors.buttonTextColor,
      onSurface: AppColors.primaryTextColor,
      onError: AppColors.buttonTextColor,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.buttonBackgroundColor,
      foregroundColor: AppColors.buttonTextColor,
    ),
    cardTheme: const CardTheme(color: AppColors.buttonBackgroundColor),
    dividerTheme: const DividerThemeData(
      color: AppColors.darkPrimaryTextColor,
    ),
    iconTheme: const IconThemeData(
      color: AppColors.darkPrimaryTextColor,
    ),
    dialogTheme:
        const DialogTheme(backgroundColor: AppColors.buttonBackgroundColor),
  );

  static ThemeData darkTheme = ThemeData(
      primaryColor: AppColors.darkGridLineColor,
      scaffoldBackgroundColor: AppColors.darkBackgroundColor,
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.darkModalBottomSheetColor,
        modalBackgroundColor: AppColors.darkModalBottomSheetColor,
      ),
      textTheme: TextTheme(
        headlineLarge: TextStyle(
          color: AppColors.darkPrimaryTextColor,
          fontFamily: GoogleFonts.zcoolKuaiLe().fontFamily,
          fontWeight: FontWeight.w700,
          fontSize: 50,
        ),
        headlineMedium: TextStyle(
          color: AppColors.darkPrimaryTextColor,
          fontWeight: FontWeight.w500,
          fontFamily: GoogleFonts.zcoolKuaiLe().fontFamily,
          fontSize: 30,
        ),
        headlineSmall: TextStyle(
          color: AppColors.darkPrimaryTextColor,
          fontWeight: FontWeight.w300,
          fontFamily: GoogleFonts.zcoolKuaiLe().fontFamily,
          fontSize: 20,
        ),
        bodyLarge: TextStyle(
          color: AppColors.darkPrimaryTextColor,
          fontFamily: GoogleFonts.abel().fontFamily,
          fontSize: 40,
          fontWeight: FontWeight.w700,
        ),
        bodyMedium: TextStyle(
          color: AppColors.darkPrimaryTextColor,
          fontFamily: GoogleFonts.abel().fontFamily,
          fontSize: 30,
          fontWeight: FontWeight.w500,
        ),
        bodySmall: TextStyle(
          color: AppColors.darkPrimaryTextColor,
          fontFamily: GoogleFonts.abel().fontFamily,
          fontSize: 20,
          fontWeight: FontWeight.w300,
        ),
        displayLarge: TextStyle(
          fontSize: 100,
          fontFamily: GoogleFonts.gabarito().fontFamily,
          fontWeight: FontWeight.w900,
          shadows: [
            BoxShadow(
              color: Colors.blue.withOpacity(.5),
              blurRadius: 20,
              offset: const Offset(0, 20),
            ),
          ],
        ),
        labelLarge: TextStyle(
          color: AppColors.darkButtonTextColor,
          fontFamily: GoogleFonts.zcoolKuaiLe().fontFamily,
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
        labelMedium: TextStyle(
          color: AppColors.darkButtonTextColor,
          fontFamily: GoogleFonts.zcoolKuaiLe().fontFamily,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        labelSmall: TextStyle(
          color: AppColors.darkButtonTextColor,
          fontFamily: GoogleFonts.zcoolKuaiLe().fontFamily,
          fontSize: 12,
          fontWeight: FontWeight.w200,
        ),
      ),
      buttonTheme: const ButtonThemeData(
        buttonColor: AppColors.darkButtonBackgroundColor,
        textTheme: ButtonTextTheme.primary,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.darkButtonBackgroundColor,
          foregroundColor: AppColors.darkButtonTextColor,
          disabledForegroundColor: AppColors.darkDisabledTextColor,
        ),
      ),
      appBarTheme: const AppBarTheme(
        color: AppColors.darkGridLineColor,
      ),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: AppColors.darkGridLineColor,
        secondary: AppColors.darkButtonHoverColor,
        surface: AppColors.darkBackgroundColor,
        error: Colors.red,
        onPrimary: AppColors.darkButtonTextColor,
        onSecondary: AppColors.darkButtonTextColor,
        onSurface: AppColors.darkPrimaryTextColor,
        onError: AppColors.darkButtonTextColor,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.darkButtonBackgroundColor,
        foregroundColor: AppColors.darkButtonTextColor,
      ),
      cardTheme: const CardTheme(color: AppColors.scoreboardTextColor),
      dividerTheme: const DividerThemeData(
        color: AppColors.darkPrimaryTextColor,
      ),
      iconTheme: const IconThemeData(
        color: AppColors.darkPrimaryTextColor,
      ),
      dialogTheme: DialogTheme(backgroundColor: AppColors.scoreboardTextColor));
}
