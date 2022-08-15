

import 'dart:io';

import 'package:alwan_press/helper/api.dart';
import 'package:alwan_press/helper/global.dart';
import 'package:alwan_press/helper/store.dart';
import 'package:alwan_press/model/start_up.dart';
import 'package:alwan_press/view/main_class.dart';
import 'package:alwan_press/view/sign_in.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class IntroController extends GetxController{

  RxList<Category> categoriesList = <Category>[].obs;
  RxList<SubCategories> tempCategoriesList = <SubCategories>[].obs;
  RxList<CustomerService> customerServiceList = <CustomerService>[].obs;
  RxList<MyBanner> bannerList = <MyBanner>[].obs;
  RxList<SuggestionSearch> searchSuggestionList = <SuggestionSearch>[].obs;
  RxInt contactIndex = 0.obs;

  RxBool showPhoneList = false.obs;
  RxBool showWhatsAppList = false.obs;

  @override
  void onInit() async{
    super.onInit();
   getData();
   //  Api.checkInternet();
    Global.getUserInformation();
    await fetchUserToken();
  }



  getData()async{
    /// todo
    /// no internet
    Api.checkInternet().then((value){
      if(value){
        print('internet-------------------');
        Api.getStartUpData().then((data){
          categoriesList.value = data.categories;
          customerServiceList.value = data.customerService;
          searchSuggestionList.value = data.suggestionSearch;
          bannerList.value = data.banners;
          Store.loadAddress();
          Global.getUserInformation().then((value) {
            if(Global.userId != -1){
              Api.login(Global.username, Global.password).then((value) {
                Get.offAll(()=>MainClass());
              });
            }else{
              Get.offAll(()=>SignIn());
            }

          });
          // Future.delayed(const Duration(milliseconds: 2000 )).then((value){
          //
          // });
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
            const CustomSnackBar.error(message: "whatsapp no installed"),
          );
        }
      }else{
        // android , web
        if( await canLaunch(whatsappURl_android)){
          await launch(whatsappURl_android);
        }else{
          showTopSnackBar(
            context,
            const CustomSnackBar.error(message: "whatsapp no installed"),
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