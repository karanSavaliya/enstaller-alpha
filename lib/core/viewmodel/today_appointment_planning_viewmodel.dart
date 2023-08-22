// @dart=2.9
import 'package:enstaller/core/enums/view_state.dart';
import 'package:enstaller/core/model/EngineerBaseLocation.dart';
import 'package:enstaller/core/model/appointmentDetailsModel.dart';
import 'package:enstaller/core/model/route_making.dart';
import 'package:enstaller/core/model/user_model.dart';
import 'package:enstaller/core/provider/base_model.dart';
import 'package:enstaller/core/service/api_service.dart';
import 'package:enstaller/core/service/pref_service.dart';
import '../../ui/util/common_utils.dart';

class RoutePlanningArguments {

  String appointmentID;
  String strBookingReference;
  String site_address;
  String route_plan_id;
  String intUpdateId ;
  String pincode;
  String status;
  String appointmentTime;
  RoutePlanningArguments({
    this.appointmentID,
    this.strBookingReference,
    this.site_address,
    this.route_plan_id,
    this.intUpdateId,
    this.pincode,
    this.status,
    this.appointmentTime,
  });

}



class TodayAppointmentPlanningViewModel extends BaseModel {

  ApiService _apiService = ApiService();

  List<Appointment> appointmentList = [];
  List<Appointment> _appointmentList = [];

  List<Table1> site_address = [];
  List<Table1> _site_address = [];

  EngineerBaseLocation baseLoccation = new EngineerBaseLocation();



  void getTodayAppoinmentList() async {

    appointmentList = [];
    _appointmentList = [];

    setState(ViewState.Busy);
    UserModel user = await Prefs.getUser();

    _appointmentList =
        await _apiService.getTodaysAppointments( user.intEngineerId.toString() , CommonUtils().currDate() , user.intCompanyId);
    _appointmentList.forEach((element) {
    appointmentList.add(element);

      print("element  ---"+element.strSiteAddress);

    });

    setState(ViewState.Idle);
  }



   Future<void> getRoutePlanDetailEngineerwise() async {

     site_address = [];
     _site_address = [];

     setState(ViewState.Busy);

     UserModel user = await Prefs.getUser();
     _site_address = await _apiService.getRoutePlanDetailEngineerWise( user.intEngineerId.toString() , CommonUtils().currDate());

     _site_address.forEach((element) {
      site_address.add(element);
     });

     setState(ViewState.Idle);

   }

  List<RoutePlanningArguments> list_route_plan = [];
  List<Appointment> appointmentList_ = [];
  List<Table1> site_address_ = [];

  Future<void> makeMultipleRequests() async {

    setState(ViewState.Busy);

    UserModel user = await Prefs.getUser();

    site_address_ = await _apiService.getRoutePlanDetailEngineerWise( user.intEngineerId.toString() , CommonUtils().currDate());
    site_address_.forEach((element) {


        RoutePlanningArguments rpa = new RoutePlanningArguments(
            appointmentID: element.intAppointmentId.toString(),
            strBookingReference: element.strBookingReference,
            site_address: element.strSiteAddress,
            route_plan_id: element.intRoutePlanId.toString(),
            intUpdateId: element.intId.toString(),
            pincode: element.strPostCode.toString(),
            status: element.appointmentEventType);

        if (list_route_plan.length == 0) {
          list_route_plan.add(rpa);
        } else {
          bool exists = list_route_plan.any((element) =>
          element.strBookingReference == rpa.strBookingReference);
          if (!exists) {
            list_route_plan.add(rpa);
          }

          print(list_route_plan.any((element) => element.strBookingReference ==
              rpa.strBookingReference));
        }

    });


    appointmentList_ = await _apiService.getTodaysAppointments( user.intEngineerId.toString() , CommonUtils().currDate() , user.intCompanyId);
    appointmentList_.forEach((element) {

      print(element.strStatus.toString()+"---------------------");

        if (element.intRoutePlanId == null) {
          String appointment = element.intId.toString();
          String book_refrence = element.strBookingReference;
          String site_address = element.strSiteAddress;
          String appointmentTime = element.strBookedTime;

          RoutePlanningArguments rpa = new RoutePlanningArguments(
              appointmentID: appointment,
              strBookingReference: book_refrence,
              site_address: site_address,
              appointmentTime: appointmentTime,
              route_plan_id: "0",
              intUpdateId: "0",
              pincode: element.strPostCode,
              status: element.appointmentEventType);

          if (list_route_plan.length == 0) {
            list_route_plan.add(rpa);
          } else {
            bool exists = list_route_plan.any((element) =>
            element.strBookingReference == rpa.strBookingReference);

            if (!exists) {
              list_route_plan.add(rpa);
            }
            print(
                list_route_plan.any((element) => element.strBookingReference ==
                    rpa.strBookingReference));
          }
        }


        list_route_plan.removeWhere((element) => element.status == "Cancelled" || element.status == "Completed" ||
        element.status == "Aborted"   || element.status == "OnSite");


        if( list_route_plan.where((element) => element.status == "InRoute").toList().length > 0) {
          setToFirstIndex(list_route_plan, list_route_plan.where((element) => element.status == "InRoute").toList()[0]);
        }

    });

    setState(ViewState.Idle);

  }

  void setToFirstIndex(List<dynamic> list, dynamic value) {
    int index = list.indexOf(value);
    if (index != -1 && index != 0) {
      dynamic temp = list[0];
      list[0] = list[index];
      list[index] = temp;
    }
  }

  Future<void> getEngineerBaseLocation() async {

    setState(ViewState.Busy);

    UserModel user = await Prefs.getUser();
    final vals   = await _apiService.getRoutePlannerEngineerBaseLocation( user.intEngineerId.toString());
    baseLoccation = vals;

    setState(ViewState.Idle);

  }

  String sortorder = "false";
  Future<String> saveSortorderofLocation(Map map) async {

    setState(ViewState.Busy);

    UserModel user = await Prefs.getUser();
    final vals   = await _apiService.saveSortorderofLocation(map);
    sortorder   = vals;

    setState(ViewState.Idle);

  }

  int getCurrentDay(DateTime date) {
    return date.day;
  }
}
