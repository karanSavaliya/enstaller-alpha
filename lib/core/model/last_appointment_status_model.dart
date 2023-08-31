class LastAppointmentStatus {
  int? intId;
  String? appointmentEventType;
  int? intAppointmentId;
  String? dteCapturedAt;
  String? strDescription;
  int? intEngineerId;
  int? intCustomerId;
  int? intUserId;

  LastAppointmentStatus(
      {this.intId,
      this.appointmentEventType,
      this.intAppointmentId,
      this.dteCapturedAt,
      this.strDescription,
      this.intEngineerId,
      this.intCustomerId,
      this.intUserId});

  LastAppointmentStatus.fromJson(Map<String, dynamic> json) {
    intId = json['intId'];
    appointmentEventType = json['appointmentEventType'];
    intAppointmentId = json['intAppointmentId'];
    dteCapturedAt = json['dteCapturedAt'];
    strDescription = json['strDescription'];
    intEngineerId = json['intEngineerId'];
    intCustomerId = json['intCustomerId'];
    intUserId = json['intUserId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['intId'] = this.intId;
    data['appointmentEventType'] = this.appointmentEventType;
    data['intAppointmentId'] = this.intAppointmentId;
    data['dteCapturedAt'] = this.dteCapturedAt;
    data['strDescription'] = this.strDescription;
    data['intEngineerId'] = this.intEngineerId;
    data['intCustomerId'] = this.intCustomerId;
    data['intUserId'] = this.intUserId;
    return data;
  }
}
