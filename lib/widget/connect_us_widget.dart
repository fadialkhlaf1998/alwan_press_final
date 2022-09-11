import 'package:alwan_press/app_localization.dart';
import 'package:alwan_press/helper/myTheme.dart';
import 'package:flutter/material.dart';

class ConnectUsWidget extends StatelessWidget {

  String icon;
  String title;
  VoidCallback followButton;

  ConnectUsWidget({
    required this.icon,
    required this.title,
    required this.followButton
});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width ,
      height: 90,
      padding: const EdgeInsets.symmetric(horizontal: 15),
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Container(
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
                ),
                child:  Image.asset('assets/icons/$icon.png',fit: BoxFit.cover),
              ),
              const SizedBox(width: 10),
              Text(
                  title,
                style: TextStyle(
                  color: Theme.of(context).dividerColor,
                  fontSize: 14
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 28,
                    height: 28,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle
                    ),
                    child:  Image.asset('assets/icons/logo2.png'),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'ALWAN',
                    style: TextStyle(
                        color: Theme.of(context).dividerColor,
                        fontSize: 14
                    ),
                  )
                ],
              ),
              GestureDetector(
                onTap: followButton,
                child: Container(
                  width: 60,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(5)
                  ),
                  child: Center(
                    child: Text(App_Localization.of(context).translate('follow')),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
