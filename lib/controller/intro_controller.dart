

import 'dart:io';

import 'package:alwan_press/app_localization.dart';
import 'package:alwan_press/controller/ProfileController.dart';
import 'package:alwan_press/controller/all_subCategory_controller.dart';
import 'package:alwan_press/controller/home_controller.dart';
import 'package:alwan_press/controller/order_controller.dart';
import 'package:alwan_press/controller/wishlist_controller.dart';
import 'package:alwan_press/helper/api.dart';
import 'package:alwan_press/helper/global.dart';
import 'package:alwan_press/helper/store.dart';
import 'package:alwan_press/model/product_list.dart';
import 'package:alwan_press/model/start_up.dart';
import 'package:alwan_press/view/main_class.dart';
import 'package:alwan_press/view/sign_in.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class IntroController extends GetxController{
  RxBool logoMove = false.obs;
  RxBool openSpeedDail = false.obs;
  ValueNotifier<bool> isDialOpen = ValueNotifier(false);
  RxList<Category> categoriesList = <Category>[].obs;
  RxList<SubCategories> tempCategoriesList = <SubCategories>[].obs;
  RxList<CustomerService> customerServiceList = <CustomerService>[].obs;
  RxList<MyBanner> bannerList = <MyBanner>[].obs;
  RxList<SuggestionSearch> searchSuggestionList = <SuggestionSearch>[].obs;
  RxInt contactIndex = 0.obs;
  HomeController homeController = Get.put(HomeController());
  WishlistController wishlistController = Get.put(WishlistController());

  RxBool showPhoneList = false.obs;
  RxBool showWhatsAppList = false.obs;

  OrderController orderController = Get.put(OrderController());
  AllSubCategoryController allSubCategoryController = Get.put(AllSubCategoryController());
  @override
  void onInit() async{
    super.onInit();
   getData();
   //  Api.checkInternet();
    Global.getUserInformation();
    await fetchUserToken();
  }

  move(){
    logoMove.value = true;
    Future.delayed(const Duration(milliseconds: 2300)).then((value){
      logoMove.value = false;
    });
  }

  getData()async{
    /// todo
    /// no internet
    // Store.saveWishlist(<ProductList>[]);
    wishlistController.wishlist = await Store.loadWishlist();
    Api.checkInternet().then((value){
      if(value){
        print('internet-------------------');
        Api.getStartUpData().then((data){
          categoriesList.value = data.categories;
          customerServiceList.value = data.customerService;
          searchSuggestionList.value = data.suggestionSearch;
          bannerList.value = data.banners;
         if(categoriesList.isNotEmpty){
           allSubCategoryController.categoryIndex.value = 0;
           tempCategoriesList.clear();
           tempCategoriesList.addAll(categoriesList[0].subCategories);
         }
          print('****************');
          Store.loadAddress();
          Global.getUserInformation().then((value) {
            Future.delayed(const Duration(milliseconds: 750 )).then((value){
              if(Global.userId != -1){

                Api.login(Global.username, Global.password).then((value) {
                  ProfileController profileController = Get.put(ProfileController());
                  Get.offAll(()=>MainClass());
                });
              }else{
                ProfileController profileController = Get.put(ProfileController());
                Get.offAll(()=>SignIn());
              }
            });


          });

        });
      }else{
        //todo no internet
        print('No internet +++++++++++++');
      }
    });
  }

  search(String query,index){
    List<SubCategories> dummySearchList = <SubCategories>[];
    dummySearchList.addAll(categoriesList[index].subCategories);
    if(query.isNotEmpty) {
      List<SubCategories> dummyListData = <SubCategories>[];
      for (var product in dummySearchList) {
        if(product.title.toLowerCase().contains(query)) {
          dummyListData.add(product);
        }
      }
      tempCategoriesList.clear();
      tempCategoriesList.addAll(dummyListData);
      print('----------------');
      print(tempCategoriesList.length);
      return;
    } else {
      tempCategoriesList.clear();
      tempCategoriesList.addAll(categoriesList[index].subCategories);
      print('----------------+');
      print(tempCategoriesList.length);
    }
  }

  fetchUserToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    Global.setUserToken(token ?? "");
  }

  openWhatApp(context,String msg,String phone) async{
    try {
      var whatsapp = phone;
      var whatsappURl_android = "whatsapp://send?phone="+whatsapp+"&text=$msg";
      var whatappURL_ios ="https://wa.me/$whatsapp?text=${Uri.parse(msg)}";
      if(Platform.isIOS){
        // for iOS phone only
        if( await canLaunch(whatappURL_ios)){
          await launch(whatappURL_ios, forceSafariVC: false);
        }else{
          showTopSnackBar(
            context,
            CustomSnackBar.error(message: App_Localization.of(context).translate("whatsapp_no_installed")),
          );
        }
      }else{
        // android , web
        if( await canLaunch(whatsappURl_android)){
          await launch(whatsappURl_android);
        }else{
          showTopSnackBar(
            context,
            CustomSnackBar.error(message: App_Localization.of(context).translate("whatsapp_no_installed")),
          );
        }
      }
    } catch(e) {
      print(e.toString());
    }
  }
  openPhone(String phone) async{
    if(Platform.isAndroid){
      final Uri launchUri = Uri(
        scheme: 'tel',
        path: phone,
      );
      // print(introController.customerServiceList[index].phone);
      await launch(launchUri.toString());
    }else if (Platform.isIOS){
      launch("tel://$phone");
      // print(introController.customerServiceList[index].phone);
    }
  }




}