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
                  :RefreshIndicator(
                  key: orderDetailsController.refreshIndicatorKey,
                  onRefresh: () async {
                    return await orderDetailsController.refreshIndicater();
                  },
                
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                        child: Column(
                          children: [
                            _header(context),
                            // SizedBox(height: MediaQuery.of(context).size.height*0.1,),
                            Container(
                              width: MediaQuery.of(context).size.width*0.95,
                              // height: 190,
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
                                child: Column(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width*0.9,
                                      height: 77,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(orderDetailsController.order!.title,style:  TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black,fontSize: 18,fontWeight: FontWeight.bold),),
                                          SizedBox(height: 5,),
                                          Text("#"+orderDetailsController.order!.orderId,style:  TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white.withOpacity(0.5) : Colors.black.withOpacity(0.5),fontSize: 14,fontWeight: FontWeight.bold),),
                                          Text(App_Localization.of(context).translate("pleaced_on") +" "+orderController.convertTime(orderDetailsController.order!.created_at.toString()),
                                            style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white.withOpacity(0.5) : Colors.black.withOpacity(0.5),fontSize: 14),),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 15,),
                                    Container(
                                      height: 1,
                                      width: MediaQuery.of(context).size.width*0.9,
                                      color: MyTheme.isDarkTheme.value ? Colors.white.withOpacity(0.5) : Colors.black.withOpacity(0.5)
                                    ),
                                    SizedBox(height: 15,),
                                    orderDetailsController.fake.value ?Center():Center(),
                                    orderDetailsController.order!.state != 3?Center():Container(
                                      width: MediaQuery.of(context).size.width*0.9,
                                      height: 94,
                                      child: orderDetailsController.order!.shippingAddress!=null?
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [

                                          Text(App_Localization.of(context).translate("shipping_address") ,
                                            style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black,fontSize: 18,fontWeight: FontWeight.bold),),

                                          Text(orderDetailsController.order!.shippingAddress!.customer,
                                            style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white.withOpacity(0.5) : Colors.black.withOpacity(0.5),fontSize: 14),),
                                          Text(orderDetailsController.order!.shippingAddress!.streetName+" / "+
                                              orderDetailsController.order!.shippingAddress!.building+" / flat: "+
                                              orderDetailsController.order!.shippingAddress!.flat+" / floor: "+orderDetailsController.order!.shippingAddress!.floor,
                                            style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white.withOpacity(0.5) : Colors.black.withOpacity(0.5),fontSize: 14,),),
                                          Text("Mobile: "+orderDetailsController.order!.shippingAddress!.phone,
                                            style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white.withOpacity(0.5) : Colors.black.withOpacity(0.5),fontSize: 14,),),

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
                                            style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white.withOpacity(0.5) : Colors.black.withOpacity(0.5),fontSize: 14),),
                                        ],
                                      ):

                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(App_Localization.of(context).translate("do_u_want") ,
                                                style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white.withOpacity(0.5) : Colors.black.withOpacity(0.5),fontSize: 14),),

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
                                            ],
                                          ),
                                    ),
                                    orderDetailsController.order!.state != 3?Center():SizedBox(height: 15,),
                                    orderDetailsController.order!.state != 3?Center():Container(
                                        height: 1,
                                        width: MediaQuery.of(context).size.width*0.9,
                                        color: MyTheme.isDarkTheme.value ? Colors.white.withOpacity(0.5) : Colors.black.withOpacity(0.5)
                                    ),
                                    SizedBox(height: 15,),
                                    Container(
                                      width: MediaQuery.of(context).size.width*0.9,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(orderDetailsController.order!.description,
                                            style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white.withOpacity(0.5) : Colors.black.withOpacity(0.5),fontSize: 14,),),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 15,),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 20,),
                            Container(
                              width: MediaQuery.of(context).size.width*0.95,
                              height: 135,
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
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(orderDetailsController.order!.getState(context),
                                    style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black,fontSize: 12,fontWeight: FontWeight.bold),),

                                  Container(
                                    height: 100,
                                    width: 100,
                                    child: Center(
                                      child: _getAnimation(orderDetailsController.order!.state,orderDetailsController.order!.hold),
                                    ),
                                  )

                                ],
                              ),
                            ),
                            const SizedBox(height: 20,),
                            Stack(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Center(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width*0.95,
                                      height: 135,
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
                                                        style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black,fontSize: 16,fontWeight: FontWeight.bold,decoration: TextDecoration.underline,height: 2,),),
                                                    ],
                                                  ),
                                                ),
                                                // GestureDetector(
                                                //   onTap: (){
                                                //     orderDetailsController.reorder(context);
                                                //   },
                                                //   child: Row(
                                                //     children: [
                                                //       SvgPicture.asset("assets/icons/reorder.svg",width: 16,color: MyTheme.isDarkTheme.value?Colors.white:Colors.black,),
                                                //       const SizedBox(width: 7,),
                                                //       Container(
                                                //         child: Center(
                                                //           child: Text(App_Localization.of(context).translate('reorder')),
                                                //         ),
                                                //       )
                                                //     ],
                                                //   ),
                                                // )
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
                                  width: MediaQuery.of(context).size.width*0.95,
                                  height: 135,
                                  decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage("assets/image/blur_background.png"),
                                          fit: BoxFit.cover
                                        ),
                                        color: MyTheme.isDarkTheme.value?Colors.black.withAlpha(150):Colors.black.withAlpha(50),
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
                                child: Center(child: Text(App_Localization.of(context).translate("hold"),style: TextStyle( color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),)),
                                ),
                                      ),
                                    )
                                    :Center()
                              ],
                            ),

                            const SizedBox(height: 20,),
                            Container(
                              width: MediaQuery.of(context).size.width*0.95,
                              height: 150,
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
                                  width: MediaQuery.of(context).size.width*0.9,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [

                                      SizedBox(height: 1,),
                                      Text(App_Localization.of(context).translate("order_summery"),
                                        style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black,fontSize: 18,fontWeight: FontWeight.bold),),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(App_Localization.of(context).translate("sub_total"),
                                            style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white.withOpacity(0.5) : Colors.black.withOpacity(0.5) ,fontSize: 14),),
                                          Text(App_Localization.of(context).translate("aed")+" "+orderDetailsController.order!.price.toString(),
                                            style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white.withOpacity(0.5) : Colors.black.withOpacity(0.5) ,fontSize: 14),),
                                        ],
                                      ),

                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(App_Localization.of(context).translate("vat"),
                                            style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white.withOpacity(0.5) : Colors.black.withOpacity(0.5) ,fontSize: 14),),
                                          Text(App_Localization.of(context).translate("aed")+" "+orderDetailsController.order!.vat.toString(),
                                            style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white.withOpacity(0.5) : Colors.black.withOpacity(0.5) ,fontSize: 14),),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(App_Localization.of(context).translate("shipping"),
                                            style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white.withOpacity(0.5) : Colors.black.withOpacity(0.5) ,fontSize: 14),),
                                          orderDetailsController.order!.shippingRequestCount > 0
                                              ? orderDetailsController.order!.shippingState == 0?Text(App_Localization.of(context).translate("free"),
                                                style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white.withOpacity(0.5) : Colors.black.withOpacity(0.5) ,fontSize: 14),)
                                              :Text(App_Localization.of(context).translate("aed")+" "+orderDetailsController.order!.shippingPrice.toString(),
                                            style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white.withOpacity(0.5) : Colors.black.withOpacity(0.5) ,fontSize: 14),)
                                         : Text(App_Localization.of(context).translate("calculating_when_request"),
                                            style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white.withOpacity(0.5) : Colors.black.withOpacity(0.5) ,fontSize: 14),),
                                        ],
                                      ),
                                      SizedBox(height: 15,),
                                      Container(
                                          height: 1,
                                          width: MediaQuery.of(context).size.width*0.9,
                                          color: MyTheme.isDarkTheme.value ? Colors.white.withOpacity(0.5) : Colors.black.withOpacity(0.5)
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
                                                style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white.withOpacity(0.5) : Colors.black.withOpacity(0.5) ,fontSize: 10,fontWeight: FontWeight.bold),)
                                            ],
                                          ),
                                          Text( orderDetailsController.order!.shippingPrice>0&&orderDetailsController.order!.shippingState==1&&orderDetailsController.order!.shippingRequestCount>0?App_Localization.of(context).translate("aed")+" "+
                                              (orderDetailsController.order!.shippingPrice+orderDetailsController.order!.price+orderDetailsController.order!.vat).toString():
                                          App_Localization.of(context).translate("aed")+" "+(orderDetailsController.order!.price+orderDetailsController.order!.vat).toString(),
                                            style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white.withOpacity(0.5) : Colors.black.withOpacity(0.5) ,fontSize: 14),)
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
                                //todo pay
                                Get.to(()=>MyFatoraahPage("Payment", orderDetailsController.totalForPayment.toStringAsFixed(2)))!.then((value) {
                                  orderDetailsController.refreshData();
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
                                  child:  Text(
                                      App_Localization.of(context).translate("pay").toUpperCase()+" "+orderDetailsController.totalForPayment.toStringAsFixed(2)+App_Localization.of(context).translate("aed"),
                                      style: const TextStyle(color: Colors.white,fontSize: 13)),
                                ),
                              ),
                            )
                                : const Center(),
                            const SizedBox(height: 30)
                          ],
                        ),
                    ),
                  ),

            ],
          ),
        ),
      );
    });
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
  _header(context){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.1,
      decoration: BoxDecoration(
        color: MyTheme.isDarkTheme.value ?  Colors.transparent : Colors.white,
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(onPressed: (){Get.back();}, icon: Icon(Icons.arrow_back_ios,color: MyTheme.isDarkTheme.value ?Colors.white:Colors.black,)),
            Text(App_Localization.of(context).translate("orders"),
              style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black,fontSize: 24),
            ),
            IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back_ios,color: MyTheme.isDarkTheme.value ?Colors.transparent:Colors.transparent,)),
          ],
        ),
      ),
    );
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
              style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white.withOpacity(0.5) : Colors.black.withOpacity(0.5),fontSize: 8,fontWeight: FontWeight.bold,),maxLines: 2,textAlign: TextAlign.center),
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
    Get.back();
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