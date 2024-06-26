import 'package:flutter/material.dart';

class ColorsStyle {
  static const Color primaryColor = Color(0xFF00a8e8);

  static const Color secondColor = Color(0xFF0059A7);
  static const Color orangeColor = Color(0xFFFF9900);
  static const Color redColor = Color(0xFFFF5C3A);
  static const Color greenColor = Color(0xFF4BC74F);
  static const Color greyColor = Color(0xFF696B77);
  static const Color inputColor = Color(0xFFEDEDED);
  static const Color lightGreyColor = Color(0xFFB5B5B5);
  static const Color darkGreyColor = Color(0xFF535763);
  static const Color whiteColor = Color(0xFFFFFFFF);
  static const Color blackColor = Color(0xFF1C242A);

  static MaterialColor primaryColorSwatch = MaterialColor(0xFFFFA200, color);

  static Map<int, Color> color = const {
    50: Color.fromRGBO(4, 131, 184, .1),
    100: Color.fromRGBO(4, 131, 184, .2),
    200: Color.fromRGBO(4, 131, 184, .3),
    300: Color.fromRGBO(4, 131, 184, .4),
    400: Color.fromRGBO(4, 131, 184, .5),
    500: Color.fromRGBO(4, 131, 184, .6),
    600: Color.fromRGBO(4, 131, 184, .7),
    700: Color.fromRGBO(4, 131, 184, .8),
    800: Color.fromRGBO(4, 131, 184, .9),
    900: Color.fromRGBO(4, 131, 184, 1),
  };
}
