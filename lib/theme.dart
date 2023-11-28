import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

double smallFontSize(double size) {
  if (size.h > size.w) {
    return size.w;
  } else {
    return size.h;
  }
}

class LetsCrewTheme {
  // static const _lightFillColor = Color(0xffffffff);

  static final Color _lightFocusColor = Colors.black.withOpacity(0.12);

  static ThemeData lightThemeData =
      themeData(lightColorScheme, _lightFocusColor);

  static ThemeData themeData(ColorScheme colorScheme, Color focusColor) {
    return ThemeData(
      colorScheme: colorScheme,
      // fontFamily: '',
      textTheme: Platform.isIOS ? textThemeIOS : textThemeDefault,
      primaryColor: colorScheme.primary,
      backgroundColor: Colors.white,
      dividerColor: colorScheme.tertiary,
    );
  }

  static const ColorScheme lightColorScheme = ColorScheme(
    primary: Color(0xFFFFFFFF),
    onPrimary: Colors.black,
    secondary: Color(0xFFFCCF5D), //Color(0xff3fa9f5) - 기존 color
    tertiary: Color.fromARGB(255, 255, 231, 143),
    onSecondary: Color(0xFFFFFFFF),
    error: Color(0xffb00020),
    onError: Colors.white,
    background: Color(0xFFFFFFFF),
    onBackground: Color(0xFFF1F1F1),
    surface: Color(0xFFFFFFFF),
    onSurface: Colors.black,
    brightness: Brightness.light,
  );

  static TextTheme textThemeDefault = TextTheme(
    headline1: TextStyle(fontSize: smallFontSize(38), fontFamily: 'Black'),
    headline2: TextStyle(fontSize: smallFontSize(30), fontFamily: 'Bold'),
    headline3: TextStyle(fontSize: smallFontSize(22), fontFamily: 'Bold'),
    subtitle1: TextStyle(fontSize: smallFontSize(18), fontFamily: 'Medium'),
    subtitle2: TextStyle(fontSize: smallFontSize(14), fontFamily: 'SemiBold'),
    bodyText1: TextStyle(fontSize: smallFontSize(14), fontFamily: 'Regular'),
    bodyText2: TextStyle(fontSize: smallFontSize(11), fontFamily: 'Regular'),
  );
  static TextTheme textThemeHeading = TextTheme(
    headline1: TextStyle(fontSize: smallFontSize(38), fontFamily: 'Montserrat'),
    headline2: TextStyle(fontSize: smallFontSize(30), fontFamily: 'Bold'),
    bodyText1: TextStyle(fontSize: smallFontSize(18), fontFamily: 'Montserrat'),
  );

  static TextTheme textThemeIOS = TextTheme(
    headline1: TextStyle(fontSize: smallFontSize(40), fontFamily: 'Black'),
    headline2: TextStyle(fontSize: smallFontSize(32), fontFamily: 'Bold'),
    headline3: TextStyle(fontSize: smallFontSize(24), fontFamily: 'Bold'),
    subtitle1: TextStyle(fontSize: smallFontSize(20), fontFamily: 'Medium'),
    subtitle2: TextStyle(fontSize: smallFontSize(16), fontFamily: 'SemiBold'),
    bodyText1: TextStyle(fontSize: smallFontSize(16), fontFamily: 'Regular'),
    bodyText2: TextStyle(fontSize: smallFontSize(13), fontFamily: 'Regular'),
  );
}
