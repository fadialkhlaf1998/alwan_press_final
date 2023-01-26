import 'package:alwan_press/app_localization.dart';
import 'package:alwan_press/controller/all_subCategory_controller.dart';
import 'package:alwan_press/controller/home_controller.dart';
import 'package:alwan_press/controller/intro_controller.dart';
import 'package:alwan_press/helper/app.dart';
import 'package:alwan_press/helper/global.dart';
import 'package:alwan_press/helper/myTheme.dart';
import 'package:alwan_press/view/products_list.dart';
import 'package:alwan_press/view/search_text_field.dart';
import 'package:alwan_press/widget/darkModeBackground.dart';
import 'package:alwan_press/widget/my_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class AllSubCategory extends StatelessWidget {

  int categoryIndex;
  IntroController introController = Get.find();
  HomeController homeController = Get.find();
  AllSubCategoryController allSubCategoryController = Get.find();

  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

  AllSubCategory(this.categoryIndex){
    allSubCategoryController.categoryIndex.value = categoryIndex;
    introController.tempCategoriesList.clear();
    introController.tempCategoriesList.addAll(introController.categoriesList[categoryIndex].subCategories);
  }

  @override
  Widget build(BuildContext context) {

    return Obx((){
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarColor: MyTheme.isDarkTheme.value ? const Color(0XFF181818) : Colors.white
      ));
      return Scaffold(
        endDrawer: MyDrawer(_scaffoldkey),
        key: _scaffoldkey,
        body: SafeArea(
          child: Stack(
            children: [
              const DarkModeBackground(),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _header(context),
                      const SizedBox(height: 20),
                      _categoryBar(context),
                      _gridBody(context, allSubCategoryController.categoryIndex.value),
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
    return Container(
      padding: const EdgeInsets.only(top: 10),
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
                  : GestureDetector(
                onTap: (){
                  _scaffoldkey.currentState!.openEndDrawer();
                },
                child: Container(
                width: MediaQuery.of(context).size.width * 0.15,
                color: Colors.transparent,
                child: const Align(
                      alignment: Alignment.centerRight,
                      child: Icon(Icons.menu, size: 25)),
              ),
                  ),
              _logo(context),
              Global.langCode == 'en' ?
              GestureDetector(
                onTap: (){
                  _scaffoldkey.currentState!.openEndDrawer();
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.15,
                  color: Colors.transparent,
                  child: const Align(
                      alignment: Alignment.centerRight,
                      child: Icon(Icons.menu, size: 25)),
                ),
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
          const SizedBox(height: 10),
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
      decoration: BoxDecoration(
        // color: Colors.red,
          image: DecorationImage(
              fit: BoxFit.contain,
              image:  MyTheme.isDarkTheme.value ? AssetImage('assets/icons/logo_text.png') : AssetImage('assets/icons/logo_text_black.png')
          )),
    );
  }

  _categoryBar(context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 50,
            child: ScrollablePositionedList.builder(
              scrollDirection: Axis.horizontal,
              itemScrollController: allSubCategoryController.itemScrollController,
              itemCount: introController.categoriesList.length,
              itemBuilder: (BuildContext context, index) {
                return Row(
                  children: [
                    Obx(() {
                      return GestureDetector(
                        onTap: () async {
                          homeController.categoryIndex.value = index;
                          allSubCategoryController.categoryIndex.value = index;
                          if(MediaQuery.of(context).size.shortestSide < 600){
                            await allSubCategoryController.scrollToItem(index,introController.categoriesList.length);
                          }
                          allSubCategoryController.searchController.clear();
                          introController.tempCategoriesList.clear();
                          introController.tempCategoriesList.addAll(introController.categoriesList[index].subCategories);
                        },
                        child: AnimatedContainer(
                            duration: const Duration(milliseconds: 500),
                            width: MediaQuery.of(context).size.width * 0.19,
                            height: 90,
                            decoration: BoxDecoration(
                                color: homeController.categoryIndex.value ==
                                    index
                                    ? Color(int.parse(
                                    '0xFF${introController.categoriesList[index].color.toString().substring(1)}'))
                                    : MyTheme.isDarkTheme.value
                                    ? App.darkGrey
                                    : App.lightGrey,
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Container(
                                margin:
                                const EdgeInsets.symmetric(horizontal: 1),
                                child: Text(
                                  Global.langCode == "en"
                                      ?
                                  introController.categoriesList[index].title
                                  :introController.categoriesList[index].ar_title,
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 9,
                                    fontWeight:
                                    homeController.categoryIndex.value ==
                                        index
                                        ? FontWeight.bold
                                        : null,
                                    color:
                                    homeController.categoryIndex.value ==
                                        index
                                        ? Colors.white
                                        : MyTheme.isDarkTheme.value
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            )),
                      );
                    }),
                    const SizedBox(width: 7)
                  ],
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 15,bottom: 15),
            child: Text(
                Global.langCode == "en"
                    ?
                introController
                    .categoriesList[homeController.categoryIndex.value].title
                :introController
                    .categoriesList[homeController.categoryIndex.value].ar_title,
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).disabledColor)),
          ),
        ],
      ),
    );
  }

  _gridBody(context, categoryIndex) {
    int listLength = introController.tempCategoriesList.length;
    return Container(
      padding: EdgeInsets.only(bottom: 20),
      width: MediaQuery.of(context).size.width * 0.9,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: MediaQuery.of(context).size.shortestSide < 600
              ? MediaQuery.of(context).size.width * 0.5
              : MediaQuery.of(context).size.width * 0.3,
          childAspectRatio: 4 / 6,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: listLength,
        itemBuilder: (context, index) {
          return _subCategory(context, index, categoryIndex);
        },
      ),
    );
  }

  _subCategory(context, index, categoryIndex) {
    return GestureDetector(
      onTap: () {
        homeController.productIndex.value = introController
            .categoriesList[categoryIndex].subCategories[index].id;
        Get.to(() => ProductList());
      },
      child: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                flex: 4,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Hero(
                      transitionOnUserGestures: true,
                      tag: introController
                          .categoriesList[categoryIndex].subCategories[index],
                      child: Image.network(
                          introController.categoriesList[categoryIndex]
                              .subCategories[index].image,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            } else {
                              return Center(
                                child:
                                Lottie.asset('assets/icons/LogoAnimation.json'),
                                // child: CircularProgressIndicator(),
                              );
                            }
                          }),
                    ),
                  ),
                )),
            Expanded(
              flex: 1,
              child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  width: MediaQuery.of(context).size.width * 0.5,
                  decoration: BoxDecoration(
                      // color: MyTheme.isDarkTheme.value ? App.darkGrey : App.lightGrey,
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10))),
                  child: Align(
                    alignment: Global.langCode == "en"?Alignment.centerLeft:Alignment.centerRight,
                    child: Text(
                        Global.langCode == "en"
                            ?
                        introController.categoriesList[categoryIndex].subCategories[index].title
                        :introController.categoriesList[categoryIndex].subCategories[index].ar_title,
                        maxLines: 2,
                        style: TextStyle(
                            color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black,
                            fontSize: 13,
                            overflow: TextOverflow.ellipsis
                        )
                    ),
                  )
              ),
            ),
            // Expanded(
            //   flex: 1,
            //   child: Text(
            //     introController.categoriesList[categoryIndex].subCategories[index].title,
            //     maxLines: 2,
            //       style: TextStyle(
            //       color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black,
            //       fontSize: 12,
            //       overflow: TextOverflow.ellipsis
            //     )
            //   ),
            // )
          ],
        ),
      ),
    );
  }


  _header1(context){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 190,//MediaQuery.of(context).size.height * 0.25,
      padding: const EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 10),
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
        children: [
          SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    homeController.categoryIndex.value = allSubCategoryController.categoryIndex.value;
                    Get.back();
                  },
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.15,
                    height: MediaQuery.of(context).size.width * 0.15,
                    child: Lottie.asset('assets/icons/Arrow.json'),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.74,
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(25)
                  ),
                  child: TextField(
                    controller: allSubCategoryController.searchController,
                    onChanged: (query){
                      introController.search(query, allSubCategoryController.categoryIndex.value);
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
          _categoryBar(context),
        ],
      ),
    );
  }

  _categoryBar1(context){
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      //height: 90,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(App_Localization.of(context).translate("category"),
              style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold, color: Theme.of(context).disabledColor)),
          Container(
            height: 40,
            child: ScrollablePositionedList.builder(
              scrollDirection: Axis.horizontal,
              itemScrollController: allSubCategoryController.itemScrollController,
              itemCount: introController.categoriesList.length,
              itemBuilder: (BuildContext context, index){
                return Row(
                  children: [
                    Obx((){
                      return  GestureDetector(
                          onTap: () async {
                            allSubCategoryController.categoryIndex.value = index;
                            if(MediaQuery.of(context).size.shortestSide < 600){
                              await allSubCategoryController.scrollToItem(index,introController.categoriesList.length);
                            }
                            allSubCategoryController.searchController.clear();
                            introController.tempCategoriesList.clear();
                            introController.tempCategoriesList.addAll(introController.categoriesList[index].subCategories);
                          },
                        child: Container(
                            color: Colors.transparent,
                            child: Center(
                              child: Text(
                                Global.langCode == "en"
                                    ?
                                introController.categoriesList[index].title
                                :introController.categoriesList[index].ar_title,
                                style: allSubCategoryController.categoryIndex.value == index
                                    ? Theme.of(context).textTheme.headline2
                                    : TextStyle(
                                  fontSize: 16,
                                  fontWeight:  allSubCategoryController.categoryIndex.value == index ? FontWeight.bold : null,
                                  color:  allSubCategoryController.categoryIndex.value == index ? Colors.black : App.grey,
                                ),
                              ),
                            )
                        ),
                      );
                    }),
                    const SizedBox(width: 20)
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
  _gridBody1(context,categoryIndex){
    int listLength = introController.tempCategoriesList.length; //[categoryIndex].subCategories.length;
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
        itemCount: listLength,
        itemBuilder: (context, index){
          return  _subCategory(context, index, categoryIndex);
        },
      ),
    );
  }
  _subCategory1(context,index ,categoryIndex){
    return GestureDetector(
      onTap: (){
       // Get.to(()=>ProductDetails(introController.categoriesList[categoryIndex].subCategories[index]));
        homeController.productIndex.value = introController.tempCategoriesList[index].id; //.subCategories[index].id;
        Get.to(()=>ProductList());
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
                    tag: introController.tempCategoriesList[index],//.subCategories[index],
                    child: Image.network(
                        introController.tempCategoriesList[index].image ,//introController.categoriesList[categoryIndex].subCategories[index].image,
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
                  Global.langCode == "en"
                      ?
                  introController.tempCategoriesList[index].title
                  :introController.tempCategoriesList[index].ar_title,
                  //introController.categoriesList[categoryIndex].subCategories[index].title,
                  maxLines: 2,
                  style: TextStyle(
                      color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black,
                      fontSize: 13,
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
