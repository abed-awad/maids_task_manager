import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager/styles/color.dart';

class ThemesStyle {
  static final theme = ThemeData(
    useMaterial3: true,
    primarySwatch: ColorsStyle.primaryColorSwatch,
    fontFamily: 'Lato',
    scaffoldBackgroundColor: ColorsStyle.whiteColor,
    appBarTheme: AppBarTheme(
      backgroundColor: ColorsStyle.whiteColor,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18.sp,
        color: ColorsStyle.blackColor,
      ),
    ),
    dialogTheme: const DialogTheme(
      surfaceTintColor: ColorsStyle.whiteColor,
      backgroundColor: ColorsStyle.whiteColor,
    ),
  );

  static const gredientColor = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      ColorsStyle.primaryColor,
      ColorsStyle.secondColor,
    ],
  );
}
