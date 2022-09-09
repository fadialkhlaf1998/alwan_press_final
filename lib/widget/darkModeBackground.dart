import 'package:alwan_press/helper/myTheme.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class DarkModeBackground extends StatelessWidget {
  const DarkModeBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyTheme.isDarkTheme.value ? Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Lottie.asset(
            'assets/animation/BG.json',
          fit: BoxFit.cover
        ),
        // decoration: const BoxDecoration(
        //     image: DecorationImage(
        //         fit: BoxFit.cover,
        //         image: AssetImage('assets/image/background.png')
        //     )
        // )
    ) : const Text('');
  }
}
