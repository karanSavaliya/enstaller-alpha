class Appointment2 {
  Appointment2({
    required this.table,
    required this.table1,
  });
  late final List<Table> table;
  late final List<Table1> table1;

  Appointment2.fromJson(Map<String, dynamic> json){
    table = List.from(json['table']).map((e)=>Table.fromJson(e)).toList();
    table1 = List.from(json['table1']).map((e)=>Table1.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['table'] = table.map((e)=>e.toJson()).toList();
    _data['table1'] = table1.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Table {
  Table({
    required this.intId,
    required this.strAppointmentType,
    required this.strJobType,
    required this.dteBookedDateStr,
    required this.dteBookedDate,
    required this.strBookedTime,
    required this.strSiteAddress,
    required this.strSiteDateConsent,
    required this.strSiteCustomerPassword,
    required this.strSiteCustomerComment,
    required this.intTimeOnSite,
    required this.strComment,
    required this.strBookingReference,
    required this.strStatus,
    required this.strBookingStatusType,
    required this.dteCreatedDateStr,
    required this.intPriority,
    required this.intBookedBy,
    required this.bisCustomerConfirmed,
    required this.dteCustomerConfirmedDate,
    required this.intCustomerId,
    required this.intSupplierId,
    required this.strBookedSlotType,
    required this.bisIsEmailSendingEnabled,
    required this.bisIsSmsSendingEnabled,
    this.strBookingChannel,
    this.dteClosedAt,
    this.strCancellationComment,
    this.strCancellationReason,
    required this.strContactName,
    required this.strPostCode,
    required this.strCompanyName,
    required this.strLogo,
    required this.intEngineerId,
    required this.engineerName,
    required this.patchCode,
    required this.decJobTimeHours,
    required this.appointmentEventType,
    required this.bisEnroute,
    this.intRoutePlanId,
  });
  late final int intId;
  late final String strAppointmentType;
  late final String strJobType;
  late final String dteBookedDateStr;
  late final String dteBookedDate;
  late final String strBookedTime;
  late final String strSiteAddress;
  late final String strSiteDateConsent;
  late final String strSiteCustomerPassword;
  late final String strSiteCustomerComment;
  late final int intTimeOnSite;
  late final String strComment;
  late final String strBookingReference;
  late final String strStatus;
  late final String strBookingStatusType;
  late final String dteCreatedDateStr;
  late final int intPriority;
  late final int intBookedBy;
  late final bool bisCustomerConfirmed;
  late final String dteCustomerConfirmedDate;
  late final int intCustomerId;
  late final int intSupplierId;
  late final String strBookedSlotType;
  late final bool bisIsEmailSendingEnabled;
  late final bool bisIsSmsSendingEnabled;
  late final Null strBookingChannel;
  late final Null dteClosedAt;
  late final Null strCancellationComment;
  late final Null strCancellationReason;
  late final String strContactName;
  late final String strPostCode;
  late final String strCompanyName;
  late final String strLogo;
  late final int intEngineerId;
  late final String engineerName;
  late final String patchCode;
  late final int decJobTimeHours;
  late final String appointmentEventType;
  late final int bisEnroute;
  late final int? intRoutePlanId;

  Table.fromJson(Map<String, dynamic> json){
    intId = json['intId'];
    strAppointmentType = json['strAppointmentType'];
    strJobType = json['strJobType'];
    dteBookedDateStr = json['dteBookedDate_str'];
    dteBookedDate = json['dteBookedDate'];
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
    dteCreatedDateStr = json['dteCreatedDate_str'];
    intPriority = json['intPriority'];
    intBookedBy = json['intBookedBy'];
    bisCustomerConfirmed = json['bisCustomerConfirmed'];
    dteCustomerConfirmedDate = json['dteCustomerConfirmedDate'];
    intCustomerId = json['intCustomerId'];
    intSupplierId = json['intSupplierId'];
    strBookedSlotType = json['strBookedSlotType'];
    bisIsEmailSendingEnabled = json['bisIsEmailSendingEnabled'];
    bisIsSmsSendingEnabled = json['bisIsSmsSendingEnabled'];
    strBookingChannel = null;
    dteClosedAt = null;
    strCancellationComment = null;
    strCancellationReason = null;
    strContactName = json['strContactName'];
    strPostCode = json['strPostCode'];
    strCompanyName = json['strCompanyName'];
    strLogo = json['strLogo'];
    intEngineerId = json['intEngineerId'];
    engineerName = json['engineerName'];
    patchCode = json['patchCode'];
    decJobTimeHours = json['decJobTimeHours'];
    appointmentEventType = json['appointmentEventType'];
    bisEnroute = json['bisEnroute'];
    intRoutePlanId = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['intId'] = intId;
    _data['strAppointmentType'] = strAppointmentType;
    _data['strJobType'] = strJobType;
    _data['dteBookedDate_str'] = dteBookedDateStr;
    _data['dteBookedDate'] = dteBookedDate;
    _data['strBookedTime'] = strBookedTime;
    _data['strSiteAddress'] = strSiteAddress;
    _data['strSiteDateConsent'] = strSiteDateConsent;
    _data['strSiteCustomerPassword'] = strSiteCustomerPassword;
    _data['strSiteCustomerComment'] = strSiteCustomerComment;
    _data['intTimeOnSite'] = intTimeOnSite;
    _data['strComment'] = strComment;
    _data['strBookingReference'] = strBookingReference;
    _data['strStatus'] = strStatus;
    _data['strBookingStatusType'] = strBookingStatusType;
    _data['dteCreatedDate_str'] = dteCreatedDateStr;
    _data['intPriority'] = intPriority;
    _data['intBookedBy'] = intBookedBy;
    _data['bisCustomerConfirmed'] = bisCustomerConfirmed;
    _data['dteCustomerConfirmedDate'] = dteCustomerConfirmedDate;
    _data['intCustomerId'] = intCustomerId;
    _data['intSupplierId'] = intSupplierId;
    _data['strBookedSlotType'] = strBookedSlotType;
    _data['bisIsEmailSendingEnabled'] = bisIsEmailSendingEnabled;
    _data['bisIsSmsSendingEnabled'] = bisIsSmsSendingEnabled;
    _data['strBookingChannel'] = strBookingChannel;
    _data['dteClosedAt'] = dteClosedAt;
    _data['strCancellationComment'] = strCancellationComment;
    _data['strCancellationReason'] = strCancellationReason;
    _data['strContactName'] = strContactName;
    _data['strPostCode'] = strPostCode;
    _data['strCompanyName'] = strCompanyName;
    _data['strLogo'] = strLogo;
    _data['intEngineerId'] = intEngineerId;
    _data['engineerName'] = engineerName;
    _data['patchCode'] = patchCode;
    _data['decJobTimeHours'] = decJobTimeHours;
    _data['appointmentEventType'] = appointmentEventType;
    _data['bisEnroute'] = bisEnroute;
    _data['intRoutePlanId'] = intRoutePlanId;
    return _data;
  }
}

class Table1 {
  Table1({
    required this.intId,
    required this.strName,
    required this.strEmail,
    required this.strPatches,
    required this.strJobStartTime,
    required this.strJobEndTime,
  });
  late final int intId;
  late final String strName;
  late final String strEmail;
  late final String strPatches;
  late final String strJobStartTime;
  late final String strJobEndTime;

  Table1.fromJson(Map<String, dynamic> json){
    intId = json['intId'];
    strName = json['strName'];
    strEmail = json['strEmail'];
    strPatches = json['strPatches'];
    strJobStartTime = json['strJobStartTime'];
    strJobEndTime = json['strJobEndTime'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['intId'] = intId;
    _data['strName'] = strName;
    _data['strEmail'] = strEmail;
    _data['strPatches'] = strPatches;
    _data['strJobStartTime'] = strJobStartTime;
    _data['strJobEndTime'] = strJobEndTime;
    return _data;
  }
}