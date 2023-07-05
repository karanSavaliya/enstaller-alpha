// @dart=2.9

import 'package:enstaller/core/constant/app_string.dart';
import 'package:flutter/material.dart';

class PDFOpenModel {
  String intID;
  String bisEngineerRead;
  String isModeifiedBy;
  String intModifiedby;
  String intCompanyId;

  PDFOpenModel(
      {this.intID,
      this.bisEngineerRead,
      this.isModeifiedBy,
      this.intModifiedby,
      @required this.intCompanyId});

  PDFOpenModel.fromJson(Map<String, dynamic> json) {
    intID = json['intID'];
    bisEngineerRead = json['bisEngineerRead'];
    isModeifiedBy = json['isModeifiedBy'];
    intModifiedby = json['intModifiedby'];
    intCompanyId = json[AppStrings.intCompanyIdKey];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['intID'] = this.intID;
    data['bisEngineerRead'] = this.bisEngineerRead;
    data['isModeifiedBy'] = this.isModeifiedBy;
    data['intModifiedby'] = this.intModifiedby;
    data[AppStrings.intCompanyIdKey] = this.intCompanyId;
    return data;
  }
}
