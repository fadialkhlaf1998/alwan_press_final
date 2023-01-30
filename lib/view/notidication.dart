import 'package:alwan_press/app_localization.dart';
import 'package:alwan_press/helper/app.dart';
import 'package:alwan_press/helper/myTheme.dart';
import 'package:alwan_press/widget/darkModeBackground.dart';
import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyNotification extends StatelessWidget {
  const MyNotification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              const DarkModeBackground(),
              Container(
                // height: MediaQuery.of(context).size.height,
                  child:  SingleChildScrollView(
                    child: Column(
                      children: [
                        _header(context),
                        // SizedBox(height: 10,),
                        SizedBox(height: 15,),
                        Container(
                          width: Get.width * 0.9,
                          // padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(App_Localization.of(context).translate("notifications"),style: TextStyle(color: App.textMediumColor(),fontWeight: FontWeight.bold),),
                              SizedBox(height: 10,),
                              Text(App_Localization.of(context).translate("never_miss"),style: TextStyle(color: App.textLgColor(),fontSize: 12),),
                            ],
                          ),
                        ),
                        SizedBox(height: 15,),
                        GestureDetector(
                          onTap: (){
                            AppSettings.openNotificationSettings();
                          },
                          child: Container(
                            color: App.containerColor(),
                            width: Get.width,
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
                                child: Text(App_Localization.of(context).translate("open_notification_setting"),style: TextStyle(color: App.lightPink),),
                              )
                            ),
                          ),
                        )
                      ],
                    ),
                  )
              ),

            ],
          ),
        ),
      ),
    );
  }


  _header(BuildContext context){
    return Container(
      width: Get.width,
      height: 60,
      decoration: BoxDecoration(
          color: MyTheme.isDarkTheme.value?App.darkGrey:Colors.white,
          boxShadow: [
            App.myBoxShadow
          ]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(width: Get.width * 0.05,),
          GestureDetector(
            onTap: (){
              Get.back();
            },
            child:  Icon(Icons.arrow_back_ios,color: App.textLightColor(),),
          ),
          SizedBox(width: 10,),
          App.logo(context),

        ],
      ),
    );
  }
}
