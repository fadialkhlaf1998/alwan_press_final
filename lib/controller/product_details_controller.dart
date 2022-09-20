

import 'package:alwan_press/helper/api.dart';
import 'package:alwan_press/model/product.dart';
import 'package:get/get.dart';

class ProductDetailsController extends GetxController{



  Rx<Product> productDetails = Product(id: -1, subCategoryId: -1, title: "", subTitle: "", search: "", image: "", rate: -1, rateCount: -1, description: "", price: -1, images: [], reviews: [],ar_desc: "",ar_title: "").obs;
  RxBool loading = false.obs;

  getData(itemId) async {
    loading.value = true;
    Api.getProductDetails(itemId).then((value){
      productDetails.value = value;
      // TODO
      loading.value = false;
      Future.delayed(const Duration(milliseconds: 1000)).then((value){

      });
    });
  }

}