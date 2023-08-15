import 'package:alwan_press/helper/myTheme.dart';
import 'package:flutter/material.dart';

class Logo extends StatelessWidget {

  double size;
  Logo(this.size);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(MyTheme.isDarkTheme.value
            ?"assets/new_logo/dark_logo.png"
            :"assets/new_logo/light_logo.png",
          ),
          fit: BoxFit.fitWidth
        )
      ),
    );
  }


}
