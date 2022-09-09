
import 'dart:async';
import 'dart:io';

import 'package:alwan_press/helper/myTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';


class PdfViewerPage extends StatefulWidget {
  String src;
  PdfViewerPage(this.src);

  @override
  State<PdfViewerPage> createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
  final Completer<PDFViewController> _controller =
  Completer<PDFViewController>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: const Color(0XFF181818),
      ),
      body: Center(
          child:  PDFView(
            filePath: widget.src,
            enableSwipe: true,
            autoSpacing: false,
            pageFling: false,
            onError: (error) {
              print(error.toString());
            },
            onPageError: (page, error) {
              print('$page: ${error.toString()}');
            },
            onViewCreated: (PDFViewController pdfViewController) {
              _controller.complete(pdfViewController);
            },
          ),
      ),
    );
  }
}
