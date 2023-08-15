import 'package:alwan_press/app_localization.dart';
import 'package:alwan_press/controller/settings_controller.dart';
import 'package:alwan_press/helper/global.dart';
import 'package:alwan_press/widget/darkModeBackground.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageList extends StatelessWidget {

  SettingsController settingsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx((){
      return Scaffold(
        body: SafeArea(
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              DarkModeBackground(),
              Column(
                children: [
                  _header(context),
                  _body(context),
                  const SizedBox(height: 40),
                  GestureDetector(
                    onTap: (){
                      Global.saveLanguage(context,settingsController.languageCode.value);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(5)
                      ),
                      child: Center(
                        child: Text(
                          App_Localization.of(context).translate('save'),
                          style: const TextStyle(
                              fontSize: 18
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      );
    });
  }

  _header(context){
    return Container(
      padding: const EdgeInsets.only(top: 30,bottom: 30),
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(
             onPressed: (){
               Get.back();
             },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Theme.of(context).dividerColor,
              size: 22,
            )
          ),
          const SizedBox(width: 5),
          Text(
            App_Localization.of(context).translate('language'),
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }

  _body(context){
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.3,
      child: ListView.builder(
        itemCount: settingsController.languages.length,
        itemBuilder: (BuildContext context, index){
          return Column(
            children: [
              Obx((){
                return GestureDetector(
                  onTap: (){
                    // Global.saveLanguage(context,settingsController.languages[index]["id"]);
                    settingsController.languageCode.value = settingsController.languages[index]["id"];
                    settingsController.languageValue.value = settingsController.languages[index]["name"];
                  },
                  child: Container(
                    color: Colors.transparent,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.08,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          settingsController.languages[index]['name'],
                          style: TextStyle(
                              color: Theme.of(context).dividerColor,
                              fontSize: 15,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        settingsController.languages[index]['name'] == settingsController.languageValue.value ?
                        Icon(Icons.check, color: Theme.of(context).dividerColor)
                            : const Icon(Icons.check, color: Colors.transparent)
                      ],
                    ),
                  ),
                );
              }),
              Divider(color: Theme.of(context).dividerColor.withOpacity(0.8),)
            ],
          );
        },
      ),
    );
  }

}
