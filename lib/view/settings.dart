import 'dart:ui';
import 'package:alwan_press/app_localization.dart';
import 'package:alwan_press/controller/settings_controller.dart';
import 'package:alwan_press/helper/app.dart';
import 'package:alwan_press/helper/global.dart';
import 'package:alwan_press/helper/myTheme.dart';
import 'package:alwan_press/helper/store.dart';
import 'package:alwan_press/widget/darkModeBackground.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class Settings extends StatelessWidget {

  Settings() {
    if(Global.langCode == "en"){
      settingsController.selectedLanguage.value = 0;
    }else{
      settingsController.selectedLanguage.value = 1;
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
            DarkModeBackground(),
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
          Text(App_Localization.of(context).translate("settings"),
            style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black,fontSize: 24),
          ),
        ],
      ),
    );
  }
  _body(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.1,
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
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.1,
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
                      SizedBox(
                        //width: MediaQuery.of(context).size.width * 0.35,
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: settingsController.languages.length,
                          itemBuilder: (context, index){
                            return GestureDetector(
                              onTap: () {
                                Global.saveLanguage(context,settingsController.languages[index]["id"]);
                                settingsController.selectedLanguage.value = index;
                                if(settingsController.languages[index]["id"] == 'en'){
                                  settingsController.languageValue = settingsController.languages[index]["id"];
                                }else{
                                  settingsController.languageValue = settingsController.languages[index]["id"];
                                }
                              },
                              child: SizedBox(
                               // width: MediaQuery.of(context).size.width * 0.18,
                                  child: Row(
                                    children: [
                                      Transform.scale(
                                        scale: 1.2,
                                        child: Checkbox(
                                          side: MaterialStateBorderSide.resolveWith(
                                                (states) => BorderSide(width: 1.0, color: Theme.of(context).dividerColor,),
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          value: settingsController.selectedLanguage.value == index ?
                                          true :  false,
                                          onChanged: (value) {
                                            Global.saveLanguage(context,settingsController.languages[index]["id"]);
                                            settingsController.selectedLanguage.value = index;
                                            if(settingsController.languages[index]["id"] == 'en'){
                                              settingsController.languageValue = settingsController.languages[index]["id"];
                                            }else{
                                              settingsController.languageValue = settingsController.languages[index]["id"];
                                            }
                                          },
                                        ),
                                      ),
                                      Center(
                                        child: Text(
                                          settingsController.languages[index]["id"] == "en" ?
                                          "English" : "العربية",
                                          style: Theme.of(context).textTheme.bodyText2,
                                        ),
                                      ),
                                    ],
                                  )
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  )
              ),
            ),
          ),
        ],
      ),
    );
  }




}
