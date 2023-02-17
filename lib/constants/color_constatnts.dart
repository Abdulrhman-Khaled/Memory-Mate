import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color white = Color.fromARGB(255, 255, 255, 255);
  static const Color black = Color.fromARGB(255, 0, 0, 0);
  static const Color lightBlack = Color.fromARGB(255, 25, 25, 25);
  static const Color mintGreen = Color.fromARGB(255, 33, 159, 148);
  static const Color lightGrey = Color.fromARGB(255, 146, 138, 138);
  static const Color darkGrey = Color.fromARGB(255, 112, 112, 112);
  static const Color lightmintGreen = Color.fromARGB(255, 143, 207, 201);
  static const Color lightmintGreenOp = Color.fromARGB(214, 202, 228, 225);

  Map<int, Color> mainColor = {
    50: const Color.fromRGBO(33, 159, 148, .1),
    100: const Color.fromRGBO(33, 159, 148, .2),
    200: const Color.fromRGBO(33, 159, 148, .3),
    300: const Color.fromRGBO(33, 159, 148, .4),
    400: const Color.fromRGBO(33, 159, 148, .5),
    500: const Color.fromRGBO(33, 159, 148, .6),
    600: const Color.fromRGBO(33, 159, 148, .7),
    700: const Color.fromRGBO(33, 159, 148, .8),
    800: const Color.fromRGBO(33, 159, 148, .9),
    900: const Color.fromRGBO(33, 159, 148, 1),
  };
  late MaterialColor mintGreenMaterial = MaterialColor(0xFF219F94, mainColor);
}
