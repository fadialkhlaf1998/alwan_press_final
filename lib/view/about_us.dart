import 'package:alwan_press/app_localization.dart';
import 'package:alwan_press/helper/app.dart';
import 'package:alwan_press/helper/myTheme.dart';
import 'package:alwan_press/widget/connect_us_widget.dart';
import 'package:alwan_press/widget/darkModeBackground.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            const DarkModeBackground(),
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
            App_Localization.of(context).translate('about_us'),
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
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              App_Localization.of(context).translate("alwan_printing_press"),
              style: TextStyle(
                  color: MyTheme.isDarkTheme.value?Colors.white:Colors.black,
                  fontSize: 20,
                fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 10,),
            Container(
              height: 5,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    App.blue.withOpacity(0.0),
                    App.blue.withOpacity(0.0),
                    App.blue.withOpacity(0.0),
                    App.blue.withOpacity(0.0),
                    App.blue.withOpacity(0.0),
                    App.blue.withOpacity(0.0),
                    App.blue.withOpacity(0.0),
                    App.blue.withOpacity(0.1),
                    App.blue.withOpacity(0.2),
                    App.blue.withOpacity(0.3),
                    App.blue.withOpacity(0.4),
                    App.blue.withOpacity(0.5),
                    App.blue.withOpacity(0.6),
                    App.blue.withOpacity(0.8),
                  ],
                )
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width*0.6,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/image/about_us.webp"),
                  fit: BoxFit.cover
                )
              ),
            ),
            SizedBox(height: 10,),
            Container(
              width: MediaQuery.of(context).size.width*0.9,
              child: Text(
                App_Localization.of(context).translate("about_content"),
                style: TextStyle(
                  color: MyTheme.isDarkTheme.value?Colors.white.withOpacity(0.5):Colors.black.withOpacity(0.5),
                  fontSize: 14,
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }



}
