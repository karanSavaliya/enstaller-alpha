// @dart=2.9


class AgentReportModel {
  int intId;
  String strName;

  AgentReportModel({
    this.intId,
    this.strName,
  });

  AgentReportModel.fromJson(Map<String, dynamic> json) {
    intId = json['intId'];
    strName = json['strName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['intId'] = this.intId;
    data['strName'] = this.strName;
    return data;
  }
}
