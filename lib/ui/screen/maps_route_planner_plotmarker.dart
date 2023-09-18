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
import 'dart:ui' as ui;
import 'package:syncfusion_flutter_maps/maps.dart';


class MapRoutes {

  List<String> pincodes;
  String firstloc;

  MapRoutes({
    this.pincodes,
    this.firstloc
  });

}



/*class ClusteringPage2 extends StatefulWidget {

  static const String route = 'clusteringPage2';

  //const ClusteringPage2({Key key}) : super(key: key);

  final MapRoutes arguments;
  ClusteringPage2({this.arguments});


  @override
  State<ClusteringPage2> createState() => _ClusteringPage2State();

}


class _ClusteringPage2State extends State<ClusteringPage2> {

  final PopupController _popupController = PopupController();

  List<Marker> markers = [];
  int pointIndex = 0;
  List<latlng.LatLng> points = [
    latlng.LatLng(51.5, -0.09),
    latlng.LatLng(49.8566, 3.3522),
  ];

  double lat = 0.0 , lng = 0.0;
  MapController _mapController;

  List<Marker> co_ordinates_list = [];


  @override
  void initState() {
    pointIndex = 0;
    _mapController =  new MapController();
    super.initState();

    initLatLng();

  }

  initLatLng(){


   setState(() {

     widget.arguments.pincodes.asMap().forEach((index , element) async {

       Uint8List markerIcon = await getBytesFromCanvas(index+1 , 80 , 80);

       co_ordinates_list.add(Marker(
         width: 40.0,
         height: 40.0,
         point: latlng.LatLng(double.parse(element.split(",")[0]) , double.parse(element.split(",")[1])),
         builder: (ctx) => Container(
           child: Image.memory(markerIcon),
         ),
       ));

     });

   });


  }



  Future<Uint8List> getBytesFromCanvas(int customNum, int width, int height) async  {

    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final Paint paint = Paint()..color = Colors.blue;
    final Radius radius = Radius.circular(width/2);
    canvas.drawRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(0.0, 0.0, width.toDouble(),  height.toDouble()),
          topLeft: radius,
          topRight: radius,
          bottomLeft: radius,
          bottomRight: radius,
        ),
        paint);

    TextPainter painter = TextPainter(textDirection: TextDirection.ltr);
    painter.text = TextSpan(
      text: customNum.toString(), // your custom number here
      style: TextStyle(fontSize: 65.0, color: Colors.white),
    );

    painter.layout();
    painter.paint(
        canvas,
        Offset((width * 0.5) - painter.width * 0.5,
            (height * .5) - painter.height * 0.5));
    final img = await pictureRecorder.endRecording().toImage(width, height);
    final data = await img.toByteData(format: ui.ImageByteFormat.png);

    return data.buffer.asUint8List();

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Planned Route Location'),
      ),

      body: FlutterMap(


        options: MapOptions(
            center: co_ordinates_list.length > 0 ? latlng.LatLng(co_ordinates_list[0].point.latitude , co_ordinates_list[0].point.longitude) : latlng.LatLng(51.509865 , -0.118092),
            zoom: 17,
            interactiveFlags: InteractiveFlag.all - InteractiveFlag.rotate,



        ),
        layers: [

          TileLayerOptions(
            urlTemplate:
            "https://api.mapbox.com/styles/v1/mapbox/streets-v11/tiles/{z}/{x}/{y}?access_token=pk.eyJ1Ijoic2hhbm5pIiwiYSI6ImNsZW1sMXZqMDE2MHMzcG1pbThrbG5pbDgifQ.Pgqcv4nDvBNa4Qhrdc1jBg",
            additionalOptions: {
              'id': AppStrings.mapBoxStyleId,
              'accessToken': AppStrings.mapBoxAccessToken,
            },
          ),
          MarkerLayerOptions(
            markers: co_ordinates_list,
          ),

        ],

      ),
      *//*bottomNavigationBar: Material(
        color: const Color(0xffff8906),
        child: InkWell(
          onTap: () {

            Navigator.of(context).pop(lat.toString()+","+lng.toString());

          },
          child: const SizedBox(
            height: kToolbarHeight,
            width: double.infinity,
            child: Center(
              child: Text(
                'Submit Location',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),*//*

    );
  }
}*/
















class PolylineModel {
  PolylineModel(this.points, this.color);
  final List<MapLatLng> points;
  final Color color;
}

class MapsPage extends StatefulWidget {

  //MapsPage({Key key,  this.title}) : super(key: key);


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
         }else{


         }

         });

     //_polylinePoints.add(MapLatLng(double.parse("0") , double.parse("0")));




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
               String element_lat_lng = element.toString()
                   .replaceAll("[", "")
                   .replaceAll("]", "")
                   .replaceAll(" ", "");

               print(element_lat_lng);

               _polylinePoints_other.add(MapLatLng(
                   double.parse(element_lat_lng.split(",")[1]),
                   double.parse(element_lat_lng.split(",")[0])));
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
               // Customize the line width as desired
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






   List<List<T>> divideList<T>(List<T> originalList, int numberOfSublists) {
     final List<List<T>> dividedList = [];
     final int sublistSize = (originalList.length / numberOfSublists).ceil();

     for (int i = 0; i < originalList.length; i += sublistSize) {
       final sublist = originalList.sublist(i, i + sublistSize);
       dividedList.add(sublist);
     }

     return dividedList;
   }




   Future<List<MapLatLng>> loadDataFromExternalSource() {

     return Future.delayed(const Duration(seconds: 5), () {

       return _polylinePoints_other;
     });

   }



   Future<Uint8List> getBytesFromCanvas(int customNum, int width, int height) async  {

     final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
     final Canvas canvas = Canvas(pictureRecorder);
     final Paint paint = Paint()..color = Colors.blue;
     final Radius radius = Radius.circular(width/2);
     canvas.drawRRect(
         RRect.fromRectAndCorners(
           Rect.fromLTWH(0.0, 0.0, width.toDouble(),  height.toDouble()),
           topLeft: radius,
           topRight: radius,
           bottomLeft: radius,
           bottomRight: radius,
         ),
         paint);

     TextPainter painter = TextPainter(textDirection: TextDirection.ltr);
     painter.text = TextSpan(
       text: customNum.toString(), // your custom number here
       style: TextStyle(fontSize: 65.0, color: Colors.white),
     );

     painter.layout();
     painter.paint(
         canvas,
         Offset((width * 0.5) - painter.width * 0.5,
             (height * .5) - painter.height * 0.5));
     final img = await pictureRecorder.endRecording().toImage(width, height);
     final data = await img.toByteData(format: ui.ImageByteFormat.png);

     return data.buffer.asUint8List();

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
              //  child:index == 0 ? Icon(Icons.location_pin ,size:50 , color: Colors.black) :   Icon(Icons.location_pin ,size:50 , color: Colors.red),
              );

            },

            sublayers: [

              MapPolylineLayer(
                polylines:  polylineLayers.toSet(),
              ),

            ],


          ),













  /*  MapShapeLayer(

            sublayers: [
              MapPolylineLayer(
                polylines:List<MapPolyline>.generate(
                  _polylinePoints_other_.length,
                      (int index) {
                    return MapPolyline(
                      points: _polylinePoints_other_,
                      color: Colors.blue,
                    );
                  },
                ).toSet(),
              ),
            ],

          ),*/
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






