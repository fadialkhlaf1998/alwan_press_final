import 'package:alwan_press/app_localization.dart';
import 'package:alwan_press/controller/home_controller.dart';
import 'package:alwan_press/controller/intro_controller.dart';
import 'package:alwan_press/controller/product_list_controller.dart';
import 'package:alwan_press/helper/app.dart';
import 'package:alwan_press/helper/global.dart';
import 'package:alwan_press/helper/myTheme.dart';
import 'package:alwan_press/view/all_subCategory.dart';
import 'package:alwan_press/view/product_details.dart';
import 'package:alwan_press/view/search_text_field.dart';
import 'package:alwan_press/widget/darkModeBackground.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class ProductList extends StatelessWidget {
  ProductList(){
    productListController.getData();
  }

  ProductListController productListController = Get.put(ProductListController());
  HomeController homeController = Get.find();
  IntroController introController = Get.find();

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
              Container(
                padding: const EdgeInsets.only(top: 20),
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _header(context),
                      const SizedBox(height: 20),
                      _gridBody(context),
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

  _header(context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Global.langCode == 'en' ?
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.15,
                  height: MediaQuery.of(context).size.width * 0.15,
                  child: Lottie.asset('assets/icons/Arrow.json'),
                ),
              )
              : Container(
                width: MediaQuery.of(context).size.width * 0.15,
                color: Colors.transparent,
                child: const Align(
                    alignment: Alignment.centerRight,
                    child: Icon(Icons.menu, size: 25)),
              ),
              _logo(context),
              Global.langCode == 'en' ?
              Container(
                width: MediaQuery.of(context).size.width * 0.15,
                color: Colors.transparent,
                child: const Align(
                    alignment: Alignment.centerRight,
                    child: Icon(Icons.menu, size: 25)),
              )
                  : GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.15,
                  height: MediaQuery.of(context).size.width * 0.15,
                  child: Lottie.asset('assets/icons/Arrow.json'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          GestureDetector(
            onTap: () {
              showSearch(
                  context: context,
                  delegate: SearchTextField(
                      suggestionList: introController.searchSuggestionList,
                      homeController: homeController));
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              width: MediaQuery.of(context).size.width,
              height: 40,
              decoration: BoxDecoration(
                  color: MyTheme.isDarkTheme.value
                      ? App.darkGrey.withOpacity(0.9)
                      : App.lightGrey,
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.search),
                  const SizedBox(width: 10),
                  Text(App_Localization.of(context).translate("search"),
                      style: TextStyle(
                        fontSize: 16,
                        color: MyTheme.isDarkTheme.value
                            ? Colors.white.withOpacity(0.2)
                            : Colors.grey,
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _logo(context) {
    return  Container(
      height: MediaQuery.of(context).size.width * 0.1,
      width: MediaQuery.of(context).size.width * 0.28,
      decoration:  BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.contain,
        image:  MyTheme.isDarkTheme.value ? AssetImage('assets/icons/logo_text.png') : AssetImage('assets/icons/logo_text_black.png')
    )));
  }

  _gridBody(context) {
    int listLength = productListController.tempProductsList.length;
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: productListController.loading.value?Container(
        height: MediaQuery.of(context).size.height*0.5,
        child: Center(
          child: CircularProgressIndicator(color: App.blue,),
        ),
      ):listLength == 0
          ? Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('No Element For This Category',style: TextStyle(color: MyTheme.isDarkTheme.value?Colors.white:Colors.black),)
        ],
      )
          :GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: MediaQuery.of(context).size.shortestSide < 600
              ? MediaQuery.of(context).size.width * 0.5
              : MediaQuery.of(context).size.width * 0.3,
          childAspectRatio: 4 / 5,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount:  listLength ,
        itemBuilder: (context, index) {
          return  _product(context, index);
        },
      ),
    );
  }
  _product(context,index){
    return GestureDetector(
      onTap: (){
        // productListController.productId.value = productListController.productsList[index].id;
        Get.to(()=>ProductDetails(productListController.tempProductsList[index]));
      },
      child: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  child: Hero(
                    transitionOnUserGestures: true,
                    tag: productListController.tempProductsList[index],
                    child: Image.network(
                        productListController.tempProductsList[index].image,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          } else {
                            return Center(
                              child: Lottie.asset('assets/icons/LogoAnimation.json'),
                            );
                          }
                        }
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  width: MediaQuery.of(context).size.width * 0.5,
                  decoration: BoxDecoration(
                      color: MyTheme.isDarkTheme.value ? App.darkGrey : App.grey,
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10))),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                        productListController.tempProductsList[index].title,
                        maxLines: 2,
                        style: TextStyle(
                            color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black,
                            fontSize: 12,
                            overflow: TextOverflow.ellipsis
                        )
                    ),
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }


  _header1(context){
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 15),
      decoration: BoxDecoration(
        color: MyTheme.isDarkTheme.value ? Colors.transparent : Colors.white,
        boxShadow: [
          MyTheme.isDarkTheme.value ?
          BoxShadow(
            color: App.darkGrey.withOpacity(0.2),
          ) :
          BoxShadow(
            color: Theme.of(context).dividerColor.withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 10,
            offset: const Offset(0, 1),
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.15,
                    height: MediaQuery.of(context).size.width * 0.15,
                    child: Lottie.asset('assets/icons/Arrow.json'),
                    // decoration: const BoxDecoration(
                    //     image: DecorationImage(
                    //         fit: BoxFit.cover,
                    //         image: AssetImage('assets/icons/logo2.png')
                    //     )
                    // ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.74,
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(25)
                  ),
                  child: TextField(
                    onChanged: (q){
                      print(q);
                      productListController.search(q);
                    },
                    style: TextStyle(
                        color: MyTheme.isDarkTheme.value ?
                        Colors.white.withOpacity(0.2) :
                        Colors.grey,
                        fontSize: 16
                    ),
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search,
                            color: MyTheme.isDarkTheme.value ?
                            Colors.white:
                            App.darkGrey),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: App_Localization.of(context).translate("search"),
                        hintStyle: TextStyle(fontSize: 16,
                            color: MyTheme.isDarkTheme.value ?
                            Colors.white.withOpacity(0.2) :
                            Colors.grey
                        )
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Text(App_Localization.of(context).translate("all_products"),
              style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,
                  color: Theme.of(context).disabledColor
              )
          ),
        ],
      ),
    );
  }
  _gridBody1(context){
    int listLength = productListController.tempProductsList.length;
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: productListController.loading.value
          ? Center(
          child: Container(
              width: 25,
              height: 25,
              child: const CircularProgressIndicator(color: Colors.white,strokeWidth: 2.5)))
          : listLength == 0
          ? Center(
            child: Text(App_Localization.of(context).translate('empty_list')),
      )
      : GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: MediaQuery.of(context).size.shortestSide < 600 ? MediaQuery.of(context).size.width * 0.5 : MediaQuery.of(context).size.width * 0.3,
          childAspectRatio: 2 / 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: listLength,
        itemBuilder: (context, index){
          return  _product(context, index);
        },
      ),
    );
  }

  _product1(context,index){
    return GestureDetector(
      onTap: (){
       // productListController.productId.value = productListController.productsList[index].id;
        Get.to(()=>ProductDetails(productListController.tempProductsList[index]));
      },
      child: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Hero(
                    transitionOnUserGestures: true,
                    tag: productListController.tempProductsList[index],
                    child: Image.network(
                        productListController.tempProductsList[index].image,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          } else {
                            return Center(
                              child: Lottie.asset('assets/icons/LogoAnimation.json'),
                            );
                          }
                        }
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 5),
            Expanded(
              flex: 1,
              child: Text(
                  productListController.tempProductsList[index].title,
                  maxLines: 2,
                  style: TextStyle(
                      color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black,
                      fontSize: 16,
                      overflow: TextOverflow.ellipsis
                  )
              ),
            )
          ],
        ),
      ),
    );
  }


}
