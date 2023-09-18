// @dart=2.9
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mime/mime.dart';
import 'dart:io';

class CommonUtils {
  static CommonUtils _commonUtils = CommonUtils();

  static CommonUtils get commonUtilsInstance => _commonUtils;

  String formatDate2(DateTime dateTime) {
    return DateFormat('yyyy/MM/dd').format(dateTime);
  }

  String currDate(){

    DateTime today = DateTime.now();
    String dateStr = "${today.year}-${today.month}-${today.day}";

    return dateStr;
  }

  String getFileMimeType(String path) {
    return lookupMimeType(path);
  }
}
