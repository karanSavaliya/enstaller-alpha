// @dart=2.9

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mime/mime.dart';
import 'dart:typed_data';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'dart:io';


class CommonUtils {
  static CommonUtils _commonUtils = CommonUtils();

  static CommonUtils get commonUtilsInstance => _commonUtils;

// hide keyboard
  hideKeyboard({BuildContext context}) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  double getPercentageSize(
      {BuildContext context, double percentage, bool ofWidth = true}) {
    if (ofWidth) {
      return (MediaQuery.of(context).size.width * percentage) / 100;
    } else {
      return (MediaQuery.of(context).size.height * percentage) / 100;
    }
  }

  TextStyle getTextStyle({Color color, bool isBold = false, num fontSize}) {
    return TextStyle(
        color: color,
        fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
        fontSize: fontSize);
  }

  // default app bar
  AppBar getAppBar(
      {@required BuildContext context,
      String appBarTitle = "", // app bar title
      TextStyle appBarTitleStyle, // app bar title text style
      Function defaultLeadIconPressed, // if default icon set then customize tap
      Widget leadingWidget, // customize leading widget
      IconData
          defaultLeadingIcon, // change leading icon from back pressed to other
      Color
          defaultLeadingIconColor, // change default leading icon color from white to other
      double elevation = 0.5,
      Color backGroundColor, // app bar background color
      bool centerTitle = false,
      List<Widget> actionWidgets,
      bool popScreenOnTapOfLeadingIcon = true, // send it false if you want tap
      Widget appBarTitleWidget}) {
    return AppBar(
      backgroundColor: backGroundColor ?? Colors.blue,
      elevation: elevation,
      centerTitle: centerTitle,
      title: appBarTitleWidget ??
          Text(
            appBarTitle,
            style: appBarTitleStyle ??
                TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                ),
          ),
      leading: leadingWidget ??
          IconButton(
            onPressed: () {
              if (popScreenOnTapOfLeadingIcon == true) {
                Navigator.pop(context);
              }
              if (defaultLeadIconPressed != null) defaultLeadIconPressed();
            },
            icon: Icon(
              defaultLeadingIcon ?? Icons.arrow_back,
              color: defaultLeadingIconColor ?? Colors.white,
            ),
          ),
      actions: actionWidgets,
    );
  }

  String formatDate(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }

  String formatDate2(DateTime dateTime) {
    return DateFormat('yyyy/MM/dd').format(dateTime);
  }

  String currDate(){

    DateTime today = DateTime.now();
    String dateStr = "${today.year}-${today.month}-${today.day}";

    return dateStr;
  }


  String getExensions(var strFileExtension){
     if (strFileExtension == "jpg"){
       return "jpg";
     }else if (strFileExtension == "jpeg"){
       return "jpeg";
     }else if (strFileExtension == "png"){
       return "png";
     }else if (strFileExtension == "doc"){
       return "doc";
     }else if (strFileExtension == "docx"){
       return "docx";
     }else if (strFileExtension == "xlsx"){
       return "xlsx";
     }else if (strFileExtension == "xls"){
       return "xls";
     }else if (strFileExtension == "jfif"){
       return "jfif";
     }else if (strFileExtension == "pjpeg"){
       return "pjpeg";
     }else if (strFileExtension == "pjp"){
       return "pjp";
     }else if (strFileExtension == "jpg"){
       return "jpg";
     }

  }


  String getFileMimeType(String path) {
    return lookupMimeType(path);
  }

  String getFileExtension(String fileName) {
    try {
      return fileName.substring(fileName.lastIndexOf('.'));
    } catch(e){
      return null;
    }
  }







  downloadFile(String url, {String filename}) async {
    var httpClient = http.Client();
    var request = new http.Request('GET', Uri.parse(url));
    var response = httpClient.send(request);
    String dir = (await  getExternalStorageDirectory()).path;

    bool exists = await checkIfFileExists('$dir/$filename');

    if(!exists){

    List<List<int>> chunks = new List();
    int downloaded = 0;

    response.asStream().listen((http.StreamedResponse r) {

      r.stream.listen((List<int> chunk) {
        // Display percentage of completion
        debugPrint('downloadPercentage: ${downloaded / r.contentLength * 100}');

        chunks.add(chunk);
        downloaded += chunk.length;
      }, onDone: () async {
        // Display percentage of completion
        debugPrint('downloadPercentage: ${downloaded / r.contentLength * 100}');

        // Save the file
        File file = new File('$dir/$filename');

        print(file.absolute.path);
        final Uint8List bytes = Uint8List(r.contentLength);
        int offset = 0;
        for (List<int> chunk in chunks) {
          bytes.setRange(offset, offset + chunk.length, chunk);
          offset += chunk.length;
        }
        await file.writeAsBytes(bytes);


        Future.delayed(Duration(seconds: 3), () {
          print("valuesss");
          OpenFile.open(file.absolute.path);
        });



        return;
      });



    });

    }else{


      String dir = (await  getExternalStorageDirectory()).path;

      File file = new File('$dir/$filename');
      Future.delayed(Duration(milliseconds: 500), () {
        print("valuesss");
        OpenFile.open(file.absolute.path);
      });


    }


  }




  Future<bool> checkIfFileExists(String filePath) async {
    File file = File(filePath);
    return await file.exists();
  }




}
