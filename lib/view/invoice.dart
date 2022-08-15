import 'dart:ui';

import 'package:alwan_press/app_localization.dart';
import 'package:alwan_press/controller/intro_controller.dart';
import 'package:alwan_press/controller/main_class_controller.dart';
import 'package:alwan_press/helper/myTheme.dart';
import 'package:alwan_press/view/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InvoicePage extends StatelessWidget {

  IntroController introController = Get.find();
  MainClassController mainClassController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            MyTheme.isDarkTheme.value ? Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/image/background.png')
                    )
                )
            ) : Text(''),
            _invoiceList(context),
            _header(context),
          ],
        ),
      ),
    );
  }

  _header(context){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.1,
      decoration: BoxDecoration(
        color: MyTheme.isDarkTheme.value ?  Colors.transparent : Colors.white,
      ),
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: (){
                  Get.back();
                  },
                child: Container(
                  child: Icon(Icons.arrow_back_ios_outlined,
                    color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black,
                    size: 30,),
                ),
              ),
              Text(App_Localization.of(context).translate("my_invoice"),
                style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black,fontSize: 26),
              ),
              Container(
                child: const Icon(Icons.arrow_back_ios_outlined,color: Colors.transparent,size: 30,),
              ),
            ],
          ),
        )
      ),
    );
  }
  _invoiceList(context){
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.08),
      height: MediaQuery.of(context).size.height,
      color: !MyTheme.isDarkTheme.value ?  Colors.white : Colors.transparent,
      child: ListView.builder(
        itemCount: 4,
        itemBuilder: (context, index){
          return Column(
            children: [
              const SizedBox(height: 30),
              Container(
                width: MediaQuery.of(context).size.width * 0.95,
                child: Text("Sept 25, 2019",
                  style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black,fontSize: 20),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.2,
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
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                vertical: MediaQuery.of(context).size.height * 0.02
                            ),
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text("32454655565",
                                  style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black,fontSize: 20),
                                ),
                                Text("\$3600",
                                  style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black,fontSize: 20),
                                ),
                                SizedBox(height: 5,),
                                Row(
                                  children: [
                                    Container(
                                      width: 15,
                                      height: 15,
                                      decoration: BoxDecoration(
                                        color: Colors.blueAccent,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    SizedBox(width: 10,),
                                    Text(App_Localization.of(context).translate("done"),
                                      style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black,fontSize: 20),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                            flex: 2,
                            child: Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: MediaQuery.of(context).size.height * 0.02
                                ),                              width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage("https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/1-index-work-bags-ysl-fendi-everlane-1652465394.jpg?crop=0.381xw:0.763xh;0.609xw,0.138xh&resize=640:*")
                                    )
                                )
                            )
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }


}
