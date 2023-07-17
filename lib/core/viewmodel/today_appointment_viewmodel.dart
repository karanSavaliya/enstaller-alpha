import 'package:enstaller/core/enums/view_state.dart';
import 'package:enstaller/core/model/appointmentDetailsModel.dart';
import 'package:enstaller/core/model/user_model.dart';
import 'package:enstaller/core/provider/base_model.dart';
import 'package:enstaller/core/service/api_service.dart';
import 'package:enstaller/core/service/pref_service.dart';
import 'package:enstaller/ui/util/common_utils.dart';

class TodayAppointmentViewModel extends BaseModel {
  ApiService _apiService = ApiService();
  List<Appointment> appointmentList = [];
  List<Appointment> _appointmentList = [];
  bool searchBool = false;


  void getAppoinmentList() async {

    appointmentList = [];
    _appointmentList = [];
    setState(ViewState.Busy);
    UserModel user = await Prefs.getUser();

    _appointmentList =
        await _apiService.getTodaysAppointments( user.intEngineerId.toString() , CommonUtils().currDate() , user.intCompanyId);
    _appointmentList.forEach((element) {

      //print("****"+element.dteCreatedDate+"*****");

      DateTime dt = DateTime.parse(element.dteBookedDate);
      if (dt.day == getCurrentDay(DateTime.now())) {
        appointmentList.add(element);
      }
    });

    appointmentList.removeWhere((element) => element.appointmentEventType == "Cancelled"  ||  element.appointmentEventType == "Aborted" ||  element.appointmentEventType == "Completed");
    setState(ViewState.Idle);
  }


  void onClickSerach() {

    setState(ViewState.Busy);

    searchBool = !searchBool;
    if (!searchBool) {
      _appointmentList.forEach((element) {
        DateTime dt = DateTime.parse(element.dteBookedDate);
        if (dt.day == getCurrentDay(DateTime.now())) {
          appointmentList.add(element);
        }
      });
    }

    setState(ViewState.Idle);
  }


  void onSearch(String val) {
    setState(ViewState.Busy);
    appointmentList = [];
    _appointmentList.forEach((element) {
      DateTime dt = DateTime.parse(element.dteBookedDate);
      if (dt.day == getCurrentDay(DateTime.now())) {
        if (element.strCompanyName.toLowerCase().contains(val.toLowerCase()) || element.appointmentEventType.toLowerCase().contains(val.toLowerCase()) || element.strBookedBy.toLowerCase().contains(val.toLowerCase()) ||
            element.engineerName.toLowerCase().contains(val.toLowerCase()) || element.strBookingReference.toLowerCase().contains(val.toLowerCase()) || element.dteBookedDate.toLowerCase().contains(val.toLowerCase()) ||
            element.patchCode.toLowerCase().contains(val.toLowerCase()) || element.strPostCode.toLowerCase().contains(val.toLowerCase()) || element.strJobType.toLowerCase().contains(val.toLowerCase()) || element.strBookedSlotType.toLowerCase().contains(val.toLowerCase())) {
          appointmentList.add(element);
        }
      }
    });
    setState(ViewState.Idle);
  }


  int getCurrentDay(DateTime date) {
    return date.day;
  }

}
