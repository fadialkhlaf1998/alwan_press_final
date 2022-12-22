import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageViewerPage extends StatefulWidget {
  String src;
  ImageViewerPage(this.src);

  @override
  State<ImageViewerPage> createState() => _ImageViewerPageState();
}

class _ImageViewerPageState extends State<ImageViewerPage> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: const Color(0XFF181818),
      ),
      body: Center(
        child:  Container(
          width: Get.width,
          decoration: BoxDecoration(
            image: DecorationImage(image: NetworkImage(widget.src),fit: BoxFit.contain)
          ),
        ),
      ),
    );
  }
}