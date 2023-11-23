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
      // textTheme: _textTheme.apply(
      //     displayColor: Color(0xff343434), fontFamily: GoogleFonts
      //     .roboto()
      //     .fontFamily),
      // Matches manifest.json colors and background color.
      primaryColor: colorScheme.primary,
      // appBarTheme: AppBarTheme(
      //   textTheme: _textTheme.apply(bodyColor: colorScheme.onPrimary),
      //   color: colorScheme.background,
      //   elevation: 0,
      //   iconTheme: IconThemeData(color: colorScheme.primary),
      //   brightness: colorScheme.brightness,
      // ),
      backgroundColor: Colors.white,
      // inputDecorationTheme: InputDecorationTheme().copyWith(
      //     border: OutlineInputBorder(
      //       borderRadius: BorderRadius.circular(20.0),
      //       borderSide: BorderSide(
      //         color: Colors.white,
      //       ),
      //     )
      // ),
      // iconTheme: IconThemeData(color: colorScheme.onPrimary,),
      // canvasColor: colorScheme.background,
      // scaffoldBackgroundColor: colorScheme.background,
      // highlightColor: Colors.transparent,
      // accentColor: colorScheme.primary,
      // focusColor: focusColor,
      // buttonTheme: ButtonThemeData(
      //   disabledColor: Color(0x33000000),
      // ),
      // disabledColor: Colors.white,
      dividerColor: colorScheme.tertiary,
      // dividerTheme: const DividerThemeData(
      //   thickness: 0.3,
      // ),
      // floatingActionButtonTheme: FloatingActionButtonThemeData(
      //     backgroundColor: colorScheme.primary
      // ),
    );
  }

  static const ColorScheme lightColorScheme = ColorScheme(
    primary: Color(0xFFFFFFFF),
    onPrimary: Colors.black,
    secondary: Color(0xFFFCCF5D), //Color(0xff3fa9f5) - 기존 color
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
