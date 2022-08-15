import 'package:alwan_press/app_localization.dart';
import 'package:alwan_press/helper/app.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/image/background.png')
              )
          ),
        child: Column(
          children: [
            _header(context),
            SizedBox(height: 50),
            _body(context)
          ],
        )
      ),
    );
  }
}

_header(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Container(
          margin: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top,left: 15,right: 15),
          height: MediaQuery.of(context).size.height * 0.1,
          child: Icon(Icons.arrow_back_ios_outlined,color: Colors.white,size: 30,),
        ),
      ),
      Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.4,
          height: MediaQuery.of(context).size.width * 0.4,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Image.asset("assets/image/forget_password.png",
              width: MediaQuery.of(context).size.width * 0.2,
              color: Colors.white,
            ),
          ),
        ),
      ),
      SizedBox(height: 20),
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(App_Localization.of(context).translate("forget_password"),
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 25
              ),
            ),
          ),
          SizedBox(height: 20),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Center(
              child: Text(App_Localization.of(context).translate("enter_your_email"),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      )
    ],
  );
}
_body(BuildContext context) {
  return Column(
    children: [
      Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: 70,
        color: Colors.transparent,
        child: TextField(
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(width: 1, color: Colors.white),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(width: 1, color: Colors.white),
              ),
              label: Text(App_Localization.of(context).translate("email"), style: TextStyle(color: Colors.white))
          ),
        ),
      ),
      const SizedBox(height: 30),
      GestureDetector(
        onTap: (){
          //todo api forget password
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: 60,
          decoration: BoxDecoration(
              color: App.pink,
              borderRadius: BorderRadius.circular(10)
          ),
          child: Center(
            child: Text(App_Localization.of(context).translate("submit"),style: TextStyle(color: Colors.white,fontSize: 18)),
          ),
        ),
      ),
    ],
  );
}
