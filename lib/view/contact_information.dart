import 'package:alwan_press/app_localization.dart';
import 'package:alwan_press/controller/intro_controller.dart';
import 'package:alwan_press/controller/sign_in_controller.dart';
import 'package:alwan_press/helper/app.dart';
import 'package:alwan_press/helper/global.dart';
import 'package:alwan_press/helper/myTheme.dart';
import 'package:alwan_press/view/search_text_field.dart';
import 'package:alwan_press/widget/darkModeBackground.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';



class ContactInformation extends StatelessWidget {

  IntroController introController = Get.find();
  // SignInController signInController = Get.find();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: MyTheme.isDarkTheme.value ? const Color(0XFF181818) : Colors.white
    ));
    introController.contactIndex.value = 0;
    return WillPopScope(
      onWillPop: () async {
        introController.showPhoneList.value = false;
        introController.showWhatsAppList.value = false;
        return true;
      },
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: [
            const DarkModeBackground(),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _header(context),
                  const SizedBox(height: 50),
                  Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Text(
                          App_Localization.of(context).translate('choose_your_language_and_contact_us'),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16,
                              color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        width: MediaQuery.of(context).size.width  * 0.9,
                        height: MediaQuery.of(context).size.height * 0.6,
                        child:  ListView.builder(
                            itemCount: introController.customerServiceList.length,
                            itemBuilder: (BuildContext context, index){
                              return Container(
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                width: MediaQuery.of(context).size.width * 0.9,
                                height: 70,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.symmetric(horizontal: 10),
                                              width: 50,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                    image: NetworkImage(introController.customerServiceList[index].image)
                                                ),
                                              ),
                                            ),
                                            Text(
                                                introController.customerServiceList[index].language,
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Theme.of(context).dividerColor
                                              ),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            SvgPicture.asset('assets/icons/whatsapp-green.svg',width: 26,height: 26),
                                            const SizedBox(width: 10),
                                            SizedBox(
                                              width: 35,
                                              height: 35,
                                              child: Icon(Icons.phone,size: 20,
                                                color:  Theme.of(context).dividerColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Divider(color: Theme.of(context).dividerColor.withOpacity(0.4), indent: 10)
                                  ],
                                ),
                              );
                            }
                        ),
                      ),

                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _header(context) {
    return Container(
      padding: const EdgeInsets.only(top: 30),
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
                    child: Icon(Icons.menu, size: 25,color: Colors.transparent,)),
              ),
              _logo(context),
              Global.langCode == 'en' ?
              Container(
                width: MediaQuery.of(context).size.width * 0.15,
                color: Colors.transparent,
                child: const Align(
                    alignment: Alignment.centerRight,
                    child: Icon(Icons.menu, size: 25,color: Colors.transparent)),
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


}


// SizedBox(
//   width: MediaQuery.of(context).size.width,
//   height: MediaQuery.of(context).size.height,
//   child: CarouselSlider.builder(
//     options: CarouselOptions(
//       onPageChanged: (index,_)  {
//         introController.contactIndex.value = index;
//       },
//       height: MediaQuery.of(context).size.height,
//       viewportFraction: 1,
//     ),
//     itemCount: introController.customerServiceList.length,
//     itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex){
//       return Stack(
//         alignment: Alignment.topLeft,
//         children: [
//           Container(
//             margin: EdgeInsets.only(bottom:  MediaQuery.of(context).size.height * 0.3),
//             width: MediaQuery.of(context).size.width,
//             height: MediaQuery.of(context).size.height,// * 0.7,
//             child: FancyShimmerImage(
//               imageUrl: introController.customerServiceList[itemIndex].image,
//               shimmerBaseColor: Colors.grey,
//               shimmerHighlightColor: Colors.white,
//               shimmerBackColor: Colors.grey,
//             )
//           ),
//           GestureDetector(
//             onTap: () {
//               introController.showPhoneList.value = false;
//               introController.showWhatsAppList.value = false;
//               Get.back();
//             },
//             child: Container(
//               margin: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top,left: 15,right: 15),
//               height: MediaQuery.of(context).size.height * 0.1,
//               child: const Icon(Icons.arrow_back_ios_outlined,color: Colors.white,size: 30,),
//             ),
//           ),
//         ],
//       );
//     },
//   ),
// ),
// Stack(
//   alignment: Alignment.bottomCenter,
//   children: [
//     Container(
//       width: MediaQuery.of(context).size.width,
//       height: MediaQuery.of(context).size.height * 0.45,
//       decoration: BoxDecoration(
//         image: DecorationImage(
//             fit: BoxFit.cover,
//             image:  MyTheme.isDarkTheme.value ?
//             const AssetImage('assets/icons/black_design.png') :
//             const AssetImage('assets/icons/white_design.png')
//
//         ),
//       ),
//     ),
//     Obx((){
//       return SizedBox(
//         height: MediaQuery.of(context).size.height * 0.3,
//         width: MediaQuery.of(context).size.width * 0.9,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               introController.customerServiceList[introController.contactIndex.value].name,
//               maxLines: 2,
//               style: TextStyle(
//                   fontSize: 22,
//                   color:  MyTheme.isDarkTheme.value ?
//                   Colors.white : Colors.black,
//                   fontWeight: FontWeight.bold
//               ),
//             ),
//             const SizedBox(height: 5),
//             Text(
//               "Communicate with " + introController.customerServiceList[introController.contactIndex.value].name + " in " +
//                   introController.customerServiceList[introController.contactIndex.value].language,
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: 17,
//                 color: MyTheme.isDarkTheme.value ?
//                 Colors.white : Colors.black,
//               ),
//             ),
//             const SizedBox(height: 25),
//             SizedBox(
//               width: MediaQuery.of(context).size.width * 0.9,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   AnimatedSmoothIndicator(
//                     activeIndex: introController.contactIndex.value,
//                     count: introController.customerServiceList.length,
//                     effect: SlideEffect(
//                         dotWidth: 10,
//                         dotHeight: 10,
//                         activeDotColor: MyTheme.isDarkTheme.value ?
//                         Colors.white : Colors.black,
//                         dotColor: Colors.grey
//                     ),
//                   ),
//                   GestureDetector(
//                     onTap: (){
//                       if (introController.showWhatsAppList.isTrue){
//                         introController.openWhatApp(context, "We Need Some Information",introController.customerServiceList[introController.contactIndex.value].phone);
//                       }else if (introController.showPhoneList.isTrue){
//                         introController.openPhone(introController.customerServiceList[introController.contactIndex.value].phone);
//                       }
//                     },
//                     child: Container(
//                       width: 50,
//                       height: 50,
//                       decoration: BoxDecoration(
//                           color: MyTheme.isDarkTheme.value ?
//                           Colors.white : Colors.black,
//                           shape: BoxShape.circle
//                       ),
//                       child: introController.showWhatsAppList.isTrue ?
//                       Center(child: SvgPicture.asset('assets/icons/whatsapp-green.svg',width: 30,height: 30,))
//                       : Center(
//                         child: Icon(Icons.phone,size: 30,
//                             color: MyTheme.isDarkTheme.value ?
//                             Colors.black : Colors.white,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: MediaQuery.of(context).viewPadding.bottom),
//           ],
//         ),
//       );
//     })
//   ],
// )