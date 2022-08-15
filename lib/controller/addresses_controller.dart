// import 'package:alwan/helper/api.dart';
// import 'package:alwan/helper/global.dart';
// import 'package:alwan/helper/myTheme.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class AddressController extends GetxController {
//
//
//   TextEditingController? address1;
//   TextEditingController? address2;
//   TextEditingController? apartment;
//   TextEditingController? phone;
//
//   RxInt emirateIndex = (-1).obs;
//   RxBool loading = false.obs;
//
//   List<String> emirateList = ['Dubai','Abo Dhabi','Ajman','Ras Al Khaimah','Sharjah','Umm Al Quwin','Dubai Eye'];
//
//
//   @override
//   void onInit() {
//     super.onInit();
//     // clearTextField();
//     Global.getUserInformation();
//     address1 = TextEditingController(text: Global.address1);
//     address2 = TextEditingController(text: Global.address2);
//     apartment = TextEditingController(text: Global.apartment);
//     phone = TextEditingController(text: Global.phone);
//   }
//
//   saveAddress() async {
//     loading.value = true;
//     Api.setCustomerAddress(
//         address1!.text,
//         address2!.text,
//         emirateList[1],
//         apartment!.text,
//         phone!.text,
//         Global.userId.toString(),
//     ).then((value){
//       if(value){
//         // print('Successfully');
//         Get.snackbar(
//             'Done!',
//             'Address saved successfully',
//             margin: EdgeInsets.only(top: 30,left: 25,right: 25),
//             backgroundColor: MyTheme.isDarkTheme.value ? Colors.grey.withOpacity(0.5) : Colors.black.withOpacity(0.5),
//             colorText: Colors.white
//         );
//         loading.value = false;
//       }else{
//         Get.snackbar(
//             'There is something wrong!',
//             'Address not saved',
//             margin: EdgeInsets.only(top: 30,left: 25,right: 25),
//             backgroundColor: MyTheme.isDarkTheme.value ? Colors.grey.withOpacity(0.5) : Colors.black.withOpacity(0.5),
//             colorText: Colors.white
//         );
//         loading.value = false;
//       }
//     });
//   }
//
//   clearTextField (){
//     address1!.clear();
//     address2!.clear();
//     apartment!.clear();
//     phone!.clear();
//   }
//
//
//
// }