// ignore_for_file: must_be_immutable

import 'package:alwan_press/app_localization.dart';
import 'package:alwan_press/controller/inquery_controller.dart';
import 'package:alwan_press/controller/our_clients_controller.dart';
import 'package:alwan_press/helper/app.dart';
import 'package:alwan_press/helper/global.dart';
import 'package:alwan_press/helper/myTheme.dart';
import 'package:alwan_press/widget/darkModeBackground.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class InQuery extends StatelessWidget {

  InQuery({super.key});

  InqueryController inqueryController = Get.put(InqueryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() => Container(
          child: Stack(
            children: [
              DarkModeBackground(),
              Container(
                // height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: [
                      _header(context),
                      SizedBox(
                        height: 10,
                      ),
                      _body(context)
                    ],
                  )),
              inqueryController.successfully.value?succssfully(context):Center(),
              inqueryController.showImagePicker.value?_chooseImage(context):Center()
            ],
          ),
        )),
      ),
    );
  }

  _header(BuildContext context) {
    return Container(
      width: Get.width,
      height: 60,
      decoration: BoxDecoration(
          color: MyTheme.isDarkTheme.value ? App.newDarkGrey : Colors.white,
          boxShadow: [App.myBoxShadow]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: Get.width * 0.05,
          ),
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: App.textLightColor(),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          App.logo(context),
        ],
      ),
    );
  }

  _body(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [

              SizedBox(
                height: 20,
              ),
              inqueryController.loading.value
                  ? Center(
                child: CircularProgressIndicator(),
              )
                  : textFilds(context),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
  textFilds(BuildContext context){
    return Column(
      children: [
        SizedBox(height: 10,),
        _isPerson(context),
        SizedBox(height: 10,),
        _name(context),
        SizedBox(height: 10,),
        _email(context),
        SizedBox(height: 10,),
        _msg(context),
        SizedBox(height: 10,),
        _quantity(context),
        SizedBox(height: 10,),
        _phone(context),
        SizedBox(height: 20,),
        _attachment(context),
        SizedBox(height: 20,),
        _submit(context),
        SizedBox(height: 10,),
        inqueryController.fake.value?Center():Center()
      ],
    );
  }
  _submit(BuildContext context){
    return GestureDetector(
      onTap: (){
        inqueryController.submit(context);
      },
      child: Container(
        width: Get.width * 0.9,
        height: 40,
        decoration: BoxDecoration(
          color: App.pink,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(App_Localization.of(context).translate("save"),),
        ),
      ),
    );
  }
  _chooseImage(BuildContext context){
    return SafeArea(

      child: GestureDetector(
        onTap: (){
          //todo
          inqueryController.showImagePicker.value = false;
        },
        child: Container(
          color: Colors.black.withOpacity(0.5),
          child: Center(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 180,
                child: Center(
                  child: Container(
                      width: 150,
                      height: 65,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: ()async{
                                //todo camera
                                inqueryController.pickCamera(context);
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.camera_alt,size: 35,color: App.blue,),
                                  Text(App_Localization.of(context).translate("camera"),style: TextStyle(color: App.blue,fontSize: 11,fontWeight: FontWeight.bold),)
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: ()async{
                                //todo gallery
                                inqueryController.pickGallery(context);
                              },
                              child:Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.photo,size: 35,color: App.pink,),
                                  Text(App_Localization.of(context).translate("gallery"),style: TextStyle(color: App.pink,fontSize: 11,fontWeight: FontWeight.bold),)
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  succssfully(BuildContext context){
    return Container(
      width: Get.width,
      height: Get.height,
      color: App.containerColor().withOpacity(0.5),
      child: Center(
        child: Lottie.asset("assets/animation/Tick.json"),
      ),
    );
  }
  getChilds(BuildContext context){
    return [

    ];
  }
  _isPerson(BuildContext context){
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 55,
      child: Center(
        child: Container(
          width: 182,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: App.pink)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: (){
                  inqueryController.isPerson(1);
                },
                child: Container(
                  width: 90,
                  height: 40,
                  decoration: BoxDecoration(
                    color: inqueryController.isPerson.value==1?App.pink:App.containerColor(),

                    borderRadius: Global.langCode == "en"?
                    BorderRadius.horizontal(left: Radius.circular(25))
                        :BorderRadius.horizontal(right: Radius.circular(25))
                  ),
                  child: Center(child: Text(App_Localization.of(context).translate("person"),style: TextStyle(color: App.textColor()),)),
                ),
              ),
              GestureDetector(
                onTap: (){
                  inqueryController.isPerson(0);
                },
                child: Container(
                  width: 90,
                  height: 40,
                  decoration: BoxDecoration(
                      color: inqueryController.isPerson.value==0?App.pink:App.containerColor(),
                      borderRadius:
                      Global.langCode == "en"?
                      BorderRadius.horizontal(right: Radius.circular(25))
                          :BorderRadius.horizontal(left: Radius.circular(25))
                  ),
                  child: Center(child: Text(App_Localization.of(context).translate("company"),style: TextStyle(color: App.textColor()),)),
                ),
              ),

            ],
          ),
        ),
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
        controller: inqueryController.phone_number,
        style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black),
        maxLength: 9,
        decoration: InputDecoration(
            counterText: '',
            prefixText: '+971 ',
            prefixStyle:  TextStyle(
              color: Theme.of(context).dividerColor,
            ),
            focusedBorder: UnderlineInputBorder(

              borderSide: BorderSide(width: 1, color:  inqueryController.validate.value&&inqueryController.phone_number.text.isEmpty?Colors.red:getColor()),
            ),
            enabledBorder: UnderlineInputBorder(

              borderSide:  BorderSide(width: 1, color:  inqueryController.validate.value&&inqueryController.phone_number.text.isEmpty?Colors.red:getColor()),
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            label: Text(App_Localization.of(context).translate("phone"),
                style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black,fontSize: 14))
        ),
      ),
    );
  }
  _name(context){
    return  Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 55,
      color: Colors.transparent,
      child: TextField(
        controller: inqueryController.name,
        style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black),
        decoration: InputDecoration(
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(width: 1, color:  inqueryController.validate.value&&inqueryController.name.text.isEmpty?Colors.red:getColor()),
            ),
            enabledBorder: UnderlineInputBorder(

              // borderSide:  BorderSide(width: 1, color: addressController.validate.value&&addressController.building!.text.isEmpty?Colors.red: MyTheme.isDarkTheme.value ? Colors.white : Colors.black),
              borderSide:  BorderSide(width: 1, color: inqueryController.validate.value&&inqueryController.name.text.isEmpty?Colors.red:getColor()),
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            label: Text(App_Localization.of(context).translate("name"),
                style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black,fontSize: 14))
        ),
      ),
    );
  }
  _email(context){
    return  Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 55,
      color: Colors.transparent,
      child: TextField(
        controller: inqueryController.email,
        style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black),
        decoration: InputDecoration(
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(width: 1, color:  getColor()),
            ),
            enabledBorder: UnderlineInputBorder(

              // borderSide:  BorderSide(width: 1, color: addressController.validate.value&&addressController.building!.text.isEmpty?Colors.red: MyTheme.isDarkTheme.value ? Colors.white : Colors.black),
              borderSide:  BorderSide(width: 1, color: getColor()),
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            label: Text(App_Localization.of(context).translate("email"),
                style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black,fontSize: 14))
        ),
      ),
    );
  }
  _msg(BuildContext context){
    return  Container(
      width: MediaQuery.of(context).size.width * 0.9,
      // height: 55,
      color: Colors.transparent,
      child: Column(
        children: [
          TextField(
            keyboardType: TextInputType.multiline,
            controller: inqueryController.msg,
            minLines: 1,
            maxLines: 8,
            style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black),
            decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(width: 1, color:  inqueryController.validate.value&&inqueryController.msg.text.isEmpty?Colors.red:getColor()),
                ),
                enabledBorder: UnderlineInputBorder(

                  // borderSide:  BorderSide(width: 1, color: addressController.validate.value&&addressController.building!.text.isEmpty?Colors.red: MyTheme.isDarkTheme.value ? Colors.white : Colors.black),
                  borderSide:  BorderSide(width: 1, color: inqueryController.validate.value&&inqueryController.msg.text.isEmpty?Colors.red:getColor()),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                label: Text(App_Localization.of(context).translate("message"),
                    style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black,fontSize: 14))
            ),
          ),
        ],
      ),
    );
  }
  _quantity(context){
    return  Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 55,
      color: Colors.transparent,
      child: TextField(
        keyboardType: TextInputType.number,
        controller: inqueryController.quantity,
        style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black),
        decoration: InputDecoration(
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(width: 1,
                  color: getColor()),
            ),
            enabledBorder: UnderlineInputBorder(

              // borderSide:  BorderSide(width: 1, color: addressController.validate.value&&addressController.building!.text.isEmpty?Colors.red: MyTheme.isDarkTheme.value ? Colors.white : Colors.black),
              borderSide:  BorderSide(width: 1, color: getColor()),
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            label: Text(App_Localization.of(context).translate("quantity"),
                style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black,fontSize: 14))
        ),
      ),
    );
  }
  _attachment(context){
    return  GestureDetector(
      onTap: (){
        inqueryController.showImagePicker(true);
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: 40,
        decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(color: getColor()),
          borderRadius: BorderRadius.circular(25)
        ),

        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(App_Localization.of(context).translate("attachment"),style: TextStyle(color: App.textColor()),),
              inqueryController.image==null
                  ?Icon(Icons.add,color: App.textColor(),)
                  :Icon(Icons.check,color: Colors.green,)
            ],
          ),
        )
      ),
    );
  }
  Color getColor(){
    return MyTheme.isDarkTheme.value ?Color(0xff3B3B3B):Color(0xffDFDFDF);
  }
}
