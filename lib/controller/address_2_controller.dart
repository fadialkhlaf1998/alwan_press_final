import 'package:alwan_press/app_localization.dart';
import 'package:alwan_press/controller/order_controller.dart';
import 'package:alwan_press/controller/order_details_controller.dart';
import 'package:alwan_press/helper/api.dart';
import 'package:alwan_press/helper/app.dart';
import 'package:alwan_press/helper/global.dart';
import 'package:alwan_press/helper/myTheme.dart';
import 'package:alwan_press/helper/store.dart';
import 'package:alwan_press/model/address.dart';
import 'package:alwan_press/view/sign_in.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressController_2 extends GetxController {


  TextEditingController? nick_name;
  TextEditingController? street_name;
  TextEditingController? building;
  TextEditingController? floor;
  TextEditingController? flat;
  TextEditingController? ad_desc;
  TextEditingController? phone;

  int orderId = -1;

  RxInt emirateIndex = (-1).obs;
  RxBool loading = false.obs;
  RxBool validate = false.obs;

  List<String> emirateList = ['Dubai','Abo Dhabi','Ajman','Ras Al Khaimah','Sharjah','Umm Al Quwin','Dubai Eye'];

  OrderController orderController = Get.find();

  @override
  void onInit() {
    super.onInit();
    // clearTextField();
    // Global.getUserInformation();
    // nick_name = TextEditingController(text: Global.nick_name);
    // street_name = TextEditingController(text: Global.street_name);
    // building = TextEditingController(text: Global.building);
    // floor = TextEditingController(text: Global.floor);
    // flat = TextEditingController(text: Global.flat);
    // ad_desc = TextEditingController(text: Global.ad_desc);
    // phone = TextEditingController(text: Global.phone);
  }

  saveAddress(BuildContext context) async {
    // loading.value = true;
    if(nick_name!.text.isNotEmpty&&street_name!.text.isNotEmpty&&building!.text.isNotEmpty&&floor!.text.isNotEmpty&&flat!.text.isNotEmpty&&phone!.text.isNotEmpty){
      Address address = Address(nickName: nick_name!.text, streetName: street_name!.text,
          building: building!.text, floor: floor!.text, flat: flat!.text,
          adDesc: ad_desc!.text, phone: phone!.text);
      Store.saveAddress(address);
      Store.loadAddress();
      print('-------------');
      print(Global.phone);
      print('------------');
      Get.back();
      Get.snackbar(
          App_Localization.of(context).translate("done")+"!",
          App_Localization.of(context).translate("address_saved_success"),
          margin: const EdgeInsets.only(top: 30,left: 25,right: 25),
          backgroundColor: MyTheme.isDarkTheme.value ? Colors.grey.withOpacity(0.5) : Colors.black.withOpacity(0.5),
          colorText: Colors.white
      );
    }

  }

  clearTextField (){
    nick_name!.clear();
    street_name!.clear();
    building!.clear();
    floor!.clear();
    flat!.clear();
    ad_desc!.clear();
    phone!.clear();
  }

  requsetShipping(BuildContext context){

    if(Global.userId==-1){
      Get.offAll(()=>SignIn());
    }else{
      if(nick_name!.text.isEmpty||street_name!.text.isEmpty||building!.text.isEmpty||
          floor!.text.isEmpty||flat!.text.isEmpty||phone!.text.isEmpty){
        validate.value = true;
      }else{
        validate.value = false;
        loading.value = true;
        Api.requestShipping(nick_name!.text, street_name!.text, building!.text, floor!.text, flat!.text, ad_desc!.text, phone!.text, orderId).then((value) {
          loading.value = false;
          print("loading.value");
          print(value);


          if(value){
            OrderDetailsController orderDetailsController = Get.find();
            orderDetailsController.animation();
            String title = App_Localization.of(context).translate("req_shipping_succ_t");
            String desc = App_Localization.of(context).translate("req_shipping_succ_d");
            Get.back();
            Get.snackbar(
              title,
              desc,
              margin: EdgeInsets.only(top: 30,left: 25,right: 25),
              colorText: Colors.white,
            );
            // Get.back();
          }else{
            Get.snackbar(
              App_Localization.of(context).translate("oops_t"),
              App_Localization.of(context).translate("oops_d"),
              margin: EdgeInsets.only(top: 30,left: 25,right: 25),
              colorText: Colors.white,
            );
          }
          orderController.getOrderData();
          //Get.back();
        }).catchError((err){
          Get.snackbar(
            App_Localization.of(context).translate("oops_t"),
            App_Localization.of(context).translate("oops_d"),
            margin: EdgeInsets.only(top: 30,left: 25,right: 25),
            colorText: Colors.white,
          );
        });
      }

    }
  }

}