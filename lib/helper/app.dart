import 'package:alwan_press/helper/myTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class App{

  static Color pink = const Color(0XFFA3228E);
  static Color darkGrey = const Color(0XFF31323B);
  static Color black = const Color(0XFF181818);
  static Color grey = const Color(0XFF8e8e8e);
  static Color lightGrey = const Color(0XFFf5f5f5);
  static Color blue = const Color(0XFF0f6db3);

  // static mySnackBar(title, description){
  //   return Get.snackbar(
  //     title,
  //     description,
  //     margin: EdgeInsets.only(top: 30,left: 25,right: 25),
  //     colorText: Colors.white,
  //   );
  // }
  static textColor(){
    if(MyTheme.isDarkTheme.value){
      return Colors.white;
    }else{
      return Colors.black;
    }
  }
}