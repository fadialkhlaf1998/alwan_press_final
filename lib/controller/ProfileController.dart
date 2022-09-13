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
import 'package:path_provider/path_provider.dart';


class ProfileController extends GetxController {

    RxBool loading = false.obs;
    var note = TextEditingController();

    requsetLastStatment(BuildContext context){
      if(Global.userId==-1){
        Get.offAll(()=>SignIn());
      }else{
        //Get.back();
        loading.value = true;
        Api.requestStatement(note.text, Global.userId).then((value) {
          loading.value = false;
          note.clear();
          if(value){
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
}