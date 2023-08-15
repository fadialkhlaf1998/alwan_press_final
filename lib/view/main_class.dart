import 'package:alwan_press/app_localization.dart';
import 'package:alwan_press/controller/main_class_controller.dart';
import 'package:alwan_press/helper/app.dart';
import 'package:alwan_press/helper/global.dart';
import 'package:alwan_press/helper/myTheme.dart';
import 'package:alwan_press/main.dart';
import 'package:alwan_press/view/home.dart';
import 'package:alwan_press/view/new_profile.dart';
import 'package:alwan_press/view/order.dart';
import 'package:alwan_press/view/profile.dart';
import 'package:alwan_press/view/settings.dart';
import 'package:alwan_press/view/wishlist.dart';
import 'package:bottom_bar_page_transition/bottom_bar_page_transition.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

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
        body: BottomBarPageTransition(
          totalLength: 4,
          transitionDuration: Duration(milliseconds: 0),
          transitionCurve: Curves.fastOutSlowIn,
          currentIndex: mainClassController.selectedIndex.value,
          builder: (context,index){
            return mainClassController.selectedIndex.value == 0
            ?Home()
            :mainClassController.selectedIndex.value == 1
                ?OrderPage()
                :mainClassController.selectedIndex.value == 2
                ?Wishlist()
                :NewProfile();
          },
        ),
        bottomNavigationBar:Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              // color: MyTheme.isDarkTheme.value ?Colors.black:Color(0xffededed),
              color:Colors.red,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10), topLeft: Radius.circular(10)),
              boxShadow: [
                BoxShadow(color: MyTheme.isDarkTheme.value ?Colors.black:Colors.black26, spreadRadius: 0, blurRadius: 10),
              ],
            ),
            child:  BottomNavigationBar(
              backgroundColor: App.containerColor(),
              currentIndex: mainClassController.selectedIndex.value,
              onTap: (index){
                mainClassController.selectedIndex.value = index;
              },
              selectedItemColor: App.lightPink,
              unselectedItemColor: App.textLightColor(),
              selectedFontSize: 11,
              unselectedFontSize: 11,
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(
                    icon:SvgPicture.asset(
                      'assets/icons/home.svg',
                      color: mainClassController.selectedIndex.value == 0 ?App.lightPink:App.textLightColor(),
                    ),
                    label:App_Localization.of(context).translate('home')
                ),
                BottomNavigationBarItem(
                    icon:SvgPicture.asset(
                      'assets/icons/order.svg',
                      color: mainClassController.selectedIndex.value == 1 ?App.lightPink:App.textLightColor(),
                    ),
                    label:App_Localization.of(context).translate('orders')
                ),
                BottomNavigationBarItem(
                    icon:Icon(Icons.favorite_border,color: mainClassController.selectedIndex.value == 2 ?App.lightPink:App.textLightColor(),),
                    label:App_Localization.of(context).translate('wishlist')
                ),
                BottomNavigationBarItem(
                    icon:SvgPicture.asset(
                      'assets/icons/profile.svg',
                      color: mainClassController.selectedIndex.value == 3 ?App.lightPink:App.textLightColor(),
                    ),
                    label:App_Localization.of(context).translate('profile')
                )
              ],
            )
        )

      );
    });
  }

  old(BuildContext context){
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
            Wishlist(),
            NewProfile()
          ],
          items: _navBarsItems(context),
          resizeToAvoidBottomInset: false,
          // controller: mainClassController.bottomBarController,
          navBarStyle: NavBarStyle.style6,
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
          //
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
          color: App.lightPink,
      ),
      title: App_Localization.of(context).translate('home'),
      activeColorSecondary: App.lightPink,
      activeColorPrimary: Color(0xffEC008C),
      inactiveColorPrimary: App.grey,

      inactiveIcon: Container(
        width: 40 ,
        height: 40,
        color: Colors.red,
        child: SvgPicture.asset(
          'assets/icons/home.svg',
        ),
      )
      ),
      PersistentBottomNavBarItem(
      icon:  SvgPicture.asset(
      'assets/icons/order.svg',
      color: App.lightPink,
      ),
      title: Global.langCode=="ar"?"   "+App_Localization.of(context).translate('orders'):App_Localization.of(context).translate('orders'),
      activeColorSecondary: App.lightPink,
      activeColorPrimary: Color(0xff0072BC),
      inactiveColorPrimary: App.grey,
      inactiveIcon: SvgPicture.asset(
      'assets/icons/order.svg',
      color:  App.lightLight,
      ),
      ),
      PersistentBottomNavBarItem(
      icon: Icon(Icons.favorite_border,color: App.lightPink,),
      title: App_Localization.of(context).translate('wishlist'),
      activeColorSecondary: App.lightPink,
      activeColorPrimary:  Color(0xffA3228E),
      inactiveColorPrimary: App.grey,
      inactiveIcon: Icon(Icons.favorite_border,color: App.lightLight,),
      ),
      PersistentBottomNavBarItem(
      icon: SvgPicture.asset(
      'assets/icons/profile.svg',
        color: App.lightPink,
      ),
      title: App_Localization.of(context).translate('profile'),
      activeColorSecondary: App.lightPink,
      activeColorPrimary:  App.yellow,
      inactiveColorPrimary: App.grey,
      inactiveIcon: SvgPicture.asset(
      'assets/icons/profile.svg',
      color:  App.lightLight,
      ),
      ),
    ];
  }


  List<PersistentBottomNavBarItem> _oldNavBarsItems(context){
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
        icon: Icon(Icons.favorite_border,color: Colors.white,),
        title: App_Localization.of(context).translate('wishlist'),
        activeColorSecondary: Colors.white,
        activeColorPrimary:  Color(0xffA3228E),
        inactiveColorPrimary: App.grey,
        inactiveIcon: Icon(Icons.favorite_border,color: App.grey,),
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          'assets/icons/profile.svg',
          color: App.darkGrey,
        ),
        title: App_Localization.of(context).translate('profile'),
        activeColorSecondary: App.darkGrey,
        activeColorPrimary:  App.yellow,
        inactiveColorPrimary: App.grey,
        inactiveIcon: SvgPicture.asset(
          'assets/icons/profile.svg',
          color:  App.grey,
        ),
      ),
    ];
  }



}
