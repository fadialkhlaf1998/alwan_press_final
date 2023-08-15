import 'package:alwan_press/app_localization.dart';
import 'package:alwan_press/controller/product_list_controller.dart';
import 'package:alwan_press/controller/search_page_controller.dart';
import 'package:alwan_press/helper/app.dart';
import 'package:alwan_press/helper/global.dart';
import 'package:alwan_press/helper/myTheme.dart';
import 'package:alwan_press/view/product_details.dart';
import 'package:alwan_press/widget/darkModeBackground.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SearchPage extends StatelessWidget {

  String searchQuery;
  SearchPageController searchPageController = Get.put(SearchPageController());

  SearchPage(this.searchQuery){
    searchPageController.getData(searchQuery);
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
               DarkModeBackground(),
              SizedBox(
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

  _header(context){
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 10),
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
      child: SizedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.15,
                height: MediaQuery.of(context).size.width * 0.15,
                child:  Lottie.asset('assets/icons/Arrow.json'),
              ),
            ),
            Text(App_Localization.of(context).translate("search_result"),
                style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,
                    color: Theme.of(context).disabledColor
                )
            ),
          ],
        ),
      ),
    );
  }
  _gridBody(context){
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: MediaQuery.of(context).size.shortestSide < 600 ? MediaQuery.of(context).size.width * 0.5 : MediaQuery.of(context).size.width * 0.3,
          childAspectRatio: 2 / 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: searchPageController.searchResultList.length,
        itemBuilder: (context, index){
          return  _product(context, index);
        },
      ),
    );
  }

  _product(context,index){
    return GestureDetector(
      onTap: (){
        Get.to(()=>ProductDetails(searchPageController.searchResultList[index]));
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
                    tag: searchPageController.searchResultList[index],
                    child: Image.network(
                        searchPageController.searchResultList[index].image,
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
            const SizedBox(height: 5),
            Expanded(
              flex: 1,
              child: Text(
                  Global.langCode == "en"?
                  searchPageController.searchResultList[index].title:searchPageController.searchResultList[index].ar_title,
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
