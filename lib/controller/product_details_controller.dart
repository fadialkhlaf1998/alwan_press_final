

import 'package:alwan_press/controller/wishlist_controller.dart';
import 'package:alwan_press/helper/api.dart';
import 'package:alwan_press/model/product.dart';
import 'package:alwan_press/model/product_list.dart';
import 'package:get/get.dart';

class ProductDetailsController extends GetxController{

  WishlistController wishlistController = Get.find();

  Rx<ProductList> productDetails = ProductList(id: -1, subCategoryId: -1, title: "", subTitle: "", search: "", image: "", rate: -1, rateCount: -1, description: "", price: -1, images: [],ar_desc: "",ar_title: "").obs;
  RxBool loading = false.obs;
  RxInt slectedSlider = 0.obs;
  getData(itemId) async {
    loading.value = true;
    Api.getProductDetails(itemId).then((value){
      productDetails.value = value;
      productDetails.value.wishlist(wishlistController.checkWishlist(productDetails.value));
      loading.value = false;
      Future.delayed(const Duration(milliseconds: 1000)).then((value){

      });
    });
  }

}