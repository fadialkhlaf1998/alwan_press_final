import 'package:alwan_press/app_localization.dart';
import 'package:alwan_press/controller/main_class_controller.dart';
import 'package:alwan_press/helper/app.dart';
import 'package:alwan_press/helper/global.dart';
import 'package:alwan_press/helper/myTheme.dart';
import 'package:alwan_press/main.dart';
import 'package:alwan_press/view/home.dart';
import 'package:alwan_press/view/order.dart';
import 'package:alwan_press/view/profile.dart';
import 'package:alwan_press/view/settings.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class MainClass extends StatelessWidget {

  MainClassController mainClassController = Get.put(MainClassController());

  MainClass(){
    Future.delayed(const Duration(milliseconds: 200)).then((value) {
      mainClassController.selectedIndex.value=0;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Obx((){
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarColor: MyTheme.isDarkTheme.value ? const Color(0XFF181818) : Colors.white
      ));
      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: PersistentTabView(
          context,
          screens: [
            Home(),
            OrderPage(),
            Profile(),
            Settings()
          ],
          items: _navBarsItems(context),
          resizeToAvoidBottomInset: false,
          controller: mainClassController.bottomBarController,
          navBarStyle: NavBarStyle.style7,
          backgroundColor: MyTheme.isDarkTheme.value ? App.darkGrey : Colors.white,
          decoration: NavBarDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight:Radius.circular(15),
            ),
            boxShadow: [
              MyTheme.isDarkTheme.value ?
                BoxShadow(
                color: Colors.grey.withOpacity(0),
                spreadRadius: 1,
                blurRadius: 7,
                offset: const Offset(0, 2),
              )
                  : BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                spreadRadius: 1,
                blurRadius: 7,
                offset: const Offset(0, 2),
              ),
            ],
            colorBehindNavBar: Colors.white,
          ),
          itemAnimationProperties: const ItemAnimationProperties(
            duration: Duration(milliseconds: 600),
            curve: Curves.fastOutSlowIn,
          ),
          screenTransitionAnimation: const ScreenTransitionAnimation(
            animateTabTransition: true,
            curve: Curves.fastOutSlowIn,
            duration: Duration(milliseconds: 600),
          ),
        ),
      );
    });
  }


  List<PersistentBottomNavBarItem> _navBarsItems(context){
    return [
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
              'assets/icons/home.svg',
          ),
        title: App_Localization.of(context).translate('home'),
        activeColorSecondary: Colors.white,
        activeColorPrimary: Color(0xffEC008C),
        inactiveColorPrimary: App.grey,
        inactiveIcon: SvgPicture.asset(
          'assets/icons/home.svg',
          color:  App.grey,
        ),
      ),
      PersistentBottomNavBarItem(
        icon:  SvgPicture.asset(
              'assets/icons/order.svg',
          color: Colors.white,
        ),
        title: Global.langCode=="ar"?"   "+App_Localization.of(context).translate('orders'):App_Localization.of(context).translate('orders'),
        activeColorSecondary: Colors.white,
        activeColorPrimary: Color(0xff0072BC),
        inactiveColorPrimary: App.grey,
        inactiveIcon: SvgPicture.asset(
          'assets/icons/order.svg',
          color:  App.grey,
        ),
      ),
      PersistentBottomNavBarItem(
        icon:  SvgPicture.asset(
          'assets/icons/profile.svg',
          color: Colors.white,
        ),
        title: App_Localization.of(context).translate('profile'),
        activeColorSecondary: Colors.white,
        activeColorPrimary:  Color(0xffA3228E),
        inactiveColorPrimary: App.grey,
        inactiveIcon: SvgPicture.asset(
          'assets/icons/profile.svg',
          color:  App.grey,
        ),
      ),
      PersistentBottomNavBarItem(
        icon:  SvgPicture.asset(
          'assets/icons/setting.svg',
          width: 30,
          height: 30,
          color: Colors.white,
        ),
        title: App_Localization.of(context).translate('settings'),
        // textStyle: TextStyle(shadows: [Shadow(color: Colors.black,blurRadius: 18)],fontSize: 12),
        activeColorSecondary: Colors.white,
        activeColorPrimary:  Color(0xffBED82D).withOpacity(0.7),
        inactiveColorPrimary: App.grey,
        inactiveIcon: SvgPicture.asset(
          'assets/icons/setting.svg',
          width: 30,
          height: 30,
          color:  App.grey,
        ),
      ),
    ];
  }

}
