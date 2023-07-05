// @dart=2.9

import 'package:enstaller/core/constant/app_string.dart';
import 'package:flutter/cupertino.dart';

class AppointmentStatusUpdateCredentials {
  String intId;
  String intEngineerId;
  String intBookedBy;
  String strStatus;
  String strEmailActionby;
  String intCompanyId;
  String intUserId;
  AppointmentStatusUpdateCredentials(
      {this.intId,
      this.intEngineerId,
      this.intBookedBy,
      this.strStatus,
      @required this.intCompanyId,
      @required this.strEmailActionby,
      @required this.intUserId});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['intId'] = this.intId;
    data['intEngineerId'] = this.intEngineerId;
    data['intBookedBy'] = this.intBookedBy;
    data['strStatus'] = this.strStatus;
    data['strEmailActionby'] = this.strEmailActionby;
    data[AppStrings.intCompanyIdKey] = this.intCompanyId;
    data['intUserId'] = this.intUserId;
    return data;
  }
}
