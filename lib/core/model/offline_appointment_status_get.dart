class OfflineAppointmentStatusGetModel {
  int? intAppointmentId;
  String? strSectionName;

  OfflineAppointmentStatusGetModel({this.intAppointmentId, this.strSectionName});

  OfflineAppointmentStatusGetModel.fromJson(Map<String, dynamic> json) {
    intAppointmentId = json['intAppointmentId'];
    strSectionName = json['strSectionName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['intAppointmentId'] = this.intAppointmentId;
    data['strSectionName'] = this.strSectionName;
    return data;
  }
}