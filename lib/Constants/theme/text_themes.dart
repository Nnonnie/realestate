import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../colors.dart';
import '../size_constants.dart';

class TextThemes {
  const TextThemes._();

  static getTextTheme() {
    return TextTheme(
      titleLarge: whiteHeadLine6,
      headlineSmall: whiteHeadline5,
      headlineLarge: whiteLargeHeadline,
      titleMedium: whiteSubtitle1,
      labelLarge: whiteButtonText,
      bodyLarge: orangeButtonText,
      bodyMedium: whiteBodyText2,
    );
  }

  static TextTheme get _poppinsTextTheme => GoogleFonts.poppinsTextTheme();

  static TextStyle get whiteButtonText => _poppinsTextTheme.button!.copyWith(
        fontSize: Sizes.s16,
        color: Palette.deardGrey,
      );

  static TextStyle get orangeButtonText => _poppinsTextTheme.button!.copyWith(
      fontSize: Sizes.s14, color: Palette.black, fontWeight: FontWeight.bold);

  static TextStyle get greyTextText => _poppinsTextTheme.button!.copyWith(
        fontSize: Sizes.s14,
        color: Palette.deardGrey,
      );

  static TextStyle get OrangeTextText => _poppinsTextTheme.button!.copyWith(
        fontSize: Sizes.s14,
        color: Palette.Orange,
      );

  static TextStyle get whiteSubtitle1 => _poppinsTextTheme.subtitle1!.copyWith(
        color: Palette.white,
        fontSize: Sizes.s16,
      );

  static TextStyle get whiteBodyText2 => _poppinsTextTheme.bodyText2!.copyWith(
        color: Palette.white,
        fontSize: Sizes.s14,
        wordSpacing: 0.25,
        letterSpacing: 0.25,
        height: 1.5,
      );

  static TextStyle get whiteHeadline5 => _poppinsTextTheme.headline5!.copyWith(
        fontSize: Sizes.s20,
        color: Palette.deardGrey,
      );

  static TextStyle get greyBigWeightline5 =>
      _poppinsTextTheme.headline5!.copyWith(
        fontSize: Sizes.s32,
        color: Palette.deardGrey,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get whiteWeightline5 =>
      _poppinsTextTheme.headline5!.copyWith(
        fontSize: Sizes.s32,
        color: Palette.white,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get whiteHeadLine6 {
    return _poppinsTextTheme.headline6!.copyWith(
      fontSize: Sizes.s32,
      color: Palette.black,
    );
  }

  static TextStyle get whiteLargeHeadline {
    return _poppinsTextTheme.displayLarge!.copyWith(
      fontSize: Sizes.s40,
      color: Palette.white,
    );
  }
}

extension TextThemeExtension on TextTheme {
  TextStyle get royalBlueSubtitle1 => subtitle1!.copyWith(
        color: Palette.Orange,
        fontWeight: FontWeight.w600,
      );
}
