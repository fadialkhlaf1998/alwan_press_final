import 'package:alwan_press/app_localization.dart';
import 'package:alwan_press/controller/home_controller.dart';
import 'package:alwan_press/controller/intro_controller.dart';
import 'package:alwan_press/controller/settings_controller.dart';
import 'package:alwan_press/helper/app.dart';
import 'package:alwan_press/helper/global.dart';
import 'package:alwan_press/helper/myTheme.dart';
import 'package:alwan_press/view/all_subCategory.dart';
import 'package:alwan_press/view/products_list.dart';
import 'package:alwan_press/view/search_text_field.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:lottie/lottie.dart';



class Home extends StatelessWidget {

  IntroController introController = Get.find();
  HomeController homeController = Get.put(HomeController());
  final dataKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Obx((){
      return Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              MyTheme.isDarkTheme.value ? Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/image/background.png')
                      )
                  )
              ) : const Text(''),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      _header(context),
                      const SizedBox(height: 20),
                      _body(context)
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
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          homeController.logoMove.value ?
          SizedBox(
              height: MediaQuery.of(context).size.width * 0.17,
              child: Lottie.asset('assets/icons/ICONS.json',fit: BoxFit.cover)
          )
          : GestureDetector(
            onTap: (){
              homeController.move();
            },
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.17,
              height: MediaQuery.of(context).size.width * 0.17,
              child: Image.asset('assets/icons/Logo-Header.png',fit: BoxFit.cover,)
              ),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: (){
              showSearch(
                  context: context,
                  delegate: SearchTextField(
                      suggestionList: introController.searchSuggestionList,
                      homeController: homeController)
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              width: MediaQuery.of(context).size.width,
              height: 45,//MediaQuery.of(context).size.height * 0.06,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(25)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.search),
                  const SizedBox(width: 10),
                  Text(
                      App_Localization.of(context).translate("search"),
                    style: TextStyle(fontSize: 16,
                              color: MyTheme.isDarkTheme.value ?
                              Colors.white.withOpacity(0.2) :
                              Colors.grey,
                          )
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  _body(context){
    return  Column(
        children: [
          _slider(context),
          _categoryBar(context),
          _gridBody(context,homeController.categoryIndex.value),
          const SizedBox(height: 20),
        ],
    );
  }
  _slider(context){
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width * 0.45,
          color: App.grey,
          child: CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              viewportFraction: 1,
              autoPlayAnimationDuration: Duration(milliseconds: 1000),
              autoPlayCurve: Curves.fastOutSlowIn,
              onPageChanged: (index, _){
                homeController.sliderIndex.value = index;
              }
            ),
            items: introController.bannerList.map((e) => Container(
              width:MediaQuery.of(context).size.width,
              child: CachedNetworkImage(
                imageUrl: e.image,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            )).toList(),
          )
          // ImageSlideshow(
          //   width: double.infinity,
          //   height: MediaQuery.of(context).size.height*0.2,
          //   initialPage: 0,
          //   indicatorColor: Theme.of(context).primaryColor,
          //   indicatorBackgroundColor: App.grey,
          //   children:
          //   introController.bannerList.map((e) => Container(
          //     decoration: BoxDecoration(
          //         //borderRadius: BorderRadius.circular(10),
          //         image: DecorationImage(
          //             image: NetworkImage(e.image),
          //             fit: BoxFit.cover
          //         )
          //     ),
          //   )).toList(),
          //   autoPlayInterval: 5000,
          //   isLoop: true,
          // ),
        ),
        Positioned(
          bottom: 10,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: introController.bannerList.map((e) {
                return  Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: homeController.sliderIndex.value == introController.bannerList.indexOf(e)
                          ? App.pink
                          : Colors.grey,
                      shape: BoxShape.circle,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
  _categoryBar(context){
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: MediaQuery.of(context).size.width * 0.9,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(App_Localization.of(context).translate("category"),
              style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,
              color: Theme.of(context).disabledColor
              )
          ),
          SizedBox(
            height: 45,
            child: ScrollablePositionedList.builder(
              scrollDirection: Axis.horizontal,
              itemScrollController: homeController.itemScrollController,
              itemCount: introController.categoriesList.length,
              itemBuilder: (BuildContext context, index){
                return Row(
                  children: [
                   Obx((){
                     return  GestureDetector(
                       onTap: () async {
                         // if(settingsController)
                         if(Global.langCode == 'en'){
                           homeController.categoryIndex.value = index;
                           if(MediaQuery.of(context).size.shortestSide < 600){
                             await homeController.scrollToItem(index,introController.categoriesList.length);
                           }
                         }else{
                           homeController.categoryIndex.value = index;
                         }
                       },
                       child: Container(
                           color: Colors.transparent,
                           child: Center(
                             child: Text(
                               introController.categoriesList[index].title,
                               style: homeController.categoryIndex.value == index
                                 ? Theme.of(context).textTheme.headline2
                                   : TextStyle(
                                 fontSize: 16,
                                 fontWeight:  homeController.categoryIndex.value == index ? FontWeight.bold : null,
                                 color:  homeController.categoryIndex.value == index ? Colors.black : App.grey,
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
  _gridBody(context, categoryIndex){
    int listLength = 0;
    if(introController.categoriesList.isNotEmpty){
      listLength = introController.categoriesList[categoryIndex].subCategories.length;
    }
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: MediaQuery.of(context).size.shortestSide < 600 ? MediaQuery.of(context).size.width * 0.5 : MediaQuery.of(context).size.width * 0.3,
             childAspectRatio: 2 / 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
        ),
        itemCount: listLength < 5 ? listLength : 6,
        itemBuilder: (context, index){
          return listLength == 0
              ? Container(
            /// TODO
                 child: Text('empty'),
              )
              : index == 5
              ?
         Bounce(
             child: Container(
                 width: 100,height: 100,color: Colors.transparent,
                 child: Center(
                     child: Text(
                         App_Localization.of(context).translate("see_more"),
                         style: Theme.of(context).textTheme.headline1
                     )
                 )
             ),
             duration: const Duration(milliseconds: 150),
             onPressed: (){
               Get.to(()=>AllSubCategory(homeController.categoryIndex.value));
             })
              : _subCategory(context, index, categoryIndex);
        },
      ),
    );
  }
  _subCategory(context,index ,categoryIndex){
    return GestureDetector(
      onTap: (){
         //Get.to(()=>ProductDetails(introController.categoriesList[categoryIndex].subCategories[index]));
        homeController.productIndex.value = introController.categoriesList[categoryIndex].subCategories[index].id;
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
                    tag: introController.categoriesList[categoryIndex].subCategories[index],
                    child: Image.network(
                        introController.categoriesList[categoryIndex].subCategories[index].image,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          } else {
                            return Center(
                              child: Lottie.asset('assets/icons/LogoAnimation.json'),
                              // child: CircularProgressIndicator(),
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
                introController.categoriesList[categoryIndex].subCategories[index].title,
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