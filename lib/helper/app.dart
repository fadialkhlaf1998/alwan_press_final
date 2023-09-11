import 'package:alwan_press/helper/myTheme.dart';
import 'package:alwan_press/widget/logo.dart';
import 'package:alwan_press/widget/logo_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class App{

  static Color pink = const Color(0XFF43c3b1);
  static Color lightPink = const Color(0xff43c3b1);
  static Color darkGrey = const Color(0XFF464646);
  static Color newDarkGrey = const Color(0XFF313131);
  static Color yellow = const Color(0xffBED82D);
  static Color blueLogo = const Color(0xff0072BC);
  static Color black = const Color(0XFF181818);
  static Color grey = const Color(0XFF8e8e8e);
  static Color lightGrey = const Color(0XFFededed);
  static Color blue = const Color(0XFF0f6db3);

  static Color textColor(){
    if(MyTheme.isDarkTheme.value){
      return Colors.white;
    }else{
      return Colors.black;
    }
  }
  static Color lightLight = Color(0xffc4c4c4);
  static Color textLightColor(){
    if(MyTheme.isDarkTheme.value){
      return Colors.white.withOpacity(0.5);
    }else{
      return lightLight;
    }
  }

  static Color lightMed = Color(0xff7D7D7D);
  static Color textMediumColor(){
    if(MyTheme.isDarkTheme.value){
      return Colors.white.withOpacity(0.5);
    }else{
      return lightMed;
    }
  }
  static mySnackBar(title, description){
    return Get.snackbar(
      title,
      description,
      margin: EdgeInsets.only(top: 30,left: 25,right: 25),
      colorText: Colors.white,
    );
  }

  static Color lightLG = Color(0xff7D7D7D);
  static Color textLgColor(){
    if(MyTheme.isDarkTheme.value){
      return Colors.white.withOpacity(0.5);
    }else{
      return lightLG;
    }
  }

  static Color containerColor(){
    return MyTheme.isDarkTheme.value ?
     App.newDarkGrey :
    Colors.white;
  }

  static BoxShadow myBoxShadow =  BoxShadow(color: MyTheme.isDarkTheme.value ?Colors.transparent:Colors.black26, spreadRadius: 0, blurRadius: 10);

  static logo(context) {
    return GestureDetector(
      onTap: (){
        // mainClassController.bottomBarController.jumpToTab(0);
      },
      child: Container(
        height: 45,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              curve: Curves.fastOutSlowIn,
              width: 35,
              height: 35,
              child: Logo(Get.width * 0.1),
            ),
            const SizedBox(width: 7),
            Container(
              height: 30,
              width: 70,
              child: LogoText(70),
            )
          ],
        ),
      ),
    );
  }
}