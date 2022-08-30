import 'package:alwan_press/app_localization.dart';
import 'package:alwan_press/controller/main_class_controller.dart';
import 'package:alwan_press/helper/app.dart';
import 'package:alwan_press/helper/global.dart';
import 'package:alwan_press/helper/myTheme.dart';
import 'package:alwan_press/view/home.dart';
import 'package:alwan_press/view/order.dart';
import 'package:alwan_press/view/profile.dart';
import 'package:alwan_press/view/settings.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class MainClass extends StatelessWidget {

  MainClassController mainClassController = Get.put(MainClassController());

  MainClass(){
    Future.delayed(Duration(milliseconds: 200)).then((value) {
      mainClassController.selectedIndex.value=0;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Obx((){
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarColor: MyTheme.isDarkTheme.value?Color(0XFF181818):Colors.white
      ));
      return Scaffold(
        // appBar: AppBar(
        //     elevation: 0,
        //     toolbarHeight: 0,
        //     systemOverlayStyle: const SystemUiOverlayStyle(
        //       statusBarColor: Color(0XFF181818),
        //     ),
        // ),
        bottomNavigationBar: BottomNavyBar(
          backgroundColor: MyTheme.isDarkTheme.value ? App.darkGrey : Colors.white,
          selectedIndex: mainClassController.selectedIndex.value,
          showElevation: true, // use this to remove appBar's elevation
          onItemSelected: (index) {
            mainClassController.selectedIndex.value = index;
            // mainClassController.pageController.animateToPage(index, duration: const Duration(milliseconds: 700), curve: Curves.fastOutSlowIn);
            mainClassController.pageController.jumpTo(index*MediaQuery.of(context).size.width);
          },
          items: [
            BottomNavyBarItem(
              icon: Container(
                width: 30,
                height: 30,
                child: SvgPicture.asset(
                    'assets/icons/home.svg',
                  color: mainClassController.selectedIndex.value == 0
                      ? MyTheme.isDarkTheme.value ? Colors.white : App.pink : App.grey,
                ),
              ),
              title: Text(
                  App_Localization.of(context).translate("home"),
                style: TextStyle(
                  color: mainClassController.selectedIndex.value == 0
                    ? MyTheme.isDarkTheme.value ? Colors.white : App.pink : App.grey,
                    fontSize: Global.langCode == "en" ? 15 : 10
                ),
              ),
              activeColor: App.pink,
              textAlign: TextAlign.center
            ),
            BottomNavyBarItem(
              icon: Container(
                width: 30,
                height: 30,
                child: SvgPicture.asset(
                    'assets/icons/order.svg',
                  color: mainClassController.selectedIndex.value == 1
                      ? MyTheme.isDarkTheme.value ? Colors.white : App.pink : App.grey,
                ),
              ),
                title: Text(
                  App_Localization.of(context).translate("orders"),
                  style: TextStyle(
                    color: mainClassController.selectedIndex.value == 1
                        ? MyTheme.isDarkTheme.value ? Colors.white : App.pink : App.grey,),
                ),
              activeColor: App.pink,
                textAlign: TextAlign.center
            ),
            BottomNavyBarItem(
              icon: Container(
                width: 30,
                height: 30,
                child: SvgPicture.asset(
                    'assets/icons/profile.svg',
                  color: mainClassController.selectedIndex.value == 2
                      ? MyTheme.isDarkTheme.value ? Colors.white : App.pink : App.grey,
                ),
              ),
                title: Text(
                  App_Localization.of(context).translate("profile"),
                  style: TextStyle(
                    color: mainClassController.selectedIndex.value == 2
                        ? MyTheme.isDarkTheme.value ? Colors.white : App.pink : App.grey,
                  fontSize: Global.langCode == "en" ? 15 : 12
                  ),
                ),
              activeColor: App.pink,
                textAlign: TextAlign.center

            ),
            BottomNavyBarItem(
              icon: Icon(
                  Icons.settings,
                color: mainClassController.selectedIndex.value == 3
                    ? MyTheme.isDarkTheme.value ? Colors.white : App.pink : App.grey,
              ),
                title: Text(
                  App_Localization.of(context).translate("settings"),
                  style: TextStyle(
                    color: mainClassController.selectedIndex.value == 3
                        ? MyTheme.isDarkTheme.value ? Colors.white : App.pink : App.grey,),
                ),
              activeColor: App.pink,
                textAlign: TextAlign.center

            ),
          ],
        ),
        body: SafeArea(
          child: PageView(
            controller: mainClassController.pageController,
            onPageChanged: (index){
            //  print(index);
             mainClassController.selectedIndex.value = index;
            },
             // physics: NeverScrollableScrollPhysics(),
            children: [
              Home(),
              OrderPage(),
              Profile(),
              Settings()
            ],
          ),
        ),
      );
    });
  }

}
