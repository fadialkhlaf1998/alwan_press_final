import 'package:alwan_press/app_localization.dart';
import 'package:alwan_press/controller/main_class_controller.dart';
import 'package:alwan_press/controller/wishlist_controller.dart';
import 'package:alwan_press/helper/app.dart';
import 'package:alwan_press/helper/global.dart';
import 'package:alwan_press/helper/myTheme.dart';
import 'package:alwan_press/view/product_details.dart';
import 'package:alwan_press/widget/darkModeBackground.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class Wishlist extends StatelessWidget {

  WishlistController wishlistController = Get.find();
  MainClassController mainClassController = Get.find();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: MyTheme.isDarkTheme.value ? const Color(0XFF181818) : Colors.white
    ));
    return Scaffold(
      body: Obx(() => SafeArea(
        child: Stack(
          children: [
            MyTheme.isDarkTheme.value?  DarkModeBackground():Center(),
            Column(
              children: [
                _header(context),
                wishlistController.fake.value?
                const SizedBox(height: 10,):const SizedBox(height: 10,),
                Expanded(

                  child: Container(child:
                  wishlistController.wishlist.isEmpty
                      ?Center(
                        child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        // SizedBox(height: Get.height * 0.2,),
                        Text(App_Localization.of(context).translate("no_wishlist")+" ",style:TextStyle( color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black, fontSize: 12,) ,),

                        GestureDetector(
                            onTap: (){
                              // mainClassController.bottomBarController.jumpToTab(0);
                              mainClassController.selectedIndex(0);
                            },
                            child: Text(App_Localization.of(context).translate("continue_shopping"),style:TextStyle( color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black, fontSize: 12,fontWeight: FontWeight.bold) ,))
                    ],
                  ),
                      )
                      :Container(
                    width: Get.width * 0.95,
                        child: GridView.builder(
                          padding: EdgeInsets.only(bottom: 50),
                    shrinkWrap: true,

                    // physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: MediaQuery.of(context).size.shortestSide < 600
                            ? MediaQuery.of(context).size.width * 0.5
                            : MediaQuery.of(context).size.width * 0.3,
                        childAspectRatio: 4 / 6,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                    ),
                    itemCount:  wishlistController.wishlist.length ,
                    itemBuilder: (context, index) {
                        return  _product(context, index);
                    },
                  ),
                      ),),
                )
              ],
            )
          ],
        ),
      )),
    );
  }

  _product(context,index){
    return GestureDetector(
      onTap: (){
        // productListController.productId.value = productListController.productsList[index].id;
        Get.to(()=>ProductDetails(wishlistController.wishlist[index]));
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
                  borderRadius: BorderRadius.circular(10),
                  child: Hero(
                    transitionOnUserGestures: true,
                    tag: wishlistController.wishlist[index],
                    child: Image.network(
                        wishlistController.wishlist[index].image,
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
                    // color: MyTheme.isDarkTheme.value ? App.darkGrey : App.lightGrey,
                    // borderRadius: BorderRadius.circular(10)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(height: 5,),
                      Text(
                          Global.langCode == "en"
                              ?
                          wishlistController.wishlist[index].title
                              :wishlistController.wishlist[index].ar_title,
                          maxLines: 1,
                          style: TextStyle(
                              color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black,
                              fontSize: 12,
                              overflow: TextOverflow.ellipsis
                          )
                      ),
                      Obx(() => GestureDetector(
                        onTap: (){
                          wishlistController.wishlistFunction(wishlistController.wishlist[index]);
                        },
                        child:
                        wishlistController.wishlist[index].wishlist.value
                            ?Icon(Icons.favorite,size: 20,color: App.lightPink,)
                            :Icon(Icons.favorite_border,size: 20,),
                      ))
                    ],
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }

  _header(BuildContext context){
    return Container(
      width: Get.width,
      height: 60,
      decoration: BoxDecoration(
        color: MyTheme.isDarkTheme.value?App.newDarkGrey:Colors.white,
        boxShadow: [
          App.myBoxShadow
        ]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(width: 10,),
              App.logo(context),
            ],
          ),
          Row(
            children: [
              itemsNumber(context),
              SizedBox(width: 10,),
            ],
          )

        ],
      ),
    );
  }
  itemsNumber(BuildContext context){
    return Text(
      wishlistController.wishlist.length == 0 ?""
      :wishlistController.wishlist.length == 1 ?wishlistController.wishlist.length.toString()+ " " +App_Localization.of(context).translate("item")
      :wishlistController.wishlist.length.toString()+ " " +App_Localization.of(context).translate("items")
    ,style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black,fontWeight: FontWeight.bold),);
  }

}
