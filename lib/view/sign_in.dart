import 'package:alwan_press/app_localization.dart';
import 'package:alwan_press/controller/intro_controller.dart';
import 'package:alwan_press/controller/sign_in_controller.dart';
import 'package:alwan_press/helper/app.dart';
import 'package:alwan_press/main.dart';
import 'package:alwan_press/view/contact_information.dart';
import 'package:alwan_press/view/forget_password.dart';
import 'package:alwan_press/view/home.dart';
import 'package:alwan_press/view/main_class.dart';
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
    Future.delayed(const Duration(milliseconds: 0)).then((value){
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 6000),
        curve: Curves.fastOutSlowIn,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx((){
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 0,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Color(0XFF300A2A),
          ),
        ),
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/image/background.png')
                    )
                )
            ),
            _titleAnimation(context),
            SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(height: 200),
                   // _titleAnimation(context),
                    _inputTextField(context),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 600),
                      child: signInController.signUpOption.isTrue
                          ? _signUpOptions(context)
                          : _signUpText(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  _titleAnimation(context){
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        controller: scrollController,
        child: Container(
            child: FittedBox(
              fit: BoxFit.cover,
              child: Text('Welcome',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white.withOpacity(0.05))
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
          height: 60,
          color: Colors.transparent,
          child: TextField(
            controller: signInController.username,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(width: 1, color: Colors.white),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(width: 1, color: Colors.white),
              ),
              label: Text(App_Localization.of(context).translate("email"), style: TextStyle(color: Colors.white))
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
            style: const TextStyle(color: Colors.white),
            obscureText: !signInController.showPassword.value,
            decoration: InputDecoration(
              suffixIcon: signInController.showPassword.isFalse
                ? GestureDetector(
                onTap: (){
                  signInController.showPassword.value = !signInController.showPassword.value;
                },
                child: const Icon(Icons.visibility_outlined, color: Colors.white,),
              )
                : GestureDetector(
                onTap: (){
                  signInController.showPassword.value = !signInController.showPassword.value;
                },
                child: const Icon(Icons.visibility_off_outlined, color: Colors.white,),
              ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(width: 1, color: Colors.white),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(width: 1, color: Colors.white),
                ),
                label: Text(App_Localization.of(context).translate("password"), style: TextStyle(color: Colors.white))
            ),
          ),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () async {

            // FocusManager.instance.primaryFocus?.unfocus();
            // Navigator.push(
            //   context,
            //   PageRouteBuilder(
            //     pageBuilder: (c, a1, a2) => ForgetPassword(),
            //     transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
            //     transitionDuration: const Duration(milliseconds: 500),
            //   ),
            // );
          },
          child: Container(
            height: 25,
            color: Colors.transparent,
            child: Text(App_Localization.of(context).translate("forget_password"),style: const TextStyle(fontSize: 14,color: Colors.white),),
          ),
        ),
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
              color: App.pink,
              borderRadius: BorderRadius.circular(10)
            ),
            child:  Center(
              child: signInController.loading.value
                  ? Center(child: Container(
                width: 25,
                  height: 25,
                  child: CircularProgressIndicator(color: Colors.white,strokeWidth: 2.5)))
                  : Text(App_Localization.of(context).translate("sign_in").toUpperCase(),
                  style: TextStyle(color: Colors.white,fontSize: 16)),
            ),
          ),
        ),
        const SizedBox(height: 20),
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
                  style: const TextStyle(color: Colors.white,fontSize: 16)),
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
            style: TextStyle(color: Colors.white.withOpacity(0.8),fontSize: 14),),
        ),
        const SizedBox(width: 5),
        GestureDetector(
          onTap: (){
            signInController.signUpOption.value = true;
          },
          child: Container(
            color: Colors.transparent,
          //  margin: const EdgeInsets.only(bottom: 60),
            child: Text(App_Localization.of(context).translate("sign_up"),style: TextStyle(color: Colors.white.withOpacity(0.8),fontSize: 16,decoration: TextDecoration.underline),),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // GestureDetector(
              //   onTap: (){
              //     signInController.showWhatsAppList.value = !signInController.showWhatsAppList.value;
              //   },
              //   child: AnimatedContainer(
              //     duration: const Duration(milliseconds: 400),
              //     width: signInController.showWhatsAppList.value ? 200 : 60,
              //     height: 60,
              //     decoration: BoxDecoration(
              //       color: App.darkGrey,
              //      //shape: BoxShape.circle
              //       borderRadius: BorderRadius.circular(30)
              //     ),
              //     child: Center(
              //       child: AnimatedSwitcher(
              //         duration: const Duration(milliseconds: 400),
              //         child: signInController.showWhatsAppList.value
              //             ? ListView.builder(
              //             scrollDirection: Axis.horizontal,
              //             itemCount: introController.customerServiceList.length+1,
              //             itemBuilder: (context, index){
              //             return index==0?
              //             GestureDetector(
              //               onTap: (){
              //                 signInController.showWhatsAppList.value = false;
              //               },
              //               child: Container(
              //                 width: 50,
              //                 height: 50,
              //                 decoration: BoxDecoration(
              //                     color: App.darkGrey,
              //                     shape: BoxShape.circle
              //                 ),
              //                 child: Center(
              //                     child: SizedBox(
              //                         width: 35,
              //                         height: 35,
              //                         child: AnimatedSwitcher(
              //                           duration: const Duration(milliseconds: 400),
              //                           child: signInController.showWhatsAppList.value ? const Icon(Icons.keyboard_backspace,color: Colors.white,size: 30,): SvgPicture.asset('assets/icons/whatsapp.svg'),
              //                         )
              //                     )
              //                 ),
              //               ),
              //             )
              //                 :Container(
              //               margin: const EdgeInsets.symmetric(horizontal: 10),
              //               width: 50,
              //               height: 50,
              //               child: Center(
              //                   child: Image.network(introController.customerServiceList[index-1].image, fit: BoxFit.cover,)
              //               ),
              //             );
              //           },
              //         )
              //             : SizedBox(
              //           width: 35,
              //           height: 35,
              //           child: AnimatedSwitcher(
              //             duration: const Duration(milliseconds: 400),
              //             child:  SvgPicture.asset('assets/icons/whatsapp.svg'),
              //           )
              //         ),
              //       )
              //     ),
              //   ),
              // ),
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
        ],
      ),
    );
  }
}
