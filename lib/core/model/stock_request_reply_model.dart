// @dart=2.9

import 'package:enstaller/core/constant/app_string.dart';
import 'package:enstaller/core/model/serial_model.dart';
import 'package:flutter/material.dart';

class StockRequestReplyModel {
  List<SerialNoModel> listSerials;
  int intRequestId;
  String strComments;
  String intCompanyId;

  StockRequestReplyModel(
      {this.listSerials,
      this.intRequestId,
      this.strComments,
      @required this.intCompanyId});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['strComments'] = strComments;
    data['intRequestId'] = intRequestId.toString();
    data['listSerials'] = listSerials.map((e) => e.toJson()).toList();
    data[AppStrings.intCompanyIdKey] = intCompanyId;
    return data;
  }
}
