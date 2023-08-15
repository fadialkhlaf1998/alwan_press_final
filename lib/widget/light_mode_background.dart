import 'package:alwan_press/helper/myTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class LightModeBackground extends StatelessWidget {

  bool withBackground;
  LightModeBackground({this.withBackground = false});

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          color: MyTheme.isDarkTheme.value ?Color(0xff2a2b2c):Colors.white,
          image: withBackground
              ?DecorationImage(image: AssetImage("assets/image/background.png"),fit: BoxFit.cover)
              :null
      ),

      // color: Colors.white,
      // child: Lottie.asset(
      //     'assets/animation/BG.json',
      //   fit: BoxFit.cover
      // ),
    );
  }
}
