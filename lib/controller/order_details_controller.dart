import 'dart:convert';

import 'package:alwan_press/app_localization.dart';
import 'package:alwan_press/helper/api.dart';
import 'package:alwan_press/helper/app.dart';
import 'package:alwan_press/helper/global.dart';
import 'package:alwan_press/helper/myTheme.dart';
import 'package:alwan_press/model/order.dart';
import 'package:alwan_press/view/success.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:foloosi_plugins/foloosi_plugins.dart';
import 'package:get/get.dart';

class OrderDetailsController extends GetxController{

  var loading = false.obs;
  var fake = false.obs;
  var shippingSucc = false.obs;
  var shippingAnimationSucc = false.obs;
  double totalForPayment = 0;
  Order? order;
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  getData(int id){

  }

  animation(){
    shippingAnimationSucc.value = true;
    Future.delayed(Duration(milliseconds: 1000)).then((value) {
      refreshIndicater();
    });
  }

  Future<void> refreshIndicater()async{
    // loading.value = true;
    var orderRes = await Api.getOrderInfo(order!.id);
      if(orderRes != null){
        order = orderRes;
        if(order!.shippingRequestCount > 0){
          shippingSucc.value = true;
          shippingAnimationSucc.value = true;
        }
        totalForPayment = order!.price.toDouble() - order!.paid_amount.toDouble() + order!.vat;
        print(totalForPayment);
      if(order!.shippingState != 0 && order!.state != 0 && order!.shippingRequestCount > 0){
          totalForPayment += order!.shippingPrice;
        }
        if(order!.state == 0 ){
          totalForPayment = totalForPayment / 4 ;
        }
        fake.value = ! fake.value;
        print('check');
        print(order!.shippingAddress);
        loading.value = true;
        loading.value = false;
        return ;
      }else{
        return refreshIndicater();
      }

  }

  reorder(BuildContext context){
    loading.value = true;
    Api.reOrder(Global.user!.id,order!.id).then((success) {
      loading.value = false;
      if(success){
        Get.to(()=>Success());
      }else{
        mySnackBar(App_Localization.of(context).translate("something_wrong"),App_Localization.of(context).translate("Please_try_again"));
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

  Future<void> initFolosiPlatformState(BuildContext context) async {
    if (totalForPayment > 0) {
      try {

        var initData = {
          "merchantKey": "test_\$2y\$10\$9c6MQOTsB58aZwOFiznk0.qPCwUnaEdxFbr-9sWHDAO9yvzqEXbWy",
          "customColor": MyTheme.isDarkTheme.value?"#2C2B2B":"#2C2B2B",
        };
        await FoloosiPlugins.init(json.encode(initData));

        FoloosiPlugins.setLogVisible(true);
        var res = {
          "orderId":  order!.quickBookId,
          "orderDescription": order!.description,
          "orderAmount": totalForPayment,
          "state": "",
          "postalCode": "",
          "country": "ARE",
          "currencyCode": "AED",
          "customerUniqueReference": Global.user!.quickBookId,
          "customer": {
            "name": Global.user!.name,
            "email": Global.user!.email,
            "mobile": Global.user!.phone,
            "code": "",
            "address": "",
            "city": "",
          },
        };
        var result = await FoloosiPlugins.makePayment(json.encode(res));
        // var referenceToken = "";
        // var result = await FoloosiPlugins.makePaymentWithReferenceToken(referenceToken);
        if(result["success"]){
          Get.snackbar(
              App_Localization.of(context).translate("payment"),
              App_Localization.of(context).translate("you_payment_completed_successfully"),
              margin: EdgeInsets.only(top: 30,left: 25,right: 25),
              backgroundColor: MyTheme.isDarkTheme.value ? Colors.grey.withOpacity(0.5) : Colors.black.withOpacity(0.5),
              colorText: Colors.white
          );
          addToDashboard(int.parse(order!.quickBookId),totalForPayment);
        }
        if (kDebugMode) {
          print("Payment Response: $result");
        }
      } on Exception catch (exception) {
        Get.snackbar(
            App_Localization.of(context).translate("payment"),
            App_Localization.of(context).translate("oops_d"),
            margin: EdgeInsets.only(top: 30,left: 25,right: 25),
            backgroundColor: MyTheme.isDarkTheme.value ? Colors.grey.withOpacity(0.5) : Colors.black.withOpacity(0.5),
            colorText: Colors.white
        );
        // exception.runtimeType;
      }
    } else {
      if (kDebugMode) {
        print("Error: Please enter amount");
      }
    }

    /// Platform messages may fail, so we use a try/catch PlatformException.

    /// If the widget was removed from the tree while the asynchronous platform
    /// message was in flight, we want to discard the reply rather than calling
    /// setState to update our non-existent appearance.
  }

  addToDashboard(int order_id,double amount)async{
    loading(true);
    var succ  = await Api.pay(order_id, amount);
    if(succ){
      refreshIndicater();
      // Get.back();
      // Get.back();
      // Get.snackbar("Suxx", "payment not succ").show();
      return true;
    }
    else{
      return addToDashboard(order_id,amount);
    }
  }

}