// @dart=2.9


class EngineerBaseLocation {
  List<RouteLocationMst> routeLocationMst;
  EngineerRouteBaseLocation engineerRouteBaseLocation;

  EngineerBaseLocation({this.routeLocationMst, this.engineerRouteBaseLocation});

  EngineerBaseLocation.fromJson(Map<String, dynamic> json) {
    if (json['routeLocationMst'] != null) {
      routeLocationMst = <RouteLocationMst>[];
      json['routeLocationMst'].forEach((v) {
        routeLocationMst.add(new RouteLocationMst.fromJson(v));
      });
    }
    engineerRouteBaseLocation = json['engineerRouteBaseLocation'] != null
        ? new EngineerRouteBaseLocation.fromJson(
        json['engineerRouteBaseLocation'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.routeLocationMst != null) {
      data['routeLocationMst'] =
          this.routeLocationMst.map((v) => v.toJson()).toList();
    }
    if (this.engineerRouteBaseLocation != null) {
      data['engineerRouteBaseLocation'] =
          this.engineerRouteBaseLocation.toJson();
    }
    return data;
  }
}

class RouteLocationMst {
  int intId;
  String strLocationName;

  RouteLocationMst({this.intId, this.strLocationName});

  RouteLocationMst.fromJson(Map<String, dynamic> json) {
    intId = json['intId'];
    strLocationName = json['strLocationName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['intId'] = this.intId;
    data['strLocationName'] = this.strLocationName;
    return data;
  }
}

class EngineerRouteBaseLocation {
  int intLocationId;
  String strLocationName;
  String strBaseLocation;
  String strBaseLocationLatitude;
  String strBaseLocationLongitude;
  String strBaseLocationPostcode;

  EngineerRouteBaseLocation(
      {this.intLocationId,
        this.strLocationName,
        this.strBaseLocation,
        this.strBaseLocationLatitude,
        this.strBaseLocationLongitude,
        this.strBaseLocationPostcode});

  EngineerRouteBaseLocation.fromJson(Map<String, dynamic> json) {
    intLocationId = json['intLocationId'];
    strLocationName = json['strLocationName'];
    strBaseLocation = json['strBaseLocation'];
    strBaseLocationLatitude = json['strBaseLocationLatitude'];
    strBaseLocationLongitude = json['strBaseLocationLongitude'];
    strBaseLocationPostcode = json['strBaseLocationPostcode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['intLocationId'] = this.intLocationId;
    data['strLocationName'] = this.strLocationName;
    data['strBaseLocation'] = this.strBaseLocation;
    data['strBaseLocationLatitude'] = this.strBaseLocationLatitude;
    data['strBaseLocationLongitude'] = this.strBaseLocationLongitude;
    data['strBaseLocationPostcode'] = this.strBaseLocationPostcode;
    return data;
  }
}