import 'dart:io';
import 'package:alwan_press/helper/api.dart';
import 'package:alwan_press/helper/global.dart';
import 'package:alwan_press/helper/myTheme.dart';
import 'package:alwan_press/view/main_class.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:url_launcher/url_launcher.dart';


class SignInController extends GetxController{


  RxBool signUpOption = false.obs;
  RxBool showPassword = false.obs;

  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  RxBool loading = false.obs;


  @override
  void onInit() {
    super.onInit();
  }


  login(){
    if(username.text.isNotEmpty){
      if(password.text.isNotEmpty){
        loading.value = true;
        Api.login(username.text, password.text).then((value){
          print(username.text);
          print(password.text);
          if(value.id == -1){
            mySnackBar('Wrong Email or password', 'Please try again');
            loading.value = false;
          }else if (value.id == -2){
            mySnackBar('Something is wrong', 'Please try again');
            loading.value = false;
          }else{
            /// todo
            Api.sendUserToken(Global.token, value.id).then((done){
              if(done){
                Global.storeUserInformation(
                    value.id,
                    username.text,
                    password.text,
                 );
                Get.snackbar(
                    'Successfully login',
                    'Welcome to alwan_press app',
                    margin: EdgeInsets.only(top: 30,left: 25,right: 25),
                    backgroundColor: MyTheme.isDarkTheme.value ? Colors.grey.withOpacity(0.5) : Colors.black.withOpacity(0.5),
                    colorText: Colors.white
                );
                loading.value = false;
                username.clear();
                password.clear();
                Get.offAll(()=>MainClass());
              }else{
                print('can not send token');
              }
            });
          }
        });
      }else{
        /// password empty
        mySnackBar('Password is empty', 'Please enter your password');
      }
    }else{
      /// username empty
      mySnackBar('Email is empty', 'Please enter your email');
    }
  }

  mySnackBar(title, description){
    return Get.snackbar(
        title,
        description,
        margin: EdgeInsets.only(top: 30,left: 25,right: 25),
        colorText: Colors.white,
    );
  }







}