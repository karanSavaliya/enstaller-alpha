// @dart=2.9
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:flutter/services.dart';

class DocumentView extends StatelessWidget {
  String doc;
  DocumentView({@required this.doc});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light));
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        title: Text(
          "Document",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: SfPdfViewer.network(
          doc,
        ),
      ),
    );
  }
}
