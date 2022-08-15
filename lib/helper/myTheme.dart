import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class MyTheme with ChangeNotifier {

  static RxBool isDarkTheme = false.obs;

  ThemeMode get myTheme => isDarkTheme.value ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    isDarkTheme.value = !isDarkTheme.value;
    notifyListeners();
  }

  static ThemeData get lightTheme {

    return ThemeData(
        primarySwatch: generateMaterialColor(const Color(0XFFA3228E)),
        fontFamily: "Poppins",
        primaryColor: const Color(0XFFA3228E),
        dividerColor: const Color(0XFF8e8e8e),
        disabledColor: Colors.black,
        iconTheme: const IconThemeData(color: Color(0XFF8e8e8e)),
        backgroundColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        textTheme: const TextTheme(
          headline1: TextStyle(color: Colors.black,fontSize: 18),
          headline2: TextStyle(color: Colors.black,fontSize: 16,fontFamily: "Poppins",fontWeight: FontWeight.bold),
          headline3: TextStyle(color: Colors.black,fontSize: 14,fontFamily: "Poppins",fontWeight: FontWeight.bold),
          headline4: TextStyle(color: Colors.black,fontSize: 12,fontFamily: "Poppins"),
          bodyText1: TextStyle(color: Colors.black,fontSize: 18,fontFamily: "Poppins",fontWeight: FontWeight.bold),
          bodyText2: TextStyle(color: Colors.black,fontSize: 14,fontFamily: "Poppins"),
          // bodyMedium: TextStyle(color: Colors.black,fontSize: 15,fontFamily: "OpenSans"),
          // bodySmall: TextStyle(color: Colors.black,fontSize: 12,fontFamily: "OpenSans"),
        ));
  }

  static ThemeData get darkTheme {
    return ThemeData(
        primarySwatch: generateMaterialColor(const Color(0XFFA3228E)),
        fontFamily: "Poppins",
        primaryColor: const Color(0XFFA3228E),
        dividerColor: Colors.white,
        disabledColor: Colors.white,
        iconTheme: const IconThemeData(color: Color(0XFF8e8e8e)),
        backgroundColor: const Color(0XFF181818),
        scaffoldBackgroundColor: const Color(0XFF181818),
        textTheme: const TextTheme(
          headline1: TextStyle(color: Colors.white,fontSize: 18),
          headline2: TextStyle(color: Colors.white,fontSize: 16,fontFamily: "Poppins",fontWeight: FontWeight.bold),
          headline3: TextStyle(color: Colors.white,fontSize: 14,fontFamily: "Poppins",fontWeight: FontWeight.bold),
          headline4: TextStyle(color: Colors.white,fontSize: 12,fontFamily: "Poppins"),
          bodyText1: TextStyle(color: Colors.white,fontSize: 18,fontFamily: "Poppins",fontWeight: FontWeight.bold),
          bodyText2: TextStyle(color: Colors.white,fontSize: 14,fontFamily: "Poppins"),
          // bodyMedium: TextStyle(color: Colors.white,fontSize: 15,fontFamily: "OpenSans"),
          // bodySmall: TextStyle(color: Colors.white,fontSize: 12,fontFamily: "OpenSans"),
        ));
  }
}

MaterialColor generateMaterialColor(Color color) {
  return MaterialColor(color.value, {
    50: tintColor(color, 0.9),
    100: tintColor(color, 0.8),
    200: tintColor(color, 0.6),
    300: tintColor(color, 0.4),
    400: tintColor(color, 0.2),
    500: color,
    600: shadeColor(color, 0.1),
    700: shadeColor(color, 0.2),
    800: shadeColor(color, 0.3),
    900: shadeColor(color, 0.4),
  });
}

Color tintColor(Color color, double factor) => Color.fromRGBO(
    tintValue(color.red, factor),
    tintValue(color.green, factor),
    tintValue(color.blue, factor),
    1);

int tintValue(int value, double factor) =>
    max(0, min((value + ((255 - value) * factor)).round(), 255));

Color shadeColor(Color color, double factor) => Color.fromRGBO(
    shadeValue(color.red, factor),
    shadeValue(color.green, factor),
    shadeValue(color.blue, factor),
    1);

int shadeValue(int value, double factor) =>
    max(0, min(value - (value * factor).round(), 255));

