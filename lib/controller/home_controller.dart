import 'package:alwan_press/controller/intro_controller.dart';
import 'package:alwan_press/helper/api.dart';
import 'package:alwan_press/model/product_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class HomeController extends GetxController{


  RxInt categoryIndex = 0.obs;
  ItemScrollController itemScrollController = ItemScrollController();
  RxInt productIndex = (-1).obs;
  RxList <ProductList> searchList = <ProductList>[].obs;
  RxBool logoMove = false.obs;
  RxInt sliderIndex = 0.obs;



 Future scrollToItem(index, lastIndex) async{
    itemScrollController.scrollTo(
        index: index,
      alignment: index == 0 ? 0 : index == lastIndex - 1 ? 0.5 : 0.4,
      curve: Curves.fastOutSlowIn,
      duration: const Duration(milliseconds: 1000)
    );
  }

  Future getResult(query) async {
   Api.getSearchResult(query).then((value){
     searchList.addAll(value);
   });
  }

  move(){
   logoMove.value = true;
   Future.delayed(const Duration(milliseconds: 2300)).then((value){
     logoMove.value = false;
   });
  }







}