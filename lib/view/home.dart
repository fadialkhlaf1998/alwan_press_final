import 'package:alwan_press/app_localization.dart';
import 'package:alwan_press/controller/home_controller.dart';
import 'package:alwan_press/controller/intro_controller.dart';
import 'package:alwan_press/controller/main_class_controller.dart';
import 'package:alwan_press/helper/app.dart';
import 'package:alwan_press/helper/global.dart';
import 'package:alwan_press/helper/myTheme.dart';
import 'package:alwan_press/view/all_subCategory.dart';
import 'package:alwan_press/view/contact_information.dart';
import 'package:alwan_press/view/inquery.dart';
import 'package:alwan_press/view/order_details.dart';
import 'package:alwan_press/view/products_list.dart';
import 'package:alwan_press/view/search_text_field.dart';
import 'package:alwan_press/widget/darkModeBackground.dart';
import 'package:alwan_press/widget/light_mode_background.dart';
import 'package:alwan_press/widget/logo.dart';
import 'package:alwan_press/widget/logo_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:alwan_press/widget/my_drawer.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  IntroController introController = Get.find();
  MainClassController mainClassController = Get.find();

  HomeController homeController = Get.find();

  final dataKey = GlobalKey();

  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();


  Future<void> setupInteractedMessage() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage =
    await FirebaseMessaging.instance.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message) {
    try{
      if (message.data!=null&&message.data['page'].toString() == 'order') {
        Get.to(()=>OrderDetails(int.parse(message.data['id'])));
      }
    }catch(e){

    }
  }

  @override
  void initState() {
    super.initState();

    // Run code required to handle interacted messages in an async function
    // as initState() must not be async
    setupInteractedMessage();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarColor: MyTheme.isDarkTheme.value
              ? const Color(0XFF181818)
              : Colors.white));
      return Scaffold(
        floatingActionButton: SpeedDial(
          // isOpenOnStart: true,
          openCloseDial: introController.isDialOpen,
          onClose: (){
            introController.openSpeedDail(false);
            introController.isDialOpen.value = false;
          },
          onPress: (){
            print('**************');
            introController.openSpeedDail(!introController.openSpeedDail.value);
            introController.isDialOpen.value = introController.openSpeedDail.value;
            print(introController.openSpeedDail.value);
          },
          overlayColor: App.containerColor(),
          child:AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            child: introController.openSpeedDail.value
            ?Icon(Icons.keyboard_arrow_down_outlined,color: Colors.white,)
            :Icon(Icons.keyboard_arrow_up,color: Colors.white),
          ),
          children: [
            SpeedDialChild(
              child: Icon(Icons.perm_phone_msg_outlined),
              backgroundColor: App.pink,
              foregroundColor: Colors.white,
              onTap: (){
                Get.to(()=>ContactInformation());
              }
            ),
            SpeedDialChild(
              backgroundColor: App.pink,
              foregroundColor: Colors.white,
              child: Icon(Icons.chat),
              onTap: (){
                Get.to(()=>InQuery());
              }
            )
          ],
        ),
        endDrawer: MyDrawer(_scaffoldkey),
        key: _scaffoldkey,
        body: SafeArea(
          child: Stack(
            children: [
              MyTheme.isDarkTheme.value? DarkModeBackground(): LightModeBackground(),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    _header(context),
                    const SizedBox(height: 10),
                    _body(context)
                  ],
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
      height: 215,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Global.user!=null?
              GestureDetector(
                onTap: (){
                  // mainClassController.bottomBarController.jumpToTab(3);
                  mainClassController.selectedIndex(3);
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(image: NetworkImage(Global.user!.image),fit: BoxFit.cover),
                  ),
                ),
              )
                  :GestureDetector(
                onTap: (){
                  print('*-*-*');
                },
                child: Container(
                  color: Colors.transparent,
                  child: const Icon(
                    Icons.menu,
                    size: 25,
                    color: Colors.transparent,
                  ),
                ),
              ),
              _logo(context),
              GestureDetector(
                onTap: (){
                  print('*-*-*');
                  // Get.to(()=>ContactInformation());
                  _scaffoldkey.currentState!.openEndDrawer();
                },
                child: Container(
                  color: Colors.transparent,
                  child: Icon(Icons.menu, size: 25,color: App.textColor(),),
                ),

              ),
            ],
          ),
          const SizedBox(height: 15),
          _categoryBar(context),

          const SizedBox(height: 5),
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
              height: 35,
              decoration: BoxDecoration(
                  color: MyTheme.isDarkTheme.value
                      ? App.darkGrey.withOpacity(0.9)
                      : App.lightGrey,
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.search, color: MyTheme.isDarkTheme.value
                      ? App.lightLight
                      : Colors.grey,),
                  const SizedBox(width: 10),
                  Text(App_Localization.of(context).translate("search"),
                      style: TextStyle(
                        fontSize: 14,
                        color: MyTheme.isDarkTheme.value
                            ? App.lightLight
                            : Colors.grey,
                      )),
                ],
              ),
            ),
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }

  _logo(context) {
    return Container(
      height: 45,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 800),
            curve: Curves.fastOutSlowIn,
            width: homeController.logoMove.value
                ? MediaQuery.of(context).size.width * 0.25
                : MediaQuery.of(context).size.width * 0.1,
            child: homeController.logoMove.value
                ? SizedBox(
                    height: MediaQuery.of(context).size.width * 0.1,
                    child: Lottie.asset('assets/icons/ICONS.json',
                        fit: BoxFit.cover))
                : Center(
                  child: GestureDetector(
                      onTap: () {
                        homeController.move();
                      },
                      child: Logo(MediaQuery.of(context).size.width * 0.1),
                    ),
                ),
          ),
          const SizedBox(width: 7),
          LogoText(MediaQuery.of(context).size.width * 0.25),
        ],
      ),
    );
  }

  _body(context) {
    return Expanded(
      // height: 300,
      child: SingleChildScrollView(
        child: Column(
          children: [
            _slider(context),
            const SizedBox(height: 15),
            _gridBody(context, homeController.categoryIndex.value),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  _slider(context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: MyTheme.isDarkTheme.value?Colors.transparent:Colors.white,
              border: Border.all(color: MyTheme.isDarkTheme.value?Colors.transparent:Colors.black26.withOpacity(0.1))
          ),
          child: Padding(
            padding: const EdgeInsets.all(1),
            child: Container(
                width: MediaQuery.of(context).size.width*0.9,
                height: MediaQuery.of(context).size.width*0.9 * 40 / 100,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
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
                                   borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                )),
          ),
        ),
        Positioned(
          bottom: 5,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: introController.bannerList.map((e) {
                return Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Container(
                    width: 5,
                    height: 5,
                    decoration: BoxDecoration(
                      color: homeController.sliderIndex.value ==
                              introController.bannerList.indexOf(e)
                          ? App.blue
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
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              // itemScrollController: homeController.itemScrollController,
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
                                    Global.langCode == "en"
                                        ?introController.categoriesList[index].title
                                        :introController.categoriesList[index].ar_title,
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 8,
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
                    const SizedBox(width: 10)
                  ],
                );
              },
            ),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(top: 10),
          child: Text(
              Global.langCode == "en"
                  ?introController
                  .categoriesList[homeController.categoryIndex.value].title
                  :introController
                  .categoriesList[homeController.categoryIndex.value].ar_title,

              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: App.textMediumColor())),
        ),
        SizedBox(height: 15,),
        SizedBox(
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
        ),
      ],
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
                            child: Lottie.asset('assets/icons/LogoAnimation.json'),
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
                    Global.langCode == "en"?
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
          ],
        ),
      ),
    );
  }
}
