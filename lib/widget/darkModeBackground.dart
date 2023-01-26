import 'package:alwan_press/helper/myTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class DarkModeBackground extends StatelessWidget {
  const DarkModeBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Obx(() => Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,

      color: MyTheme.isDarkTheme.value ?Colors.black:Color(0xffF1F3F7),
      // child: Lottie.asset(
      //     'assets/animation/BG.json',
      //   fit: BoxFit.cover
      // ),
    ) );
  }
}
