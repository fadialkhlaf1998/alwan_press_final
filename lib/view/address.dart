// import 'package:alwan/app_localization.dart';
// import 'package:alwan/controller/addresses_controller.dart';
// import 'package:alwan/helper/app.dart';
// import 'package:alwan/helper/myTheme.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
//
// class Addresses extends StatelessWidget {
//
//   AddressController addressController = Get.put(AddressController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(() => Scaffold(
//       body: SafeArea(
//         child: Stack(
//           children: [
//             MyTheme.isDarkTheme.value ? Container(
//                 width: MediaQuery.of(context).size.width,
//                 height: MediaQuery.of(context).size.height,
//                 decoration: const BoxDecoration(
//                     image: DecorationImage(
//                         fit: BoxFit.cover,
//                         image: AssetImage('assets/image/background.png')
//                     )
//                 )
//             ) : Text(''),
//             SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     _header(context),
//                     _body(context),
//                   ],
//                 ),
//             ),
//           ],
//         ),
//       ),
//     ));
//   }
//
//   _header(context){
//     return Container(
//       width: MediaQuery.of(context).size.width,
//       height: MediaQuery.of(context).size.height * 0.1,
//       decoration: BoxDecoration(
//         color: MyTheme.isDarkTheme.value ?  Colors.transparent : Colors.white,
//       ),
//       child: Center(
//           child: Container(
//             width: MediaQuery.of(context).size.width * 0.9,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 GestureDetector(
//                   onTap: (){
//                     Get.back();
//                   },
//                   child: Container(
//                     child: Icon(Icons.arrow_back_ios_outlined,
//                       color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black,
//                       size: 25,),
//                   ),
//                 ),
//                 Text(App_Localization.of(context).translate("my_address"),
//                   style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black,fontSize: 24),
//                 ),
//                 Container(
//                   child: const Icon(Icons.arrow_back_ios_outlined,color: Colors.transparent,size: 20,),
//                 ),
//               ],
//             ),
//           )
//       ),
//     );
//   }
//
//   _body(context){
//     return Container(
//       width: MediaQuery.of(context).size.width,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           const SizedBox(height: 20),
//           _address1(context),
//           const SizedBox(height: 20),
//           _address2(context),
//           const SizedBox(height: 20),
//           _emirate(context),
//           const SizedBox(height: 20),
//           _apartment(context),
//           const SizedBox(height: 20),
//           _phone(context),
//           const SizedBox(height: 50),
//           _saveButton(context),
//           const SizedBox(height: 20),
//           _cancelButton(context),
//           const SizedBox(height: 50),
//         ],
//       ),
//     );
//   }
//
//   _address1(context){
//     return  Container(
//       width: MediaQuery.of(context).size.width * 0.9,
//       height: 55,
//       color: Colors.transparent,
//       child: TextField(
//         controller: addressController.address1,
//         style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black),
//         decoration: InputDecoration(
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//               borderSide: BorderSide(width: 1, color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//               borderSide:  BorderSide(width: 1, color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black),
//             ),
//             label: Text(App_Localization.of(context).translate("address1"),
//                 style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black))
//         ),
//       ),
//     );
//   }
//
//   _address2(context){
//     return  Container(
//       width: MediaQuery.of(context).size.width * 0.9,
//       height: 55,
//       color: Colors.transparent,
//       child: TextField(
//         controller: addressController.address2,
//         style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black),
//         decoration: InputDecoration(
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//               borderSide: BorderSide(width: 1, color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//               borderSide:  BorderSide(width: 1, color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black),
//             ),
//             label: Text(App_Localization.of(context).translate("address2"),
//                 style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black))
//         ),
//       ),
//     );
//   }
//
//   _emirate(context){
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//             App_Localization.of(context).translate('emirate'),
//           style: Theme.of(context).textTheme.headline1,
//         ),
//         SizedBox(height: 7),
//         Container(
//           height: 100,
//           width: MediaQuery.of(context).size.width * 0.9,
//           color: Colors.blue,
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: 7,
//             itemBuilder: (BuildContext context, index){
//               return Row(
//                 children: [
//                   Container(
//                     width: 100,
//                     height: 100,
//                     decoration: BoxDecoration(
//                       color: Colors.red,
//                       borderRadius: BorderRadius.circular(10),
//
//                     ),
//                     child: Text(
//                         addressController.emirateList[index],
//                       maxLines: 2,
//                       textAlign: TextAlign.center,
//                       style: Theme.of(context).textTheme.headline4,
//                     ),
//                   ),
//                   SizedBox(width: index != 6 ? 10 : 0)
//                 ],
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
//
//   _apartment(context){
//     return  Container(
//       width: MediaQuery.of(context).size.width * 0.9,
//       height: 55,
//       color: Colors.transparent,
//       child: TextField(
//         controller: addressController.apartment,
//         style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black),
//         decoration: InputDecoration(
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//               borderSide: BorderSide(width: 1, color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//               borderSide:  BorderSide(width: 1, color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black),
//             ),
//             label: Text(App_Localization.of(context).translate("apartment"),
//                 style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black))
//         ),
//       ),
//     );
//   }
//
//   _phone(context){
//     return  Container(
//       width: MediaQuery.of(context).size.width * 0.9,
//       height: 55,
//       color: Colors.transparent,
//       child: TextField(
//         keyboardType: TextInputType.phone,
//         controller: addressController.phone,
//         style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black),
//         decoration: InputDecoration(
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//               borderSide: BorderSide(width: 1, color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//               borderSide:  BorderSide(width: 1, color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black),
//             ),
//             label: Text(App_Localization.of(context).translate("phone"),
//                 style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black))
//         ),
//       ),
//     );
//   }
//
//   _saveButton(context){
//     return  GestureDetector(
//       onTap: (){
//         FocusManager.instance.primaryFocus?.unfocus();
//         // signInController.login();
//         addressController.saveAddress();
//       },
//       child: Container(
//         width: MediaQuery.of(context).size.width * 0.9,
//         height: 55,
//         decoration: BoxDecoration(
//             color: App.pink,
//             borderRadius: BorderRadius.circular(10)
//         ),
//         child:  Center(
//           child:  addressController.loading.value
//               ?  Center(child: Container(
//                 width: 25,
//                 height: 25,
//                 child: CircularProgressIndicator(color: Colors.white,strokeWidth: 2.5)))
//               : Text(App_Localization.of(context).translate("save_address"),
//                 style: TextStyle(color: Colors.white,fontSize: 16)),
//         ),
//       ),
//     );
//   }
//
//   _cancelButton(context){
//     return GestureDetector(
//       onTap: (){
//         FocusManager.instance.primaryFocus?.unfocus();
//         addressController.clearTextField();
//         Get.back();
//       },
//       child: Container(
//         width: MediaQuery.of(context).size.width * 0.9,
//         height: 55,
//         decoration: BoxDecoration(
//             color: App.darkGrey,
//             borderRadius: BorderRadius.circular(10)
//         ),
//         child:  Center(
//           child: Text(App_Localization.of(context).translate("cancel").toUpperCase(),
//               style: const TextStyle(color: Colors.white,fontSize: 16)),
//         ),
//       ),
//     );
//   }
// }
