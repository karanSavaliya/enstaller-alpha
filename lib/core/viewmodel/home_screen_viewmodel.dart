// @dart=2.9


import 'package:enstaller/core/enums/view_state.dart';
import 'package:enstaller/core/model/app_table.dart';
import 'package:enstaller/core/model/appointmentDetailsModel.dart';
import 'package:enstaller/core/model/user_model.dart';
import 'package:enstaller/core/provider/base_model.dart';
import 'package:enstaller/core/service/api_service.dart';
import 'package:enstaller/core/service/pref_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreenViewModel extends BaseModel {
  ApiService _apiService = ApiService();

  List<Appointment> masterAppointmentList = [];
  List<DateTime> uniqueDates = [];

  bool dateSelected = false;
  List<AppTable> tables = [];
  int selectedIndex;

  void onSelectIndex(int value) {
    setState(ViewState.Busy);
    if (selectedIndex != value) {
      selectedIndex = value;
    } else {
      selectedIndex = null;
    }
    setState(ViewState.Idle);
  }

  void onToggleDateSelected() {
    setState(ViewState.Busy);
    dateSelected = !dateSelected;
    setState(ViewState.Idle);
  }

  Future getAppointmentList() async {
    UserModel userModel = await Prefs.getUser();
    // Fetch Appointment List
    setState(ViewState.Busy);
    print("int engineer id-------------${userModel.intEngineerId}");
    masterAppointmentList = await _apiService
        .getAppointmentList(userModel.intEngineerId.toString());
    setUniqeDates();
    if (uniqueDates.length > 0) {
      setTableData(uniqueDates[0], masterAppointmentList);
    }

    await _apiService.storeMeterSerialNoForEngineer(userModel.id);
    masterAppointmentList.removeWhere((element) => element.appointmentEventType == "Cancelled" || element.appointmentEventType == "Aborted" || element.appointmentEventType == "Completed");

    setState(ViewState.Idle);
  }


  void setUniqeDates() {
    setState(ViewState.Busy);
    uniqueDates.clear();


    masterAppointmentList.forEach((element) {
      DateTime date = DateTime.parse(element.dteBookedDate.split("T").first);
      if (!uniqueDates.contains(date) && (element.strStatus != "Cancelled"  && element.strStatus != "Aborted")) {
        uniqueDates.add(date);
      }
    });
    uniqueDates.sort((a, b) {
      return -a.compareTo(b);
    });
    print("Unique dates-------------$uniqueDates");
    setState(ViewState.Idle);
  }


  void setTableData(DateTime date, List<Appointment> appointments) {
    setState(ViewState.Busy);
    tables = [];
    appointments.forEach((element) {
      DateTime elementDate =
          DateTime.parse(element.dteBookedDate.split("T").first);
      print("$date == $elementDate");
      if (date == elementDate) {
        print("True");
        tables.add(AppTable.fromJson(element.toJson()));
      }
    });
    print("setTableData------$date-------${tables.length}");
    setState(ViewState.Idle);
  }


}
