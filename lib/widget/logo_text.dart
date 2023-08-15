import 'package:alwan_press/helper/myTheme.dart';
import 'package:flutter/material.dart';

class LogoText extends StatelessWidget {

  double width;
  double? height;
  LogoText(this.width,{this.height});
  @override
  Widget build(BuildContext context) {
    return  Container(
      // height: size * 0.08,
      // width: size * 0.23,
      height: height ,
      width: width,
      decoration: BoxDecoration(
        // color: Colors.red,
          image: DecorationImage(
              fit: BoxFit.fitWidth,
              image: MyTheme.isDarkTheme.value
                  ? const AssetImage('assets/new_logo/dark_text.png')
                  : const AssetImage('assets/new_logo/light_text.png')
          )),
    );
  }


}
