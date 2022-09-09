import 'package:alwan_press/app_localization.dart';
import 'package:alwan_press/controller/home_controller.dart';
import 'package:alwan_press/controller/intro_controller.dart';
import 'package:alwan_press/helper/app.dart';
import 'package:alwan_press/helper/global.dart';
import 'package:alwan_press/helper/myTheme.dart';
import 'package:alwan_press/view/all_subCategory.dart';
import 'package:alwan_press/view/products_list.dart';
import 'package:alwan_press/view/search_text_field.dart';
import 'package:alwan_press/widget/darkModeBackground.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  IntroController introController = Get.find();
  HomeController homeController = Get.put(HomeController());
  final dataKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarColor: MyTheme.isDarkTheme.value
              ? const Color(0XFF181818)
              : Colors.white));
      return Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              const DarkModeBackground(),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      _header(context),
                      const SizedBox(height: 10),
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
              Container(
                color: Colors.transparent,
                child: const Icon(
                  Icons.menu,
                  size: 25,
                  color: Colors.transparent,
                ),
              ),
              _logo(context),
              Container(
                color: Colors.transparent,
                child: const Icon(Icons.menu, size: 25),
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          curve: Curves.fastOutSlowIn,
          width: homeController.logoMove.value
              ? MediaQuery.of(context).size.width * 0.3
              : MediaQuery.of(context).size.width * 0.12,
          child: homeController.logoMove.value
              ? SizedBox(
                  height: MediaQuery.of(context).size.width * 0.12,
                  child: Lottie.asset('assets/icons/ICONS.json',
                      fit: BoxFit.cover))
              : GestureDetector(
                  onTap: () {
                    homeController.move();
                  },
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.12,
                      height: MediaQuery.of(context).size.width * 0.12,
                      child: Image.asset(
                        'assets/icons/Logo-Header.png',
                        fit: BoxFit.cover,
                      )),
                ),
        ),
        const SizedBox(width: 7),
        Container(
          height: MediaQuery.of(context).size.width * 0.1,
          width: MediaQuery.of(context).size.width * 0.28,
          decoration: const BoxDecoration(
              // color: Colors.red,
              image: DecorationImage(
                  fit: BoxFit.contain,
                  image: AssetImage('assets/icons/logo_text.png'))),
        )
      ],
    );
  }

  _body(context) {
    return Column(
      children: [
        _slider(context),
        _categoryBar(context),
        _gridBody(context, homeController.categoryIndex.value),
        const SizedBox(height: 20),
      ],
    );
  }

  _slider(context) {
    return Stack(
      children: [
        Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.2,
            color: Colors.transparent,
            child: CarouselSlider(
              options: CarouselOptions(
                  autoPlay: true,
                  viewportFraction: 1,
                  autoPlayAnimationDuration: const Duration(milliseconds: 1000),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  onPageChanged: (index, _) {
                    homeController.sliderIndex.value = index;
                  }),
              items: introController.bannerList
                  .map((e) => SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: CachedNetworkImage(
                          imageUrl: e.image,
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              //  borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ))
                  .toList(),
            )),
        Positioned(
          bottom: 10,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: introController.bannerList.map((e) {
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: homeController.sliderIndex.value ==
                              introController.bannerList.indexOf(e)
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

  _categoryBar(context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      width: MediaQuery.of(context).size.width * 0.9,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 100,
            child: ScrollablePositionedList.builder(
              scrollDirection: Axis.horizontal,
              itemScrollController: homeController.itemScrollController,
              itemCount: introController.categoriesList.length,
              itemBuilder: (BuildContext context, index) {
                return Row(
                  children: [
                    Obx(() {
                      return GestureDetector(
                        onTap: () async {
                          if (Global.langCode == 'en') {
                            homeController.categoryIndex.value = index;
                            if (MediaQuery.of(context).size.shortestSide <
                                600) {
                              await homeController.scrollToItem(
                                  index, introController.categoriesList.length);
                            }
                          } else {
                            homeController.categoryIndex.value = index;
                          }
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
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: AnimatedSwitcher(
                                      duration:
                                          const Duration(milliseconds: 400),
                                      child: homeController
                                                  .categoryIndex.value ==
                                              index
                                          ? SvgPicture.network(
                                              introController
                                                  .categoriesList[index].image,
                                              key: const ValueKey('1'),
                                              fit: BoxFit.contain,
                                              color: Colors.white,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.12,
                                              height: 40,
                                            )
                                          : SvgPicture.network(
                                              introController
                                                  .categoriesList[index].image,
                                              key: const ValueKey('2'),
                                              fit: BoxFit.contain,
                                              color: MyTheme.isDarkTheme.value
                                                  ? Colors.white
                                                  : Colors.black,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.12,
                                              height: 40,
                                            ),
                                    )),
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 1),
                                  child: Text(
                                    introController.categoriesList[index].title,
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
                              ],
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
            padding: const EdgeInsets.only(top: 10),
            child: Text(
                introController
                    .categoriesList[homeController.categoryIndex.value].title,
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
    int listLength = 0;
    if (introController.categoriesList.isNotEmpty) {
      listLength =
          introController.categoriesList[categoryIndex].subCategories.length;
    }
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: MediaQuery.of(context).size.shortestSide < 600
              ? MediaQuery.of(context).size.width * 0.5
              : MediaQuery.of(context).size.width * 0.3,
          childAspectRatio: 3 / 4,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: listLength < 5 ? listLength : 6,
        itemBuilder: (context, index) {
          return listLength == 0
              ? const Text('empty')
              : index == 5
                  ? Bounce(
                      child: Container(
                          width: 100,
                          height: 100,
                          color: Colors.transparent,
                          child: Center(
                              child: Text(
                                  App_Localization.of(context)
                                      .translate("see_more"),
                                  style:
                                      Theme.of(context).textTheme.headline1))),
                      duration: const Duration(milliseconds: 150),
                      onPressed: () {
                        Get.to(() =>
                            AllSubCategory(homeController.categoryIndex.value));
                      })
                  : _subCategory(context, index, categoryIndex);
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
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
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
                width: MediaQuery.of(context).size.width * 0.5,
                decoration: BoxDecoration(
                    color: MyTheme.isDarkTheme.value ? App.darkGrey : App.grey,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10))),
                child: Text(
                      introController.categoriesList[categoryIndex].subCategories[index].title,
                      maxLines: 2,
                        style: TextStyle(
                        color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black,
                        fontSize: 14,
                        overflow: TextOverflow.ellipsis
                      )
                    ),
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
}
