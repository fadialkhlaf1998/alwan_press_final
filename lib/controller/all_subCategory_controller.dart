
import 'package:alwan_press/model/start_up.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class AllSubCategoryController extends GetxController{

  ItemScrollController itemScrollController = ItemScrollController();
  RxInt categoryIndex = 0.obs;
  TextEditingController searchController = TextEditingController();

  Future scrollToItem(index, lastIndex) async{
    itemScrollController.scrollTo(
        index: index,
        alignment: index == 0 ? 0 : index == lastIndex - 1 ? 0.5 : 0.4,
        curve: Curves.fastOutSlowIn,
        duration: const Duration(milliseconds: 1000)
    );
  }



}