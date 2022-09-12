import 'package:alwan_press/app_localization.dart';
import 'package:alwan_press/controller/intro_controller.dart';
import 'package:alwan_press/controller/sign_in_controller.dart';
import 'package:alwan_press/helper/app.dart';
import 'package:alwan_press/helper/myTheme.dart';
import 'package:alwan_press/main.dart';
import 'package:alwan_press/view/contact_information.dart';
import 'package:alwan_press/view/forget_password.dart';
import 'package:alwan_press/view/home.dart';
import 'package:alwan_press/view/main_class.dart';
import 'package:alwan_press/widget/darkModeBackground.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';


class SignIn extends StatefulWidget {
  @override
  State<SignIn> createState() => _SignInState();



}

class _SignInState extends State<SignIn> {



  SignInController signInController = Get.put(SignInController());
  IntroController introController = Get.find();
  ScrollController scrollController = ScrollController();

  @override
  void initState()  {
     super.initState();
    // Future.delayed(const Duration(milliseconds: 0)).then((value){
    //   scrollController.animateTo(
    //     scrollController.position.maxScrollExtent,
    //     duration: const Duration(milliseconds: 6000),
    //     curve: Curves.fastOutSlowIn,
    //   );
    // });
  }
  _SignInState(){
    Future.delayed(const Duration(milliseconds: 500)).then((value){
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 2000),
        curve: Curves.easeInQuart,
        // curve: Curves.bounceIn,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx((){
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarColor: MyTheme.isDarkTheme.value ? const Color(0XFF181818) : Colors.white
      ));
      return Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: [
            DarkModeBackground(),
            SingleChildScrollView(
              child: Column(
                children: [
                  _titleAnimation(context),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _inputTextField(context),
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 600),
                          child: signInController.signUpOption.isTrue
                              ? _signUpOptions(context)
                              : _signUpText(),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),

          ],
        ),
      );
    });
  }

  _titleAnimation(context){
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        controller: scrollController,
        child: Container(
            width: MediaQuery.of(context).size.width*3,
            height: MediaQuery.of(context).size.height * 0.3,
            child: FittedBox(
              fit: BoxFit.cover,
              child: Text('Welcome',style: TextStyle(fontWeight: FontWeight.bold,color: MyTheme.isDarkTheme.value?App.textColor().withOpacity(0.05):App.textColor().withOpacity(0.1))
              ),
            )
        ),
      ),
    );
  }

  _inputTextField(context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: 55,
          color: Colors.transparent,
          child: TextField(
            controller: signInController.username,
            style: TextStyle(color: App.textColor()),
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:  BorderSide(width: 1, color:App.textColor()),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:  BorderSide(width: 1, color: App.textColor()),
              ),
              label: Text(App_Localization.of(context).translate("email"), style: TextStyle(color:App.textColor()))
            ),
          ),
        ),
        const SizedBox(height: 20),
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: 55,
          color: Colors.transparent,
          child: TextField(
            controller: signInController.password,
            style:  TextStyle(color: App.textColor()),
            obscureText: !signInController.showPassword.value,
            decoration: InputDecoration(
              suffixIcon: signInController.showPassword.isFalse
                ? GestureDetector(
                onTap: (){
                  signInController.showPassword.value = !signInController.showPassword.value;
                },
                child: Icon(Icons.visibility_outlined, color: App.textColor(),),
              )
                : GestureDetector(
                onTap: (){
                  signInController.showPassword.value = !signInController.showPassword.value;
                },
                child: Icon(Icons.visibility_off_outlined, color:App.textColor(),),
              ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:  BorderSide(width: 1, color: App.textColor()),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:  BorderSide(width: 1, color: App.textColor()),
                ),
                label: Text(App_Localization.of(context).translate("password"), style: TextStyle(color:App.textColor()))
            ),
          ),
        ),
        // const SizedBox(height: 10),
        // GestureDetector(
        //   onTap: () async {
        //
        //     // FocusManager.instance.primaryFocus?.unfocus();
        //     // Navigator.push(
        //     //   context,
        //     //   PageRouteBuilder(
        //     //     pageBuilder: (c, a1, a2) => ForgetPassword(),
        //     //     transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
        //     //     transitionDuration: const Duration(milliseconds: 500),
        //     //   ),
        //     // );
        //   },
        //   child: Container(
        //     height: 25,
        //     color: Colors.transparent,
        //     child: Text(App_Localization.of(context).translate("forget_password"),style: TextStyle(fontSize: 14,color: App.textColor()),),
        //   ),
        // ),
        const SizedBox(height: 30),
        GestureDetector(
          onTap: (){
            FocusManager.instance.primaryFocus?.unfocus();
            signInController.login();
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: 55,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(10)
            ),
            child:  Center(
              child: signInController.loading.value
                  ? Center(child: Container(
                width: 25,
                  height: 25,
                  child: CircularProgressIndicator(color: App.textColor(),strokeWidth: 2.5)))
                  : Text(App_Localization.of(context).translate("sign_in").toUpperCase(),
                  style: TextStyle(color: Colors.white,fontSize: 16)),
            ),
          ),
        ),
        const SizedBox(height: 15),
        GestureDetector(
          onTap: (){
            FocusManager.instance.primaryFocus?.unfocus();
            Get.to(()=>MainClass());
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: 55,
            decoration: BoxDecoration(
                color: App.darkGrey,
                borderRadius: BorderRadius.circular(10)
            ),
            child:  Center(
              child: Text(App_Localization.of(context).translate("login_us_guest").toUpperCase(),
                  style: TextStyle(color: Colors.white,fontSize: 16)),
            ),
          ),
        ),
      ],
    );
  }

  _signUpText(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          child: Text(App_Localization.of(context).translate("don't_have_account"),
            style: TextStyle(color: App.textColor().withOpacity(0.8),fontSize: 14),),
        ),
        const SizedBox(width: 5),
        GestureDetector(
          onTap: (){
            signInController.signUpOption.value = true;
          },
          child: Container(
            color: Colors.transparent,
          //  margin: const EdgeInsets.only(bottom: 60),
            child: Text(App_Localization.of(context).translate("sign_up"),style: TextStyle(color: App.textColor().withOpacity(0.8),fontSize: 16,decoration: TextDecoration.underline),),
          ),
        ),
      ],
    );
  }

  _signUpOptions(context){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width*0.9,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                GestureDetector(
                  onTap: (){
                    introController.showWhatsAppList.value = true;
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (c, a1, a2) => ContactInformation(),
                        transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                        transitionDuration: Duration(milliseconds: 500),
                      ),
                    );
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        color: App.darkGrey,
                        shape: BoxShape.circle
                    ),
                    child: Center(child: SvgPicture.asset('assets/icons/whatsapp.svg',width: 30,height: 30,)),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    introController.showPhoneList.value = true;
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (c, a1, a2) => ContactInformation(),
                        transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                        transitionDuration: const Duration(milliseconds: 500),
                      ),
                    );
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        color: App.darkGrey,
                        shape: BoxShape.circle
                    ),
                    child: Center(
                      child: Icon(Icons.phone,size: 30,color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
