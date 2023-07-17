// @dart=2.9
import 'package:enstaller/core/constant/appconstant.dart';

class UpdateProfile {
  String strFile;
  String intEngineerId;
  String intUserId;
  UpdateProfile({this.strFile, this.intEngineerId, this.intUserId});
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['strfile'] = AppConstants.base64Prefix + this.strFile;
    data['intEngineerId'] = this.intEngineerId;
    data['intUserId'] = this.intUserId;
    return data;
  }
}