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
        // bottomNavigationBar: BottomNavyBar(
        //   backgroundColor: MyTheme.isDarkTheme.value ? App.darkGrey : Colors.white,
        //   selectedIndex: mainClassController.selectedIndex.value,
        //   showElevation: true, // use this to remove appBar's elevation
        //   onItemSelected: (index) {
        //     mainClassController.selectedIndex.value = index;
        //     // mainClassController.pageController.animateToPage(index, duration: const Duration(milliseconds: 700), curve: Curves.fastOutSlowIn);
        //     mainClassController.pageController.jumpTo(index*MediaQuery.of(context).size.width);
        //   },
        //   items: [
        //     BottomNavyBarItem(
        //       icon: SizedBox(
        //         width: 30,
        //         height: 30,
        //         child: SvgPicture.asset(
        //             'assets/icons/home.svg',
        //           color: mainClassController.selectedIndex.value == 0
        //               ? MyTheme.isDarkTheme.value ? Colors.white : Theme.of(context).primaryColor : App.grey,
        //         ),
        //       ),
        //       title: Text(
        //           App_Localization.of(context).translate("home"),
        //         style: TextStyle(
        //           color: mainClassController.selectedIndex.value == 0
        //             ? MyTheme.isDarkTheme.value ? Colors.white : Theme.of(context).primaryColor : App.grey,
        //             fontSize: Global.langCode == "en" ? 15 : 10
        //         ),
        //       ),
        //       activeColor: Theme.of(context).primaryColor,
        //       textAlign: TextAlign.center
        //     ),
        //     BottomNavyBarItem(
        //       icon: Container(
        //         width: 30,
        //         height: 30,
        //         child: SvgPicture.asset(
        //             'assets/icons/order.svg',
        //           color: mainClassController.selectedIndex.value == 1
        //               ? MyTheme.isDarkTheme.value ? Colors.white : Theme.of(context).primaryColor : App.grey,
        //         ),
        //       ),
        //         title: Text(
        //           App_Localization.of(context).translate("orders"),
        //           style: TextStyle(
        //             color: mainClassController.selectedIndex.value == 1
        //                 ? MyTheme.isDarkTheme.value ? Colors.white : Theme.of(context).primaryColor : App.grey,),
        //         ),
        //       activeColor: Theme.of(context).primaryColor,
        //         textAlign: TextAlign.center
        //     ),
        //     BottomNavyBarItem(
        //       icon: Container(
        //         width: 30,
        //         height: 30,
        //         child: SvgPicture.asset(
        //             'assets/icons/profile.svg',
        //           color: mainClassController.selectedIndex.value == 2
        //               ? MyTheme.isDarkTheme.value ? Colors.white : Theme.of(context).primaryColor : App.grey,
        //         ),
        //       ),
        //         title: Text(
        //           App_Localization.of(context).translate("profile"),
        //           style: TextStyle(
        //             color: mainClassController.selectedIndex.value == 2
        //                 ? MyTheme.isDarkTheme.value ? Colors.white : Theme.of(context).primaryColor : App.grey,
        //           fontSize: Global.langCode == "en" ? 15 : 12
        //           ),
        //         ),
        //       activeColor: Theme.of(context).primaryColor,
        //         textAlign: TextAlign.center
        //
        //     ),
        //     BottomNavyBarItem(
        //       icon: Icon(
        //           Icons.settings,
        //         color: mainClassController.selectedIndex.value == 3
        //             ? MyTheme.isDarkTheme.value ? Colors.white : Theme.of(context).primaryColor : App.grey,
        //       ),
        //         title: Text(
        //           App_Localization.of(context).translate("settings"),
        //           style: TextStyle(
        //             color: mainClassController.selectedIndex.value == 3
        //                 ? MyTheme.isDarkTheme.value ? Colors.white : Theme.of(context).primaryColor : App.grey,),
        //         ),
        //       activeColor: Theme.of(context).primaryColor,
        //         textAlign: TextAlign.center
        //
        //     ),
        //   ],
        // ),
        // body: SafeArea(
        //   child: PageView(
        //     controller: mainClassController.pageController,
        //     onPageChanged: (index){
        //     //  print(index);
        //      mainClassController.selectedIndex.value = index;
        //     },
        //      // physics: NeverScrollableScrollPhysics(),
        //     children: [
        //      ` Home(),
        //       OrderPage(),
        //       Profile(),
        //       Settings()`
        //     ],
        //   ),
        // ),
        body: PersistentTabView(
          context,
          screens: [
            Home(),
            OrderPage(),
            Profile(),
            Settings()
          ],
          items: _navBarsItems(context),
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
        activeColorPrimary: Theme.of(context).primaryColor,
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
        activeColorPrimary: Theme.of(context).primaryColor,
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
        activeColorPrimary: Theme.of(context).primaryColor,
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
        activeColorSecondary: Colors.white,
        activeColorPrimary: Theme.of(context).primaryColor,
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
