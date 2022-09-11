import 'package:alwan_press/helper/api.dart';
import 'package:alwan_press/model/order.dart';
import 'package:get/get.dart';

class OrderDetailsController extends GetxController{

  var loading = false.obs;
  var fake = false.obs;
  var shippingSucc = false.obs;
  var shippingAnimationSucc = false.obs;
  double totalForPayment = 0;
  Order? order;
  getData(int id){

  }

  animation(){
    shippingAnimationSucc.value = true;
    Future.delayed(Duration(milliseconds: 1000)).then((value) {
      refreshData();
    });
  }
  
  refreshData(){
    loading.value = true;
    Api.getOrderInfo(order!.id).then((orderRes) {
      if(orderRes != null){
        order = orderRes;
        if(order!.shippingRequestCount > 0){
          shippingSucc.value = true;
          shippingAnimationSucc.value = true;
        }
        totalForPayment = order!.price.toDouble() - order!.paid_amount.toDouble();
        if(order!.shippingState != 0 ){
          totalForPayment += order!.shippingPrice;
        }
        if(order!.state == 0 ){
          totalForPayment = totalForPayment / 4 ;
        }
        fake.value = ! fake.value;
        print('check');
        print(order!.shippingAddress);
        loading.value = false;
      }else{
        refreshData();
      }
    });
  }

}