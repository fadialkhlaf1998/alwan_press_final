import 'dart:ui';
import 'package:alwan_press/app_localization.dart';
import 'package:alwan_press/controller/intro_controller.dart';
import 'package:alwan_press/controller/main_class_controller.dart';
import 'package:alwan_press/controller/order_controller.dart';
import 'package:alwan_press/helper/app.dart';
import 'package:alwan_press/helper/global.dart';
import 'package:alwan_press/helper/myTheme.dart';
import 'package:alwan_press/model/order.dart';
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
  FocusNode focusNode = FocusNode();
  OrderPage(){
    orderController.dropdownvalue.value = "";
  }
  
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



  _orderList(context){
    return RefreshIndicator(
        key: orderController.refreshIndicatorKey,
        onRefresh: () async {
         return await orderController.getOrderDataIndicater();
      },
      child: Container(
        margin: EdgeInsets.only(top: 70),
        // height: MediaQuery.of(context).size.height * 0.8,
        // color: !MyTheme.isDarkTheme.value ?  Colors.white : Colors.black,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 600),
          child:  orderController.loading.value
              ? const Center(child: CircularProgressIndicator(),)
              :Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _filteredOrderList(context,orderController.filteredData),

                    ],
                  ),
                )
              ),
        ),
      )
    );
  }

  _header(BuildContext context){
    return Container(
      width: Get.width,
      height: 60,
      color: MyTheme.isDarkTheme.value?App.darkGrey:Colors.white,
      child: Column(
        children: [
          Container(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: Get.width * 0.05,),
                App.logo(context),
                SizedBox(width: Get.width * 0.05,),
                Container(
                    width: Get.width *0.85 - 112,
                    height: 30,
                    decoration: BoxDecoration(
                        color: App.textColor().withOpacity(0.1),
                        borderRadius: BorderRadius.circular(5)
                    ),
                    child: TextField(
                      controller: orderController.search,
                      focusNode: focusNode,
                      style: TextStyle(color: App.textColor()),
                      onChanged: (val){
                        orderController.searchForData();
                      },
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(0),
                            borderSide:  BorderSide(width: 1, color:Colors.transparent),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(0),
                            borderSide:  BorderSide(width: 1, color:Colors.transparent),
                          ),
                          suffixIcon: GestureDetector(
                            onTap: (){
                              orderController.search.clear();
                              orderController.searchForData();
                              focusNode.unfocus();
                            },
                            child: Icon(Icons.close,color:orderController.search.text.isEmpty?Colors.transparent:App.textColor().withOpacity(0.5),size: 20,),
                          ),
                          prefixIcon: Icon(Icons.search,color:App.textColor().withOpacity(0.5),size: 20,),
                          hintText: App_Localization.of(context).translate("search"),
                          hintStyle: TextStyle(color:App.textColor().withOpacity(0.5),fontSize: 10),
                          floatingLabelBehavior: FloatingLabelBehavior.always
                        // alignLabelWithHint: true,
                      ),
                      // autofocus: true,
                    )
                ),
                SizedBox(width: Get.width * 0.05,),


                // Expanded(
                //   child: Container(
                //     height: 35,
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(2),
                //       border: Border.all(color: App.textColor().withOpacity(0.3))
                //     ),
                //     child:  Padding(
                //       padding: const EdgeInsets.symmetric(horizontal: 5),
                //       child: DropdownButton(
                //
                //         // Initial Value
                //         value: orderController.dropdownvalue.value == ""?App_Localization.of(context).translate("all"):orderController.dropdownvalue.value,
                //
                //         // Down Arrow Icon
                //         icon: Icon(Icons.keyboard_arrow_down,color: App.textColor()),
                //         dropdownColor: App.containerColor(),
                //         // Array list of items
                //         items: [
                //           App_Localization.of(context).translate("all"),
                //           App_Localization.of(context).translate("state0"),
                //           App_Localization.of(context).translate("state1"),
                //           App_Localization.of(context).translate("state2"),
                //           App_Localization.of(context).translate("state3"),
                //           App_Localization.of(context).translate("state4"),
                //           App_Localization.of(context).translate("hold"),
                //         ].map((String items) {
                //           return DropdownMenuItem(
                //             value: items,
                //             child: Text(items,style: TextStyle(color: App.textColor(),fontSize: 10)),
                //           );
                //         }).toList(),
                //         // After selecting the desired option,it will
                //         // change button value to selected value
                //         onChanged: (newValue) {
                //           print(newValue);
                //           orderController.dropdownvalue.value = newValue.toString();
                //           orderController.filteredData.value =
                //           orderController.dropdownvalue.value == App_Localization.of(context).translate("all") || orderController.dropdownvalue.value == ""?
                //           orderController.myOrders.value:
                //           orderController.dropdownvalue.value == App_Localization.of(context).translate("state0")?
                //           orderController.waitingAdvance.value:
                //           orderController.dropdownvalue.value == App_Localization.of(context).translate("state1")?
                //           orderController.inProgress.value:
                //           orderController.dropdownvalue.value == App_Localization.of(context).translate("state2")?
                //           orderController.waitingFinal.value:
                //           orderController.dropdownvalue.value == App_Localization.of(context).translate("state3")?
                //           orderController.ready.value:
                //           orderController.dropdownvalue.value == App_Localization.of(context).translate("state4")?
                //           orderController.delivered.value:
                //           orderController.hold.value;
                //         },
                //         underline: Center(),
                //         hint: Text(orderController.dropdownvalue.value,style: TextStyle(color: App.textColor(),fontSize: 10),),
                //       ),
                //     ),
                //   ),
                // ),


              ],
            ),
          ),

        ],
      ),
    );
  }

  _hold(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(App_Localization.of(context).translate("hold"),style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black,fontSize: 15,fontWeight: FontWeight.bold),),
        Container(
          height: 130,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: orderController.hold.length,
              itemBuilder: (context,index){
                return _orderCard(context, orderController.hold[index]);
              }),
        ),
      ],
    );
  }
  _waitingAdvanced(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(App_Localization.of(context).translate("state0"),style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black,fontSize: 15,fontWeight: FontWeight.bold),),
        Container(
          height: 130,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: orderController.waitingAdvance.length,
              itemBuilder: (context,index){
                return _orderCard(context, orderController.waitingAdvance[index]);
              }),
        ),
      ],
    );
  }

  _inProgress(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(App_Localization.of(context).translate("state1"),style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black,fontSize: 15,fontWeight: FontWeight.bold),),
        Container(
          height: 130,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: orderController.inProgress.length,
              itemBuilder: (context,index){
                return _orderCard(context, orderController.inProgress[index]);
              }),
        ),
      ],
    );
  }

  _waitingFinal(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(App_Localization.of(context).translate("state2"),style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black,fontSize: 15,fontWeight: FontWeight.bold),),
        Container(
          height: 130,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: orderController.waitingFinal.length,
              itemBuilder: (context,index){
                return _orderCard(context, orderController.waitingFinal[index]);
              }),
        ),
      ],
    );
  }

  _ready(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(App_Localization.of(context).translate("state3"),style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black,fontSize: 15,fontWeight: FontWeight.bold),),
        Container(
          height: 130,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: orderController.ready.length,
              itemBuilder: (context,index){
                return _orderCard(context, orderController.ready[index]);
              }),
        ),
      ],
    );
  }

  _delivered(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(App_Localization.of(context).translate("state4"),style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black,fontSize: 15,fontWeight: FontWeight.bold),),
        Container(
          height: 130,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: orderController.delivered.length,
              itemBuilder: (context,index){
                return _orderCard(context, orderController.delivered[index]);
              }),
        ),
      ],
    );
  }
  _filteredOrderList(BuildContext context,List<Order> orders){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount:orders.length,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context,index){
                return _orderCard(context, orders[index]);
              }),
        ),
      ],
    );
  }

  _orderCard(BuildContext context,Order order){
    return GestureDetector(
      onTap: (){
        Get.to(()=>OrderDetails(order.id));
      },
      child: Column(

        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: MyTheme.isDarkTheme.value ?
              App.darkGrey :
              Colors.white,
            ),
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width-20 ,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("#"+order.quickBookId.toString(),style:  TextStyle(color: App.textColor(),fontSize: 11,fontWeight: FontWeight.bold),),
                            Text(App_Localization.of(context).translate("pleaced_on") +" "+orderController.convertTime(order.created_at.toString()),
                              style: TextStyle(color: App.textMediumColor(),fontSize: 10),
                            ),
                          ],
                        ),
                        Container(
                          width: 100,
                          decoration: BoxDecoration(
                            // color: App.pink,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Center(
                            child: GestureDetector(
                              onTap: (){
                                Get.to(()=>OrderDetails(order.id));
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(App_Localization.of(context).translate("view_details"),style:  TextStyle(color: App.textLightColor(),fontSize: 11,fontWeight: FontWeight.bold),),
                                  SizedBox(width: 5,),
                                  Icon(Icons.arrow_forward_ios,color: App.textLightColor(),size: 13,)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Container(width: Get.width - 20 ,color: MyTheme.isDarkTheme.value ? Colors.white.withOpacity(0.5) : Color(0xffA1A1A1),height: 0.5,),
                    const SizedBox(height: 10),
                    Text(order.title,style:  TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white.withOpacity(0.5) : Color(0xffA1A1A1),fontSize: 16,fontWeight: FontWeight.bold),),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            order.hold == 1
                                ? Text(App_Localization.of(context).translate("hold"),style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 12),)
                                :order.state == 0
                                ? Text(order.getStateManual(context,0),style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 12),)
                                :order.state == 2
                                ?Text(order.getStateManual(context,2),style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 12),)
                                :Text(App_Localization.of(context).translate("ready_on"),
                              style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black,fontSize: 13,fontWeight: FontWeight.bold),
                            ),

                            order.state == 0
                                || order.state == 2
                                || order.hold == 1
                                ?Center()
                                : Text(" "+orderController.convertTime(order.deadline.toString()),
                              style: TextStyle(color: Colors.green,fontSize: 13,fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),

                      ],
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 10,)
        ],
      ),
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
              Colors.white.withOpacity(0.15) :
              Colors.black.withOpacity(0.075),
              borderRadius: BorderRadius.circular(5),

            ),
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width*0.9 ,
                height: 160,

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

                      ],
                    ),
                    SizedBox(height: 5,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 40,
                          width: Get.width * 0.9,
                          decoration: BoxDecoration(
                            color: App.pink,
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: Center(
                            child: GestureDetector(
                              onTap: (){
                                //orderController.myOrders[index].orderId
                                Get.to(()=>OrderDetails(orderController.myOrders[index].id));
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(App_Localization.of(context).translate("view_details"),style:  TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),),
                                  SizedBox(width: 10,),
                                  Icon(Icons.arrow_circle_right_outlined,color: Colors.white,size: 20,)
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 5,)
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
  _orderItemArchive(BuildContext context,int index){
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
