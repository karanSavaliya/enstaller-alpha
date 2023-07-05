

import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';

class GeoLocationService{

  static Future<Address> getAddressFromPinCode(String pinCode) async{

    final res = await Geocoder.local.findAddressesFromQuery(pinCode);

    print(res.first.coordinates.latitude.toString()+"*********");

    return res.first;
  }

  static Future<List<Address>> getAddFromLatLong(double lat,double lng){

    return  Geocoder.local.findAddressesFromCoordinates(Coordinates(lat, lng));
  }

  static Future getLatLng() async {

   final val = await Geolocator().getCurrentPosition();

   return val.latitude.toString()+","+val.longitude.toString();
  }


}