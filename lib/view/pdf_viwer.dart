
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

  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    // final name = basename(widget.src.path);

    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        backgroundColor: Color(0XFF181818),
      ),
      body: Center(
          child:  PDFView(
            filePath: widget.src,
            enableSwipe: true,
            // swipeHorizontal: true,
            autoSpacing: false,
            pageFling: false,
            // onRender: (_pages) {
            //   setState(() {
            //     pages = _pages;
            //     isReady = true;
            //   });
            // },
            onError: (error) {
              print(error.toString());
            },
            onPageError: (page, error) {
              print('$page: ${error.toString()}');
            },
            onViewCreated: (PDFViewController pdfViewController) {
              _controller.complete(pdfViewController);
            },
            // onPageChanged: (int page, int total) {
            //   print('page change: $page/$total');
            // },
          ),
      ),
    );
  }
}
