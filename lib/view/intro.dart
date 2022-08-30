import 'dart:ffi';

import 'package:alwan_press/controller/intro_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

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
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.black,
        ),
      ),
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
              child: SvgPicture.asset('assets/image/gredient.svg',fit: BoxFit.cover)
            ),
            Container(
                width: MediaQuery.of(context).size.width * 0.4,
                height: MediaQuery.of(context).size.height * 0.4,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/icons/logo.png')
                  )
                ),
            ),
          ],
        ),
      ),
    );
  }
}
