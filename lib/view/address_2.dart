import 'package:alwan_press/app_localization.dart';
import 'package:alwan_press/controller/address_2_controller.dart';
import 'package:alwan_press/helper/app.dart';
import 'package:alwan_press/helper/global.dart';
import 'package:alwan_press/helper/myTheme.dart';
import 'package:alwan_press/helper/store.dart';
import 'package:alwan_press/model/address.dart';
import 'package:alwan_press/widget/darkModeBackground.dart';
import 'package:alwan_press/widget/light_mode_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';


class Addresses_2 extends StatelessWidget {

  AddressController_2 addressController = Get.put(AddressController_2());

  Addresses_2(int orderId){
    addressController.orderId = orderId;
    addressController.validate.value = false;
    print(Global.nick_name);
    addressController.nick_name = TextEditingController(text: Global.nick_name);
    addressController.street_name = TextEditingController(text: Global.street_name);
    addressController.building = TextEditingController(text: Global.building);
    addressController.floor = TextEditingController(text: Global.floor);
    addressController.flat = TextEditingController(text: Global.flat);
    addressController.ad_desc = TextEditingController(text: Global.ad_desc);
    addressController.phone = TextEditingController(text: Global.phone);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: MyTheme.isDarkTheme.value?Color(0XFF181818):Colors.white
    ));
    return Obx(() => Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            MyTheme.isDarkTheme.value?DarkModeBackground():LightModeBackground(),
            // DarkModeBackground(),
            SingleChildScrollView(
              child: Column(
                children: [
                  _header(context),
                  _body(context),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }

  _header(BuildContext context){
    return Container(
      width: Get.width,
      height: 60,
      decoration: BoxDecoration(
          color: MyTheme.isDarkTheme.value?App.darkGrey:Colors.white,
          boxShadow: [
            App.myBoxShadow
          ]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(width: Get.width * 0.05,),
          GestureDetector(
            onTap: (){
              Get.back();
            },
            child:  Icon(Icons.arrow_back_ios,color: App.textLightColor(),),
          ),
          SizedBox(width: 10,),
          App.logo(context),

        ],
      ),
    );
  }

  _old_header(context){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.1,
      decoration: BoxDecoration(
        color: MyTheme.isDarkTheme.value ?  Colors.transparent : Colors.white,
      ),
      child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: (){
                    Get.back();
                  },
                  child: Container(
                    child: Icon(Icons.arrow_back_ios_outlined,
                      color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black,
                      size: 25,),
                  ),
                ),
                Text(App_Localization.of(context).translate("my_address"),
                  style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black,fontSize: 24),
                ),
                Container(
                  child: const Icon(Icons.arrow_back_ios_outlined,color: Colors.transparent,size: 20,),
                ),
              ],
            ),
          )
      ),
    );
  }

  _body(context){
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(height: 20),
          _nickName(context),
          const SizedBox(height: 20),
          _streetName(context),
          const SizedBox(height: 20),
          _building(context),
          const SizedBox(height: 20),
          _floor_flat(context),
          const SizedBox(height: 20),
          _phone(context),
          const SizedBox(height: 20),
          _ad_desc(context),
          const SizedBox(height: 50),
          _saveButton(context),
          const SizedBox(height: 10),
          _cancelButton(context),
          const SizedBox(height: 50),
        ],
      ),
    );
  }

  Color getColor(){
    return MyTheme.isDarkTheme.value ?Color(0xff3B3B3B):Color(0xffDFDFDF);
  }

  _nickName(context){
    return  Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 55,
      color: Colors.transparent,
      child: TextField(
        controller: addressController.nick_name,
        style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black),
        decoration: InputDecoration(
          // prefixText: 'Nike name: ',
            prefixStyle: TextStyle(
              color: Theme.of(context).dividerColor
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(width: 1, color: addressController.validate.value&&addressController.nick_name!.text.isEmpty?Colors.red:getColor()),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide:  BorderSide(width: 1, color:  addressController.validate.value&&addressController.nick_name!.text.isEmpty?Colors.red:getColor()),
            ),

            floatingLabelBehavior: FloatingLabelBehavior.always,
            label: Text(App_Localization.of(context).translate("nick_name"),
                style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black,fontSize: 14))
        ),
      ),
    );
  }

  _streetName(context){
    return  Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 55,
      color: Colors.transparent,
      child: TextField(
        controller: addressController.street_name,
        style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black),
        decoration: InputDecoration(
            focusedBorder: UnderlineInputBorder(
              
              borderSide: BorderSide(width: 1, color:  addressController.validate.value&&addressController.street_name!.text.isEmpty?Colors.red:getColor()),
            ),
            enabledBorder: UnderlineInputBorder(
              
              borderSide:  BorderSide(width: 1, color:  addressController.validate.value&&addressController.street_name!.text.isEmpty?Colors.red:getColor()),
            ),

            floatingLabelBehavior: FloatingLabelBehavior.always,
            label: Text(App_Localization.of(context).translate("street_name"),
                style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black,fontSize: 14))
        ),
      ),
    );
  }


  _building(context){
    return  Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 55,
      color: Colors.transparent,
      child: TextField(
        controller: addressController.building,
        style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black),
        decoration: InputDecoration(
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(width: 1, color:  addressController.validate.value&&addressController.building!.text.isEmpty?Colors.red:getColor()),
            ),
            enabledBorder: UnderlineInputBorder(
              
              // borderSide:  BorderSide(width: 1, color: addressController.validate.value&&addressController.building!.text.isEmpty?Colors.red: MyTheme.isDarkTheme.value ? Colors.white : Colors.black),
              borderSide:  BorderSide(width: 1, color: addressController.validate.value&&addressController.building!.text.isEmpty?Colors.red:getColor()),
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            label: Text(App_Localization.of(context).translate("building"),
                style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black,fontSize: 14))
        ),
      ),
    );
  }
  _floor_flat(context){
    return  Container(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.4,
            height: 55,
            color: Colors.transparent,
            child: TextField(
              controller: addressController.floor,
              style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black),
              decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    
                    borderSide: BorderSide(width: 1, color:  addressController.validate.value&&addressController.floor!.text.isEmpty?Colors.red:getColor()),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    
                    borderSide:  BorderSide(width: 1, color:  addressController.validate.value&&addressController.floor!.text.isEmpty?Colors.red:getColor()),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  label: Text(App_Localization.of(context).translate("floor"),
                      style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black,fontSize: 14))
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.4,
            height: 55,
            color: Colors.transparent,
            child: TextField(
              controller: addressController.flat,
              style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black),
              decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    
                    borderSide: BorderSide(width: 1, color:  addressController.validate.value&&addressController.flat!.text.isEmpty?Colors.red:getColor()),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    
                    borderSide:  BorderSide(width: 1, color:  addressController.validate.value&&addressController.flat!.text.isEmpty?Colors.red:getColor()),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  label: Text(App_Localization.of(context).translate("flat"),
                      style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black,fontSize: 14))
              ),
            ),
          ),
        ],
      ),
    );
  }

  _phone(context){
    return  Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 55,
      color: Colors.transparent,
      child: TextField(
        keyboardType: TextInputType.phone,
        controller: addressController.phone,
        style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black),
        maxLength: 9,
        decoration: InputDecoration(
          counterText: '',
          prefixText: '+971 ',
            prefixStyle:  TextStyle(
              color: Theme.of(context).dividerColor,
            ),
            focusedBorder: UnderlineInputBorder(
              
              borderSide: BorderSide(width: 1, color:  addressController.validate.value&&addressController.phone!.text.isEmpty?Colors.red:getColor()),
            ),
            enabledBorder: UnderlineInputBorder(
              
              borderSide:  BorderSide(width: 1, color:  addressController.validate.value&&addressController.phone!.text.isEmpty?Colors.red:getColor()),
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            label: Text(App_Localization.of(context).translate("phone"),
                style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black,fontSize: 14))
        ),
      ),
    );
  }

  _ad_desc(context){
    return  Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 55,
      color: Colors.transparent,
      child: TextField(
        keyboardType: TextInputType.text,
        controller: addressController.ad_desc,
        style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black),
        decoration: InputDecoration(
            focusedBorder: UnderlineInputBorder(
              
              borderSide: BorderSide(width: 1, color: getColor()),
            ),
            enabledBorder: UnderlineInputBorder(
              
              borderSide:  BorderSide(width: 1, color: getColor()),
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            label: Text(App_Localization.of(context).translate("ad_desc"),
                style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black,fontSize: 14))
        ),
      ),
    );
  }

  _saveButton(context){
    return  GestureDetector(
      onTap: (){
        // Get.snackbar(
        //   "title",
        //   "desc",
        //   margin: EdgeInsets.only(top: 30,left: 25,right: 25),
        //   colorText: Colors.white,
        // );
        FocusManager.instance.primaryFocus?.unfocus();
        // signInController.login();
        if(addressController.orderId == -1){
          addressController.saveAddress(context);
        }else{
          addressController.requsetShipping(context);
        }

      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: 40,
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(10)
        ),
        child:  Center(
          child:  addressController.loading.value
              ?  Center(child: Container(
              width: 25,
              height: 25,
              child: CircularProgressIndicator(color: Colors.white,strokeWidth: 2.5)))
              : Text(App_Localization.of(context).translate("submit").toUpperCase(),
              style: TextStyle(color: Colors.white,fontSize: 16)),
        ),
      ),
    );
  }

  _cancelButton(context){
    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus?.unfocus();
        addressController.clearTextField();
        Get.back();
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: 40,
        decoration: BoxDecoration(
            color: MyTheme.isDarkTheme.value?App.darkGrey:Color(0xffededed),
            borderRadius: BorderRadius.circular(10)
        ),
        child:  Center(
          child: Text(App_Localization.of(context).translate("cancel").toUpperCase(),
              style: TextStyle(color: App.textMediumColor(),fontSize: 16)),
        ),
      ),
    );
  }
}
