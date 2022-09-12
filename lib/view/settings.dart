import 'package:alwan_press/app_localization.dart';
import 'package:alwan_press/controller/settings_controller.dart';
import 'package:alwan_press/helper/app.dart';
import 'package:alwan_press/helper/global.dart';
import 'package:alwan_press/helper/myTheme.dart';
import 'package:alwan_press/helper/store.dart';
import 'package:alwan_press/view/about_us.dart';
import 'package:alwan_press/view/connect_us.dart';
import 'package:alwan_press/view/language_list.dart';
import 'package:alwan_press/widget/darkModeBackground.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class Settings extends StatelessWidget {

  Settings() {
    if(Global.langCode == "en"){
      settingsController.selectedLanguage.value = 0;
      settingsController.languageName.value = "English";
    }else{
      settingsController.selectedLanguage.value = 1;
      settingsController.languageName.value = "العربية";
    }
  }
  SettingsController settingsController = Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: MyTheme.isDarkTheme.value ? const Color(0XFF181818) : Colors.white
    ));
    return Obx(() => Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            MyTheme.isDarkTheme.value? const DarkModeBackground():Center(),
            Column(
              children: [
                _header(context),
                const SizedBox(height: 10,),
                _body(context),
              ],
            )
          ],
        ),
      ),
    ));
  }

  _header(context){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.1,
      decoration: BoxDecoration(
        color: MyTheme.isDarkTheme.value ?  Colors.transparent : Colors.white,
      ),
      child: Row(
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
    );
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


  _body(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          GestureDetector(
            onTap: (){
              Get.to(()=>LanguageList());
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.08,
              decoration: BoxDecoration(
                color: MyTheme.isDarkTheme.value ?
                Colors.white.withOpacity(0.05) : Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: MyTheme.isDarkTheme.value ?
                    Colors.transparent :
                    Colors.grey.withOpacity(0.5),
                    blurRadius: 3,
                    offset: const Offset(1, 1),
                  ),
                ],
              ),
              child: Center(
                child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(App_Localization.of(context).translate("language"),
                          maxLines: 1,
                          style: Theme.of(context).textTheme.headline2,),
                        Row(
                          children: [
                            Text(
                              settingsController.languageName.value,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context).dividerColor
                              ),
                            ),
                            const SizedBox(width: 5),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Theme.of(context).dividerColor,
                            )
                          ],
                        )
                      ],
                    )
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.08,
            decoration: BoxDecoration(
              color: MyTheme.isDarkTheme.value ?
              Colors.white.withOpacity(0.05) :
              Colors.white,
              boxShadow: [
                BoxShadow(
                  color: MyTheme.isDarkTheme.value ?
                  Colors.transparent :
                  Colors.grey.withOpacity(0.5),
                  blurRadius: 3,
                  offset: const Offset(1, 1),
                ),
              ],
            ),
            child: Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyTheme.isDarkTheme.value ?
                    Text(App_Localization.of(context).translate("dark_mode"),
                      style: Theme.of(context).textTheme.headline2,) :
                    Text(App_Localization.of(context).translate("light_mode"),
                      style: Theme.of(context).textTheme.headline2,),
                    Row(
                      children: [
                        MyTheme.isDarkTheme.value ?
                        const Icon(Icons.dark_mode,color: Colors.white) :
                         const Icon(Icons.light_mode,color: Colors.black,),
                        const SizedBox(width: 10,),
                        CupertinoSwitch(
                          activeColor: App.pink,
                          thumbColor: Theme.of(context).dividerColor,
                          value: MyTheme.isDarkTheme.value,
                          onChanged: (bool value) {
                            settingsController.changeMode(context);
                            Store.saveTheme(!value);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: (){
              Get.to(()=> ConnectUs());
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.08,
              decoration: BoxDecoration(
                color: MyTheme.isDarkTheme.value ?
                Colors.white.withOpacity(0.05) : Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: MyTheme.isDarkTheme.value ?
                    Colors.transparent :
                    Colors.grey.withOpacity(0.5),
                    blurRadius: 3,
                    offset: const Offset(1, 1),
                  ),
                ],
              ),
              child: Center(
                child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(App_Localization.of(context).translate("connect_us"),
                          maxLines: 1,
                          style: Theme.of(context).textTheme.headline2,),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Theme.of(context).dividerColor,
                        )
                      ],
                    )
                ),
              ),
            ),
          ),
          const SizedBox(height: 2),
          GestureDetector(
            onTap: (){
              Get.to(()=> AboutUs());
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.08,
              decoration: BoxDecoration(
                color: MyTheme.isDarkTheme.value ?
                Colors.white.withOpacity(0.05) : Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: MyTheme.isDarkTheme.value ?
                    Colors.transparent :
                    Colors.grey.withOpacity(0.5),
                    blurRadius: 3,
                    offset: const Offset(1, 1),
                  ),
                ],
              ),
              child: Center(
                child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(App_Localization.of(context).translate("about_us"),
                          maxLines: 1,
                          style: Theme.of(context).textTheme.headline2,),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Theme.of(context).dividerColor,
                        )
                      ],
                    )
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }




}
