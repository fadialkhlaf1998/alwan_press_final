import 'package:alwan_press/app_localization.dart';
import 'package:alwan_press/controller/order_controller.dart';
import 'package:alwan_press/helper/global.dart';
import 'package:alwan_press/helper/myTheme.dart';
import 'package:alwan_press/view/about_us.dart';
import 'package:alwan_press/view/contact_information.dart';
import 'package:alwan_press/view/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:alwan_press/controller/main_class_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class MyDrawer extends StatelessWidget {

  GlobalKey<ScaffoldState> _scaffoldkey;
  MainClassController mainClassController = Get.find();
  OrderController orderController = Get.find();

  MyDrawer(this._scaffoldkey);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width*0.75,
        color: MyTheme.isDarkTheme.value?Color(0xff272727):Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _logo(context),
            Container(
              width: MediaQuery.of(context).size.width*0.75,
              height: MediaQuery.of(context).size.width/2*0.75,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/image/about_us.webp"),
                      fit: BoxFit.cover
                  )
              ),
            ),
            GestureDetector(
              onTap: (){
                _scaffoldkey.currentState!.closeEndDrawer();
                Get.back();
                mainClassController.bottomBarController.jumpToTab(0);
              },
              child: Container(
                width: MediaQuery.of(context).size.width*0.75*0.75,
                height: 40,
                decoration: BoxDecoration(
                  color: Color(0xffe9098c),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomLeft:  Radius.circular(10)),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 20,),
                    SvgPicture.asset("assets/drawer/home.svg",color: Colors.white,),
                    SizedBox(width: 10,),
                    Text(App_Localization.of(context).translate("home"),style: TextStyle(color: Colors.white,fontSize: 16),)
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: (){
                if(Global.user != null){
                  orderController.loadPdf(Global.user!.financialState);
                }else{
                  Get.to(()=>SignIn());
                }
              },
              child: Container(
                width: MediaQuery.of(context).size.width*0.75*0.75,
                height: 40,
                decoration: BoxDecoration(
                  color: Color(0xff0a72b7),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomLeft:  Radius.circular(10)),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 20,),
                    SvgPicture.asset("assets/drawer/my_statement.svg",color: Colors.white,),
                    SizedBox(width: 10,),
                    Text(App_Localization.of(context).translate("my_statement"),style: TextStyle(color: Colors.white,fontSize: 16),)
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: (){
                Get.to(()=>ContactInformation());
              },
              child: Container(
                width: MediaQuery.of(context).size.width*0.75*0.75,
                height: 40,
                decoration: BoxDecoration(
                  color: Color(0xffbdd433),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomLeft:  Radius.circular(10)),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 20,),
                    SvgPicture.asset("assets/drawer/contact_us.svg",color: Colors.white,),
                    SizedBox(width: 10,),
                    Text(App_Localization.of(context).translate("connect_us"),style: TextStyle(color: Colors.white,fontSize: 16),)
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: (){
                _scaffoldkey.currentState!.closeEndDrawer();
                Get.back();
                mainClassController.bottomBarController.jumpToTab(1);
              },
              child: Container(
                width: MediaQuery.of(context).size.width*0.75*0.75,
                height: 40,
                decoration: BoxDecoration(
                  color: Color(0xffa0268c),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomLeft:  Radius.circular(10)),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 20,),
                    SvgPicture.asset("assets/drawer/my_order.svg",color: Colors.white,),
                    SizedBox(width: 10,),
                    Text(App_Localization.of(context).translate("my_order"),style: TextStyle(color: Colors.white,fontSize: 16),)
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: (){
                Get.to(()=>AboutUs());
              },
              child: Container(
                width: MediaQuery.of(context).size.width*0.75*0.75,
                height: 40,
                decoration: BoxDecoration(
                  color: Color(0xfffecb11),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomLeft:  Radius.circular(10)),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 20,),
                    SvgPicture.asset("assets/drawer/about_us.svg",color: Colors.white,),
                    SizedBox(width: 10,),
                    Text(App_Localization.of(context).translate("about_us"),style: TextStyle(color: Colors.white,fontSize: 16),)
                  ],
                ),
              ),
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(width: 10,),
                GestureDetector(
                  onTap: (){
                    Global.openUrl(Global.facebook);
                  },
                  child: SvgPicture.asset("assets/icons/facebook.svg",color: Colors.grey,height: 20,),),

                GestureDetector(
                  onTap: (){
                    Global.openUrl(Global.insta);
                  },
                  child: SvgPicture.asset("assets/icons/instagram.svg",color: Colors.grey,height: 18,),),

                GestureDetector(
                  onTap: (){
                    Global.openUrl(Global.twitter);
                  },
                  child: SvgPicture.asset("assets/icons/twitter.svg",color: Colors.grey,height: 18,),
                ),
                SizedBox(width: 10,),
              ],
            )
          ],
        ),
      ),
    );
  }

  _logo(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          curve: Curves.fastOutSlowIn,
          width: MediaQuery.of(context).size.width * 0.12,
          child: GestureDetector(
            onTap: () {
              // homeController.move();
              _scaffoldkey.currentState!.closeEndDrawer();
            },
            child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.12,
                height: MediaQuery.of(context).size.width * 0.12,
                child: Image.asset(
                  'assets/icons/Logo-Header.png',
                  fit: BoxFit.cover,
                )),
          ),
        ),
        const SizedBox(width: 7),
        Container(
          height: MediaQuery.of(context).size.width * 0.1,
          width: MediaQuery.of(context).size.width * 0.28,
          decoration: BoxDecoration(
            // color: Colors.red,
              image: DecorationImage(
                  fit: BoxFit.contain,
                  image: MyTheme.isDarkTheme.value ? const AssetImage('assets/icons/logo_text.png') : const AssetImage('assets/icons/logo_text_black.png')
              )),
        )
      ],
    );
  }
}
