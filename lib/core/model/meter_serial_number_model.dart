// @dart=2.9

class MeterSerialNumber {
  int intId;
  bool bisInstalledOnJob;
  String strSerialNo;

  MeterSerialNumber({this.intId, this.bisInstalledOnJob, this.strSerialNo});

  MeterSerialNumber.fromJson(Map<String, dynamic> json) {
    intId = json['intId'];
    bisInstalledOnJob = json['bisInstalledOnJob'];
    strSerialNo = json['strSerialNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['intId'] = this.intId;
    data['bisInstalledOnJob'] = this.bisInstalledOnJob;
    data['strSerialNo'] = this.strSerialNo;
    return data;
  }
}
