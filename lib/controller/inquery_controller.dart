import 'package:alwan_press/app_localization.dart';
import 'package:alwan_press/helper/api.dart';
import 'package:alwan_press/helper/app.dart';
import 'package:alwan_press/helper/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class InqueryController extends GetxController{

  RxBool loading = false.obs;
  RxBool validate = false.obs;
  RxBool successfully = false.obs;
  RxBool fake = false.obs;
  RxBool showImagePicker = false.obs;
  RxInt isPerson = 0.obs;
  TextEditingController name = TextEditingController();
  TextEditingController msg = TextEditingController();
  TextEditingController quantity = TextEditingController();
  TextEditingController phone_number = TextEditingController();
  TextEditingController email = TextEditingController();
  String code = "+971";
  XFile? image;
  final ImagePicker _picker = ImagePicker();

  pickCamera(BuildContext context)async{
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    showImagePicker.value=false;
    if(image!=null){
      this.image = image;
      fake(!fake.value);
    }
  }

  pickGallery(BuildContext context)async{
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    showImagePicker.value=false;
    if(image!=null){
      this.image = image;
      fake(!fake.value);
    }
  }

  submit(BuildContext context)async{
    validate(true);
    if(name.text.isNotEmpty &&
      msg.text.isNotEmpty &&
      phone_number.text.isNotEmpty &&
      code.isNotEmpty ){
      loading(true);
      bool succ = await Api.addInquery(image,
          isPerson.value,
          name.text, msg.text, quantity.text, phone_number.text, code, email.text);
      if(succ){
        successfully(true);
        await Future.delayed(Duration(milliseconds: 1500));
        successfully(false);
        Get.back();
      }else{
        App.mySnackBar(App_Localization.of(context).translate("inquiry"), App_Localization.of(context).translate("oops_d"));
      }
      loading(false);
    }
  }

}