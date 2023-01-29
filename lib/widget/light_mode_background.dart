import 'package:alwan_press/helper/myTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class LightModeBackground extends StatelessWidget {
  const LightModeBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,

      color: Colors.white,
      // child: Lottie.asset(
      //     'assets/animation/BG.json',
      //   fit: BoxFit.cover
      // ),
    );
  }
}
