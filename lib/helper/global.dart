import 'package:alwan_press/helper/store.dart';
import 'package:alwan_press/main.dart';
import 'package:alwan_press/model/address.dart';
import 'package:alwan_press/model/user.dart';
import 'package:alwan_press/view/sign_in.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';


class Global {


  static User? user ;
  static String langCode = "en";
  static String token = '';
  static int userId = -1;
  static String name = '';
  static String nick_name = '';
  static String street_name = '';
  static String building = '';
  static String floor = '';
  static String flat = '';
  static String ad_desc = '';
  static String phone = '';
  static String username = '';
  static String password = '';
  static String facebook = '';
  static String insta = '';
  static String twitter = '';


  static openUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch $url';
    }
  }

  static saveLanguage(BuildContext context , String lang){
    SharedPreferences.getInstance().then((prefs){
      prefs.setString("language", lang);
      langCode = lang;
      MyApp.set_local(context, Locale(lang));
      Get.updateLocale(Locale(lang));
    });
  }

  static Future<String> loadLanguage()async{
    try{
      SharedPreferences prefs= await SharedPreferences.getInstance();
      String lang = prefs.getString("language")??'def';
      if(lang!="def"){
        langCode = lang;
      }else{
        langCode="en";
      }
      Get.updateLocale(Locale(langCode));
      return langCode;
    }catch(e){
      return "en";
    }
  }

  static storeUserInformation(id, username, password) async {
    userId = id;
       await SharedPreferences.getInstance().then((prefs){
        prefs.setInt("id", id );
        prefs.setString("username", username);
        prefs.setString("password", password);
        // prefs.setString("address1", address1);
        // prefs.setString("address2", address2);
        // prefs.setString("emirate", emirate);
        // prefs.setString("apartment", apartment);
        // prefs.setString("phone", phone);
      });

  }

  static logout(){
    storeUserInformation(-1, "", "");
    // IntroController introController = Get.find();
    // Get.delete<IntroController>();
    Get.to(()=>SignIn());
  }

  static Future<bool> getUserInformation() async {
    try{
      SharedPreferences prefs= await SharedPreferences.getInstance();
      userId = prefs.getInt("id") ?? -1;
      name = prefs.getString('name') ?? "";
      username = prefs.getString('username') ?? "";
      password = prefs.getString('password') ?? "";
      // emirate = prefs.getString('emirate') ?? "";
      // apartment = prefs.getString('apartment') ?? "";
      phone = prefs.getString('phone') ?? "";
      Address address = await Store.loadAddress();
      nick_name = address.nickName;
      street_name = address.streetName;
      building = address.building;
      floor = address.floor;
      flat = address.flat;
      phone = address.phone;
      ad_desc = address.adDesc;
      return true;
    }catch (e){
      return false;
    }
  }

  static getUserToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token') ?? "";
  }

  static setUserToken (userToken) async {
    token = userToken;
    await SharedPreferences.getInstance().then((prefs){
      prefs.setString('token', token);
    });
  }



}