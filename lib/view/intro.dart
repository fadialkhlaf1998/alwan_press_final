import 'dart:ffi';

import 'package:alwan_press/controller/intro_controller.dart';
import 'package:alwan_press/helper/myTheme.dart';
import 'package:alwan_press/widget/logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class Intro extends StatefulWidget {

  @override
  State<Intro> createState() => _IntroState();
}

class _IntroState extends State<Intro> {

  ScrollController scrollController = ScrollController();
  IntroController introController = Get.put(IntroController());

  @override
  void initState() {

    // introController.dispose();

    super.initState();
    Future.delayed(const Duration(milliseconds: 1000)).then((value){
      print('Animation');
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 2500),
        curve: Curves.fastOutSlowIn,
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Color(0XFF181818)
    ));
    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0,
      //   toolbarHeight: 0,
      //   systemOverlayStyle: const SystemUiOverlayStyle(
      //     statusBarColor: Colors.black,
      //   ),
      // ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                 controller: scrollController,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  // height:  MediaQuery.of(context).size.height*2,
                  child: Image.asset('assets/image/intro_background.png',fit: BoxFit.fitHeight),
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(image: AssetImage("assets/image/intro.png"),fit: BoxFit.cover)
              ),
            ),
            // Column(
            //   children: [
            //     SizedBox(height: 100,),
            //     Container(
            //       height: MediaQuery.of(context).size.width * 0.4,
            //       width: MediaQuery.of(context).size.width * 0.4,
            //       child: Lottie.asset("assets/icons/LogoAnimation.json"),
            //     ),
            //     // Logo(MediaQuery.of(context).size.width * 0.4),
            //   ],
            // )


          ],
        ),
      ),
    );
  }
}
