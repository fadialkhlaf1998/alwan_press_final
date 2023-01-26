import 'package:alwan_press/controller/home_controller.dart';
import 'package:alwan_press/controller/wishlist_controller.dart';
import 'package:alwan_press/helper/api.dart';
import 'package:alwan_press/model/product_list.dart';
import 'package:get/get.dart';

class ProductListController extends GetxController{

 RxList<ProductList> productsList = <ProductList>[].obs;
 RxList<ProductList> tempProductsList = <ProductList>[].obs;
 HomeController homeController = Get.find();
 WishlistController wishlistController = Get.find();

 RxInt productId = (-1).obs;
 RxBool loading = false.obs;
 
 @override
  void onInit() {
    super.onInit();
    // getData();
  }

  
  getData() async {
   loading.value = true;
    await Api.getProductList(homeController.productIndex.value).then((value){
     if(value.isNotEmpty){
        print('Not empty');
        productsList.addAll(value);
        tempProductsList.addAll(value);
        for(var elm in tempProductsList){
          elm.wishlist(wishlistController.checkWishlist(elm));
        }
        loading.value = false;
     }else{
        print('empty');
        loading.value = false;
      }
   });
  }

 wishlistUpdate() async {
   loading.value = true;
   for(var elm in tempProductsList){
     elm.wishlist(wishlistController.checkWishlist(elm));
   }
   loading.value = false;
 }


 search(String query){
    List<ProductList> dummySearchList = <ProductList>[];
    dummySearchList.addAll(productsList);
    if(query.isNotEmpty) {
      List<ProductList> dummyListData = <ProductList>[];
      for (var product in dummySearchList) {
        if(product.title.toLowerCase().contains(query)) {
          dummyListData.add(product);
        }
      }
      tempProductsList.clear();
      tempProductsList.addAll(dummyListData);
      return;
    } else {
      tempProductsList.clear();
      tempProductsList.addAll(productsList);

    }
  }
  

}