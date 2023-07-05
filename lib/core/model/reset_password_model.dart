// @dart=2.9

class reset_password_model {
  String result;
  int intId;

  reset_password_model({this.result, this.intId});

  reset_password_model.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    intId = json['intId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    data['intId'] = this.intId;
    return data;
  }
}