import 'dart:async';
import 'dart:io';
import 'package:alwan_press/app_localization.dart';
import 'package:alwan_press/controller/ProfileController.dart';
import 'package:alwan_press/controller/intro_controller.dart';
import 'package:alwan_press/controller/main_class_controller.dart';
import 'package:alwan_press/helper/app.dart';
import 'package:alwan_press/helper/global.dart';
import 'package:alwan_press/helper/myTheme.dart';
import 'package:alwan_press/view/address_2.dart';
import 'package:alwan_press/view/contact_information.dart';
import 'package:alwan_press/view/pdf_viwer.dart';
import 'package:alwan_press/view/sign_in.dart';
import 'package:alwan_press/widget/darkModeBackground.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:url_launcher/url_launcher.dart';

class Profile extends StatefulWidget {
  Profile(){

  }

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  _ProfileState(){
    if(Global.user!=null){
      profileController.name.text = Global.user!.name;
      profileController.email.text = Global.user!.email;
      profileController.phone.text = Global.user!.phone.length>6&&Global.user!.phone.contains("+971")?Global.user!.phone.split("+971")[1]:"";
    }
  }
  IntroController introController = Get.find();
  ProfileController profileController = Get.find();
  MainClassController mainClassController = Get.find();
  final ImagePicker _picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: MyTheme.isDarkTheme.value?Color(0XFF181818):Colors.white
    ));
    return Obx(() => Scaffold(
        // resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
           DarkModeBackground(),
            SingleChildScrollView(
              child: Column(
                children: [
                  _logo(context),
                  const SizedBox(height: 10),
                  _body(context)
                ],
              ),
            ),
            profileController.showChoose.value?_chooseImage(context):Center(),
          ],
        ),
      ),
    ));
  }
  _header(BuildContext context){
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              GestureDetector(
                onTap: () {
                  // mainClassController.selectedIndex.value = 0;
                  // mainClassController.pageController.animateToPage(0,
                  //     duration: const Duration(milliseconds: 700), curve: Curves.fastOutSlowIn);
                  mainClassController.bottomBarController.jumpToTab(0);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.17,
                  height: MediaQuery.of(context).size.width * 0.17,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/icons/logo2.png')
                      )
                  ),
                ),
              ),

            ],
          ),
        ],
      ),
    );
  }
  _body(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.height * 0.7,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [

              profileController.loading.value
                  ? _loading(context)
                  : Global.user == null?
                    Container(
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
                    )
                  :Column(
                      children: [
                        _slider(context),
                        Text(Global.user!.name,style: TextStyle(color: MyTheme.isDarkTheme.value?Colors.white:Colors.black,fontSize: 16,fontWeight: FontWeight.bold),),
                        const SizedBox(height: 15),
                        _optionBar(context),
                        const SizedBox(height: 15),
                        _details(context),
                        const SizedBox(height: 25),
                        _contactHelp(context),
                      ],
                   )

            ],
          ),

        ],
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

      ],
    ));
  }
  _emailTextField(context,TextEditingController textEditingController,String hint){
    return  Container(

      width: MediaQuery.of(context).size.width * 0.9,
      height: 40,
      color: Colors.transparent,
      child: TextField(
        onChanged: (q){
          profileController.onChange();
        },
        controller: textEditingController,
        style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black,fontSize: 12,height: 1),
        // textAlign: TextAlign.start,
        decoration: InputDecoration(
            // prefixText: 'Nike name: ',
            // prefixStyle: TextStyle(
            //     color: Theme.of(context).dividerColor
            // ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(width: 1, color: profileController.validate.value&&(textEditingController.text.isEmpty||!RegExp(r'\S+@\S+\.\S+').hasMatch(textEditingController.text))?Colors.red:MyTheme.isDarkTheme.value ? Colors.white : Colors.black),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:  BorderSide(width: 1, color: profileController.validate.value&&(textEditingController.text.isEmpty||!RegExp(r'\S+@\S+\.\S+').hasMatch(textEditingController.text))?Colors.red:MyTheme.isDarkTheme.value ? Colors.white : Colors.black),
            ),

            label: Text(App_Localization.of(context).translate(hint),
                style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black,fontSize: 12))
        ),
      ),
    );
  }
  _textField(context,TextEditingController textEditingController,String hint){
    return  Container(

      width: MediaQuery.of(context).size.width * 0.9,
      height: 40,
      color: Colors.transparent,
      child: TextField(
        onChanged: (q){
          profileController.onChange();
        },
        controller: textEditingController,
        style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black,fontSize: 12,height: 1),
        // textAlign: TextAlign.start,
        decoration: InputDecoration(
            // prefixText: 'Nike name: ',
            // prefixStyle: TextStyle(
            //     color: Theme.of(context).dividerColor
            // ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(width: 1, color: profileController.validate.value&&(textEditingController.text.isEmpty)?Colors.red:MyTheme.isDarkTheme.value ? Colors.white : Colors.black),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:  BorderSide(width: 1, color: profileController.validate.value&&textEditingController.text.isEmpty?Colors.red:MyTheme.isDarkTheme.value ? Colors.white : Colors.black),
            ),

            label: Text(App_Localization.of(context).translate(hint),
                style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black,fontSize: 12))
        ),
      ),
    );
  }
  _phone(context){
    return  Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 40,
      color: Colors.transparent,
      child: TextField(
        onChanged: (q){
          profileController.onChange();
        },
        keyboardType: TextInputType.phone,
        controller: profileController.phone,
        style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black,fontSize: 12,height: 1),
        maxLength: 9,
        decoration: InputDecoration(
            counterText: '',
            prefixText: '+971 ',
            prefixStyle:  TextStyle(
              color: Theme.of(context).dividerColor,fontSize: 12,height: 1
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(width: 1, color:  profileController.validate.value&&profileController.phone.text.isEmpty?Colors.red:MyTheme.isDarkTheme.value ? Colors.white : Colors.black),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:  BorderSide(width: 1, color:  profileController.validate.value&&profileController.phone.text.isEmpty?Colors.red:MyTheme.isDarkTheme.value ? Colors.white : Colors.black),
            ),
            label: Text(App_Localization.of(context).translate("phone"),
                style: TextStyle(color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black))
        ),
      ),
    );
  }
  _logo(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          curve: Curves.fastOutSlowIn,
          width: MediaQuery.of(context).size.width * 0.12,
          child: GestureDetector(
            onTap: () {
              // homeController.move();
              // _scaffoldkey.currentState!.closeEndDrawer();
              mainClassController.bottomBarController.jumpToTab(0);
            },
            child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.12,
                height: MediaQuery.of(context).size.width * 0.12,
                child: Image.asset(
                  'assets/icons/Logo-Header.png',
                  fit: BoxFit.cover,
                )),
          ),
        ),
        const SizedBox(width: 7),
        Container(
          height: MediaQuery.of(context).size.width * 0.1,
          width: MediaQuery.of(context).size.width * 0.28,
          decoration: BoxDecoration(
            // color: Colors.red,
              image: DecorationImage(
                  fit: BoxFit.contain,
                  image: MyTheme.isDarkTheme.value ? const AssetImage('assets/icons/logo_text.png') : const AssetImage('assets/icons/logo_text_black.png')
              )),
        )
      ],
    );
  }
  _loading(BuildContext context){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height*0.4,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
  _slider(context){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width * 0.4/3*2+25,
      child:  GestureDetector(
        onTap: () {
          //todo edit image

        },
        child: Container(
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              (Global.user!.image=="")?
              CircleAvatar(
                child: Icon(Icons.person,color: MyTheme.isDarkTheme.value?Colors.white:Colors.black,size: MediaQuery.of(context).size.width * 0.4/2,),
                backgroundColor: Colors.grey,
                radius: MediaQuery.of(context).size.width * 0.4/3,
              )
                  :Stack(
                    children: [
                      GestureDetector(

                        child: Container(
                          height:  MediaQuery.of(context).size.width * 0.4/3*2 +20,
                          child: Center(
                            child: GestureDetector(
                              onTap: (){
                                profileController.showChoose.value = true;
                              },
                              child: CircleAvatar(
                                backgroundColor: Colors.grey,
                                backgroundImage: NetworkImage(Global.user!.image),
                                radius: MediaQuery.of(context).size.width * 0.4/3,
                              ),
                            )
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){

                        },
                        child: Container(
                          height:  MediaQuery.of(context).size.width * 0.4/3*2 +20,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: GestureDetector(
                              onTap: (){
                                profileController.showChoose.value = true;
                              },
                              child: CircleAvatar(
                                backgroundColor: MyTheme.isDarkTheme.value?Colors.white:Colors.black,
                                child: Icon(Icons.edit,color: MyTheme.isDarkTheme.value?Colors.black:Colors.white,size: 20,),
                                radius: 13,
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
  _optionBar(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: GestureDetector(
                onTap: () async {
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
                  color: Colors.transparent,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 25,
                        height: 25,
                        child: SvgPicture.asset("assets/icons/invoice.svg",
                            color: MyTheme.isDarkTheme.value ? Colors.white :
                            Colors.black
                        ),
                      ),
                      Center(
                          child: Text(App_Localization.of(context).translate("my_statement"),
                              style: TextStyle(
                                  color: MyTheme.isDarkTheme.value ? Colors.white :
                                  Colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold
                              )
                          )
                      )
                    ],
                  ),
                )
            ),
          ),
          VerticalDivider(
            color: MyTheme.isDarkTheme.value ? Colors.white.withOpacity(0.5) :
            Colors.black.withOpacity(0.5),
            width: 1,
            thickness: 1,
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                Get.to(()=>Addresses_2(-1));
              },
              child: Container(
                color: Colors.transparent,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      child: SvgPicture.asset("assets/icons/address.svg",
                          color: MyTheme.isDarkTheme.value ? Colors.white :
                          Colors.black
                      ),
                    ),
                    Center(child: Text(App_Localization.of(context).translate("my_address"),
                        style: TextStyle(
                            color: MyTheme.isDarkTheme.value ? Colors.white :
                            Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.bold
                        )
                    )
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  _contactHelp(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      // height: 50,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          profileController.dataUpdated.value?Column(
            children: [
              GestureDetector(
                  onTap: () {
                    //todo save data
                    print('/*/*');
                          profileController.updateData(context);
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
          GestureDetector(
              onTap: () {

               Get.to(()=>ContactInformation());
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 40,
                decoration: BoxDecoration(
                    color: Theme.of(context).disabledColor,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.call,
                      color: Theme.of(context).backgroundColor,
                    ),
                    const SizedBox(width: 10),
                    Center(child: Text(App_Localization.of(context).translate("connect_with_us"),
                        style: TextStyle(
                            fontSize: 15,
                            color: Theme.of(context).backgroundColor,
                            fontWeight: FontWeight.bold
                        )
                    )
                    )
                  ],
                ),
              )
          ),
          SizedBox(height: 10,),
          GestureDetector(
              onTap: () {
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
                width: MediaQuery.of(context).size.width * 0.9,
                height: 40,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
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
                          Icons.update_outlined,
                          color:  Colors.white,
                          size: 28,)
                    ),
                    const SizedBox(width: 10),
                    Center(
                        child: Text(App_Localization.of(context).translate("req_last_state"),
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
          GestureDetector(
              onTap: () {
                Global.logout();
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 40,
                decoration: BoxDecoration(
                    color: App.pink,
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
                          Icons.logout,
                          color:  Colors.white,
                          size: 28,)
                    ),
                    const SizedBox(width: 10),
                    Center(
                        child: Text(App_Localization.of(context).translate("logout"),
                            style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                            )))
                  ],
                ),
              )
          ),
        ],
      ),
    );
  }
  _socialMedia(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.65,
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              //todo
            },
            child: Container(
              width: 22,
              height: 22,
              child: SvgPicture.asset("assets/icons/instagram.svg",
                color: MyTheme.isDarkTheme.value ? Colors.white :
                Colors.black,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              //todo
            },
            child: Container(
              width: 22,
              height: 22,
              child: SvgPicture.asset("assets/icons/twitter.svg",
                color: MyTheme.isDarkTheme.value ? Colors.white :
                Colors.black,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              //todo
            },
            child: Container(
              width: 22,
              height: 22,
              child: SvgPicture.asset("assets/icons/facebook.svg",
                color: MyTheme.isDarkTheme.value ? Colors.white :
                Colors.black,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              //todo
            },
            child: Container(
              width: 22,
              height: 22,
              child: SvgPicture.asset("assets/icons/youtube.svg",
                color: MyTheme.isDarkTheme.value ? Colors.white :
                Colors.black,
              ),
            ),
          )
        ],
      ),
    );
  }
  _terms(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.7,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap:() {
                  //todo
                },
                child: Text(App_Localization.of(context).translate("privacy_policy"),
                  style: TextStyle(
                      color: MyTheme.isDarkTheme.value ? Colors.white :
                      Colors.black,
                      fontSize: 11,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Text(".",style: TextStyle(
                  color: MyTheme.isDarkTheme.value ? Colors.white :
                  Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.bold
              ),),
              GestureDetector(
                onTap:() {
                  //todo
                },
                child: Text(App_Localization.of(context).translate("terms_of_sale"),
                  style: TextStyle(
                      color: MyTheme.isDarkTheme.value ? Colors.white :
                      Colors.black,
                      fontSize: 11,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Text(".",style: TextStyle(
                  color: MyTheme.isDarkTheme.value ? Colors.white :
                  Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.bold
              ),),
              GestureDetector(
                onTap:() {
                  //todo
                },
                child: Text(App_Localization.of(context).translate("terms_of_use"),
                  style: TextStyle(
                      color: MyTheme.isDarkTheme.value ? Colors.white :
                      Colors.black,
                      fontSize: 11,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20,),
        Container(
          width: MediaQuery.of(context).size.width * 0.6,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap:() {
                  //todo
                },
                child: Text(App_Localization.of(context).translate("return_policy"),
                  style: TextStyle(
                      color: MyTheme.isDarkTheme.value ? Colors.white :
                      Colors.black,
                      fontSize: 11,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Text(".",style: TextStyle(
                  color: MyTheme.isDarkTheme.value ? Colors.white :
                  Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.bold
              ),),
              GestureDetector(
                onTap:() {
                  //todo
                },
                child: Text(App_Localization.of(context).translate("warranty_policy"),
                  style: TextStyle(
                      color: MyTheme.isDarkTheme.value ? Colors.white :
                      Colors.black,
                      fontSize: 11,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20,),
        Text("© 2018 alwan_press. ALL RIGHTS RESERVED.",
          style: TextStyle(
              color: MyTheme.isDarkTheme.value ? Colors.white :
              Colors.black,
              fontSize: 11,
              fontWeight: FontWeight.bold
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

}



