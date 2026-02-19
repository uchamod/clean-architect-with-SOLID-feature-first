import 'package:clen_archetecture_bloc_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final appDarkTheme = ThemeData.dark(
    useMaterial3: true,
  ).copyWith(scaffoldBackgroundColor: AppColorPallete.backgroundColor);
  static final bodyTextTheme = GoogleFonts.poppins(
    color: AppColorPallete.whiteColor,
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );
  static final titleTextTheme = GoogleFonts.poppins(
    color: AppColorPallete.whiteColor,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
  static final subTitleTextTheme = GoogleFonts.poppins(
    color: AppColorPallete.whiteColor,
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );
  static final lableTextTheme = GoogleFonts.poppins(
    color: AppColorPallete.whiteColor,
    fontSize: 11,
    fontWeight: FontWeight.normal,
  );
}
