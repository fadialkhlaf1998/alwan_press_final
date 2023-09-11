// ignore_for_file: must_be_immutable

import 'package:alwan_press/app_localization.dart';
import 'package:alwan_press/controller/our_clients_controller.dart';
import 'package:alwan_press/helper/app.dart';
import 'package:alwan_press/helper/myTheme.dart';
import 'package:alwan_press/widget/darkModeBackground.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OurClients extends StatelessWidget {
  OurClientsController ourClientsController = Get.put(OurClientsController());

  OurClients({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              DarkModeBackground(),
              Container(
                  // height: MediaQuery.of(context).size.height,
                  child: Column(
                children: [
                  _header(context),
                  SizedBox(
                    height: 10,
                  ),
                  _body(context)
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }

  _header(BuildContext context) {
    return Container(
      width: Get.width,
      height: 60,
      decoration: BoxDecoration(
          color: MyTheme.isDarkTheme.value ? App.newDarkGrey : Colors.white,
          boxShadow: [App.myBoxShadow]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: Get.width * 0.05,
          ),
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: App.textLightColor(),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          App.logo(context),
        ],
      ),
    );
  }

  _body(BuildContext context) {
    return Obx(() => Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    App_Localization.of(context)
                        .translate("our_clients_description"),
                    style: TextStyle(fontSize: 10),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ourClientsController.loading.value
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                  crossAxisSpacing: 10,
                                  childAspectRatio: 1,
                                  mainAxisSpacing: 10),
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: ourClientsController.my_clients.length,
                          itemBuilder: (context, index) {
                            return Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  // color: App.containerColor(),
                                  image: DecorationImage(
                                      image: NetworkImage(ourClientsController
                                          .my_clients[index].image),
                                      fit: BoxFit.cover)),
                            );
                          }),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
