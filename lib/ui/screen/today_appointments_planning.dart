// @dart=2.9

import 'dart:async';
import 'dart:convert';
import 'package:enstaller/core/constant/app_colors.dart';
import 'package:enstaller/core/constant/app_string.dart';
import 'package:enstaller/core/constant/appconstant.dart';
import 'package:enstaller/core/constant/size_config.dart';
import 'package:enstaller/core/enums/view_state.dart';
import 'package:enstaller/core/model/appointmentDetailsModel.dart';
import 'package:enstaller/core/model/custom_drop_down.dart';
import 'package:enstaller/core/model/user_model.dart';
import 'package:enstaller/core/provider/base_view.dart';
import 'package:enstaller/core/service/geo_service.dart';
import 'package:enstaller/core/service/pref_service.dart';
import 'package:enstaller/core/viewmodel/today_appointment_planning_viewmodel.dart';
import 'package:enstaller/ui/screen/detail_screen.dart';
import 'package:enstaller/ui/screen/maps_route_palnner.dart';
import 'package:enstaller/ui/screen/widget/appointment/appointment_data_row.dart';
import 'package:enstaller/ui/shared/app_drawer_widget.dart';
import 'package:enstaller/ui/shared/appbuttonwidget.dart';
import 'package:enstaller/ui/util/common_utils.dart';
import 'package:enstaller/ui/util/dialog_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'maps_route_planner_plotmarker.dart';
import 'package:select_form_field/select_form_field.dart';




class TodayAppointmentPlanningScreen extends StatefulWidget {

  @override
  _ApppointmentPlanningScreenState createState() => _ApppointmentPlanningScreenState();

}


class _ApppointmentPlanningScreenState extends State<TodayAppointmentPlanningScreen> {

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> _list = ["Apple", "Ball", "Cat", "Dog", "Elephant"];
  List<String> listlatng = [];

  @override
  void dispose() {

    super.dispose();
  }

  String address = "";
  String postalcode = "";

 bool shouldButtonEnabled =true;

  _disabledButton(){
    shouldButtonEnabled=false;
    Timer(
        Duration(seconds: 10),
            () => shouldButtonEnabled=true);
  }


  inserUpdatePlan(TodayAppointmentPlanningViewModel model) async {

    listlatng.clear();

    if(type == "0"){

      DialogSnackBarUtils().showSnackbar(context: context , scaffoldState: null , message: "Select Proper Location Type" , backgroundColor:Colors.red );

    }else {


      String latitude = "", longitude = "";

      if (type == "1") {
        latitude = model.baseLoccation.engineerRouteBaseLocation
            .strBaseLocationLatitude;
        longitude = model.baseLoccation.engineerRouteBaseLocation
            .strBaseLocationLongitude;

          if(latitude.isEmpty || longitude.isEmpty){
           // AppConstants.showSuccessToast(context , "Base Location Not Available");

            return;
          }else{
           // AppConstants.showSuccessToast(context , "Base Location Set");
          }

      } else if (type == "2") {
        latitude = latlng_str.split(",")[0];
        longitude = latlng_str.split(",")[1];
      } else if (type == "3") {
        latitude = latlng_str.split(",")[0];
        longitude = latlng_str.split(",")[1];
      }


      print("------"+latitude+","+longitude+"-------------------------------------------------");
      listlatng.add(latitude+","+longitude);

      String add_update_type = "";
      if (model.list_route_plan[0].route_plan_id == "0") {
        add_update_type = "insert";
      } else {
        add_update_type = "update";
      }

      print(add_update_type+";;;;;;;;;;;;;;;;"+model.list_route_plan[0].route_plan_id);

      UserModel user = await Prefs.getUser();

      Map routeplanner = {
        "intId": model.list_route_plan[0].route_plan_id,
        "intEngineerId": user.intEngineerId,
        "intLocationTypeId": type,
        "strRouteName": CommonUtils().currDate() + "-" + user.intEngineerId,
        "strEngLocAddress": type == "1" ?  model.baseLoccation.engineerRouteBaseLocation.strBaseLocation :  address,
        "strEngLocLatitude": latitude,
        "strEngLocLongitude": longitude,
        "strEngLocPostCode": type == "1" ? model.baseLoccation.engineerRouteBaseLocation.strBaseLocationPostcode : postalcode,
        "intCreatedby": user.intCompanyId,
        "strAction": add_update_type,
        "intModifiedby": user.intCompanyId
      };


      List<Map> listmap = [];
      model.list_route_plan.asMap().forEach((index, element) async {
        listmap.add({
          "intId": element.intUpdateId,
          "intAppointmentId": element.appointmentID,
          "intPriority": model.list_route_plan.length - index
        });

        print(element.appointmentID+"-----"+element.pincode);


      });








      Future.delayed(const Duration(milliseconds: 1500) , () async {

        model.list_route_plan.forEach((element) async {

          print("^^^^^^^^"+element.pincode);

          final location = await GeoLocationService.getAddressFromPinCode(element.pincode);

          print(location.coordinates.latitude.toString()+"^^^^^^^^^^^");

          listlatng.add(location.coordinates.latitude.toString()+","+location.coordinates.longitude.toString());

        });


        Future.delayed(const Duration(milliseconds: 2000), () async {
          Map routeplannerMap = {
            "routePlanner": routeplanner,
            "routePlannerDetail": listmap
          };

          model.saveSortorderofLocation(routeplannerMap).then((value) =>
              setorder(model));

          print(listlatng.length.toString());

        });

        /*if(res == true) {
          Navigator.of(context).pushNamed(ClusteringPage2.route,
              arguments: MapRoutes(pincodes: listlatng));
        }*/


      });

    }


  }

  
  Future<void> setorder(TodayAppointmentPlanningViewModel model) async {

    print(model.sortorder+"----------))))))(((((((");

    print(listlatng.length.toString()+"!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!11111111");

    listlatng.removeWhere((element) => element.length <= 1);

    final preferences = await SharedPreferences.getInstance();
    preferences.setStringList(CommonUtils().currDate() , listlatng);

    if(model.sortorder == "true") {
      Navigator.of(context).pushNamed(MapsPage.route,
          arguments: MapRoutes(pincodes: listlatng , firstloc: listlatng[0]));
    }



    
  }
  

  List<String> location_items = ["Select Location Type" ,"Base Location" , "Current Location" , "Custom Location"];

  List<Map<String , dynamic>> location_items_list = [{ "type":"Select Location Type" , "base":"Base Location" , "current":"Current Location" , "custom":"Custom Location"}];

  String locate = "Select Location Type";
  String lat_lng = "";
  String type = "0" , latlng_str = "";

  @override
  Widget build(BuildContext context) {
    return BaseView<TodayAppointmentPlanningViewModel>(
      onModelReady: (model) {
             model.makeMultipleRequests();
        },
      builder: (context , model , child) {
        return Scaffold(
          backgroundColor: AppColors.scafoldColor,
          key: _scaffoldKey,
          drawer: Drawer(
            child: AppDrawerWidget(),
          ),
          appBar: AppBar(
            brightness: Brightness.dark,
            backgroundColor: AppColors.appThemeColor,
            leading: Padding(
              padding: const EdgeInsets.all(18.0),
              child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(Icons.arrow_back)),
            ),
            title: Text(
              AppStrings.TODAY_APPOINTMENTS_PLANNING,
              style: getTextStyle(color: AppColors.whiteColor, isBold: true),
            ),
            actions: [
              IconButton(icon: Icon(Icons.save  , color: Colors.white), onPressed: () {

                if(shouldButtonEnabled == true) {
                  _disabledButton();
                  inserUpdatePlan(model);
                }


              }),
            ],
          ),
          body: model.state == ViewState.Busy
              ? AppConstants.circulerProgressIndicator()
              : Column( children: <Widget>[

            Container(  margin: EdgeInsets.only(top: 15 ,left: 15 , right: 15)   ,child:  DecoratedBox(
              decoration: BoxDecoration(
                  color:AppColors.lightGrayLittleColor, //background color of dropdown button
                  border: Border.all(color: Colors.black38, width:3), //border of dropdown button
                  borderRadius: BorderRadius.circular(0), //border raiuds of dropdown button
                  boxShadow: <BoxShadow>[ //apply shadow on Dropdown button
                    BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.57), //shadow for button
                        blurRadius: 5) //blur radius of shadow
                  ]
              ),


              child:Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  padding: EdgeInsets.symmetric(horizontal: 20.0) , child:CustomDropdownButton(
              isExpanded: true,
              value: locate,
              elevation: 10,
              items: location_items.map((country){
                return CustomDropdownMenuItem(
                  child: Container(child:Text(country , style: TextStyle(color: Colors.black87),)),
                  value: country,
                  
                );
              }).toList(),
              onChanged: (country) async {

                setState(() {
                  locate  = country;
                });

                if(country == "Select Location Type"){

                  type = "0";

                }else if(country == "Base Location"){

                  type = "1";
                  model.getEngineerBaseLocation();

                  await Future.delayed(Duration(seconds: 3));

                  String latitude = model.baseLoccation.engineerRouteBaseLocation
                      .strBaseLocationLatitude;
                  String longitude2 = model.baseLoccation.engineerRouteBaseLocation
                      .strBaseLocationLongitude;

                  if(latitude.isEmpty || longitude2.isEmpty){
                     AppConstants.showFailToast(context , "UPDATE ENGINEER BASE LOCATION FROM ENSTALL PORTAL");

                    return;
                  }else{
                    AppConstants.showSuccessToast(context , "Base Location Set");
                  }


                }else if(country == "Current Location"){

                  print("test");

                  type = "2";
                  latlng_str = await GeoLocationService.getLatLng();

                  print(latlng_str);

                  final address_fetch =  await GeoLocationService.getAddFromLatLong(double.parse(latlng_str.split(",")[0]) , double.parse(latlng_str.split(",")[1]));

                  address = address_fetch.first.addressLine;
                  postalcode = address_fetch.first.postalCode;

                  AppConstants.showSuccessToast(context , "Current Location Set");


                }else if(country == "Custom Location"){

                  type = "3";

                  latlng_str =  await Navigator.of(context).push(new MaterialPageRoute(
                      builder: (context) => ClusteringPage(
                      )));

                  final address_fetch =  await GeoLocationService.getAddFromLatLong(double.parse(latlng_str.split(",")[0]) , double.parse(latlng_str.split(",")[1]));

                    address = address_fetch.first.addressLine;
                    postalcode = address_fetch.first.postalCode;


                }

              },
            ),),










            ),),

            Container( margin: EdgeInsets.only(top: 15) , height: MediaQuery.of(context).size.height*0.75 , child:ReorderableListView(
                children: model.list_route_plan
                    .map((item) => ListTile(
                  key: Key(model.list_route_plan.indexOf(item).toString()),
                  title: RichText(
                      text: new TextSpan(
                        text: (model.list_route_plan.indexOf(item)+1).toString()+".",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                            fontSize: 20),
                        children: <TextSpan>[
                          new TextSpan(
                              text: " ${item.strBookingReference}",
                              style: new TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                  fontSize: 18)),
                          new TextSpan(
                              text: "\n Address : ${item.site_address}",
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 14))
                        ],
                      )),
                  trailing: Icon(Icons.menu),
                  shape: Border(bottom: BorderSide()),
                ))
                    .toList(),
                onReorder: (int start , int current) {

                  print(start.toString()+"----"+current.toString()+"----"+model.list_route_plan[start].status);

                  if(model.list_route_plan[start].status == "InRoute" ){

                     if(model.list_route_plan[start].status == "InRoute") {
                       AppConstants.showFailToast(context,
                           "Sequence of "+(model.list_route_plan[start].appointmentID)+" can not be changed");
                     }/*else if(model.list_route_plan[curent_status].status == "InRoute"){

                       if(curent_status == 0 && start > current){
                         curent_status = curent_status +1;
                       }else{ = curent_status;
                       }
                         curent_status

                       AppConstants.showFailToast(context,
                           "This Sequence Number with InRoute status can not be replaced with other");
                     }*/

                    return;
                  }

                  int curr_type = 0;
                  if(start == 0 || current == model.list_route_plan.length){
                    curr_type = current - 1;
                  }else{
                    curr_type  = current;

                  }


                  if(model.list_route_plan[curr_type].status == "InRoute" ){

                    if(model.list_route_plan[curr_type].status == "InRoute") {
                      AppConstants.showFailToast(context,
                          "Sequence of "+(model.list_route_plan[curr_type].appointmentID)+" can not be changed");
                    }/*else if(model.list_route_plan[curent_status].status == "InRoute"){

                       if(curent_status == 0 && start > current){
                         curent_status = curent_status +1;
                       }else{
                         curent_status = curent_status;
                       }

                       AppConstants.showFailToast(context,
                           "This Sequence Number with InRoute status can not be replaced with other");
                     }*/

                    return;
                  }



                  // dragging from top to bottom
                  if (start < current) {
                    int end = current - 1;
                    RoutePlanningArguments startItem = model.list_route_plan[start];
                    int i = 0;
                    int local = start;
                    do {
                      model.list_route_plan[local] =
                      model.list_route_plan[++local];
                      i++;
                    } while (i < end - start);
                    model.list_route_plan[end] = startItem;
                  }
                  // dragging from bottom to top
                  else if (start > current) {
                    RoutePlanningArguments startItem = model.list_route_plan[start];
                    for (int i = start; i > current; i--) {
                      model.list_route_plan[i] = model.list_route_plan[i - 1];
                    }
                    model.list_route_plan[current] = startItem;
                  }

                  setState(() {});
                },
              ))

          ],),


        );


      },
    );
  }


  TextStyle getTextStyle({Color color, bool isBold = false, num fontSize}) {
    return TextStyle(
        color: color,
        fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
        fontSize: fontSize);
  }

}
