import 'package:alwan_press/helper/store.dart';
import 'package:alwan_press/model/product.dart';
import 'package:alwan_press/model/product_list.dart';
import 'package:get/get.dart';

class WishlistController extends GetxController{
  List<ProductList> wishlist = <ProductList>[];
  RxBool fake = false.obs;

  addToWishlist(ProductList product){
    wishlist.add(product);
    product.wishlist(true);
    updateNow();
    Store.saveWishlist(wishlist);
  }

  deleteFromWishlist(ProductList product){
    for(int i=0;i<wishlist.length;i++){
      if(wishlist[i].id == product.id){
        wishlist.removeAt(i);
        break;
      }
    }
    product.wishlist(false);
    updateNow();
    Store.saveWishlist(wishlist);
  }

  wishlistFunction(ProductList product){
    if(product.wishlist.value){
      deleteFromWishlist(product);
    }else{
      addToWishlist(product);
    }
  }

  checkWishlist(ProductList product){
    for(int i=0;i<wishlist.length;i++){
      if(wishlist[i].id == product.id){
        return true;
      }
    }
    return false;
  }

  updateNow(){
    fake(!fake.value);
  }
}