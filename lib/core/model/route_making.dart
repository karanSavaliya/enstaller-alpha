// @dart=2.9

class route_making {
  List<Table> table;
  List<Table1> table1;

  route_making({this.table, this.table1});

  route_making.fromJson(Map<String, dynamic> json) {
    if (json['table'] != null) {
      table = <Table>[];
      json['table'].forEach((v) {
        table.add(new Table.fromJson(v));
      });
    }
    if (json['table1'] != null) {
      table1 = <Table1>[];
      json['table1'].forEach((v) {
        table1.add(new Table1.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.table != null) {
      data['table'] = this.table.map((v) => v.toJson()).toList();
    }
    if (this.table1 != null) {
      data['table1'] = this.table1.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Table {
  int intId;
  int intEngineerId;
  int intLocationTypeId;
  String strRouteName;
  String strEngLocAddress;
  String strEngLocPostCode;
  String strEngLocLatitude;
  String strEngLocLongitude;

  Table(
      {this.intId,
        this.intEngineerId,
        this.intLocationTypeId,
        this.strRouteName,
        this.strEngLocAddress,
        this.strEngLocPostCode,
        this.strEngLocLatitude,
        this.strEngLocLongitude});

  Table.fromJson(Map<String, dynamic> json) {
    intId = json['intId'];
    intEngineerId = json['intEngineerId'];
    intLocationTypeId = json['intLocationTypeId'];
    strRouteName = json['strRouteName'];
    strEngLocAddress = json['strEngLocAddress'];
    strEngLocPostCode = json['strEngLocPostCode'];
    strEngLocLatitude = json['strEngLocLatitude'];
    strEngLocLongitude = json['strEngLocLongitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['intId'] = this.intId;
    data['intEngineerId'] = this.intEngineerId;
    data['intLocationTypeId'] = this.intLocationTypeId;
    data['strRouteName'] = this.strRouteName;
    data['strEngLocAddress'] = this.strEngLocAddress;
    data['strEngLocPostCode'] = this.strEngLocPostCode;
    data['strEngLocLatitude'] = this.strEngLocLatitude;
    data['strEngLocLongitude'] = this.strEngLocLongitude;
    return data;
  }
}

class Table1 {
  int intId;
  int intRoutePlanId;
  int intAppointmentId;
  int intPriority;
  String strBookingReference;
  String strSiteAddress;
  String strPostCode;
  String strcustomername;
  String appointmentEventType;
  String strBookedTime;

  Table1(
      {this.intId,
        this.intRoutePlanId,
        this.intAppointmentId,
        this.intPriority,
        this.strBookingReference,
        this.strSiteAddress,
        this.strPostCode,
        this.strcustomername,
        this.appointmentEventType,
        this.strBookedTime});

  Table1.fromJson(Map<String, dynamic> json) {
    intId = json['intId'];
    intRoutePlanId = json['intRoutePlanId'];
    intAppointmentId = json['intAppointmentId'];
    intPriority = json['intPriority'];
    strBookingReference = json['strBookingReference'];
    strSiteAddress = json['strSiteAddress'];
    strPostCode = json['strPostCode'];
    strcustomername = json['strcustomername'];
    appointmentEventType = json['appointmentEventType'];
    strBookedTime = json['strBookedTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['intId'] = this.intId;
    data['intRoutePlanId'] = this.intRoutePlanId;
    data['intAppointmentId'] = this.intAppointmentId;
    data['intPriority'] = this.intPriority;
    data['strBookingReference'] = this.strBookingReference;
    data['strSiteAddress'] = this.strSiteAddress;
    data['strPostCode'] = this.strPostCode;
    data['strcustomername'] = this.strcustomername;
    data['appointmentEventType'] = this.appointmentEventType;
    data['strBookedTime'] = this.strBookedTime;
    return data;
  }
}