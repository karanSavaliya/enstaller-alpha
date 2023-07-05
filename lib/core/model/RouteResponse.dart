// @dart=2.9

class RouteResponse {
  List<RouteFeature> features;
  RouteProperties properties;
  String type;

  RouteResponse({this.features, this.properties, this.type});

  factory RouteResponse.fromJson(Map<String, dynamic> json) {
    return RouteResponse(
      features: List<RouteFeature>.from(json['features'].map((x) => RouteFeature.fromJson(x))),
      properties: RouteProperties.fromJson(json['properties']),
      type: json['type'],
    );
  }
}

class RouteFeature {
  RouteProperties properties;
  RouteGeometry geometry;

  RouteFeature({this.properties, this.geometry});

  factory RouteFeature.fromJson(Map<String, dynamic> json) {
    return RouteFeature(
      properties: RouteProperties.fromJson(json['properties']),
      geometry: RouteGeometry.fromJson(json['geometry']),
    );
  }
}

class RouteProperties {
  String mode;
  List<Waypoint> waypoints;
  String units;

  RouteProperties({this.mode, this.waypoints, this.units});

  factory RouteProperties.fromJson(Map<String, dynamic> json) {
    return RouteProperties(
      mode: json['mode'],
      waypoints: List<Waypoint>.from(json['waypoints'].map((x) => Waypoint.fromJson(x))),
      units: json['units'],
    );
  }
}

class Waypoint {
  double lat;
  double lon;

  Waypoint({this.lat, this.lon});

  factory Waypoint.fromJson(Map<String, dynamic> json) {
    return Waypoint(
      lat: json['lat'],
      lon: json['lon'],
    );
  }
}

class RouteGeometry {
  String type;
  List<List<List<double>>> coordinates;

  RouteGeometry({this.type, this.coordinates});

  factory RouteGeometry.fromJson(Map<String, dynamic> json) {
    return RouteGeometry(
      type: json['type'],
      coordinates: List<List<List<double>>>.from(json['coordinates'].map((x) => List<List<double>>.from(x.map((y) => List<double>.from(y.map((z) => z.toDouble())))))),
    );
  }
}
