import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../shape/shape.dart';
import 'colors.dart';

class CustomTheme {
  static ThemeData lightTheme = ThemeData.light().copyWith(
    primaryColor: primaryColor,
scaffoldBackgroundColor: Colors.white,
    useMaterial3: false,
    dialogTheme: DialogTheme(shape: getShapeWidget(10), elevation: 5),
    iconTheme: const IconThemeData().copyWith(
      color: iconColor,
      size: ScreenUtil().setSp(20),
    ),
    floatingActionButtonTheme:
        const FloatingActionButtonThemeData(backgroundColor: primaryColor, elevation: 5),

    //
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        shape: getShapeWidget(10),
        alignment: Alignment.center,
        backgroundColor: primaryColor,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        shape: getShapeWidget(10),
        alignment: Alignment.center,
        side: const BorderSide(color: primaryColor),
        foregroundColor: primaryColor,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        shape: getShapeWidget(10),
        alignment: Alignment.center,
        foregroundColor: primaryColor,
      ),
    ),

    appBarTheme: AppBarTheme(centerTitle: false,color: whiteColor,iconTheme: IconThemeData(color: darkColor)),

    //
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: textFieldColor,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(7.5),
        gapPadding: 10,
        borderSide: const BorderSide(color: primary2Color, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(7.5),
        gapPadding: 10,
        borderSide: const BorderSide(color: Colors.red, width: 2),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(7.5),
        gapPadding: 10,
        borderSide: const BorderSide(color: Colors.red, width: 2),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(7.5),
        gapPadding: 10,
        borderSide: BorderSide(color: darkColor.withOpacity(0.0), width: 1),
      ),
      disabledBorder: OutlineInputBorder(
        gapPadding: 10,
        borderRadius: BorderRadius.circular(7.5),
        borderSide: BorderSide(color: darkColor.withOpacity(0.0), width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        gapPadding: 10,
        borderRadius: BorderRadius.circular(7.5),
        borderSide: BorderSide(color: darkColor.withOpacity(0.0), width: 1),
      ),
      iconColor: primary2Color,
      suffixIconColor: primary2Color,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    ),
  );
}
