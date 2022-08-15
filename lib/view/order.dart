import 'dart:ui';
import 'package:alwan_press/app_localization.dart';
import 'package:alwan_press/controller/intro_controller.dart';
import 'package:alwan_press/controller/main_class_controller.dart';
import 'package:alwan_press/controller/order_controller.dart';
import 'package:alwan_press/helper/app.dart';
import 'package:alwan_press/helper/global.dart';
import 'package:alwan_press/helper/myTheme.dart';
import 'package:alwan_press/view/address_2.dart';
import 'package:alwan_press/view/pdf_viwer.dart';
import 'package:alwan_press/view/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:get/get.dart';

class OrderPage extends StatelessWidget {

  IntroController introController = Get.find();
  OrderController orderController = Get.put(OrderController());
  MainClassController mainClassController = Get.find();
  
  @override
  Widget build(BuildContext context) {
    return Obx((){
      return Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              MyTheme.isDarkTheme.value ? Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/image/background.png')
                      )
                  )
              ) : Text(''),
              Global.userId == -1?_notLogedIn(context):
              orderController.myOrders.length>0
                  ?_orderList(context)
                  :_noOrder(context),
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
      onRefresh: () async {
        orderController.getOrderData();
      },
      child: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.08),
        height: MediaQuery.of(context).size.height,
        color: !MyTheme.isDarkTheme.value ?  Colors.white : Colors.transparent,
        child: AnimatedSwitcher(
          duration: Duration(milliseconds: 600),
          child:  orderController.loading.value
              ? Center(child: CircularProgressIndicator(),)
              :ListView.builder(
            itemCount: orderController.myOrders.length,
            itemBuilder: (context, index){
              // var dateTime = orderController.calculateTime(index);
              // orderController.setOrderState(index);
              return Column(
                children: [
                  const SizedBox(height: 20),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.95,
                    child: Text(orderController.convertTime(orderController.myOrders[index].deadline.toString()),
                      style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black,fontSize: 14),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: MyTheme.isDarkTheme.value ?
                      Colors.white.withOpacity(0.05) :
                      Colors.white,
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
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: MediaQuery.of(context).size.height*0.19,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                      vertical: 10, //MediaQuery.of(context).size.height * 0.02
                                    ),
                                    width: MediaQuery.of(context).size.width*0.9,
                                    height: MediaQuery.of(context).size.height,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "#"+orderController.myOrders[index].orderId,
                                              maxLines: 2,
                                              style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black,fontSize: 16,fontWeight: FontWeight.bold),
                                            ),
                                            orderController.myOrders[index].ready.value == true
                                                ?
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.symmetric(vertical: 0),
                                                  child: CountdownTimer(
                                                    endTime:  orderController.myOrders[index].deadline.millisecondsSinceEpoch,
                                                    textStyle: TextStyle(fontSize: 16, color: MyTheme.isDarkTheme.value?Colors.white:Colors.black),
                                                    widgetBuilder: (cuntext,current){
                                                      return Container(
                                                        child: Row(
                                                          children: [
                                                            Container(
                                                              height:MediaQuery.of(context).size.width/5*2/4,
                                                              width: MediaQuery.of(context).size.width/5*2/4,
                                                              decoration: BoxDecoration(
                                                                shape: BoxShape.circle,
                                                                // border: Border.all(color: MyTheme.isDarkTheme.value?Colors.white:Colors.black)
                                                              ),
                                                              child: Column(
                                                                children: [
                                                                  Text(current!.days.toString()),
                                                                  Text(App_Localization.of(context).translate("days"),style: TextStyle(fontSize: 8),)
                                                                ],
                                                              ),
                                                            ),

                                                            Container(
                                                              height:MediaQuery.of(context).size.width/5*2/4,
                                                              width: MediaQuery.of(context).size.width/5*2/4,
                                                              decoration: BoxDecoration(
                                                                shape: BoxShape.circle,
                                                                // border: Border.all(color: MyTheme.isDarkTheme.value?Colors.white:Colors.black)
                                                              ),
                                                              child: Column(
                                                                children: [
                                                                  Text(current.hours.toString()),
                                                                  Text(App_Localization.of(context).translate("hr"),style: TextStyle(fontSize: 8),)
                                                                ],
                                                              ),
                                                            ),
                                                            Container(
                                                              height:MediaQuery.of(context).size.width/5*2/4,
                                                              width: MediaQuery.of(context).size.width/5*2/4,
                                                              decoration: BoxDecoration(
                                                                shape: BoxShape.circle,
                                                                // border: Border.all(color: MyTheme.isDarkTheme.value?Colors.white:Colors.black)
                                                              ),
                                                              child: Column(
                                                                children: [
                                                                  Text(current.min.toString()),
                                                                  Text(App_Localization.of(context).translate("min"),style: TextStyle(fontSize: 8),)
                                                                ],
                                                              ),
                                                            ),
                                                            Container(
                                                              height:MediaQuery.of(context).size.width/5*2/4,
                                                              width: MediaQuery.of(context).size.width/5*2/4,
                                                              decoration: BoxDecoration(
                                                                shape: BoxShape.circle,
                                                                // border: Border.all(color: MyTheme.isDarkTheme.value?Colors.white:Colors.black)
                                                              ),
                                                              child: Column(
                                                                children: [
                                                                  Text(current.sec.toString()),
                                                                  Text(App_Localization.of(context).translate("sec"),style: TextStyle(fontSize: 8),)
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ],
                                            )

                                                : Container(
                                              child: Row(
                                                children: [
                                                  Container(
                                                    height:MediaQuery.of(context).size.width/5*2/4,
                                                    width: MediaQuery.of(context).size.width/5*2/4,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      // border: Border.all(color: MyTheme.isDarkTheme.value?Colors.white:Colors.black)
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        Text("0"),
                                                        Text(App_Localization.of(context).translate("days"),style: TextStyle(fontSize: 8),)
                                                      ],
                                                    ),
                                                  ),

                                                  Container(
                                                    height:MediaQuery.of(context).size.width/5*2/4,
                                                    width: MediaQuery.of(context).size.width/5*2/4,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      // border: Border.all(color: MyTheme.isDarkTheme.value?Colors.white:Colors.black)
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        Text("0"),
                                                        Text(App_Localization.of(context).translate("hr"),style: TextStyle(fontSize: 8),)
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    height:MediaQuery.of(context).size.width/5*2/4,
                                                    width: MediaQuery.of(context).size.width/5*2/4,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      // border: Border.all(color: MyTheme.isDarkTheme.value?Colors.white:Colors.black)
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        Text("0"),
                                                        Text(App_Localization.of(context).translate("min"),style: TextStyle(fontSize: 8),)
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    height:MediaQuery.of(context).size.width/5*2/4,
                                                    width: MediaQuery.of(context).size.width/5*2/4,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      // border: Border.all(color: MyTheme.isDarkTheme.value?Colors.white:Colors.black)
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        Text("0"),
                                                        Text(App_Localization.of(context).translate("sec"),style: TextStyle(fontSize: 8),)
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        RichText(
                                          text: TextSpan(
                                            text: orderController.myOrders[index].price.toString(),
                                            style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black,fontSize: 16),
                                            children: [
                                              TextSpan(text: ' AED', style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black,fontSize: 14)),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          child: FittedBox(
                                            child: Text(
                                              orderController.myOrders[index].getState(context),
                                              style: TextStyle(color: App.pink,fontSize: 11,fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            orderController.myOrders[index].title.isNotEmpty?
                            Container(
                              width: MediaQuery.of(context).size.width*0.9,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    orderController.myOrders[index].title,
                                    maxLines: 2,
                                    style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black,fontSize: 16,fontWeight: FontWeight.bold),
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      orderController.myOrders[index].openDescription.value =
                                          !orderController.myOrders[index].openDescription.value;
                                      print(orderController.myOrders[index].openDescription.value);
                                    },
                                    child: Obx(
                                     () {
                                        return Icon(orderController.myOrders[index].openDescription.value?Icons.keyboard_arrow_up_sharp:Icons.keyboard_arrow_down_sharp);
                                      }
                                    ),
                                  ),

                                ],
                              ),
                            ):Center(),

                            // orderController.myOrders[index].description.isNotEmpty?SizedBox(height: 10,):Center(),
                            orderController.myOrders[index].description.isNotEmpty?
                            Obx(() => AnimatedContainer(
                              duration: Duration(milliseconds: 400),
                              height: orderController.myOrders[index].openDescription.value?120:0,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    SizedBox(height: 10,),
                                    Text(
                                      orderController.myOrders[index].description,
                                      style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black,fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),

                            )):Center(),
                            SizedBox(height: 10,),
                            orderController.myOrders[index].shippingRequestCount == 0
                                ? _requestShipping(context,index)
                                :_shippingRequested(context,index),
                            SizedBox(height: 10,),
                            index == orderController.myOrders.length-1?SizedBox(height: 20,):Center()
                          ],
                        ),
                      ),
                    ),
                  ),

                ],
              );
            },
          ),
        ),
      )
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
            style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black,fontSize: 14),
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
                  style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black,fontSize: 14,fontWeight: FontWeight.bold),
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
                style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),
              ),
            ),
          ),
          SizedBox(height: 6),
          Text(
              '$title',
            style: TextStyle(fontSize: 10, color: Colors.white),
          )
        ],
      ),
    );
  }
}
