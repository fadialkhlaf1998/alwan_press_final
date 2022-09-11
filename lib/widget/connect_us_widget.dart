import 'package:alwan_press/helper/myTheme.dart';
import 'package:flutter/material.dart';

class ConnectUsWidget extends StatelessWidget {

  String icon;
  String title;

  ConnectUsWidget({
    required this.icon,
    required this.title,
});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width ,
      height: 100,
      decoration: BoxDecoration(
        color: MyTheme.isDarkTheme.value ?
        Colors.white.withOpacity(0.05) : Colors.white,
        boxShadow: [
          BoxShadow(
            color: MyTheme.isDarkTheme.value ?
            Colors.transparent :
            Colors.grey.withOpacity(0.5),
            blurRadius: 3,
            offset: const Offset(1, 1),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                child:  Image.asset('assets/icons/$icon.png'),
              ),
              Text('$title')
            ],
          ),
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle
                ),
                child:  Image.asset('assets/icons/logo2.png'),
              ),
              Text('ALWAN')
            ],
          )
        ],
      ),
    );
  }
}
