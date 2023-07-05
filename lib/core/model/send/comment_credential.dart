// @dart=2.9

import 'package:enstaller/core/constant/app_string.dart';
import 'package:flutter/material.dart';

class CommentCredential {
  String intappintmentid;
  String strcomments;
  String intCreatedBy;
  String intCompanyId;

  CommentCredential(
      {this.intappintmentid,
      this.strcomments,
      this.intCreatedBy,
      @required this.intCompanyId});

  CommentCredential.fromJson(Map<String, dynamic> json) {
    intappintmentid = json['intappintmentid'];
    strcomments = json['strcomments'];
    intCreatedBy = json['intCreatedBy'];
    intCompanyId = json[AppStrings.intCompanyIdKey];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['intappintmentid'] = this.intappintmentid;
    data['strcomments'] = this.strcomments;
    data['intCreatedBy'] = this.intCreatedBy;
    data[AppStrings.intCompanyIdKey] = this.intCompanyId;
    return data;
  }
}
