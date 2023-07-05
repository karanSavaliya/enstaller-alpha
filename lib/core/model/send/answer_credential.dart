// @dart=2.9

import 'package:enstaller/core/constant/app_string.dart';
import 'package:flutter/cupertino.dart';

class AnswerCredential {
  String intappointmentid;
  String intsurveyid;
  String intsurveyquetionid;
  String stranswer;
  String intcreatedby;
  bool bisalive;
  String strfilename;
  String strRequireExplaination;

  AnswerCredential(
      {this.intappointmentid,
      this.intsurveyid,
      this.intsurveyquetionid,
      this.stranswer,
      this.intcreatedby,
      this.bisalive,
      this.strfilename,
      @required this.strRequireExplaination});

  AnswerCredential.fromJson(Map<String, dynamic> json) {
    intappointmentid = json['intappointmentid'];
    intsurveyid = json['intsurveyid'];
    intsurveyquetionid = json['intsurveyquetionid'];
    stranswer = json['stranswer'];
    intcreatedby = json['intcreatedby'];
    bisalive = json['bisalive'];
    strfilename = json['strfilename'];
    strRequireExplaination = json['strRequireExplaination'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['intappointmentid'] = this.intappointmentid;
    data['intsurveyid'] = this.intsurveyid;
    data['intsurveyquetionid'] = this.intsurveyquetionid;
    data['stranswer'] = this.stranswer;
    data['intcreatedby'] = this.intcreatedby;
    data['"bisalive"'] = this.bisalive;
    data['strfilename'] = this.strfilename;
    data['strRequireExplaination'] = this.strRequireExplaination;

    return data;
  }
//  Map<String, dynamic> toJson() => <String, dynamic>{
//    'intappointmentid': intappointmentid,
//    'intsurveyid': intsurveyid,
//    'intsurveyquetionid': intsurveyquetionid,
//    'stranswer': stranswer,
//    'intcreatedby': intcreatedby,
//    'bisalive': bisalive,
//    'strfilename': strfilename,
//
//  };
}

class AbortAppointmentReasonModel {
  int intId;
  bool isabort;
  String strCancellationReason;
  String intCompanyId;

  AbortAppointmentReasonModel(
      {this.intId,
      this.isabort,
      this.strCancellationReason,
      @required this.intCompanyId});

  AbortAppointmentReasonModel.fromJson(Map<String, dynamic> json) {
    intId = json['intId'];
    isabort = json['isabort'];
    strCancellationReason = json['strCancellationReason'];
    intCompanyId = json[AppStrings.intCompanyIdKey];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['intId'] = this.intId;
    data['isabort'] = this.isabort;
    data['strCancellationReason'] = this.strCancellationReason;
    data[AppStrings.intCompanyIdKey] = this.intCompanyId;
    return data;
  }
}

class GlobalVar {
  static String abortReason = "";
  static String warehosueID = "40056";
  static bool bisNonTechnical = false;
  static int roleId = 0;
  static bool isloadAppointmentDetail = false;
  static bool isloadDashboard = false;
  static int gasCloseJob = 0;
  static int elecCloseJob = 0;
  static bool closejobsubmittedoffline = false;
  static bool offilineSSubmittionStarted = false;
}
