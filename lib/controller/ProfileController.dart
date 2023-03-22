import 'dart:async';
import 'dart:io';

import 'package:alwan_press/app_localization.dart';
import 'package:alwan_press/helper/api.dart';
import 'package:alwan_press/helper/app.dart';
import 'package:alwan_press/helper/global.dart';
import 'package:alwan_press/view/sign_in.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:path_provider/path_provider.dart';


class ProfileController extends GetxController {

    RxBool loading = false.obs;
    RxBool validate = false.obs;
    RxBool dataUpdated = false.obs;
    RxBool fake = false.obs;
    RxBool showChoose = false.obs;

    @override
  void onInit() {
    super.onInit();
    if(Global.user!=null){
      // name.text = Global.user!.name;
      // email.text = Global.user!.email;
      // phone.text = Global.user!.phone;
    }

  }

  var note = TextEditingController();
  var name = TextEditingController();
  var email = TextEditingController();
  var phone = TextEditingController();
  var landLine = TextEditingController();

    onChange(){
      if(name.text != Global.user!.name||
          email.text!=Global.user!.email||
          ("+971"+phone.text!=Global.user!.phone)||("+971"+landLine.text!=Global.user!.land_line)){
        dataUpdated.value = true;
        print(dataUpdated.value);
      }else{
        dataUpdated.value = false;
      }
      print(dataUpdated.value);
      // print(email.text!=Global.user!.email);
      validate.value = true;
      fake.value = !fake.value;
    }


    requsetLastStatment(BuildContext context){
      if(Global.user==null){
        Get.offAll(()=>SignIn());
      }else{
        //Get.back();
        loading.value = true;
        Api.requestStatement(note.text, Global.user!.id).then((value) {
          loading.value = false;
          note.clear();
          if(value){
            Global.user!.request_statment = 1;
            Get.snackbar(
              App_Localization.of(context).translate("req_state_succ_t"),
              App_Localization.of(context).translate("req_state_succ_d"),
              margin: EdgeInsets.only(top: 30,left: 25,right: 25),
              colorText: Colors.white,
            );
          }else{
            Get.snackbar(
              App_Localization.of(context).translate("oops_t"),
              App_Localization.of(context).translate("oops_d"),
              margin: EdgeInsets.only(top: 30,left: 25,right: 25),
              colorText: Colors.white,
            );
          }
        });
      }
    }

    updateData(BuildContext context){

    if(email.text.isNotEmpty&&RegExp(r'\S+@\S+\.\S+').hasMatch(email.text)&&
         phone.text.isNotEmpty && name.text.isNotEmpty ){
        Api.checkInternet().then((internet) {
          print('*-*-*');
        if(internet){
            loading.value = true;
            try{

              Api.updateCustomerData(email.text,phone.text,name.text,landLine.text, Global.user!.id).then((value) {
                if(value){

                  Api.login(Global.user!.username, Global.user!.password).then((value) {
                    if(value.id != -1){

                      name.text = Global.user!.name;
                      email.text = Global.user!.email;
                      phone.text = Global.user!.phone.length>6&&Global.user!.phone.contains("+971")?Global.user!.phone.split("+971")[1]:"";
                      loading.value = false;
                      dataUpdated.value = false;
                    }else{
                      loading.value = false;
                      mySnackBar(App_Localization.of(context).translate("Please_try_again"),App_Localization.of(context).translate("something_wrong"));
                    }
                  });
                }else{
                  loading.value = false;
                  mySnackBar(App_Localization.of(context).translate("Please_try_again"),App_Localization.of(context).translate("something_wrong"));
                }

              });
            }catch(err){
              loading.value = false;
              mySnackBar(App_Localization.of(context).translate("Please_try_again"),App_Localization.of(context).translate("something_wrong"));
            }
          }
        });
      }
    }
    uploadAvatar(XFile file,BuildContext context){
      Api.checkInternet().then((internet) {
        if(internet){
          loading.value = true;
          try{
            Api.uploadAvatar(file.path, Global.user!.id).then((value) {
              if(value){
                Api.login(Global.user!.username, Global.user!.password).then((value) {
                  if(value.id != -1){
                    loading.value = false;
                  }else{
                    loading.value = false;
                    mySnackBar(App_Localization.of(context).translate("Please_try_again"),App_Localization.of(context).translate("something_wrong"));
                  }
                });
              }else{
                loading.value = false;
                mySnackBar(App_Localization.of(context).translate("Please_try_again"),App_Localization.of(context).translate("something_wrong"));
              }

            });
          }catch(err){
            loading.value = false;
            mySnackBar(App_Localization.of(context).translate("Please_try_again"),App_Localization.of(context).translate("something_wrong"));
          }
        }
      });
    }
    mySnackBar(title, description){
      return Get.snackbar(
        title,
        description,
        margin: EdgeInsets.only(top: 30,left: 25,right: 25),
        colorText: Colors.white,
      );
    }
    Future<File> loadPdf() async {
      Completer<File> completer = Completer();
      final url = Global.user!.financialState;
      print(url);
      final filename = url.substring(url.lastIndexOf("/") + 1);
      var request = await HttpClient().getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/$filename");
      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
      return completer.future;
    }

    Future<File> loadPdfTradLicence() async {
      Completer<File> completer = Completer();
      final url = Global.user!.trade_license;
      print(url);
      final filename = url.substring(url.lastIndexOf("/") + 1);
      var request = await HttpClient().getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/$filename");
      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
      return completer.future;

    }

    deleteAccount(BuildContext context){
      Api.checkInternet().then((internet) {
        if(internet){
          loading.value = true;
          try{
            Api.deleteAccount(Global.user!.id).then((value) {
              if(value){
                Global.logout();
              }else{
                loading.value = false;
                mySnackBar(App_Localization.of(context).translate("Please_try_again"),App_Localization.of(context).translate("something_wrong"));
              }

            });
          }catch(err){
            loading.value = false;
            mySnackBar(App_Localization.of(context).translate("Please_try_again"),App_Localization.of(context).translate("something_wrong"));
          }
        }
      });
    }
}