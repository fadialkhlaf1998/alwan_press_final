import 'dart:async';
import 'dart:io';
import 'package:alwan_press/app_localization.dart';
import 'package:alwan_press/controller/ProfileController.dart';
import 'package:alwan_press/controller/intro_controller.dart';
import 'package:alwan_press/controller/main_class_controller.dart';
import 'package:alwan_press/helper/app.dart';
import 'package:alwan_press/helper/global.dart';
import 'package:alwan_press/helper/myTheme.dart';
import 'package:alwan_press/view/address_2.dart';
import 'package:alwan_press/view/contact_information.dart';
import 'package:alwan_press/view/pdf_viwer.dart';
import 'package:alwan_press/view/sign_in.dart';
import 'package:alwan_press/widget/darkModeBackground.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  IntroController introController = Get.find();
  ProfileController profileController = Get.find();
  MainClassController mainClassController = Get.find();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: MyTheme.isDarkTheme.value?Color(0XFF181818):Colors.white
    ));
    return Obx(() => Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
           DarkModeBackground(),
            SingleChildScrollView(
              child: Column(
                children: [
                  _header(context),
                  const SizedBox(height: 10),
                  _body(context)
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
  _header(BuildContext context){
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(onPressed: (){}, icon: Icon(Icons.logout ,color: Colors.transparent)),
              GestureDetector(
                onTap: () {
                  // mainClassController.selectedIndex.value = 0;
                  // mainClassController.pageController.animateToPage(0,
                  //     duration: const Duration(milliseconds: 700), curve: Curves.fastOutSlowIn);
                  mainClassController.bottomBarController.jumpToTab(0);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.17,
                  height: MediaQuery.of(context).size.width * 0.17,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/icons/logo2.png')
                      )
                  ),
                ),
              ),
              Global.userId==-1
                  ?  IconButton(onPressed: (){}, icon: Icon(Icons.logout ,color: Colors.transparent))
                  :IconButton(onPressed: (){Global.logout();}, icon: Icon(Icons.logout ,color: MyTheme.isDarkTheme.value?Colors.white:Colors.black)),

            ],
          ),
        ],
      ),
    );
  }
  _body(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.height * 0.7,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              _slider(context),
              profileController.loading.value
                  ? _loading(context)
                  : Column(
                children: [
                  const SizedBox(height: 30),
                  _optionBar(context),
                  const SizedBox(height: 25),
                  _contactHelp(context),
                  // Column(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     _socialMedia(context),
                  //    // _terms(context),
                  //     const SizedBox(height: 20),
                  //     Text("© 2018 alwan_press. ALL RIGHTS RESERVED.",
                  //       style: TextStyle(
                  //           color: MyTheme.isDarkTheme.value ? Colors.white :
                  //           Colors.black,
                  //           fontSize: 11,
                  //           fontWeight: FontWeight.bold
                  //       ),
                  //     ),
                  //     Container(
                  //       padding: EdgeInsets.symmetric(vertical: 20),
                  //       child: Row(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         crossAxisAlignment: CrossAxisAlignment.center,
                  //         children: [
                  //           Text("Created by ",
                  //             style: TextStyle(
                  //                 color: MyTheme.isDarkTheme.value ? Colors.white :
                  //                 Colors.black,
                  //                 fontSize: 11,
                  //                 // fontWeight: FontWeight.bold
                  //             ),
                  //           ),
                  //         GestureDetector(
                  //           onTap: () async{
                  //             if (!await launchUrl(
                  //             Uri.parse('https://www.maxart.ae/'),
                  //             // mode: LaunchMode.externalApplication,
                  //               mode: LaunchMode.inAppWebView,
                  //               webViewConfiguration: const WebViewConfiguration(
                  //                   headers: <String, String>{'my_header_key': 'my_header_value'}),
                  //               // webViewConfiguration: const WebViewConfiguration(enableJavaScript: false),
                  //             )) {
                  //             throw 'Could not launch';
                  //             }
                  //           },
                  //           child: Text("MAXART",
                  //             style: TextStyle(
                  //               color: MyTheme.isDarkTheme.value ? Colors.white :
                  //               Colors.black,
                  //               fontSize: 12,
                  //               fontWeight: FontWeight.bold,
                  //               decoration: TextDecoration.underline,
                  //
                  //             ),
                  //           ),
                  //         )
                  //         ],
                  //       )
                  //     ),
                  //   ],
                  // ),
                ],
              )

            ],
          ),

        ],
      ),
    );
  }
  _loading(BuildContext context){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height*0.4,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
  _slider(context){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width * 0.45,
      color: App.grey,
      child:ImageSlideshow(
        width: double.infinity,
        height: MediaQuery.of(context).size.height*0.2,
        initialPage: 0,
        indicatorColor: Theme.of(context).primaryColor,
        indicatorBackgroundColor: App.grey,
        children:
        introController.bannerList.map((e) => Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: NetworkImage(e.image),
                  fit: BoxFit.cover
              )
          ),
        )).toList(),
        autoPlayInterval: 0,
        isLoop: true,
      ),
    );
  }
  _optionBar(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: GestureDetector(
                onTap: () async {
                  if(Global.user!=null){
                    if(Global.user!.financialState.endsWith("pdf")){
                      profileController.loading.value = true;
                      profileController.loadPdf().then((value){
                        var pdf = value.path;
                        profileController.loading.value = false;
                        Get.to(()=>PdfViewerPage(pdf));
                      });
                    }else{
                      noStatementDialog();
                      profileController.loading.value = false;
                    }
                  }else{
                    Get.to(()=>SignIn());
                  }
                },
                child: Container(
                  color: Colors.transparent,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 25,
                        height: 25,
                        child: SvgPicture.asset("assets/icons/invoice.svg",
                            color: MyTheme.isDarkTheme.value ? Colors.white :
                            Colors.black
                        ),
                      ),
                      Center(
                          child: Text(App_Localization.of(context).translate("my_statement"),
                              style: TextStyle(
                                  color: MyTheme.isDarkTheme.value ? Colors.white :
                                  Colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold
                              )
                          )
                      )
                    ],
                  ),
                )
            ),
          ),
          VerticalDivider(
            color: MyTheme.isDarkTheme.value ? Colors.white :
            Colors.black,
            width: 1,
            thickness: 1,
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                Get.to(()=>Addresses_2(-1));
              },
              child: Container(
                color: Colors.transparent,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      child: SvgPicture.asset("assets/icons/address.svg",
                          color: MyTheme.isDarkTheme.value ? Colors.white :
                          Colors.black
                      ),
                    ),
                    Center(child: Text(App_Localization.of(context).translate("my_address"),
                        style: TextStyle(
                            color: MyTheme.isDarkTheme.value ? Colors.white :
                            Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.bold
                        )
                    )
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  _contactHelp(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      // height: 50,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
              onTap: () {
                // showDialog(
                //   context: context,
                //   builder: (ctx) => AlertDialog(
                //     title: Text(App_Localization.of(context).translate('choose_option_to_connect')),
                //     titleTextStyle: const TextStyle(
                //       fontSize: 15,
                //       color: Colors.black,
                //     ),
                //     content: Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceAround,
                //       children: [
                //        GestureDetector(
                //          onTap: (){
                //            Get.back();
                //            introController.showWhatsAppList.value = true;
                //            introController.showPhoneList.value = false;
                //            Get.to(()=>ContactInformation());
                //          },
                //          child:  Container(
                //            width: 70,
                //            height: 55,
                //            child: Column(
                //              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //              children: [
                //                SvgPicture.asset('assets/icons/whatsapp-green.svg',width: 30,height: 30,),
                //                Text(
                //                  App_Localization.of(context).translate('whatsapp'),
                //                  style: const TextStyle(color: Colors.black, fontSize: 12),
                //                ),
                //              ],
                //            ),
                //          ),
                //        ),
                //        GestureDetector(
                //          onTap: (){
                //            Get.back();
                //            introController.showPhoneList.value = true;
                //            introController.showWhatsAppList.value = false;
                //            Get.to(()=>ContactInformation());
                //          },
                //          child:  Container(
                //            width: 70,
                //            height: 55,
                //            child: Column(
                //              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //              children: [
                //                Container(
                //                  width: 35,
                //                  height: 35,
                //                  // padding: EdgeInsets.all(10),
                //                  decoration: const BoxDecoration(
                //                      shape: BoxShape.circle,
                //                      color: Colors.black
                //                  ),
                //                  child: const Icon(Icons.phone,size: 20,
                //                    color:  Colors.white,
                //                  ),
                //                ),
                //                Text(
                //                  App_Localization.of(context).translate('phone'),
                //                  style: const TextStyle(color: Colors.black, fontSize: 12),                              ),
                //              ],
                //            ),
                //          )
                //        )
                //       ],
                //     ),
                //     // actions: <Widget>[
                //     //   TextButton(
                //     //     onPressed: () {
                //     //       // Navigator.of(ctx).pop();
                //     //       Get.back();
                //     //     },
                //     //     child: Container(
                //     //       padding: EdgeInsets.symmetric(vertical: 10,horizontal: 8),
                //     //       decoration: BoxDecoration(
                //     //         color: App.pink,
                //     //         borderRadius: BorderRadius.circular(5)
                //     //       ),
                //     //       child: Text(
                //     //           App_Localization.of(context).translate('cancel'),
                //     //         style: TextStyle(
                //     //           color: Colors.white,
                //     //           fontSize: 15
                //     //         ),
                //     //       ),
                //     //     ),
                //     //   ),
                //     // ],
                //   ),
                // );
               Get.to(()=>ContactInformation());
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 50,
                decoration: BoxDecoration(
                    color: Theme.of(context).disabledColor,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.call,
                      color: Theme.of(context).backgroundColor,
                    ),
                    const SizedBox(width: 10),
                    Center(child: Text(App_Localization.of(context).translate("connect_with_us"),
                        style: TextStyle(
                            fontSize: 15,
                            color: Theme.of(context).backgroundColor,
                            fontWeight: FontWeight.bold
                        )
                    )
                    )
                  ],
                ),
              )
          ),
          SizedBox(height: 10,),
          GestureDetector(
              onTap: () {
                if(Global.userId == -1){
                  Get.offAll(()=>SignIn());
                }else{
                  _showMyDialog(context);
                }
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 50,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        width: 28,
                        height: 28,
                        child: const Icon(
                          Icons.update_outlined,
                          color:  Colors.white,
                          size: 28,)
                    ),
                    const SizedBox(width: 10),
                    Center(
                        child: Text(App_Localization.of(context).translate("req_last_state"),
                            style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                            )))
                  ],
                ),
              )
          ),
        ],
      ),
    );
  }
  _socialMedia(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.65,
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              //todo
            },
            child: Container(
              width: 22,
              height: 22,
              child: SvgPicture.asset("assets/icons/instagram.svg",
                color: MyTheme.isDarkTheme.value ? Colors.white :
                Colors.black,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              //todo
            },
            child: Container(
              width: 22,
              height: 22,
              child: SvgPicture.asset("assets/icons/twitter.svg",
                color: MyTheme.isDarkTheme.value ? Colors.white :
                Colors.black,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              //todo
            },
            child: Container(
              width: 22,
              height: 22,
              child: SvgPicture.asset("assets/icons/facebook.svg",
                color: MyTheme.isDarkTheme.value ? Colors.white :
                Colors.black,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              //todo
            },
            child: Container(
              width: 22,
              height: 22,
              child: SvgPicture.asset("assets/icons/youtube.svg",
                color: MyTheme.isDarkTheme.value ? Colors.white :
                Colors.black,
              ),
            ),
          )
        ],
      ),
    );
  }
  _terms(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.7,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap:() {
                  //todo
                },
                child: Text(App_Localization.of(context).translate("privacy_policy"),
                  style: TextStyle(
                      color: MyTheme.isDarkTheme.value ? Colors.white :
                      Colors.black,
                      fontSize: 11,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Text(".",style: TextStyle(
                  color: MyTheme.isDarkTheme.value ? Colors.white :
                  Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.bold
              ),),
              GestureDetector(
                onTap:() {
                  //todo
                },
                child: Text(App_Localization.of(context).translate("terms_of_sale"),
                  style: TextStyle(
                      color: MyTheme.isDarkTheme.value ? Colors.white :
                      Colors.black,
                      fontSize: 11,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Text(".",style: TextStyle(
                  color: MyTheme.isDarkTheme.value ? Colors.white :
                  Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.bold
              ),),
              GestureDetector(
                onTap:() {
                  //todo
                },
                child: Text(App_Localization.of(context).translate("terms_of_use"),
                  style: TextStyle(
                      color: MyTheme.isDarkTheme.value ? Colors.white :
                      Colors.black,
                      fontSize: 11,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20,),
        Container(
          width: MediaQuery.of(context).size.width * 0.6,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap:() {
                  //todo
                },
                child: Text(App_Localization.of(context).translate("return_policy"),
                  style: TextStyle(
                      color: MyTheme.isDarkTheme.value ? Colors.white :
                      Colors.black,
                      fontSize: 11,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Text(".",style: TextStyle(
                  color: MyTheme.isDarkTheme.value ? Colors.white :
                  Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.bold
              ),),
              GestureDetector(
                onTap:() {
                  //todo
                },
                child: Text(App_Localization.of(context).translate("warranty_policy"),
                  style: TextStyle(
                      color: MyTheme.isDarkTheme.value ? Colors.white :
                      Colors.black,
                      fontSize: 11,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20,),
        Text("© 2018 alwan_press. ALL RIGHTS RESERVED.",
          style: TextStyle(
              color: MyTheme.isDarkTheme.value ? Colors.white :
              Colors.black,
              fontSize: 11,
              fontWeight: FontWeight.bold
          ),
        ),
      ],
    );
  }
  submit(){
    Get.back();
    profileController.requsetLastStatment(context);
  }
  Future<void> _showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(App_Localization.of(context).translate("req_last_state")),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                _note(context)
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(App_Localization.of(context).translate("submit")),
              onPressed: () {
                //Navigator.of(context).pop();
                submit();
              },
            ),
            TextButton(
              child: Text(App_Localization.of(context).translate("cancel")),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  _note(context){
    return  Container(
      width: MediaQuery.of(context).size.width * 0.4,
      height: 55,
      color: Colors.transparent,
      child: TextField(
        controller: profileController.note,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(width: 1, color: Colors.black),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:  BorderSide(width: 1, color:Colors.black),
            ),
            label: Text(App_Localization.of(context).translate("note"),
                style: TextStyle(color: Colors.black))
        ),
      ),
    );
  }

  noStatementDialog(){
    return  showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(App_Localization.of(context).translate('no_statement')),
        titleTextStyle: const TextStyle(
          fontSize: 16,
          color: Colors.black,
          fontWeight: FontWeight.bold
        ),
        content: Text(
          App_Localization.of(context).translate('request_last_statement'),
          style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
          ),
        ),
      ),
    );
  }


}



