import 'package:alwan_press/app_localization.dart';
import 'package:alwan_press/helper/api.dart';
import 'package:alwan_press/helper/global.dart';
import 'package:alwan_press/model/order.dart';
import 'package:alwan_press/view/success.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
      refreshData();
    });
  }
  
  refreshData(){
    loading.value = true;
    Api.getOrderInfo(order!.id).then((order) {
      if(order != null){

        order = order;
        if(order.shippingRequestCount > 0){
          shippingSucc.value = true;
          shippingAnimationSucc.value = true;
        }
        totalForPayment = order.price.toDouble() - order.paid_amount.toDouble() + order.vat;
        if(order.shippingState != 0 && order.state != 0 && order.shippingRequestCount > 0){
          totalForPayment += order.shippingPrice;
        }
        if(order.state == 0 ){
          totalForPayment = totalForPayment / 4 ;
        }
        loading.value = false;
      }else{
        Get.back();
      }
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
        // loading.value = false;
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

}