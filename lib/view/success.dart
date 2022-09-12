import 'package:alwan_press/app_localization.dart';
import 'package:alwan_press/helper/app.dart';
import 'package:alwan_press/helper/global.dart';
import 'package:alwan_press/helper/myTheme.dart';
import 'package:alwan_press/widget/darkModeBackground.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Success extends StatelessWidget {
  Success(){
    Future.delayed(Duration(milliseconds: 2500)).then((value) {
      Get.back();
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: MyTheme.isDarkTheme.value ? const Color(0XFF181818) : Colors.white
    ));
    return Obx(() => Scaffold(
      backgroundColor:  MyTheme.isDarkTheme.value? Colors.transparent:Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            MyTheme.isDarkTheme.value? const DarkModeBackground():Center(),
            SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height*0.9,
                child: Center(
                  child: Container(
                    // color: Colors.red,
                    height: MediaQuery.of(context).size.height*0.7,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // const SizedBox(height: 50,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Global.langCode == 'en' ?
                            SizedBox(
                                width: MediaQuery.of(context).size.width * 0.1,
                                height: MediaQuery.of(context).size.width * 0.1,
                                child: Image.asset(
                                  'assets/icons/Logo-Header.png',
                                  fit: BoxFit.cover,
                                )) : _logo(context),
                            const SizedBox(width: 7),
                            Global.langCode == 'en' ?
                            _logo(context)
                                : SizedBox(
                                width: MediaQuery.of(context).size.width * 0.1,
                                height: MediaQuery.of(context).size.width * 0.1,
                                child: Image.asset(
                                  'assets/icons/Logo-Header.png',
                                  fit: BoxFit.cover,
                                )),
                          ],
                        ),
                        const SizedBox(height: 1,),
                        const SizedBox(height: 1,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(App_Localization.of(context).translate("succ_title_1").toUpperCase(),style: TextStyle(color: MyTheme.isDarkTheme.value ?Colors.white:Colors.black,fontSize: 20),),
                          ],
                        ),

                        SvgPicture.asset("assets/icons/succ.svg",width: MediaQuery.of(context).size.width*0.55,),
                        const SizedBox(height: 1,),
                        const SizedBox(height: 1,),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(App_Localization.of(context).translate("succ_title_2"),style: TextStyle(color: MyTheme.isDarkTheme.value ?Colors.white:Colors.black,fontSize: 18),),
                              ],
                            ),

                            const SizedBox(height: 5,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(App_Localization.of(context).translate("succ_title_3"),style: TextStyle(color: MyTheme.isDarkTheme.value ?Colors.white:Colors.black,fontSize: 18),),
                              ],
                            ),
                            const SizedBox(height: 5,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(App_Localization.of(context).translate("succ_title_4"),style: TextStyle(color: App.blue,fontSize: 20,fontWeight: FontWeight.bold),),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
  _logo(context) {
    return  Container(
      height: MediaQuery.of(context).size.width * 0.1,
      width: MediaQuery.of(context).size.width * 0.28,
      decoration: BoxDecoration(
        // color: Colors.red,
          image: DecorationImage(
              fit: BoxFit.contain,
              image:  MyTheme.isDarkTheme.value ? AssetImage('assets/icons/logo_text.png') : AssetImage('assets/icons/logo_text_black.png')
          )),
    );
  }
}
