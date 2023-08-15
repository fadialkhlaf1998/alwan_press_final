import 'package:alwan_press/app_localization.dart';
import 'package:alwan_press/helper/global.dart';
import 'package:alwan_press/helper/myTheme.dart';
import 'package:alwan_press/widget/connect_us_widget.dart';
import 'package:alwan_press/widget/darkModeBackground.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ConnectUs extends StatelessWidget {
  const ConnectUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            DarkModeBackground(),
            Column(
              children: [
                _header(context),
                _body(context)
              ],
            )
          ],
        ),
      ),
    );
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
            App_Localization.of(context).translate('connect_us'),
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  _body(context){
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          ConnectUsWidget(
              icon: 'facebook',
              title: 'Facebook',
            followButton: (){
              Global.openUrl(Global.facebook);
            },
          ),
          const SizedBox(height: 20),
          ConnectUsWidget(
              icon: 'instagram',
              title: 'Instagram',
            followButton: (){
              Global.openUrl(Global.insta);
            },
          ),
          const SizedBox(height: 20),
          ConnectUsWidget(
              icon: 'twitter',
              title: 'Twitter',
            followButton: (){
                Global.openUrl(Global.twitter);
            },
          ),

        ],
      ),
    );
  }




}
