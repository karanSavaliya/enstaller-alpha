// @dart=2.9

class AppointmentDetails {
  Appointment appointment;
  Eventdata eventData;

  AppointmentDetails({this.appointment, this.eventData});

  AppointmentDetails.fromJson(Map<String, dynamic> json) {
    appointment = json['appointment'] != null
        ? new Appointment.fromJson(json['appointment'])
        : null;
    eventData = json['eventdata'] != null
        ? new Eventdata.fromJson(json['eventdata'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.appointment != null) {
      data['appointment'] = this.appointment.toJson();
    }
    if (this.eventData != null) {
      data['eventdata'] = this.eventData.toJson();
    }
    return data;
  }
}

class Appointment {
  int intId;
  String strAppointmentType;
  String strJobType;
  String dteBookedDate;
  String dteBookedDateStr;
  String strBookedTime;
  String strSiteAddress;
  String strSiteDateConsent;
  String strSiteCustomerPassword;
  String strSiteCustomerComment;
  int intTimeOnSite;
  String strComment;
  String strBookingReference;
  String strStatus;
  String strBookingStatusType;
  String dteCreatedDate;
  bool bisAbortRequested;
  bool bisAbortRequestApproved;
  int intPriority;
  int intBookedBy;
  bool bisCustomerConfirmed;
  String dteCustomerConfirmedDate;
  int intCustomerId;
  int intSupplierId;
  String strBookedSlotType;
  bool bisIsEmailSendingEnabled;
  bool bisIsSmsSendingEnabled;
  String strContactName;
  String strCompanyName;
  String strLogo;
  String strLogoPath;
  String dteCreatedDateStr;
  int intEngineerId;
  String engineerName;
  String strPostCode;
  String regionPatches;
  String patchCode;
  String strBookedBy;
  String appointmentEventType;
  int intTimeSlotId;
  int intAppointmentTypeId;
  int intJobTypeId;
  String surveyReceived;
  String strEmailActionby;
  int intjumborequestid;
  int intjumboresponseid;
  bool bCompleteForwardCall;
  int intRoutePlanId;
  String strGasCode;
  String strSupplierCode;

  Appointment(
      {this.intId,
      this.strAppointmentType,
      this.strJobType,
      this.dteBookedDate,
      this.dteBookedDateStr,
      this.strBookedTime,
      this.strSiteAddress,
      this.strSiteDateConsent,
      this.strSiteCustomerPassword,
      this.strSiteCustomerComment,
      this.intTimeOnSite,
      this.strComment,
      this.strBookingReference,
      this.strStatus,
      this.strBookingStatusType,
      this.dteCreatedDate,
      this.bisAbortRequested,
      this.bisAbortRequestApproved,
      this.intPriority,
      this.intBookedBy,
      this.bisCustomerConfirmed,
      this.dteCustomerConfirmedDate,
      this.intCustomerId,
      this.intSupplierId,
      this.strBookedSlotType,
      this.bisIsEmailSendingEnabled,
      this.bisIsSmsSendingEnabled,
      this.strContactName,
      this.strCompanyName,
      this.strLogo,
      this.strLogoPath,
      this.dteCreatedDateStr,
      this.intEngineerId,
      this.engineerName,
      this.strPostCode,
      this.regionPatches,
      this.patchCode,
      this.strBookedBy,
      this.appointmentEventType,
      this.intTimeSlotId,
      this.intAppointmentTypeId,
      this.intJobTypeId,
      this.surveyReceived,
      this.strEmailActionby,
      this.intjumborequestid,
      this.intjumboresponseid,
      this.bCompleteForwardCall,
      this.intRoutePlanId,
      this.strGasCode,
      this.strSupplierCode
      });

  Appointment.fromJson(Map<String, dynamic> json) {
    intId = json['intId'];
    strAppointmentType = json['strAppointmentType'];
    strJobType = json['strJobType'];
    dteBookedDate = json['dteBookedDate'];
    dteBookedDateStr = json['dteBookedDate_str'];
    strBookedTime = json['strBookedTime'];
    strSiteAddress = json['strSiteAddress'];
    strSiteDateConsent = json['strSiteDateConsent'];
    strSiteCustomerPassword = json['strSiteCustomerPassword'];
    strSiteCustomerComment = json['strSiteCustomerComment'];
    intTimeOnSite = json['intTimeOnSite'];
    strComment = json['strComment'];
    strBookingReference = json['strBookingReference'];
    strStatus = json['strStatus'];
    strBookingStatusType = json['strBookingStatusType'];
    dteCreatedDate = json['dteCreatedDate'];
    bisAbortRequested = json['bisAbortRequested'];
    bisAbortRequestApproved = json['bisAbortRequestApproved'];
    intPriority = json['intPriority'];
    intBookedBy = json['intBookedBy'];
    bisCustomerConfirmed = json['bisCustomerConfirmed'];
    dteCustomerConfirmedDate = json['dteCustomerConfirmedDate'];
    intCustomerId = json['intCustomerId'];
    intSupplierId = json['intSupplierId'];
    strBookedSlotType = json['strBookedSlotType'];
    bisIsEmailSendingEnabled = json['bisIsEmailSendingEnabled'];
    bisIsSmsSendingEnabled = json['bisIsSmsSendingEnabled'];
    strContactName = json['strContactName'];
    strCompanyName = json['strCompanyName'];
    strLogo = json['strLogo'];
    strLogoPath = json['strLogoPath'];
    dteCreatedDateStr = json['dteCreatedDate_str'];
    intEngineerId = json['intEngineerId'];
    engineerName = json['engineerName'];
    strPostCode = json['strPostCode'];
    regionPatches = json['regionPatches'];
    patchCode = json['patchCode'];
    strBookedBy = json['strBookedBy'];
    appointmentEventType = json['appointmentEventType'];
    intTimeSlotId = json['intTimeSlotId'];
    intAppointmentTypeId = json['intAppointmentTypeId'];
    intJobTypeId = json['intJobTypeId'];
    surveyReceived = json['surveyReceived'];
    strEmailActionby = json['strEmailActionby'];
    intjumborequestid = json['jumborequest_id'];
    intjumboresponseid = json['jumboresponse_id'];
    bCompleteForwardCall = json["bCompleteForwardCall"];
    intRoutePlanId = json["intRoutePlanId"];
    strGasCode = json["strGasCode"];
    strSupplierCode = json["strSupplierCode"];
  }

  Map<String, dynamic> toJson() {

    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['intId'] = this.intId;
    data['strAppointmentType'] = this.strAppointmentType;
    data['strJobType'] = this.strJobType;
    data['dteBookedDate'] = this.dteBookedDate;
    data['dteBookedDate_str'] = this.dteBookedDateStr;
    data['strBookedTime'] = this.strBookedTime;
    data['strSiteAddress'] = this.strSiteAddress;
    data['strSiteDateConsent'] = this.strSiteDateConsent;
    data['strSiteCustomerPassword'] = this.strSiteCustomerPassword;
    data['strSiteCustomerComment'] = this.strSiteCustomerComment;
    data['intTimeOnSite'] = this.intTimeOnSite;
    data['strComment'] = this.strComment;
    data['strBookingReference'] = this.strBookingReference;
    data['strStatus'] = this.strStatus;
    data['strBookingStatusType'] = this.strBookingStatusType;
    data['dteCreatedDate'] = this.dteCreatedDate;
    data['bisAbortRequested'] = this.bisAbortRequested;
    data['bisAbortRequestApproved'] = this.bisAbortRequestApproved;
    data['intPriority'] = this.intPriority;
    data['intBookedBy'] = this.intBookedBy;
    data['bisCustomerConfirmed'] = this.bisCustomerConfirmed;
    data['dteCustomerConfirmedDate'] = this.dteCustomerConfirmedDate;
    data['intCustomerId'] = this.intCustomerId;
    data['intSupplierId'] = this.intSupplierId;
    data['strBookedSlotType'] = this.strBookedSlotType;
    data['bisIsEmailSendingEnabled'] = this.bisIsEmailSendingEnabled;
    data['bisIsSmsSendingEnabled'] = this.bisIsSmsSendingEnabled;
    data['strContactName'] = this.strContactName;
    data['strCompanyName'] = this.strCompanyName;
    data['strLogo'] = this.strLogo;
    data['strLogoPath'] = this.strLogoPath;
    data['dteCreatedDate_str'] = this.dteCreatedDateStr;
    data['intEngineerId'] = this.intEngineerId;
    data['engineerName'] = this.engineerName;
    data['strPostCode'] = this.strPostCode;
    data['regionPatches'] = this.regionPatches;
    data['patchCode'] = this.patchCode;
    data['strBookedBy'] = this.strBookedBy;
    data['appointmentEventType'] = this.appointmentEventType;
    data['intTimeSlotId'] = this.intTimeSlotId;
    data['intAppointmentTypeId'] = intAppointmentTypeId;
    data['intJobTypeId'] = intJobTypeId;
    data['surveyReceived'] = surveyReceived;
    data['strEmailActionby'] = strEmailActionby;
    data['jumborequest_id'] = intjumborequestid;
    data['jumboresponse_id'] = intjumboresponseid;
    data["bCompleteForwardCall"] = bCompleteForwardCall;
    data["intRoutePlanId"] = intRoutePlanId;
    data["strGasCode"] = strGasCode;
    data["strSupplierCode"] = strSupplierCode;

    return data;
  }
}

class Eventdata {
  String appointmentEventType;
  String dteCapturedAt;
  int intEngineerId;
  String engineerName;
  String strDescription;

  Eventdata(
      {this.appointmentEventType,
      this.dteCapturedAt,
      this.intEngineerId,
      this.engineerName,
      this.strDescription});

  Eventdata.fromJson(Map<String, dynamic> json) {
    appointmentEventType = json['appointmentEventType'];
    dteCapturedAt = json['dteCapturedAt'];
    intEngineerId = json['intEngineerId'];
    engineerName = json['engineerName'];
    strDescription = json['strDescription'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['appointmentEventType'] = this.appointmentEventType;
    data['dteCapturedAt'] = this.dteCapturedAt;
    data['intEngineerId'] = this.intEngineerId;
    data['engineerName'] = this.engineerName;
    data['strDescription'] = this.strDescription;
    return data;
  }

}
