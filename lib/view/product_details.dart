import 'package:alwan_press/app_localization.dart';
import 'package:alwan_press/controller/all_subCategory_controller.dart';
import 'package:alwan_press/controller/home_controller.dart';
import 'package:alwan_press/controller/intro_controller.dart';
import 'package:alwan_press/controller/product_details_controller.dart';
import 'package:alwan_press/controller/product_list_controller.dart';
import 'package:alwan_press/controller/sign_in_controller.dart';
import 'package:alwan_press/controller/wishlist_controller.dart';
import 'package:alwan_press/helper/app.dart';
import 'package:alwan_press/helper/global.dart';
import 'package:alwan_press/helper/myTheme.dart';
import 'package:alwan_press/model/product_list.dart';
import 'package:alwan_press/view/all_subCategory.dart';
import 'package:alwan_press/view/contact_information.dart';
import 'package:alwan_press/view/home.dart';
import 'package:alwan_press/view/main_class.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:shimmer/shimmer.dart';

class ProductDetails extends StatelessWidget {

  ProductList product;
  // ProductDetails(this.product, {Key? key}) : super(key: key);
  ProductDetailsController productDetailsController = Get.put(ProductDetailsController());

  // HomeController homeController = Get.find();
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
        body: SafeArea(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                height: MediaQuery.of(context).size.height - MediaQuery.of(context).viewPadding.bottom - 20,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _categoryBar(context),
                      Container(
                        width: Get.width * 0.9,
                        child: Row(
                          children: [
                            Text(Global.langCode == "en"?product.title:product.ar_title,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: App.textColor())
                              ,textAlign: TextAlign.justify,),
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),

                      _images(context),
                      _description(context),
                    ],
                  ),
                ),
              ),
              _contactOption(context),
            ],
          ),
        ),
      );
    });
  }

  _categoryBar(context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 15,),
          SizedBox(
            height: 50,
            child: ScrollablePositionedList.builder(
              scrollDirection: Axis.horizontal,
              // itemScrollController: allSubCategoryController.itemScrollController,
              itemCount: introController.categoriesList.length + 1 ,
              itemBuilder: (BuildContext context, index) {
                if(index == 0){
                  return  Padding(
                    padding: const EdgeInsets.only(top: 0),
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
                  );
                }else{
                  return Center(
                    child: SizedBox(
                      height: 40,
                      child: Row(
                        children: [
                          Obx(() {
                            return GestureDetector(
                              onTap: () async {
                                print((index-1).toString());
                                introController.homeController.categoryIndex.value = index -1;
                                Get.offAll(()=>MainClass());
                              },
                              child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 500),
                                  width: MediaQuery.of(context).size.width * 0.19,
                                  height: 90,
                                  decoration: BoxDecoration(
                                      color: introController.homeController.categoryIndex.value ==
                                          index-1
                                          ? Color(int.parse(
                                          '0xFF${introController.categoriesList[index-1].color.toString().substring(1)}'))
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
                                        introController.categoriesList[index-1].title
                                            :introController.categoriesList[index-1].ar_title,
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 8,
                                          fontWeight:
                                          introController.homeController.categoryIndex.value ==
                                              (index-1)
                                              ? FontWeight.bold
                                              : null,
                                          color:
                                          introController.homeController.categoryIndex.value ==
                                              (index-1)
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
                      ),
                    ),
                  );
                }

              },
            ),
          ),
          SizedBox(height: 15,),
        ],
      ),
    );
  }
  _images(BuildContext context){

    if(product.images.isEmpty){
      return Hero(tag: product, child: _image(context, product.image));
    }else{
      return Hero(tag: product,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10)
            ),
            child: CarouselSlider(
              options: CarouselOptions(
                  autoPlay: true,
                  viewportFraction: 1,
                  // width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.width * 0.9,
                  autoPlayAnimationDuration: const Duration(milliseconds: 1000),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  onPageChanged: (index, _) {
                    // homeController.sliderIndex.value = index;
                  }),
              items: product.images
                  .map((e) => Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(e.link),
                    fit: BoxFit.cover,
                  ),
                ),
              ))
                  .toList(),
            ),
          )
      );
    }
  }
  
  _image(context,String url) {
    return  Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(image: NetworkImage(url),fit: BoxFit.cover)
      ),
    );
  }
  _description(context){
    return Container(
      margin: const EdgeInsets.only(top: 20),
      width: MediaQuery.of(context).size.width * 0.9,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Divider(height: 30,color: Theme.of(context).dividerColor),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(App_Localization.of(context).translate("description"),
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black
                ),
              ),
              Container(
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                  border: Border.all(color: MyTheme.isDarkTheme.value ? Colors.white.withOpacity(0.5) : App.grey),
                  shape: BoxShape.circle
                ),
                child: Center(
                  child: Obx(() => GestureDetector(
                    onTap: (){
                      productDetailsController.wishlistController.wishlistFunction(productDetailsController.productDetails.value);
                    },
                    child:
                    productDetailsController.productDetails.value.wishlist.value
                        ?Icon(Icons.favorite,size: 18,color: App.lightPink,)
                        :Icon(Icons.favorite_border,size: 18,),
                  )),
                ),
              )
            ],
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
                  color: App.textLightColor()),
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
