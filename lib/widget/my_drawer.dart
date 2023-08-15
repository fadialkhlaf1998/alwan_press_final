import 'package:alwan_press/app_localization.dart';
import 'package:alwan_press/controller/ProfileController.dart';
import 'package:alwan_press/controller/order_controller.dart';
import 'package:alwan_press/helper/app.dart';
import 'package:alwan_press/helper/global.dart';
import 'package:alwan_press/helper/myTheme.dart';
import 'package:alwan_press/view/about_us.dart';
import 'package:alwan_press/view/contact_information.dart';
import 'package:alwan_press/view/pdf_viwer.dart';
import 'package:alwan_press/view/sign_in.dart';
import 'package:alwan_press/widget/logo.dart';
import 'package:alwan_press/widget/logo_text.dart';
import 'package:flutter/material.dart';
import 'package:alwan_press/controller/main_class_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class MyDrawer extends StatelessWidget {

  GlobalKey<ScaffoldState> _scaffoldkey;
  MainClassController mainClassController = Get.find();
  ProfileController profileController = Get.find();
  OrderController orderController = Get.find();
  var statement_loading = false.obs;
  MyDrawer(this._scaffoldkey);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      
      child: GestureDetector(
        onTap: (){
          _scaffoldkey.currentState!.closeEndDrawer();
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          // color: MyTheme.isDarkTheme.value?App.darkGrey.withOpacity(0.9):Colors.white,
          child: Row(

            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: MediaQuery.of(context).size.width*0.75,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: MyTheme.isDarkTheme.value?App.darkGrey.withOpacity(0.8):Colors.white38.withOpacity(0.8),
                      spreadRadius: 200,
                      blurRadius: 200
                    )
                  ],
                    color: MyTheme.isDarkTheme.value?Color(0xff272727):Colors.white,
                    // gradient: LinearGradient(
                    //     colors: [
                    //       Color(0xff272727).withOpacity(0.8),
                    //       Color(0xff272727),
                    //       Color(0xff272727),
                    //       Color(0xff272727),
                    //       Color(0xff272727),
                    //       Color(0xff272727),
                    //     ]
                    // )
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _logo(context),
                    Container(
                      width: MediaQuery.of(context).size.width*0.75,
                      height: MediaQuery.of(context).size.width/2*0.75,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image:
                                  ///dark mode
                                  AssetImage("assets/drawer/dark_new_about_us.jpg"),
                                  // :AssetImage("assets/drawer/new_about_us.jpg"),
                              fit: BoxFit.cover
                          )
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        _scaffoldkey.currentState!.closeEndDrawer();
                        Get.back();
                        // mainClassController.bottomBarController.jumpToTab(0);
                        mainClassController.selectedIndex(0);
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width*0.75*0.75,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Color(0xffe9098c),
                          borderRadius: Global.langCode=="en"?
                          BorderRadius.only(topLeft: Radius.circular(10),bottomLeft:  Radius.circular(10))
                          :BorderRadius.only(bottomRight: Radius.circular(10),topRight:  Radius.circular(10)),
                        ),
                        child: Row(
                          children: [
                            SizedBox(width: 20,),
                            SvgPicture.asset("assets/drawer/home.svg",color: Colors.white,),
                            SizedBox(width: 10,),
                            Text(App_Localization.of(context).translate("home"),style: TextStyle(color: Colors.white,fontSize: 16),)
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){

                        if(statement_loading.isFalse){
                          if(Global.user != null){
                            // orderController.loadPdf(Global.user!.financialState);

                            if(Global.user!.financialState.endsWith("pdf")){
                              // profileController.loading.value = true;
                              statement_loading.value = true;
                              profileController.loadPdf().then((value){
                                var pdf = value.path;
                                // profileController.loading.value = false;
                                statement_loading.value = false;
                                Get.to(()=>PdfViewerPage(pdf));
                              });
                            }else{
                              _scaffoldkey.currentState!.closeEndDrawer();
                              noStatementDialog(context);
                            }
                            // profileController.loadPdf();
                          }else{
                            Get.to(()=>SignIn());
                          }
                        }

                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width*0.75*0.75,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Color(0xff0a72b7),
                          borderRadius: Global.langCode=="en"?
                          BorderRadius.only(topLeft: Radius.circular(10),bottomLeft:  Radius.circular(10))
                              :BorderRadius.only(bottomRight: Radius.circular(10),topRight:  Radius.circular(10)),
                        ),
                        child: Obx(() => statement_loading.value?Center(child: Container(width: MediaQuery.of(context).size.width*0.75*0.75/1.6,child: LinearProgressIndicator(color: Colors.white,backgroundColor: App.blue),),):Row(
                          children: [
                            SizedBox(width: 20,),
                            SvgPicture.asset("assets/drawer/my_statement.svg",color: Colors.white,),
                            SizedBox(width: 10,),
                            Text(App_Localization.of(context).translate("my_statement"),style: TextStyle(color: Colors.white,fontSize: 16),)
                          ],
                        ),),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Get.to(()=>ContactInformation());
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width*0.75*0.75,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Color(0xffbdd433),
                          borderRadius: Global.langCode=="en"?
                          BorderRadius.only(topLeft: Radius.circular(10),bottomLeft:  Radius.circular(10))
                              :BorderRadius.only(bottomRight: Radius.circular(10),topRight:  Radius.circular(10)),
                        ),
                        child: Row(
                          children: [
                            SizedBox(width: 20,),
                            SvgPicture.asset("assets/drawer/contact_us.svg",color: Colors.white,),
                            SizedBox(width: 10,),
                            Text(App_Localization.of(context).translate("connect_us"),style: TextStyle(color: Colors.white,fontSize: 16),)
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        _scaffoldkey.currentState!.closeEndDrawer();
                        Get.back();
                        // mainClassController.bottomBarController.jumpToTab(1);
                        mainClassController.selectedIndex(1);
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width*0.75*0.75,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Color(0xffa0268c),
                          borderRadius: Global.langCode=="en"?
                          BorderRadius.only(topLeft: Radius.circular(10),bottomLeft:  Radius.circular(10))
                              :BorderRadius.only(bottomRight: Radius.circular(10),topRight:  Radius.circular(10)),
                        ),
                        child: Row(
                          children: [
                            SizedBox(width: 20,),
                            SvgPicture.asset("assets/drawer/my_order.svg",color: Colors.white,),
                            SizedBox(width: 10,),
                            Text(App_Localization.of(context).translate("my_order"),style: TextStyle(color: Colors.white,fontSize: 16),)
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Get.to(()=>AboutUs());
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width*0.75*0.75,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Color(0xfffecb11),
                          borderRadius: Global.langCode=="en"?
                          BorderRadius.only(topLeft: Radius.circular(10),bottomLeft:  Radius.circular(10))
                              :BorderRadius.only(bottomRight: Radius.circular(10),topRight:  Radius.circular(10)),
                        ),
                        child: Row(
                          children: [
                            SizedBox(width: 20,),
                            SvgPicture.asset("assets/drawer/about_us.svg",color: Colors.white,),
                            SizedBox(width: 10,),
                            Text(App_Localization.of(context).translate("about_us"),style: TextStyle(color: Colors.white,fontSize: 16),)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(width: 10,),
                        GestureDetector(
                          onTap: (){
                            Global.openUrl(Global.facebook);
                          },
                          child: SvgPicture.asset("assets/icons/facebook.svg",color: Colors.grey,height: 20,),),

                        GestureDetector(
                          onTap: (){
                            Global.openUrl(Global.insta);
                          },
                          child: SvgPicture.asset("assets/icons/instagram.svg",color: Colors.grey,height: 18,),),

                        GestureDetector(
                          onTap: (){
                            Global.openUrl(Global.twitter);
                          },
                          child: SvgPicture.asset("assets/icons/twitter.svg",color: Colors.grey,height: 18,),
                        ),
                        SizedBox(width: 10,),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _logo(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          curve: Curves.fastOutSlowIn,
          width: MediaQuery.of(context).size.width * 0.12,
          child: GestureDetector(
            onTap: () {
              // homeController.move();
              _scaffoldkey.currentState!.closeEndDrawer();
            },
            child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.12,
                height: MediaQuery.of(context).size.width * 0.12,
                child: Logo( MediaQuery.of(context).size.width * 0.1)),
          ),
        ),
        const SizedBox(width: 7),
        Container(
          height: MediaQuery.of(context).size.width * 0.1,
          // width: MediaQuery.of(context).size.width * 0.28,
          child: LogoText(MediaQuery.of(context).size.width * 0.26),
        )
      ],
    );
  }

  noStatementDialog(BuildContext context){
    Get.back();
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
