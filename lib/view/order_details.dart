import 'dart:ui';

import 'package:alwan_press/app_localization.dart';
import 'package:alwan_press/controller/order_controller.dart';
import 'package:alwan_press/controller/order_details_controller.dart';
import 'package:alwan_press/helper/api.dart';
import 'package:alwan_press/helper/app.dart';
import 'package:alwan_press/helper/global.dart';
import 'package:alwan_press/helper/myTheme.dart';
import 'package:alwan_press/model/order.dart';
import 'package:alwan_press/view/address_2.dart';
import 'package:alwan_press/view/my_fatoraah.dart';
import 'package:alwan_press/view/pdf_viwer.dart';
import 'package:alwan_press/view/sign_in.dart';
import 'package:alwan_press/widget/darkModeBackground.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class OrderDetails extends StatelessWidget {

  OrderDetailsController orderDetailsController = Get.put(OrderDetailsController());
  OrderController orderController = Get.find();
  var statement_loading = false.obs;
  OrderDetails(int id){
    orderDetailsController.loading.value = true;
    Api.getOrderInfo(id).then((order) {
      if(order != null){

        orderDetailsController.order = order;
        if(order.shippingRequestCount > 0){
          orderDetailsController.shippingSucc.value = true;
          orderDetailsController.shippingAnimationSucc.value = true;
        }
        orderDetailsController.totalForPayment = order.price.toDouble() - order.paid_amount.toDouble() + order.vat;
        if(order.shippingState != 0  && order.state != 0 && order.shippingRequestCount > 0){
          orderDetailsController.totalForPayment += order.shippingPrice;
        }
        print(orderDetailsController.totalForPayment);
        if(order.state == 0 ){
          orderDetailsController.totalForPayment = orderDetailsController.totalForPayment / 4 ;
        }
        print(orderDetailsController.totalForPayment);
        orderDetailsController.loading.value = false;
      }else{
        Get.back();
      }
    });

  }
  @override
  Widget build(BuildContext context) {

    return Obx((){
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarColor: MyTheme.isDarkTheme.value ? const Color(0XFF181818) : Colors.white
      ));
      return Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              const DarkModeBackground(),
              orderDetailsController.loading.value?
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: CircularProgressIndicator(
                    color: App.blue,
                  ),
                ),
              )
                  :Column(
                    children: [
                      _header(context),
                      SizedBox(height: 2,),
                      Expanded(child: RefreshIndicator(
                        key: orderDetailsController.refreshIndicatorKey,
                        onRefresh: () async {
                          return await orderDetailsController.refreshIndicater();
                        },

                        child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: Column(
                            children: [

                              // SizedBox(height: MediaQuery.of(context).size.height*0.1,),
                              SizedBox(height: 10,),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 135,
                                decoration: BoxDecoration(
                                  color: MyTheme.isDarkTheme.value ?
                                  App.darkGrey :
                                  Colors.white,
                                  // borderRadius: BorderRadius.circular(5),
                                  // boxShadow: [
                                  //   BoxShadow(
                                  //     color: MyTheme.isDarkTheme.value ?
                                  //     Colors.transparent :
                                  //     Colors.grey.withOpacity(0.5),
                                  //     blurRadius: 3,
                                  //     offset: const Offset(1, 1),
                                  //   ),
                                  // ],
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: Get.width * 0.95 /2 - 20,
                                      child: Text(
                                        orderDetailsController.order!.hold == 1?
                                        App_Localization.of(context).translate("hold")
                                            :orderDetailsController.order!.getState(context),
                                        style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black,fontSize: 15,fontWeight: FontWeight.bold,overflow: TextOverflow.clip),),
                                    ),

                                    // orderDetailsController.order!.state == 1 && orderDetailsController.order!.hold==0?
                                    false?
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        CountdownTimer(
                                          endTime: orderDetailsController.order!.deadline.millisecondsSinceEpoch + 1000 * 30,
                                          widgetBuilder: (context , deadline){
                                            return Container(
                                              width: 100,
                                              height: 80,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(15),
                                                  color: App.pink,
                                                  gradient: LinearGradient(colors: [Color(0xff962092),Color(0xff4d1043)],begin: Alignment.topCenter,end: Alignment.bottomCenter)
                                              ),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    width: 49,

                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          width: 49,
                                                          height: 50,
                                                          // color: Colors.black,
                                                          child: Center(
                                                            child: Text((deadline==null||deadline.days == null) ?"0": deadline.days.toString(),style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 25),),
                                                          ),
                                                        ),
                                                        Container(
                                                          height: 1,
                                                          width: 49,
                                                          margin: EdgeInsets.symmetric(horizontal: 5),
                                                          color: Colors.white.withOpacity(0.5),
                                                        ),
                                                        Container(
                                                          width: 49,
                                                          height: 29,
                                                          // color: Colors.black,
                                                          child: Center(
                                                            child: Text(App_Localization.of(context).translate("days").toUpperCase(),style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 10),),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 80,
                                                    width: 1,
                                                    color: Colors.white.withOpacity(0.5),
                                                  ),
                                                  Container(
                                                    width: 49,
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          width: 49,
                                                          height: 50,
                                                          // color: Colors.black,
                                                          child: Center(
                                                            child: Text((deadline==null||deadline.hours == null) ?"0": deadline.hours.toString(),style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 25),),
                                                          ),
                                                        ),
                                                        Container(
                                                          height: 1,
                                                          width: 49,
                                                          margin: EdgeInsets.symmetric(horizontal: 5),
                                                          color: Colors.white.withOpacity(0.5),
                                                        ),
                                                        Container(
                                                          width: 49,
                                                          height: 29,
                                                          // color: Colors.black,
                                                          child: Center(
                                                            child: Text(App_Localization.of(context).translate("hr").toUpperCase(),style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 10),),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                          endWidget: Container(
                                            width: 100,
                                            height: 80,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(15),
                                                color: App.pink,
                                                gradient: LinearGradient(colors: [Color(0xff962092),Color(0xff4d1043)],begin: Alignment.topCenter,end: Alignment.bottomCenter)
                                            ),
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: 49,

                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        width: 49,
                                                        height: 50,
                                                        // color: Colors.black,
                                                        child: Center(
                                                          child: Text("0",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 25),),
                                                        ),
                                                      ),
                                                      Container(
                                                        height: 1,
                                                        width: 49,
                                                        margin: EdgeInsets.symmetric(horizontal: 5),
                                                        color: Colors.white.withOpacity(0.5),
                                                      ),
                                                      Container(
                                                        width: 49,
                                                        height: 29,
                                                        // color: Colors.black,
                                                        child: Center(
                                                          child: Text(App_Localization.of(context).translate("days").toUpperCase(),style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 10),),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  height: 80,
                                                  width: 1,
                                                  color: Colors.white.withOpacity(0.5),
                                                ),
                                                Container(
                                                  width: 49,
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        width: 49,
                                                        height: 50,
                                                        // color: Colors.black,
                                                        child: Center(
                                                          child: Text("0",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 25),),
                                                        ),
                                                      ),
                                                      Container(
                                                        height: 1,
                                                        width: 49,
                                                        margin: EdgeInsets.symmetric(horizontal: 5),
                                                        color: Colors.white.withOpacity(0.5),
                                                      ),
                                                      Container(
                                                        width: 49,
                                                        height: 29,
                                                        // color: Colors.black,
                                                        child: Center(
                                                          child: Text(App_Localization.of(context).translate("hr").toUpperCase(),style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 10),),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 100,
                                          height: 100,
                                          child: Center(
                                            child: Lottie.asset("assets/animation/2.json"),
                                          ),
                                        )
                                      ],
                                    )
                                        :Container(
                                      height: 100,
                                      width: Get.width * 0.95 /2,
                                      child: Center(
                                        child: _getAnimation(orderDetailsController.order!.state,orderDetailsController.order!.hold),
                                      ),
                                    )

                                  ],
                                ),
                              ),
                              const SizedBox(height: 10,),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                // height: 190,
                                decoration: BoxDecoration(
                                  color: MyTheme.isDarkTheme.value ?
                                  App.darkGrey :
                                  Colors.white,
                                  // borderRadius: BorderRadius.circular(5),
                                  // boxShadow: [
                                  //   BoxShadow(
                                  //     color: MyTheme.isDarkTheme.value ?
                                  //     Colors.transparent :
                                  //     Colors.grey.withOpacity(0.5),
                                  //     blurRadius: 3,
                                  //     offset: const Offset(1, 1),
                                  //   ),
                                  // ],
                                ),
                                child: Center(
                                  child: Column(
                                    children: [
                                      Container(
                                        width: MediaQuery.of(context).size.width*0.9,
                                        height: 85,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(orderDetailsController.order!.title,style:  TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black,fontSize: 16,fontWeight: FontWeight.bold),),
                                            SizedBox(height: 5,),
                                            Text("#"+orderDetailsController.order!.orderId,style:  TextStyle(color: App.textLgColor(),fontSize: 14,fontWeight: FontWeight.bold),),
                                            Text(App_Localization.of(context).translate("pleaced_on") +" "+orderController.convertTime(orderDetailsController.order!.created_at.toString()),
                                              style: TextStyle(color:  App.textLgColor(),fontSize: 12),),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 15,),
                                      Container(
                                          height: 1,
                                          width: MediaQuery.of(context).size.width*0.9,
                                          color:  App.textLgColor().withOpacity(0.3)
                                      ),
                                      // SizedBox(height: 15,),
                                      orderDetailsController.fake.value ?Center():Center(),

                                      SizedBox(height: 15,),
                                      Container(
                                        width: MediaQuery.of(context).size.width*0.9,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(App_Localization.of(context).translate("description"),style:  TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black,fontSize: 16,fontWeight: FontWeight.bold),),
                                            Text(orderDetailsController.order!.description,
                                              style: TextStyle(color:  App.textLgColor(),fontSize: 12,),),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: MediaQuery.of(context).size.width*0.9,
                                        child: orderDetailsController.order!.note.isNotEmpty
                                            ?Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(App_Localization.of(context).translate("note")+":",
                                              style: TextStyle(color: Colors.red.withOpacity(0.7),fontSize: 12,fontWeight: FontWeight.bold),),
                                            Text(orderDetailsController.order!.note,
                                              style: TextStyle(color: Colors.red.withOpacity(0.7),fontSize: 12,),),
                                          ],
                                        ):Center(),
                                      ),
                                      SizedBox(height: 15,),
                                    ],
                                  ),
                                ),
                              ),
                              orderDetailsController.order!.hold == 1?Center():const SizedBox(height: 10,),
                              orderDetailsController.order!.hold == 1?Center():Container(
                                width: MediaQuery.of(context).size.width,
                                // height: 190,
                                decoration: BoxDecoration(
                                  color: MyTheme.isDarkTheme.value ?
                                  App.darkGrey :
                                  Colors.white,
                                  // borderRadius: BorderRadius.circular(5),
                                  // boxShadow: [
                                  //   BoxShadow(
                                  //     color: MyTheme.isDarkTheme.value ?
                                  //     Colors.transparent :
                                  //     Colors.grey.withOpacity(0.5),
                                  //     blurRadius: 3,
                                  //     offset: const Offset(1, 1),
                                  //   ),
                                  // ],
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(height: 15,),

                                    Container(
                                      width: MediaQuery.of(context).size.width*0.9,
                                      // height: 130,
                                      child: orderDetailsController.order!.shippingAddress!=null?
                                      Column(
                                        children: [
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              // Icon(Icons.location_on_outlined,color: App.textColor()),
                                              SvgPicture.asset("assets/icons/location.svg",color: App.textColor(),width: 22,),
                                              SizedBox(width: 5,),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [

                                                  Text(App_Localization.of(context).translate("shipping_address") ,
                                                    style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black,fontSize: 14,fontWeight: FontWeight.bold),),

                                                  Text(orderDetailsController.order!.shippingAddress!.customer,
                                                    style: TextStyle(color:  App.textLgColor(),fontSize: 12),),
                                                  Text(orderDetailsController.order!.shippingAddress!.streetName+" / "+
                                                      orderDetailsController.order!.shippingAddress!.building+" / flat: "+
                                                      orderDetailsController.order!.shippingAddress!.flat+" / floor: "+orderDetailsController.order!.shippingAddress!.floor,
                                                    style: TextStyle(color:  App.textLgColor(),fontSize: 12,),),



                                                ],
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10,),
                                          Container(
                                              height: 1,
                                              width: MediaQuery.of(context).size.width*0.9,
                                              color:  App.textLgColor().withOpacity(0.3)
                                          ),
                                          SizedBox(height: 10,),
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              // Icon(Icons.call,color: App.textColor()),
                                              SvgPicture.asset("assets/icons/call.svg",color: App.textColor(),width: 22,),
                                              SizedBox(width: 5,),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(App_Localization.of(context).translate("mobile_number"),
                                                    style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black,fontSize: 14,fontWeight: FontWeight.bold),),
                                                  Text(orderDetailsController.order!.shippingAddress!.phone,
                                                    style: TextStyle(color:  App.textLgColor(),fontSize: 12,),),
                                                ],
                                              ),

                                            ],
                                          ),
                                          SizedBox(height: 5,),
                                        ],
                                      )
                                          : orderDetailsController.shippingAnimationSucc.value?
                                      Column(
                                        children: [
                                          Container(
                                            height: 50,
                                            width: 50,
                                            child: Lottie.asset(
                                                'assets/animation/Tick.json',
                                                repeat: false,
                                                fit: BoxFit.cover
                                            ),
                                          ),
                                          Text(App_Localization.of(context).translate("your_order_will") ,
                                            style: TextStyle(color:  App.textLgColor(),fontSize: 14),),
                                          SizedBox(height: 10,),
                                        ],
                                      ):

                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(App_Localization.of(context).translate("do_u_want") ,
                                            style: TextStyle(color:  App.textLgColor(),fontSize: 14),),

                                          GestureDetector(
                                            onTap: (){
                                              //todo shipping
                                              Get.to(()=>Addresses_2(orderDetailsController.order!.id))!.then((value) {
                                                orderDetailsController.fake.value = !orderDetailsController.fake.value;
                                              });
                                            },
                                            child:  Container(
                                              width: MediaQuery.of(context).size.width * 0.9/2,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                  color: Theme.of(context).primaryColor,
                                                  borderRadius: BorderRadius.circular(10)
                                              ),
                                              child:  Center(
                                                child:  Text(App_Localization.of(context).translate("yes_order_delivery").toUpperCase(),
                                                    style: TextStyle(color: Colors.white,fontSize: 13)),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 10,),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 10,),

                                  ],
                                ),
                              ),
                              const SizedBox(height: 10,),

                              Stack(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: Center(
                                      child: Container(
                                        width: MediaQuery.of(context).size.width,
                                        height: 135,
                                        decoration: BoxDecoration(
                                          color: MyTheme.isDarkTheme.value ?
                                          App.darkGrey :
                                          Colors.white,
                                          // borderRadius: BorderRadius.circular(5),
                                          // boxShadow: [
                                          //   BoxShadow(
                                          //     color: MyTheme.isDarkTheme.value ?
                                          //     Colors.transparent :
                                          //     Colors.grey.withOpacity(0.5),
                                          //     blurRadius: 3,
                                          //     offset: const Offset(1, 1),
                                          //   ),
                                          // ],
                                        ),
                                        child: Center(
                                          child: Container(
                                            width: MediaQuery.of(context).size.width*0.9,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    GestureDetector(
                                                      onTap:(){
                                                        if(statement_loading.isFalse){
                                                          if(Global.user != null){
                                                            // orderController.loadPdf(Global.user!.financialState);

                                                            if(orderDetailsController.order!.invoice.endsWith("pdf")){
                                                              // profileController.loading.value = true;
                                                              statement_loading.value = true;
                                                              orderController.loadPdf(orderDetailsController.order!.invoice).then((value){
                                                                var pdf = value.path;
                                                                // profileController.loading.value = false;
                                                                statement_loading.value = false;
                                                                Get.to(()=>PdfViewerPage(pdf));
                                                              });
                                                            }else{
                                                              noStatementDialog(context);
                                                            }
                                                            // profileController.loadPdf();
                                                          }else{
                                                            Get.to(()=>SignIn());
                                                          }
                                                        }
                                                      },
                                                      child: statement_loading.value?
                                                      Container(
                                                        height: 32,
                                                        // color: Colors.red,
                                                        child: Center(
                                                          child: Container(
                                                            width: MediaQuery.of(context).size.width*0.25,
                                                            height: 2,
                                                            child: Center(
                                                              child: LinearProgressIndicator(),
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                          :Row(
                                                        children: [
                                                          // Icon(Icons.price_change_outlined,color:MyTheme.isDarkTheme.value ? Colors.white: Colors.black,size: 22),
                                                          SvgPicture.asset("assets/icons/tax_invoice.svg",width: 22,color: MyTheme.isDarkTheme.value?Colors.white:Colors.black,),
                                                          const SizedBox(width: 7,),
                                                          Text(App_Localization.of(context).translate("tax_invoices"),
                                                            style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black,fontSize: 14,fontWeight: FontWeight.bold,decoration: TextDecoration.underline,height: 2,),),
                                                        ],
                                                      ),
                                                    ),

                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    stateCard(0,context, 'state_0'),
                                                    stateCard(1,context, 'state_1'),
                                                    stateCard(2,context, 'state_2'),
                                                    stateCard(3,context, 'state_3'),
                                                    stateCard(4,context, 'state_4'),
                                                  ],
                                                ),

                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  orderDetailsController.order!.hold == 1
                                      ?Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: Center(
                                      child: Container(
                                        width: MediaQuery.of(context).size.width,
                                        height: 135,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage("assets/image/blur_background.png"),
                                              fit: BoxFit.cover
                                          ),
                                          color: MyTheme.isDarkTheme.value?Colors.black.withAlpha(150):Colors.black.withAlpha(50),
                                          // borderRadius: BorderRadius.circular(5),
                                          // boxShadow: [
                                          //   BoxShadow(
                                          //     color: MyTheme.isDarkTheme.value ?
                                          //     Colors.transparent :
                                          //     Colors.grey.withOpacity(0.5),
                                          //     blurRadius: 3,
                                          //     offset: const Offset(1, 1),
                                          //   ),
                                          // ],
                                        ),
                                        child: Center(child: Text(App_Localization.of(context).translate("hold"),style: TextStyle( color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),)),
                                      ),
                                    ),
                                  )
                                      :Center()
                                ],
                              ),

                              const SizedBox(height: 10,),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 170,
                                decoration: BoxDecoration(
                                  color: MyTheme.isDarkTheme.value ?
                                  App.darkGrey :
                                  Colors.white,
                                  // borderRadius: BorderRadius.circular(5),
                                  // boxShadow: [
                                  //   BoxShadow(
                                  //     color: MyTheme.isDarkTheme.value ?
                                  //     Colors.transparent :
                                  //     Colors.grey.withOpacity(0.5),
                                  //     blurRadius: 3,
                                  //     offset: const Offset(1, 1),
                                  //   ),
                                  // ],
                                ),
                                child: Center(
                                  child: Container(
                                    width: MediaQuery.of(context).size.width*0.9,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [

                                        SizedBox(height: 1,),
                                        Text(App_Localization.of(context).translate("order_summery"),
                                          style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black,fontSize: 16,fontWeight: FontWeight.bold),),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(App_Localization.of(context).translate("sub_total"),
                                              style: TextStyle(color:  App.textLgColor() ,fontSize: 12),),
                                            Text(App_Localization.of(context).translate("aed")+" "+orderDetailsController.order!.price.toString(),
                                              style: TextStyle(color:  App.textLgColor() ,fontSize: 12),),
                                          ],
                                        ),

                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(App_Localization.of(context).translate("vat"),
                                              style: TextStyle(color:  App.textLgColor() ,fontSize: 12),),
                                            Text(App_Localization.of(context).translate("aed")+" "+orderDetailsController.order!.vat.toString(),
                                              style: TextStyle(color:  App.textLgColor() ,fontSize: 12),),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(App_Localization.of(context).translate("shipping"),
                                              style: TextStyle(color:  App.textLgColor() ,fontSize: 12),),
                                            orderDetailsController.order!.shippingRequestCount > 0
                                                ? orderDetailsController.order!.shippingState == 0?Text(App_Localization.of(context).translate("free"),
                                              style: TextStyle(color: App.textLgColor() ,fontSize: 12),)
                                                :Text(App_Localization.of(context).translate("aed")+" "+orderDetailsController.order!.shippingPrice.toString(),
                                              style: TextStyle(color: App.textLgColor() ,fontSize: 12),)
                                                : Text(App_Localization.of(context).translate("calculating_when_request"),
                                              style: TextStyle(color: App.textLgColor() ,fontSize: 12),),
                                          ],
                                        ),
                                        SizedBox(height: 15,),
                                        Container(
                                            height: 1,
                                            width: MediaQuery.of(context).size.width*0.9,
                                            color: App.textLgColor()
                                        ),
                                        SizedBox(height: 15,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Text(App_Localization.of(context).translate("total"),
                                                  style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black ,fontSize: 18,fontWeight: FontWeight.bold),),
                                                SizedBox(width: 7,),
                                                Text(App_Localization.of(context).translate("inclusive_vat"),
                                                  style: TextStyle(color:  App.textLgColor() ,fontSize: 10,fontWeight: FontWeight.bold),)
                                              ],
                                            ),
                                            Text( orderDetailsController.order!.shippingPrice>0&&orderDetailsController.order!.shippingState==1&&orderDetailsController.order!.shippingRequestCount>0?App_Localization.of(context).translate("aed")+" "+
                                                (orderDetailsController.order!.shippingPrice+orderDetailsController.order!.price+orderDetailsController.order!.vat).toString():
                                            App_Localization.of(context).translate("aed")+" "+(orderDetailsController.order!.price+orderDetailsController.order!.vat).toString(),
                                              style: TextStyle(color:  App.textLgColor() ,fontSize: 14),)
                                          ],
                                        ),
                                        SizedBox(height: 1,),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20,),
                              orderDetailsController.totalForPayment > 0 ?
                              GestureDetector(
                                onTap: (){
                                  orderDetailsController.initFolosiPlatformState(context);
                                  //todo pay
                                  // Get.to(()=>MyFatoraahPage("Payment", orderDetailsController.totalForPayment.toStringAsFixed(2)))!.then((value) {
                                  //   orderDetailsController.refreshIndicater();
                                  //
                                  // });
                                },
                                child:  Container(
                                  width: MediaQuery.of(context).size.width * 0.9,
                                  height: 45,
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  child:  Center(
                                    child:  Text(
                                        App_Localization.of(context).translate("pay").toUpperCase()+" "+orderDetailsController.totalForPayment.toStringAsFixed(2)+App_Localization.of(context).translate("aed"),
                                        style: const TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold)),
                                  ),
                                ),
                              )
                                  : const Center(),
                              const SizedBox(height: 30)
                            ],
                          ),
                        ),
                      )),
                    ],
                  ),

            ],
          ),
        ),
      );
    });
  }
  _header(BuildContext context){
    return Container(
      width: Get.width,
      height: 60,
      decoration: BoxDecoration(
        color: MyTheme.isDarkTheme.value?App.darkGrey:Colors.white,
        boxShadow: [
          App.myBoxShadow,
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
            child:  Icon(Icons.arrow_back_ios,color: MyTheme.isDarkTheme.value?Colors.white:Colors.black,),
          ),
          SizedBox(width: 10,),
          App.logo(context),
        ],
      ),
    );
  }

  _getAnimation(int state, int hold){
    if(hold == 1){
      return Lottie.asset("assets/animation/6.json");
    }else if (state == 0){
      return Lottie.asset("assets/animation/1.json");
    }else if (state == 1){
      return Lottie.asset("assets/animation/2.json");
    }else if (state == 2){
      return Lottie.asset("assets/animation/3.json");
    }else if (state == 3){
      return Lottie.asset("assets/animation/4.json");
    }else{
      return Lottie.asset("assets/animation/4(2).json");
    }

  }

  stateCard(int state,BuildContext context, String icon){
    return Container(
      width: MediaQuery.of(context).size.width*0.9/5 - 10,
      height: 60,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 21,
            height: 21,
            child: SvgPicture.asset('assets/icons/$icon.svg'),
          ),
          Text(orderDetailsController.order!.getStateManual(context,state),
              style: TextStyle(color: App.textLgColor(),fontSize: 8,fontWeight: FontWeight.bold,),maxLines: 2,textAlign: TextAlign.center),
          Container(
            height: 5,
            width: MediaQuery.of(context).size.width*0.9/5 - 10,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                color: orderDetailsController.order!.state >= state?Colors.green:Colors.grey
            ),
          )
        ],
      ),
    );
  }
  noStatementDialog(BuildContext context){
    // Get.back();
    return  showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(App_Localization.of(context).translate('no_statement')),
        titleTextStyle: const TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.bold
        ),
        content: Text(
          App_Localization.of(context).translate('request_last_statement'),
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}