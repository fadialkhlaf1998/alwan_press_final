import 'dart:async';
import 'dart:io';

import 'package:alwan_press/helper/api.dart';
import 'package:alwan_press/helper/global.dart';
import 'package:alwan_press/model/order.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';


class OrderController extends GetxController{

  RxList <Order> myOrders = <Order>[].obs;
  RxList <Order> tempOrders = <Order>[].obs;
  RxList <Order> hold = <Order>[].obs;
  RxList <Order> ready = <Order>[].obs;
  RxList <Order> inProgress = <Order>[].obs;
  RxList <Order> delivered = <Order>[].obs;
  RxList <Order> waitingAdvance = <Order>[].obs;
  RxList <Order> waitingFinal = <Order>[].obs;
  RxList <Order> filteredData = <Order>[].obs;
  RxBool loading = false.obs;
  RxBool fake = false.obs;
  RxString dropdownvalue = "".obs;
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  TextEditingController search = TextEditingController();


  @override
  void onInit() {
    super.onInit();
    getOrderData();
  }

  searchForData(){
    if(search.text.isEmpty){
      loading(true);
      filteredData.value.addAll(myOrders);
      loading(false);
    }else{
      loading(true);
      filteredData.clear();
      for(int i=0;i<myOrders.length;i++){
        if(myOrders[i].title.toLowerCase().contains(search.text.toLowerCase())||myOrders[i].quickBookId.toLowerCase().contains(search.text.toLowerCase())){
          filteredData.add(myOrders[i]);
        }
      }
      loading(false);
    }
  }

  filterOrders(List<Order>  orders){
    hold.clear();
    ready.clear();
    inProgress.clear();
    waitingAdvance.clear();
    waitingFinal.clear();
    delivered.clear();
    for(var elm in orders){
      if(elm.hold == 1){
        hold.add(elm);
      }else if(elm.state == 0){
        waitingAdvance.add(elm);
      }else if(elm.state == 1){
        inProgress.add(elm);
      }else if(elm.state == 2){
        waitingFinal.add(elm);
      }else if(elm.state == 3){
        ready.add(elm);
      }else {
        delivered.add(elm);
      }
      filteredData.add(elm);
      // orders.remove(elm);
    }
  }

  Future<File> loadPdf(String url) async {
    Completer<File> completer = Completer();
    // final url = Global.user!.financialState;
    final filename = url.substring(url.lastIndexOf("/") + 1);
    var request = await HttpClient().getUrl(Uri.parse(url));
    var response = await request.close();
    var bytes = await consolidateHttpClientResponseBytes(response);
    var dir = await getApplicationDocumentsDirectory();
    File file = File("${dir.path}/$filename");
    await file.writeAsBytes(bytes, flush: true);
    completer.complete(file);
    return completer.future;

  }

  getOrderData() async {
    loading.value = true;
    Api.checkInternet().then((internet){
      if(internet){
        Api.getCustomerOrder(Global.userId.toString()).then((value){
          if(value.isNotEmpty){
            print('done orders');
            myOrders.value = value;
            List<Order> temp = value;
            filterOrders(temp);
            loading.value = false;
          }else{
            print('no orders');
            loading.value = false;
          }
        });
      }else{
        print('no internet');
        loading.value = false;
      }
    });
  }
  Future<void> getOrderDataIndicater() async {
    loading.value = true;
    var internet = await Api.checkInternet();
    if(internet){
     var value = await Api.getCustomerOrder(Global.userId.toString());
        if(value.isNotEmpty){
          print('done orders');
          myOrders.value = value;
          tempOrders.value = value;
          filterOrders(tempOrders);
          loading.value = false;
        }else{
          print('no orders');
          loading.value = false;
        }
      return ;
    }else{
      print('no internet');
      loading.value = false;
      return ;
    }
  }
  calculateTime(index){
    DateTime now = DateTime.now();
    int month = myOrders[index].deadline.month - now.month;
    int day = myOrders[index].deadline.day - now.day;
    int hour =  24 - now.hour;
    // int month = myOrders[index].deadline.difference(now).inDays;
    // int day = myOrders[index].deadline.difference(now).inDays;
    // int hour = myOrders[index].deadline.difference(now).inHours;

    if(myOrders[index].deadline.isAfter(now)){
      myOrders[index].ready.value = true;
      print(myOrders[index].ready.value);
    }
    var dateList = [];
    dateList.add(month);
    dateList.add(day);
    dateList.add(hour);

    return dateList;
  }

  convertTime(String time){
    var timeArray = time.split('T');
    var dateTime = DateFormat('yyyy-MM-dd').parse(timeArray.first);
    print(DateFormat('MMM dd yyyy').format(dateTime));
    return DateFormat('dd MMM yyyy').format(dateTime);
  }

  // setOrderState(index){
  //   switch(myOrders[index].state){
  //     case 1:
  //       myOrders[index].orderState = 'In progress';
  //       break;
  //     case 2:
  //       myOrders[index].orderState = 'Waiting for final payment';
  //       break;
  //     case 3:
  //       myOrders[index].orderState = 'Ready';
  //       break;
  //     case 4:
  //       myOrders[index].orderState = 'Deliver';
  //       break;
  //   }
  // }

}