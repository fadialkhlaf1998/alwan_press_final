import 'package:alwan_press/app_localization.dart';
import 'package:alwan_press/controller/ProfileController.dart';
import 'package:alwan_press/controller/intro_controller.dart';
import 'package:alwan_press/controller/main_class_controller.dart';
import 'package:alwan_press/controller/settings_controller.dart';
import 'package:alwan_press/helper/app.dart';
import 'package:alwan_press/helper/global.dart';
import 'package:alwan_press/helper/myTheme.dart';
import 'package:alwan_press/helper/store.dart';
import 'package:alwan_press/view/about_us.dart';
import 'package:alwan_press/view/address_2.dart';
import 'package:alwan_press/view/connect_us.dart';
import 'package:alwan_press/view/contact_information.dart';
import 'package:alwan_press/view/pdf_viwer.dart';
import 'package:alwan_press/view/sign_in.dart';
import 'package:alwan_press/widget/darkModeBackground.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class NewProfile extends StatefulWidget {
  const NewProfile({Key? key}) : super(key: key);

  @override
  State<NewProfile> createState() => _NewProfileState();
}

class _NewProfileState extends State<NewProfile> {

  IntroController introController = Get.find();
  ProfileController profileController = Get.find();
  MainClassController mainClassController = Get.find();
  SettingsController settingsController = Get.put(SettingsController());
  final ImagePicker _picker = ImagePicker();

  _NewProfileState(){
    if(Global.langCode == "en"){
      settingsController.selectedLanguage.value = 0;
      settingsController.languageName.value = "English";
    }else{
      settingsController.selectedLanguage.value = 1;
      settingsController.languageName.value = "العربية";
    }
    if(Global.user!=null){
      profileController.name.text = Global.user!.name;
      profileController.email.text = Global.user!.email;
      profileController.phone.text = Global.user!.phone.length>6&&Global.user!.phone.contains("+971")?Global.user!.phone.split("+971")[1]:"";
      profileController.landLine.text = Global.user!.land_line.length>6&&Global.user!.land_line.contains("+971")?Global.user!.land_line.split("+971")[1]:"";
    }
  }


  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: MyTheme.isDarkTheme.value?Color(0XFF181818):Colors.white
    ));
    return Obx(() => Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            DarkModeBackground(),

            Global.user == null?
            _notLogin():
            SingleChildScrollView(
              child: Column(
                children: [
                  profileController.fake.value?Center():Center(),
                  _customerDetails(context),
                  _myAccount(context),
                  _reachOutToUs(),
                ],
              ),
            ),
            profileController.showChoose.value?_chooseImage(context):Center(),
          ],
        ),
      ),
    ));
  }
  _notLogin(){
    return  Container(
      height: MediaQuery.of(context).size.height*0.7,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // SizedBox(height: 100,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(onTap:(){
                Get.to(()=>SignIn());
              } ,child: Text(App_Localization.of(context).translate("sign_in"),style: TextStyle(color: MyTheme.isDarkTheme.value?Colors.white:Colors.black,fontWeight: FontWeight.bold,decoration: TextDecoration.underline,height: 1),)),
              SizedBox(width: 5,),
              Text(App_Localization.of(context).translate("or"),style: TextStyle(color: Colors.grey),),
              SizedBox(width: 5,),
              GestureDetector(onTap:(){
                Get.to(()=>ContactInformation());
              } ,child: Text(App_Localization.of(context).translate("sign_up"),style: TextStyle(color: MyTheme.isDarkTheme.value?Colors.white:Colors.black,fontWeight: FontWeight.bold,decoration: TextDecoration.underline,height: 1),)),

            ],
          )
        ],
      ),
    );
  }
  _customerDetails(context){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 120,
      color: App.containerColor(),
      child:  Row(
        children: [
          SizedBox(width: 10,),
          GestureDetector(
            onTap: () {
              //todo edit image

            },
            child: Container(
              width: 80,
              color: Colors.transparent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Stack(
                    children: [
                      GestureDetector(

                        child: Container(
                          height:  80,
                          child: Center(
                              child: GestureDetector(
                                onTap: (){
                                  profileController.showChoose.value = true;
                                },
                                child: (Global.user!.image=="")?
                                CircleAvatar(
                                  child: Icon(Icons.person,color: MyTheme.isDarkTheme.value?Colors.white:Colors.black,size: MediaQuery.of(context).size.width * 0.4/2,),
                                  backgroundColor: Colors.grey,
                                  radius: 40,
                                )
                                    :CircleAvatar(
                                  backgroundColor: Colors.grey,
                                  backgroundImage: NetworkImage(Global.user!.image),
                                  radius: 40,
                                ),
                              )
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){

                        },
                        child: Container(
                          height:  90,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: GestureDetector(
                              onTap: (){
                                profileController.showChoose.value = true;
                              },
                              child: CircleAvatar(
                                backgroundColor: MyTheme.isDarkTheme.value?Colors.white:Colors.black,
                                child: Icon(Icons.edit,color: MyTheme.isDarkTheme.value?Colors.black:Colors.white,size: 15,),
                                radius: 10,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),

                ],
              ),
            ),
          ),
          SizedBox(width: 10,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(App_Localization.of(context).translate("hala")+" "+Global.user!.name,style: TextStyle(color: App.textColor(),fontSize: 13),),
              Text(Global.user!.email,style: TextStyle(color: App.textColor().withOpacity(0.5),fontSize: 12),),
            ],
          ),
          Spacer(),

          SizedBox(width: 10,),
        ],
      ),

    );
  }
  _languageBottomSheet(){
    showMaterialModalBottomSheet(
      useRootNavigator: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        width: Get.width,
        height: 170,
        decoration: BoxDecoration(
          color: App.containerColor(),
          borderRadius: BorderRadius.only(topRight: Radius.circular(15),topLeft: Radius.circular(15))
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(height: 15,),
              Text(App_Localization.of(context).translate('language'),style: TextStyle(color: App.textColor(),fontSize: 13),),
              SizedBox(height: 15,),
              GestureDetector(
                onTap: (){
                  settingsController.languageCode.value = settingsController.languages[1]["id"];
                  settingsController.languageValue.value = settingsController.languages[1]["name"];
                  settingsController.languageName.value = settingsController.languages[1]["name"];
                  settingsController.selectedLanguage.value = 1;
                  Global.saveLanguage(context,settingsController.languageCode.value);
                  Get.back();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset("assets/new_profile/saudi-arabia.svg"),
                        SizedBox(width: 10,),
                        Text(settingsController.languages[1]['name'],style: TextStyle(color: App.textColor().withOpacity(0.5),fontSize: 12),)
                      ],
                    ),

                        Container(
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: App.textColor().withOpacity(0.5))
                          ),
                          child: settingsController.selectedLanguage.value== 1 ?
                          Icon(Icons.check_circle,color: Colors.green,size: 13,):Center(),
                        )
                  ],
                ),
              ),
              SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: Get.width - 20,
                    height: 1,
                    color: App.textColor().withOpacity(0.05),
                  )
                ],
              ),
              SizedBox(height: 15,),
              GestureDetector(
                onTap: (){
                  settingsController.languageCode.value = settingsController.languages[0]["id"];
                  settingsController.languageValue.value = settingsController.languages[0]["name"];
                  settingsController.languageName.value = settingsController.languages[0]["name"];
                  settingsController.selectedLanguage.value = 0;
                  Global.saveLanguage(context,settingsController.languageCode.value);
                  Get.back();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset("assets/new_profile/united-kingdom.svg"),
                        SizedBox(width: 10,),
                        Text(settingsController.languages[0]['name'],style: TextStyle(color: App.textColor().withOpacity(0.5),fontSize: 12),)
                      ],
                    ),

                    Container(
                      width: 15,
                      height: 15,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: App.textColor().withOpacity(0.5))
                      ),
                      child:settingsController.selectedLanguage.value== 0 ?
                      Icon(Icons.check_circle,color: Colors.green,size: 13,):Center(),
                    )
                  ],
                ),
              ),
              SizedBox(height: 15,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: Get.width - 20,
                    height: 1,
                    color: App.textColor().withOpacity(0.05),
                  )
                ],
              ),
              SizedBox(height: 15,),
            ],
          ),
        ),
      ),
    );
  }

  _profileBottomSheet(){
    showMaterialModalBottomSheet(
      useRootNavigator: true,

      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => SingleChildScrollView(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          width: Get.width,
          height: 370,
          decoration: BoxDecoration(
              color: App.containerColor(),
              borderRadius: BorderRadius.only(topRight: Radius.circular(15),topLeft: Radius.circular(15))
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                SizedBox(height: 15,),
                Text(App_Localization.of(context).translate('edit_profile'),style: TextStyle(color: App.textColor(),fontSize: 13),),
                SizedBox(height: 15,),
                _details(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  _details(BuildContext context){
    return Obx(() => Column(

      children: [
        profileController.fake.value?Center():Center(),
        _textField(context,profileController.name,"name"),
        SizedBox(height: 10,),
        _emailTextField(context,profileController.email,"email"),
        SizedBox(height: 10,),
        _phone(context),
        SizedBox(height: 10,),
        _landLine(context),
        SizedBox(height: 10,),
        profileController.dataUpdated.value?Column(
          children: [
            GestureDetector(
                onTap: () {
                  //todo save data
                  print('/*/*');
                  profileController.updateData(context);
                  Get.back();
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          width: 28,
                          height: 28,
                          child: const Icon(
                            Icons.check_circle_outline_sharp,
                            color:  Colors.white,
                            size: 28,)
                      ),
                      const SizedBox(width: 10),
                      Center(
                          child: Text(App_Localization.of(context).translate("submit"),
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold
                              )))
                    ],
                  ),
                )
            ),
            SizedBox(height: 10,),
          ],
        ):Center(),

      ],
    ));
  }
  _emailTextField(context,TextEditingController textEditingController,String hint){
    return  Container(

      width: MediaQuery.of(context).size.width  - 20,
      height: 55,
      color: Colors.transparent,
      child: TextField(
        onChanged: (q){
          profileController.onChange();
        },
        controller: textEditingController,
        style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white.withOpacity(0.5) : Colors.black.withOpacity(0.5),fontSize: 12,height: 1),
        // textAlign: TextAlign.start,
        decoration: InputDecoration(
          // prefixText: 'Nike name: ',
          // prefixStyle: TextStyle(
          //     color: Theme.of(context).dividerColor
          // ),
            focusedBorder: UnderlineInputBorder(
              // borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(width: 1, color: profileController.validate.value&&(textEditingController.text.isEmpty||!RegExp(r'\S+@\S+\.\S+').hasMatch(textEditingController.text))?Colors.red:MyTheme.isDarkTheme.value ? Colors.white.withOpacity(0.1) : Colors.black.withOpacity(0.1)),
            ),
            enabledBorder: UnderlineInputBorder(
              // borderRadius: BorderRadius.circular(10),
              borderSide:  BorderSide(width: 1, color: profileController.validate.value&&(textEditingController.text.isEmpty||!RegExp(r'\S+@\S+\.\S+').hasMatch(textEditingController.text))?Colors.red:MyTheme.isDarkTheme.value ? Colors.white.withOpacity(0.1) : Colors.black.withOpacity(0.1)),
            ),

            label: Text(App_Localization.of(context).translate(hint),
                style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black,fontSize: 13))
        ),
      ),
    );
  }
  _textField(context,TextEditingController textEditingController,String hint){
    return  Container(

      width: MediaQuery.of(context).size.width - 20,
      height: 55,
      color: Colors.transparent,
      child: TextField(
        onChanged: (q){
          profileController.onChange();
        },
        controller: textEditingController,
        style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white.withOpacity(0.5) : Colors.black.withOpacity(0.5),fontSize: 12,height: 1),
        // textAlign: TextAlign.start,
        decoration: InputDecoration(
          // prefixText: 'Nike name: ',
          // prefixStyle: TextStyle(
          //     color: Theme.of(context).dividerColor
          // ),
            focusedBorder: UnderlineInputBorder(
              // borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(width: 1, color: profileController.validate.value&&(textEditingController.text.isEmpty)?Colors.red:MyTheme.isDarkTheme.value ? Colors.white.withOpacity(0.1) : Colors.black.withOpacity(0.1)),
            ),
            enabledBorder: UnderlineInputBorder(
              // borderRadius: BorderRadius.circular(10),
              borderSide:  BorderSide(width: 1, color: profileController.validate.value&&textEditingController.text.isEmpty?Colors.red:MyTheme.isDarkTheme.value ? Colors.white.withOpacity(0.1) : Colors.black.withOpacity(0.1)),
            ),

            label: Text(App_Localization.of(context).translate(hint),
                style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black,fontSize: 13))
        ),
      ),
    );
  }
  _phone(context){
    return  Container(
      width: MediaQuery.of(context).size.width -20,
      height: 55,
      color: Colors.transparent,
      child: TextField(
        onChanged: (q){
          profileController.onChange();
        },
        keyboardType: TextInputType.phone,
        controller: profileController.phone,
        style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white.withOpacity(0.5) : Colors.black.withOpacity(0.5),fontSize: 12,height: 1),
        maxLength: 9,
        decoration: InputDecoration(
            counterText: '',
            prefixText: '+971 ',
            prefixStyle:  TextStyle(
                color: MyTheme.isDarkTheme.value ? Colors.white.withOpacity(0.5) : Colors.black.withOpacity(0.5),fontSize: 12,height: 1
            ),
            focusedBorder: UnderlineInputBorder(
              // borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(width: 1, color:  profileController.validate.value&&profileController.phone.text.isEmpty?Colors.red:MyTheme.isDarkTheme.value ? Colors.white.withOpacity(0.1) : Colors.black.withOpacity(0.1)),
            ),
            enabledBorder: UnderlineInputBorder(
              // borderRadius: BorderRadius.circular(10),
              borderSide:  BorderSide(width: 1, color:  profileController.validate.value&&profileController.phone.text.isEmpty?Colors.red:MyTheme.isDarkTheme.value ? Colors.white.withOpacity(0.1) : Colors.black.withOpacity(0.1)),
            ),
            label: Text(App_Localization.of(context).translate("phone"),
                style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black,fontSize: 13))
        ),
      ),
    );
  }
  _landLine(context){
    return  Container(
      width: MediaQuery.of(context).size.width -20,
      height: 55,
      color: Colors.transparent,
      child: TextField(
        onChanged: (q){
          profileController.onChange();
        },
        keyboardType: TextInputType.phone,
        controller: profileController.landLine,
        style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white.withOpacity(0.5) : Colors.black.withOpacity(0.5),fontSize: 12,height: 1),
        maxLength: 9,
        decoration: InputDecoration(
            counterText: '',
            prefixText: '+971 ',
            prefixStyle:  TextStyle(
                color: MyTheme.isDarkTheme.value ? Colors.white.withOpacity(0.5) : Colors.black.withOpacity(0.5),fontSize: 12,height: 1
            ),
            focusedBorder: UnderlineInputBorder(
              // borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(width: 1, color:  MyTheme.isDarkTheme.value ? Colors.white.withOpacity(0.1) : Colors.black.withOpacity(0.1)),
            ),
            enabledBorder: UnderlineInputBorder(
              // borderRadius: BorderRadius.circular(10),
              borderSide:  BorderSide(width: 1, color:  MyTheme.isDarkTheme.value ? Colors.white.withOpacity(0.1) : Colors.black.withOpacity(0.1)),
            ),
            label: Text(App_Localization.of(context).translate("land_line"),
                style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black,fontSize: 13))
        ),
      ),
    );
  }

  _myAccount(BuildContext context){
    return Column(
      children: [
        SizedBox(height: 10,),
        Row(
          children: [
            SizedBox(width: 10,),
            Text(App_Localization.of(context).translate("my_account"),style: TextStyle(color: App.textColor(),fontSize: 15),)
          ],
        ),
        SizedBox(height: 10,),
        Container(
          width: Get.width,
          color: App.containerColor(),
          child: Column(
            children: [
              GestureDetector(
                onTap: (){
                  if(Global.user!=null){
                    if(Global.user!.financialState.endsWith("pdf")){
                      profileController.loading.value = true;
                      profileController.loadPdf().then((value){
                        var pdf = value.path;
                        profileController.loading.value = false;
                        Get.to(()=>PdfViewerPage(pdf));
                      });
                    }else{
                      noStatementDialog();
                      profileController.loading.value = false;
                    }
                  }else{
                    Get.to(()=>SignIn());
                  }
                },
                child: Container(
                  width: Get.width - 20,
                  height: 52,
                  color: Colors.transparent,
                  child: Column(
                    children: [
                      SizedBox(height: 15,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                  MyTheme.isDarkTheme.value
                                      ? "assets/new_profile/dark/my_statement.svg"
                                      : "assets/new_profile/light/my_statement.svg",
                                height: 18,
                              ),
                              SizedBox(width: 10,),
                              Text(App_Localization.of(context).translate("my_statement"),style: TextStyle(color: App.textColor(),fontSize: 12),)
                            ],
                          ),
                          Icon(Icons.arrow_forward_ios,size: 12, color: App.textColor(),)
                        ],
                      ),
                      SizedBox(height: 15,),
                      Container(color: App.textColor().withOpacity(0.05),width: Get.width - 20 ,height: 1,)
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Get.to(()=>Addresses_2(-1));
                },
                child: Container(
                  width: Get.width - 20,
                  color: Colors.transparent,
                  height: 52,
                  child: Column(
                    children: [
                      SizedBox(height: 15,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                  MyTheme.isDarkTheme.value
                                      ? "assets/new_profile/dark/my_address.svg"
                                      : "assets/new_profile/light/my_address.svg",
                                height: 19,
                              ),
                              SizedBox(width: 10,),
                              Text(App_Localization.of(context).translate("my_address"),style: TextStyle(color: App.textColor(),fontSize: 12),)
                            ],
                          ),
                          Icon(Icons.arrow_forward_ios,size: 12, color: App.textColor(),)
                        ],
                      ),
                      SizedBox(height: 15,),
                      Container(color: App.textColor().withOpacity(0.05),width: Get.width - 20 ,height: 1,)
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  _profileBottomSheet();
                },
                child: Container(
                  width: Get.width - 20,
                  height: 52,
                  color: Colors.transparent,
                  child: Column(
                    children: [
                      SizedBox(height: 15,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                MyTheme.isDarkTheme.value
                                    ? "assets/new_profile/dark/profile.svg"
                                    : "assets/new_profile/light/my_profile.svg",
                                height: 18,
                              ),
                              SizedBox(width: 10,),
                              Text(App_Localization.of(context).translate("profile"),style: TextStyle(color: App.textColor(),fontSize: 12),)
                            ],
                          ),
                          Icon(Icons.arrow_forward_ios,size: 12, color: App.textColor(),)
                        ],
                      ),
                      SizedBox(height: 15,),
                      Container(color: App.textColor().withOpacity(0.05),width: Get.width - 20 ,height: 1,)
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  _languageBottomSheet();
                },
                child: Container(
                  color: Colors.transparent,
                  width: Get.width - 20,
                  height: 52,
                  child: Column(
                    children: [
                      SizedBox(height: 15,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                MyTheme.isDarkTheme.value
                                    ? "assets/new_profile/dark/language.svg"
                                    : "assets/new_profile/light/language.svg",
                                height: 18,
                              ),
                              SizedBox(width: 10,),
                              Text(App_Localization.of(context).translate("language"),style: TextStyle(color: App.textColor(),fontSize: 12),)
                            ],
                          ),
                          Text(settingsController.languageName.value,style: TextStyle(color: App.textColor(),fontSize: 10),)

                        ],
                      ),
                      SizedBox(height: 15,),
                      Container(color: App.textColor().withOpacity(0.05),width: Get.width - 20 ,height: 1,)
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Get.to(()=> ConnectUs());
                },
                child: Container(
                  width: Get.width - 20,
                  color: Colors.transparent,
                  height: 52,
                  child: Column(
                    children: [
                      SizedBox(height: 15,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                MyTheme.isDarkTheme.value
                                    ? "assets/new_profile/dark/call.svg"
                                    : "assets/new_profile/light/call.svg",
                                height: 18,
                              ),
                              SizedBox(width: 10,),
                              Text(App_Localization.of(context).translate("connect_with_us"),style: TextStyle(color: App.textColor(),fontSize: 12),)
                            ],
                          ),
                          // Icon(Icons.arrow_forward_ios,size: 12, color: App.textColor(),)
                        ],
                      ),
                      SizedBox(height: 15,),
                      Container(color: App.textColor().withOpacity(0.05),width: Get.width - 20 ,height: 1,)
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  if(Global.user == null){
                    Get.offAll(()=>SignIn());
                  }else{
                    if(Global.user!.request_statment > 0){
                      profileController.mySnackBar(App_Localization.of(context).translate("u_req_under_process_title"),
                          App_Localization.of(context).translate("u_req_under_process_desc"));
                    }else{
                      _showMyDialog(context);
                    }
                  }
                },
                child: Container(
                  width: Get.width - 20,
                  color: Colors.transparent,
                  height: 52,
                  child: Column(
                    children: [
                      SizedBox(height: 15,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                MyTheme.isDarkTheme.value
                                    ? "assets/new_profile/dark/req_las_statement.svg"
                                    : "assets/new_profile/light/req_las_statement.svg",
                                height: 18,
                              ),
                              SizedBox(width: 10,),
                              Text(App_Localization.of(context).translate("req_last_state"),style: TextStyle(color: App.textColor(),fontSize: 12),)
                            ],
                          ),
                          // Icon(Icons.arrow_forward_ios,size: 12, color: App.textColor(),)
                        ],
                      ),
                      SizedBox(height: 15,),
                      Container(color: App.textColor().withOpacity(0.05),width: Get.width - 20 ,height: 1,)
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  //todo
                },
                child: Container(
                  width: Get.width - 20,
                  color: Colors.transparent,
                  // height: 50,
                  child: Column(
                    children: [
                      SizedBox(height: 15,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              MyTheme.isDarkTheme.value ?
                              const Icon(Icons.dark_mode,color: Colors.white,size: 22,) :
                              const Icon(Icons.light_mode,color: Colors.black,size: 22),
                              SizedBox(width: 10,),
                              Text(MyTheme.isDarkTheme.value?
                              App_Localization.of(context).translate("dark_mode")
                                :App_Localization.of(context).translate("light_mode"),style: TextStyle(color: App.textColor(),fontSize: 12),)
                            ],
                          ),
                          SizedBox(
                            height: 30,
                            child: Switch(
                              activeColor: App.pink,
                              value: MyTheme.isDarkTheme.value,
                              onChanged: (value){
                                settingsController.changeMode(context);
                                Store.saveTheme(!value);
                              },
                            ),
                            // child: CupertinoSwitch(
                            //
                            //   activeColor: App.pink,
                            //   thumbColor: Theme.of(context).dividerColor,
                            //   value: MyTheme.isDarkTheme.value,
                            //   onChanged: (bool value) {
                            //     settingsController.changeMode(context);
                            //     Store.saveTheme(!value);
                            //   },
                            // ),
                          )
                          // Icon(Icons.arrow_forward_ios,size: 12, color: App.textColor(),)
                        ],
                      ),
                      SizedBox(height: 15,),
                      // Container(color: App.textColor().withOpacity(0.05),width: Get.width - 20 ,height: 1,)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
  submit(){
    Get.back();
    profileController.requsetLastStatment(context);
  }
  Future<void> _showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(App_Localization.of(context).translate("req_last_state")),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                _note(context)
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(App_Localization.of(context).translate("submit")),
              onPressed: () {
                //Navigator.of(context).pop();
                submit();
              },
            ),
            TextButton(
              child: Text(App_Localization.of(context).translate("cancel")),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  _note(context){
    return  Container(
      width: MediaQuery.of(context).size.width * 0.4,
      height: 55,
      color: Colors.transparent,
      child: TextField(
        controller: profileController.note,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(width: 1, color: Colors.black),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:  BorderSide(width: 1, color:Colors.black),
            ),
            label: Text(App_Localization.of(context).translate("note"),
                style: TextStyle(color: Colors.black))
        ),
      ),
    );
  }
  _reachOutToUs(){
    return Column(
      children: [
        SizedBox(height: 10,),
        Row(
          children: [
            SizedBox(width: 10,),
            Text(App_Localization.of(context).translate("reach_out_to_us"),style: TextStyle(color: App.textColor(),fontSize: 15),)
          ],
        ),
        SizedBox(height: 10,),
        Container(
          width: Get.width,
          color: App.containerColor(),
          child: Column(
            children: [
              GestureDetector(
                onTap: (){
                  Get.to(()=>AboutUs());
                },
                child: Container(
                  width: Get.width - 20,
                  height: 52,
                  color: Colors.transparent,
                  child: Column(
                    children: [
                      SizedBox(height: 15,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                MyTheme.isDarkTheme.value
                                    ? "assets/new_profile/dark/help.svg"
                                    : "assets/new_profile/light/help.svg",
                                height: 18,
                              ),
                              SizedBox(width: 10,),
                              Text(App_Localization.of(context).translate("about_us"),style: TextStyle(color: App.textColor(),fontSize: 12),)
                            ],
                          ),
                          Icon(Icons.arrow_forward_ios,size: 12, color: App.textColor(),)
                        ],
                      ),
                      SizedBox(height: 15,),
                      Container(color: App.textColor().withOpacity(0.05),width: Get.width - 20 ,height: 1,)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10,),
        GestureDetector(
          onTap: (){
            Global.logout();
          },
          child: Row(
            children: [
              SizedBox(width: 10,),
              Icon(Icons.power_settings_new_outlined,color: App.textColor().withOpacity(0.5),size: 20,),
              SizedBox(width: 10,),
              Text(App_Localization.of(context).translate("sign_out"),style: TextStyle(color: App.textColor().withOpacity(0.5),fontSize: 13),)
            ],
          ),
        ),
        SizedBox(height: 10,),
      ],
    );
  }
  _chooseImage(BuildContext context){
    return SafeArea(

      child: GestureDetector(
        onTap: (){
          //todo
          profileController.showChoose.value = false;
        },
        child: Container(
          color: Colors.black.withOpacity(0.5),
          child: Center(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 180,
                child: Center(
                  child: Container(
                      width: 150,
                      height: 65,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: ()async{
                                //todo camera
                                final XFile? image = await _picker.pickImage(source: ImageSource.camera);
                                profileController.showChoose.value=false;
                                if(image!=null){
                                  profileController.uploadAvatar(image,context);
                                }
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.camera_alt,size: 35,color: App.blue,),
                                  Text(App_Localization.of(context).translate("camera"),style: TextStyle(color: App.blue,fontSize: 11,fontWeight: FontWeight.bold),)
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: ()async{
                                //todo gallery
                                final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
                                profileController.showChoose.value=false;
                                if(image!=null){
                                  profileController.uploadAvatar(image,context);
                                }
                              },
                              child:Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.photo,size: 35,color: App.pink,),
                                  Text(App_Localization.of(context).translate("gallery"),style: TextStyle(color: App.pink,fontSize: 11,fontWeight: FontWeight.bold),)
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  noStatementDialog(){
    return  showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(App_Localization.of(context).translate('no_statement')),
        titleTextStyle: const TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.bold
        ),
        content: Text(
          App_Localization.of(context).translate('request_last_statement'),
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
  noTradeLicense(){
    return  showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(App_Localization.of(context).translate('trad_license')),
        titleTextStyle: const TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.bold
        ),
        content: Text(
          App_Localization.of(context).translate('no_trad_license'),
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
