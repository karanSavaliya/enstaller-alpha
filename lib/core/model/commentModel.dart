// @dart=2.9


class commentModel {

  List<AppointmentAttachemnts> appointmentAttachemnts;
  List<AppointmentDetails> appointmentDetails;

  commentModel({this.appointmentAttachemnts, this.appointmentDetails});

  commentModel.fromJson(Map<String, dynamic> json) {
    if (json['appointmentAttachemnts'] != null) {
      appointmentAttachemnts = <AppointmentAttachemnts>[];
      json['appointmentAttachemnts'].forEach((v) {
        appointmentAttachemnts.add(new AppointmentAttachemnts.fromJson(v));
      });
    }
    if (json['appointmentDetails'] != null) {
      appointmentDetails = <AppointmentDetails>[];
      json['appointmentDetails'].forEach((v) {
        appointmentDetails.add(new AppointmentDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.appointmentAttachemnts != null) {
      data['appointmentAttachemnts'] =
          this.appointmentAttachemnts.map((v) => v.toJson()).toList();
    }
    if (this.appointmentDetails != null) {
      data['appointmentDetails'] =
          this.appointmentDetails.map((v) => v.toJson()).toList();
    }
    return data;
  }

}

class AppointmentAttachemnts {
  int intId;
  int intDetailsId;
  int rownumber;
  String strFileName;
  String dteCreatedDate;
  String dteUpdatedDate;
  bool bisalive;

  AppointmentAttachemnts(
      {this.intId,
        this.intDetailsId,
        this.rownumber,
        this.strFileName,
        this.dteCreatedDate,
        this.dteUpdatedDate,
        this.bisalive});

  AppointmentAttachemnts.fromJson(Map<String, dynamic> json) {
    intId = json['intId'];
    intDetailsId = json['intDetailsId'];
    rownumber = json['rownumber'];
    strFileName = json['strFileName'];
    dteCreatedDate = json['dteCreatedDate'];
    dteUpdatedDate = json['dteUpdatedDate'];
    bisalive = json['bisalive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['intId'] = this.intId;
    data['intDetailsId'] = this.intDetailsId;
    data['rownumber'] = this.rownumber;
    data['strFileName'] = this.strFileName;
    data['dteCreatedDate'] = this.dteCreatedDate;
    data['dteUpdatedDate'] = this.dteUpdatedDate;
    data['bisalive'] = this.bisalive;
    return data;
  }
}

class AppointmentDetails {
  int intId;
  int intDetailsId;
  int intAppointmentid;
  String strComments;
  bool bisvisibleuser;
  String dteCreatedDate;
  String dteUpdatedDate;
  String strCreatedName;
  String strUpdatedName;
  int intCreatedBy;
  int intUpdatedby;
  bool bisalive;

  AppointmentDetails(
      {this.intId,
        this.intDetailsId,
        this.intAppointmentid,
        this.strComments,
        this.bisvisibleuser,
        this.dteCreatedDate,
        this.dteUpdatedDate,
        this.strCreatedName,
        this.strUpdatedName,
        this.intCreatedBy,
        this.intUpdatedby,
        this.bisalive});

  AppointmentDetails.fromJson(Map<String, dynamic> json) {
    intId = json['intId'];
    intDetailsId = json['intDetailsId'];
    intAppointmentid = json['intAppointmentid'];
    strComments = json['strComments'];
    bisvisibleuser = json['bisvisibleuser'];
    dteCreatedDate = json['dteCreatedDate'];
    dteUpdatedDate = json['dteUpdatedDate'];
    strCreatedName = json['strCreatedName'];
    strUpdatedName = json['strUpdatedName'];
    intCreatedBy = json['intCreatedBy'];
    intUpdatedby = json['intUpdatedby'];
    bisalive = json['bisalive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['intId'] = this.intId;
    data['intDetailsId'] = this.intDetailsId;
    data['intAppointmentid'] = this.intAppointmentid;
    data['strComments'] = this.strComments;
    data['bisvisibleuser'] = this.bisvisibleuser;
    data['dteCreatedDate'] = this.dteCreatedDate;
    data['dteUpdatedDate'] = this.dteUpdatedDate;
    data['strCreatedName'] = this.strCreatedName;
    data['strUpdatedName'] = this.strUpdatedName;
    data['intCreatedBy'] = this.intCreatedBy;
    data['intUpdatedby'] = this.intUpdatedby;
    data['bisalive'] = this.bisalive;
    return data;
  }
}