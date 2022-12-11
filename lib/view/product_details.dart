import 'package:alwan_press/app_localization.dart';
import 'package:alwan_press/controller/intro_controller.dart';
import 'package:alwan_press/controller/product_details_controller.dart';
import 'package:alwan_press/controller/product_list_controller.dart';
import 'package:alwan_press/controller/sign_in_controller.dart';
import 'package:alwan_press/helper/app.dart';
import 'package:alwan_press/helper/global.dart';
import 'package:alwan_press/helper/myTheme.dart';
import 'package:alwan_press/model/product_list.dart';
import 'package:alwan_press/view/contact_information.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';

class ProductDetails extends StatelessWidget {

  ProductList product;
  // ProductDetails(this.product, {Key? key}) : super(key: key);
  ProductDetailsController productDetailsController = Get.put(ProductDetailsController());
  IntroController introController = Get.find();
  ProductDetails(this.product) {
    productDetailsController.getData(product.id);
  }

  @override
  Widget build(BuildContext context) {
    return Obx((){
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarColor: MyTheme.isDarkTheme.value?Color(0XFF181818):Colors.white
      ));
      return Scaffold(
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: MediaQuery.of(context).size.height - MediaQuery.of(context).viewPadding.bottom,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _image(context),
                    _description(context),
                  ],
                ),
              ),
            ),
            _contactOption(context),
          ],
        ),
      );
    });
  }


  _image(context) {
    return  Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.4,
          child: Hero(
            transitionOnUserGestures: true,
            tag: product,
            child: Image.network(
              product.image,
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
        Padding(
          padding: const EdgeInsets.only(top: 15),
          child: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.15,
              height: MediaQuery.of(context).size.width * 0.15,
              child: Lottie.asset('assets/icons/Arrow.json'),
            ),
          ),
        )
      ],
    );
  }
  _description(context){
    return Container(
      margin: const EdgeInsets.only(top: 20),
      width: MediaQuery.of(context).size.width * 0.9,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(App_Localization.of(context).translate("title") + ': ',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black
                      )
                  ),
                  Text(Global.langCode == "en"?product.title:product.ar_title,
                    style: TextStyle(
                        fontSize: 16,
                        color: MyTheme.isDarkTheme.value ? Colors.white.withOpacity(0.5) : App.grey)
                    ,textAlign: TextAlign.justify,),
                ],
              ),
              // Row(
              //   children: [
              //     Text(App_Localization.of(context).translate("price") + ': ',
              //         style: TextStyle(
              //             fontSize: 16,
              //             fontWeight: FontWeight.bold,
              //             color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black
              //         )
              //     ),
              //   AnimatedSwitcher(
              //     duration: const Duration(milliseconds: 300),
              //     child: productDetailsController.loading.value ?
              //     Container(
              //       width: 50,
              //       height: 20,
              //       child: Shimmer.fromColors(
              //           baseColor: Colors.grey,
              //           highlightColor:Colors.white,
              //           child:  Container(
              //             width: 50,
              //             height: 20,
              //             decoration: BoxDecoration(
              //                 color: Colors.grey.withOpacity(0.2),
              //                 borderRadius: BorderRadius.circular(20)
              //             ),
              //           )
              //       ),
              //     )
              //         : Text(
              //         productDetailsController.productDetails.value.price.toString(),
              //         style: TextStyle(
              //             fontSize: 15,
              //             color: MyTheme.isDarkTheme.value ? Colors.white.withOpacity(0.5) : App.grey),
              //         textAlign: TextAlign.justify
              //     ),
              //   )
              //   ],
              // ),
            ],
          ),
          Divider(height: 30,color: Theme.of(context).dividerColor),
          Text(App_Localization.of(context).translate("description"),
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black
            ),
          ),
          const SizedBox(height: 5,),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: productDetailsController.loading.value ?
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 150,
              child: Shimmer.fromColors(
                  baseColor: Colors.grey,
                  highlightColor:Colors.white,
                  child:  Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(5)
                    ),
                  )
              ),
            )
            : Container(
              width: MediaQuery.of(context).size.width * 0.9,
              // height: 200,
              child: Text(
                Global.langCode == "en"?
              productDetailsController.productDetails.value.description
              :productDetailsController.productDetails.value.ar_desc,
              style: TextStyle(
                height: 1.2,
                  fontSize: 13,
                  color: MyTheme.isDarkTheme.value ? Colors.white.withOpacity(0.5) : App.grey),
              textAlign: TextAlign.justify,
            ),
            ),
          ),
          Divider(height: 30,color: Theme.of(context).dividerColor),
          const SizedBox(height: 60)
          // Container(
          //   height: MediaQuery.of(context).size.height * 0.34,
          //   child: SingleChildScrollView(
          //     scrollDirection: Axis.vertical,
          //     child: Text(productDetailsController.productDetails.value.description,
          //       style: TextStyle(fontSize: 16,
          //           color: MyTheme.isDarkTheme.value ? Colors.white.withOpacity(0.5) : App.grey),
          //       textAlign: TextAlign.justify,),
          //   ),
          // ),
        ],
      ),
    );
  }
  _contactOption(context){
    return Container(
      margin: const EdgeInsets.only(right: 20,left: 20,bottom: 10),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: (){
                introController.showWhatsAppList.value = true;
                 Get.to(()=>ContactInformation());
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      color: MyTheme.isDarkTheme.value ? Colors.white : App.darkGrey,
                      //shape: BoxShape.circle
                      borderRadius: BorderRadius.circular(30)
                  ),
                  child: Center(
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 400),
                        child: SizedBox(
                            width: 30,
                            height: 30,
                            child: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 400),
                              child:  SvgPicture.asset('assets/icons/whatsapp-green.svg'),
                            )
                        ),
                      )
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  introController.showPhoneList.value = true;
                  Get.to(()=>ContactInformation());
                },
                child: Container(
                  width: 50,
                  height: 50,
                  //   margin: const EdgeInsets.only(bottom: 50),
                  decoration: BoxDecoration(
                      color: MyTheme.isDarkTheme.value ? Colors.white : App.darkGrey,
                      shape: BoxShape.circle
                  ),
                  child: Center(
                    child: Icon(Icons.phone,size: 30,
                      color: MyTheme.isDarkTheme.value ? Colors.black : Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

}
