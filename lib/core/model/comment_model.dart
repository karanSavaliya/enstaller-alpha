// @dart=2.9

class CommentModel {
  int intId;
  int intAppointmentid;
  String strComments;
  bool bisvisibleuser;
  String dteCreatedDate;
  String strCreatedName;
  int intCreatedBy;
  bool bisalive;

  CommentModel(
      {this.intId,
        this.intAppointmentid,
        this.strComments,
        this.bisvisibleuser,
        this.dteCreatedDate,
        this.strCreatedName,
        this.intCreatedBy,
        this.bisalive});

  CommentModel.fromJson(Map<String, dynamic> json) {
    intId = json['intId'];
    intAppointmentid = json['intAppointmentid'];
    strComments = json['strComments'];
    bisvisibleuser = json['bisvisibleuser'];
    dteCreatedDate = json['dteCreatedDate'];
    strCreatedName = json['strCreatedName'];
    intCreatedBy = json['intCreatedBy'];
    bisalive = json['bisalive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['intId'] = this.intId;
    data['intAppointmentid'] = this.intAppointmentid;
    data['strComments'] = this.strComments;
    data['bisvisibleuser'] = this.bisvisibleuser;
    data['dteCreatedDate'] = this.dteCreatedDate;
    data['strCreatedName'] = this.strCreatedName;
    data['intCreatedBy'] = this.intCreatedBy;
    data['bisalive'] = this.bisalive;
    return data;
  }
}