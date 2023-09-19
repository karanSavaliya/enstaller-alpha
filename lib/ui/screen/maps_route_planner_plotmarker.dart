// @dart=2.9
import 'dart:convert';
import 'dart:typed_data';
import 'package:enstaller/core/model/RouteResponse.dart';
import 'package:enstaller/core/service/api_service.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart' as latlng;
import 'package:flutter/painting.dart';
import 'dart:async';
import 'package:syncfusion_flutter_maps/maps.dart';


class MapRoutes {
  List<String> pincodes;
  String firstloc;
  MapRoutes({
    this.pincodes,
    this.firstloc
  });
}

class PolylineModel {
  PolylineModel(this.points, this.color);
  final List<MapLatLng> points;
  final Color color;
}

class MapsPage extends StatefulWidget {
  final MapRoutes arguments;
  MapsPage({this.arguments});
  static const String route = 'clusteringPage2';
  @override
  _MapsPageState createState() => _MapsPageState();

}


class _MapsPageState extends State<MapsPage> with SingleTickerProviderStateMixin {

   List<MapLatLng> _polylinePoints;
   List<MapLatLng> _polylinePoints_other;
   List<MapLatLng> _polylinePoints_other_;

   List<PolylineModel> listpolylines;
   AnimationController _animationController;
   Animation<double> _animation;
   List<Uint8List> listlocaation = [];

   List<latlng.LatLng> listlatlng = [];

   ApiService _apiService = ApiService();
   List<MapPolyline> polylineLayers = [];

   initLatLng(){
     _polylinePoints = <MapLatLng>[];
     _polylinePoints_other = <MapLatLng>[];
     _polylinePoints_other_ = <MapLatLng>[];
       widget.arguments.pincodes.asMap().forEach((index , value) async {
         print(value.toString().length.toString()+"----***");
         if(value.toString().length > 1) {
           _polylinePoints.add(MapLatLng(double.parse(value.split(",")[0]),
               double.parse(value.split(",")[1])));
           listlatlng.add(latlng.LatLng(double.parse(value.split(",")[0]),
               double.parse(value.split(",")[1])));
         }else{}
       });

     Future.delayed(const Duration(seconds: 4), () async {
       List<List<latlng.LatLng>> pairs = createPairs(listlatlng);
       for (List<latlng.LatLng> pair in pairs) {
         print(pair.first.toString()+"----&&&"+ pair.last.toString());
         final vals = await _apiService.getMapRoutePlanner(pair.first.latitude.toString()+','+pair.first.longitude.toString() , pair.last.latitude.toString()+","+pair.last.longitude.toString());
         final parsedJson = vals;
         Map<String , dynamic> json = jsonDecode(parsedJson);
         RouteResponse routeResponse = RouteResponse.fromJson(json);
         List<List<List<double>>> coordinates = routeResponse.features[0].geometry.coordinates;

         coordinates.forEach((element) {
           element.asMap().forEach((index , element) {
             if(index % 3 == 0) {
               String element_lat_lng = element.toString().replaceAll("[", "").replaceAll("]", "").replaceAll(" ", "");
               print(element_lat_lng);
               _polylinePoints_other.add(MapLatLng(double.parse(element_lat_lng.split(",")[1]), double.parse(element_lat_lng.split(",")[0])));
             }
           });
         });

         setState(() {
           List<List<MapLatLng>> dividedList = [];

           for (int i = 0; i < _polylinePoints_other.length; i += 3) {
             int endIndex = i + 3;
             if (endIndex > _polylinePoints_other.length) {
               endIndex = _polylinePoints_other.length;
             }

             List<MapLatLng> subsection = _polylinePoints_other.sublist(i, endIndex);
             dividedList.add(subsection);
           }

           polylineLayers = dividedList.map((subset) {
             return MapPolyline(
               points: subset,
               color: Colors.black,
               width: 4,
               strokeCap: StrokeCap.round
             );
           }).toList();
         });

         listpolylines = <PolylineModel>[
           PolylineModel(_polylinePoints_other_  , Colors.purple),
         ];
       }
       print(_polylinePoints_other.length.toString()+"/++++++++++++/");
     });
   }

  @override
  void initState() {
    _animationController = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _animationController.forward(from: 0);
    super.initState();
      initLatLng();
    _zoomPanBehavior = MapZoomPanBehavior();
  }

  List<List<latlng.LatLng>> createPairs(List<latlng.LatLng> numbers) {
     List<List<latlng.LatLng>> pairs = [];
     for (int i = 1; i < numbers.length; i += 1) {

         List<latlng.LatLng> pair = [numbers[i-1], numbers[i]];
         pairs.add(pair);

     }
     return pairs;
   }

   MapZoomPanBehavior _zoomPanBehavior;

  @override
  Widget build(BuildContext context) {
    print(widget.arguments.firstloc+"____________");
    return widget.arguments.firstloc.split(",")[0].isNotEmpty ? SfMaps(
        layers: <MapLayer>[
          MapTileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            initialMarkersCount: _polylinePoints.length,
            initialFocalLatLng: MapLatLng(double.parse(widget.arguments.firstloc.split(",")[0]), double.parse(widget.arguments.firstloc.split(",")[1])),
            zoomPanBehavior: _zoomPanBehavior,
            initialZoomLevel: 7,
            markerBuilder: (BuildContext context , int index) {
              print(_polylinePoints.length.toString()+"***");
              return MapMarker(
                latitude: _polylinePoints[index].latitude,
                longitude: _polylinePoints[index].longitude,
                iconType: MapIconType.circle,
                size: Size(100, 100),
                alignment: Alignment.center,
                offset: Offset(0, 9),
                iconColor: Colors.green[200],
                iconStrokeColor: Colors.green[900],
                iconStrokeWidth: 5,
                child:  index == 0 ?  SequenceMarker(sequenceNumber: (index).toString() , // Use index + 1 as sequence number
                  markerSize: 50.0,
                  markerColor: Colors.black,
                  numberColor: Colors.yellow,) : SequenceMarker(sequenceNumber:  (index).toString(), // Use index + 1 as sequence number
                  markerSize: 50.0,
                  markerColor: Colors.red,
                  numberColor: Colors.yellow,)
              );
            },
            sublayers: [
              MapPolylineLayer(
                polylines:  polylineLayers.toSet(),
              ),
            ],
          ),
        ],
    ) : SfMaps();
  }
}

class SequenceMarker extends StatelessWidget {
  final String sequenceNumber;
  final double markerSize;
  final Color markerColor;
  final Color numberColor;

  SequenceMarker({
     this.sequenceNumber,
    this.markerSize = 32.0,
    this.markerColor = Colors.blue,
    this.numberColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Icon(
          Icons.location_on,
          color: markerColor,
          size: markerSize,
        ),
        Container(margin: EdgeInsets.only(bottom:20) ,child:Text(
          sequenceNumber,
          style: TextStyle(
            color: numberColor,
            fontWeight: FontWeight.bold,
            fontSize: 22
          ),
        ),),
      ],
    );
  }
}






