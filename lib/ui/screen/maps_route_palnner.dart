// @dart=2.9

import 'dart:ui';
import 'package:enstaller/core/constant/app_string.dart';
import 'package:enstaller/core/constant/appconstant.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart' as latlng;




class ClusteringPage extends StatefulWidget {

  static const String route = 'clusteringPage';

  const ClusteringPage({Key key}) : super(key: key);

  @override
  State<ClusteringPage> createState() => _ClusteringPageState();

}

class _ClusteringPageState extends State<ClusteringPage> {

  final PopupController _popupController = PopupController();

   List<Marker> markers = [];
   int pointIndex = 0;
   List<latlng.LatLng> points = [
    latlng.LatLng(51.5, -0.09),
    latlng.LatLng(49.8566, 3.3522),
  ];

  double lat = 0.0 , lng = 0.0;
  MapController _mapController;

  @override
  void initState() {
    pointIndex = 0;
    markers = [];
    _mapController =  new MapController();

    super.initState();
  }



  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => new AlertDialog(
        title: new Text('Choose Location'),
        content: new Text('do you want to choose location?'),
        actions: <Widget>[
          TextButton(
            onPressed: () { Navigator.of(context).pop(true);
            AppConstants.showFailToast(
                context, "Custom Location Not Set");
              },
            child: new Text('No'),
          ),
          TextButton(
            onPressed: () {

              Navigator.of(context).pop(false);
              AppConstants.showFailToast(context, "Please Select Location by tapping");

            },
            child: new Text('Yes'),
          ),
        ],
      ),
    )) ?? false;
  }





  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
      appBar: AppBar(
        title: const Text('Choose Location'),
      ),

      body: FlutterMap(


        options: MapOptions(
          center: latlng.LatLng(23.0398126754123, 72.57867809833431),
          zoom: 15,
          interactiveFlags: InteractiveFlag.all - InteractiveFlag.rotate,
          onTap: (_ ,latlng){

            setState(() {

              lat = latlng.latitude;
              lng = latlng.longitude;

            });


               //print(latlng.latitude.toString()+","+latlng.longitude.toString() );
          }
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
            markers: [
              Marker(
                width: 40.0,
                height: 40.0,
                point:  latlng.LatLng(lat , lng),
                builder: (ctx) => Container(
                  child: Image.asset("assets/images/location.png" , color: Colors.pinkAccent,),
                ),
              )
            ],
          ),

        ],



      ),
      bottomNavigationBar: Material(
        color: const Color(0xffff8906),
        child: InkWell(
          onTap: () {


            if(lat == 0.0 || lng == 0.0) {
              AppConstants.showFailToast(context, 'Please Select Location by tapping');
            }else{
              Navigator.of(context).pop(lat.toString() + "," + lng.toString());
              AppConstants.showSuccessToast(
                  context, "Custom Location Set");
            }


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
      ),

    ));
  }
}