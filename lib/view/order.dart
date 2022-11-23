import 'dart:ui';
import 'package:alwan_press/app_localization.dart';
import 'package:alwan_press/controller/intro_controller.dart';
import 'package:alwan_press/controller/main_class_controller.dart';
import 'package:alwan_press/controller/order_controller.dart';
import 'package:alwan_press/helper/app.dart';
import 'package:alwan_press/helper/global.dart';
import 'package:alwan_press/helper/myTheme.dart';
import 'package:alwan_press/view/address_2.dart';
import 'package:alwan_press/view/order_details.dart';
import 'package:alwan_press/view/pdf_viwer.dart';
import 'package:alwan_press/view/sign_in.dart';
import 'package:alwan_press/widget/darkModeBackground.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:get/get.dart';

class OrderPage extends StatelessWidget {

  IntroController introController = Get.find();
  OrderController orderController = Get.find();
  MainClassController mainClassController = Get.find();
  
  @override
  Widget build(BuildContext context) {
    return Obx((){
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarColor: MyTheme.isDarkTheme.value ? const Color(0XFF181818) : Colors.white
      ));
      print( orderController.myOrders.isEmpty);
      print( "orderController.myOrders.isEmpty");
      return Scaffold(
        body: SafeArea(
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              const DarkModeBackground(),
              Global.userId == -1?_notLogedIn(context):
              orderController.myOrders.isNotEmpty
                  ? _orderList(context)
                  : _noOrder(context),
              _header(context),
            ],
          ),
        ),
      );
    });
  }

  _header(context){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.1,
      decoration: BoxDecoration(
        color: MyTheme.isDarkTheme.value ?  Colors.transparent : Colors.white,
      ),
      child: Center(
        child: Text(App_Localization.of(context).translate("orders"),
          style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black,fontSize: 24),
        ),
      ),
    );
  }

  _orderList(context){
    return RefreshIndicator(
        key: orderController.refreshIndicatorKey,
        onRefresh: () async {
         return await orderController.getOrderDataIndicater();
      },
      child: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.08),
        height: MediaQuery.of(context).size.height * 0.8,
        color: !MyTheme.isDarkTheme.value ?  Colors.white : Colors.transparent,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 600),
          child:  orderController.loading.value
              ? const Center(child: CircularProgressIndicator(),)
              :Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: ListView.builder(
            padding: EdgeInsets.only(bottom: 0),
            itemCount: orderController.myOrders.length,
            itemBuilder: (context, index){
                // var dateTime = orderController.calculateTime(index);
                // orderController.setOrderState(index);
                return _orderItem(context,index);
            },
          ),
              ),
        ),
      )
    );
  }

  _orderItem(BuildContext context,int index){
    return GestureDetector(
      onTap: (){
        Get.to(()=>OrderDetails(orderController.myOrders[index].id));
      },
      child: Column(

        children: [
          const SizedBox(height: 20),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.95,
            child: Text(App_Localization.of(context).translate("pleaced_on") +" "+orderController.convertTime(orderController.myOrders[index].created_at.toString()),
              style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white.withOpacity(0.5) : Colors.black.withOpacity(0.5),fontSize: 14),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: MediaQuery.of(context).size.width*0.95,
            decoration: BoxDecoration(
              color: MyTheme.isDarkTheme.value ?
              Colors.white.withOpacity(0.05) :
              Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                  color: MyTheme.isDarkTheme.value ?
                  Colors.transparent :
                  Colors.grey.withOpacity(0.5),
                  blurRadius: 3,
                  offset: const Offset(1, 1),
                ),
              ],
            ),
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width*0.9 ,
                height: 100,

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(orderController.myOrders[index].title,style:  TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black,fontSize: 18,fontWeight: FontWeight.bold),),
                    Text("#"+orderController.myOrders[index].orderId,style:  TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white.withOpacity(0.5) : Colors.black.withOpacity(0.5),fontSize: 14),),
                    Center(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            orderController.myOrders[index].hold == 1
                                ? Text(App_Localization.of(context).translate("hold"),style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),)
                            :orderController.myOrders[index].state == 0
                                ? Text(orderController.myOrders[index].getStateManual(context,0),style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),)
                                :orderController.myOrders[index].state == 2
                              ?Text(orderController.myOrders[index].getStateManual(context,2),style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),)
                            :Text(App_Localization.of(context).translate("ready_on"),
                              style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black,fontSize: 13,fontWeight: FontWeight.bold),
                            ),

                            orderController.myOrders[index].state == 0
                                || orderController.myOrders[index].state == 2
                                || orderController.myOrders[index].hold == 1
                                ?Center()
                                : Text(" "+orderController.convertTime(orderController.myOrders[index].deadline.toString()),
                                  style: TextStyle(color: Colors.green,fontSize: 13,fontWeight: FontWeight.bold),
                                ),
                          ],
                        ),
                        GestureDetector(
                          onTap: (){
                            //orderController.myOrders[index].orderId
                            Get.to(()=>OrderDetails(orderController.myOrders[index].id));
                          },
                          child: Row(
                            children: [
                              Text(App_Localization.of(context).translate("view_details"),style:  TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white.withOpacity(0.5) : Colors.black.withOpacity(0.5),fontSize: 15),),
                              SizedBox(width: 5,),
                              Icon(Icons.arrow_forward_ios,color: MyTheme.isDarkTheme.value ? Colors.white.withOpacity(0.5) : Colors.black.withOpacity(0.5),size: 15,)
                            ],
                          ),
                        )
                      ],
                    ),


                  ],
                ),
              ),
            ),
          ),
          // orderController.myOrders[index].openDescription.value?


        ],
      ),
    );
  }


  _requestShipping(context,int index){
    return  Container(
      width: MediaQuery.of(context).size.width*0.9,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: (){
              orderController.loading.value = true;
              orderController.loadPdf(orderController.myOrders[index].invoice).then((value){
                var pdf = value.path;
                orderController.loading.value = false;
                Get.to(()=>PdfViewerPage(pdf));
              });
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.35,
              height: 35,
              decoration: BoxDecoration(
                  color: App.pink,
                  borderRadius: BorderRadius.circular(10)
              ),
              child:  Center(
                child:Text(App_Localization.of(context).translate("invoice"),
                    style: TextStyle(color: Colors.white,fontSize: 14)),
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              Get.to(()=>Addresses_2(orderController.myOrders[index].id));
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.35,
              height: 35,
              decoration: BoxDecoration(
                  color: App.pink,
                  borderRadius: BorderRadius.circular(10)
              ),
              child:  Center(
                child:Text(App_Localization.of(context).translate("shipping"),
                    style: TextStyle(color: Colors.white,fontSize: 14)),
              ),
            ),
          ),
        ],
      ),
    );
  }
  _shippingRequested(context,int index){
    return Row(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: 35,
          child:   Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              GestureDetector(
                onTap: (){
                  orderController.loading.value = true;
                  orderController.loadPdf(orderController.myOrders[index].invoice).then((value){
                    var pdf = value.path;
                    orderController.loading.value = false;
                    Get.to(()=>PdfViewerPage(pdf));
                  });
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.35,
                  height: 35,
                  decoration: BoxDecoration(
                      color: App.pink,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child:  Center(
                    child:Text(App_Localization.of(context).translate("invoice"),
                        style: TextStyle(color: Colors.white,fontSize: 14)),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.35,
                height: 35,
                child:   FittedBox(
                  child: Row(
                    children: [

                      Text(
                        App_Localization.of(context).translate("shipping_price")+": ",
                        style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black,fontSize: 14),
                      ),

                      Text(
                        orderController.myOrders[index].shippingState ==0
                            ? App_Localization.of(context).translate("free")
                            : orderController.myOrders[index].shippingPrice.toString() +" "+App_Localization.of(context).translate("aed"),
                        style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black,fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

      ],
    );
  }
  _noOrder(context){
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.08),
      height: MediaQuery.of(context).size.height,
      color: !MyTheme.isDarkTheme.value ?  Colors.white : Colors.transparent,
      child: Column(
        children: [
          SizedBox(height: 90,),
          Icon(Icons.remove_shopping_cart_outlined,color:  MyTheme.isDarkTheme.value ? Colors.white : Colors.black),
          SizedBox(height: 15,),
          Text(App_Localization.of(context).translate("not_have_order"),
            style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black,fontSize: 13),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(App_Localization.of(context).translate("what_wait"),
                style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black,fontSize: 14),
              ),
              SizedBox(width: 5,),
              GestureDetector(
                onTap: (){
                  mainClassController.selectedIndex.value = 0;
                  mainClassController.pageController.animateToPage(0,  duration: const Duration(milliseconds: 700), curve: Curves.fastOutSlowIn);
                },
                child: Text(App_Localization.of(context).translate("start_shopping"),
                  style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black,fontSize: 14,fontWeight: FontWeight.normal),
                ),
              )
            ],
          )

        ],
      ),
    );
  }
  _notLogedIn(context){
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.08),
      height: MediaQuery.of(context).size.height,
      color: !MyTheme.isDarkTheme.value ?  Colors.white : Colors.transparent,
      child: Column(
        children: [
          SizedBox(height: 90,),
          Icon(Icons.remove_shopping_cart_outlined,color:  MyTheme.isDarkTheme.value ? Colors.white : Colors.black),
          SizedBox(height: 15,),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(App_Localization.of(context).translate("not_login"),
                style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black,fontSize: 14),
              ),
              SizedBox(width: 5,),
              GestureDetector(
                onTap: (){
                  Get.offAll(()=>SignIn());
                },
                child: Text(App_Localization.of(context).translate("sign_in"),
                  style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black,fontSize: 14,fontWeight: FontWeight.bold),
                ),
              )
            ],
          )

        ],
      ),
    );
  }
  _buildTimeWidget(context, title, text){
    return   Expanded(
      flex: 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.09 - 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Center(
              child: Text(
                '$text',
                style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
              '$title',
            style: const TextStyle(fontSize: 10, color: Colors.white),
          )
        ],
      ),
    );
  }
}
