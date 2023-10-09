// @dart=2.9
import 'package:enstaller/core/constant/api_urls.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:flutter/services.dart';

class ESignDocumentView extends StatefulWidget {
  String doc,signatureBy,date,signature;
  ESignDocumentView({@required this.doc,this.signatureBy,this.date,this.signature});

  @override
  State<ESignDocumentView> createState() => _ESignDocumentViewState();
}

class _ESignDocumentViewState extends State<ESignDocumentView> {
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
      bottomSheet: Container(
        height: 175,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Signature By : ",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(widget.signatureBy),
                ],
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "E-Signature : ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Container(
                    width: 150,
                    height: 90,
                    decoration: new BoxDecoration(
                      image: new DecorationImage(
                        image: NetworkImage(
                          ApiUrls.supplierESignImageUrl + widget.signature,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Signature Date : ",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(widget.date),
                ],
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height / 1.5,
          child: SfPdfViewer.network(
            widget.doc,
          ),
        ),
      ),
    );
  }
} //KARAN (ADD THIS ON LIVE)
