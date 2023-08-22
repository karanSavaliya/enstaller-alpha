class EngineerQualificationModel {
  int? intId;
  int? intQualificationId;
  String? strProductTypeName;
  String? strQualificationName;
  String? strEngQualificationDoc;

  EngineerQualificationModel(
      {this.intId,
        this.intQualificationId,
        this.strProductTypeName,
        this.strQualificationName,
        this.strEngQualificationDoc});

  EngineerQualificationModel.fromJson(Map<String, dynamic> json) {
    intId = json['intId'];
    intQualificationId = json['intQualificationId'];
    strProductTypeName = json['strProductTypeName'];
    strQualificationName = json['strQualificationName'];
    strEngQualificationDoc = json['strEngQualificationDoc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['intId'] = this.intId;
    data['intQualificationId'] = this.intQualificationId;
    data['strProductTypeName'] = this.strProductTypeName;
    data['strQualificationName'] = this.strQualificationName;
    data['strEngQualificationDoc'] = this.strEngQualificationDoc;
    return data;
  }
}