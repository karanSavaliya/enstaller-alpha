// @dart=2.9

import 'package:connectivity/connectivity.dart';
import 'package:enstaller/core/constant/app_string.dart';
import 'package:enstaller/core/constant/appconstant.dart';
import 'package:enstaller/core/enums/view_state.dart';
import 'package:enstaller/core/model/activity_details_model.dart';
import 'package:enstaller/core/model/appointmentDetailsModel.dart';
import 'package:enstaller/core/model/customer_details.dart';
import 'package:enstaller/core/model/elec_closejob_model.dart';
import 'package:enstaller/core/model/electric_and_gas_metter_model.dart';
import 'package:enstaller/core/model/response_model.dart';
import 'package:enstaller/core/model/send/answer_credential.dart';
import 'package:enstaller/core/model/send/appointmentStatusUpdateCredential.dart';
import 'package:enstaller/core/model/user_model.dart';
import 'package:enstaller/core/provider/base_model.dart';
import 'package:enstaller/core/service/api_service.dart';
import 'package:enstaller/core/service/geo_service.dart';
import 'package:enstaller/core/service/pref_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:encrypt/encrypt.dart' as AESencrypt;
import 'package:shared_preferences/shared_preferences.dart';

class DetailsScreenViewModel extends BaseModel {
  Map<String, String> _processid = {
    "EMREM": "6",
    "GMREM": "81",
    "GICOM": "79",
    "EICOM": "1"
  };
  Map<int, String> _smest2displaybutton = {
    0: "EMREM",
    1: "GMREM",
    2: "EMREM+GMREM",
    3: "EMREM",
    4: "EICOM",
    5: "GICON",
    6: "EICOM+GICOM",
    7: "EICOM"
  };
  Map<String, int> _appointmenttype = {
    "Electric SMETS2 Meter Exchange": 0,
    "Dual SMETS2 Meter Exchange": 2,
    "Gas SMETS2 Meter Exchange": 1,
    "Emergency Exchange Electric": 0,
    "Emergency Exchange Gas": 1
  };
  Map<String, Map<String, int>> _appointmentandjobtype = {
    "Meter removal, Scheduled Exchange, Emergency Exchange, New Connection": {
      // "SMETS2 1ph Elec": 0,
      // "SMETS2 Gas": 1,
      // "SMETS2 Dual": 2,
      // "SMETS2 3ph Elec": 3,
      // "Electric SMETS2 Meter Exchange" : 0,
      // "Dual SMETS2 Meter Exchange" : 2,
      // "Gas SMETS2 Meter Exchange" : 1,
      // "Emergency Exchange Electric" : 0,
      // "Emergency Exchange Gas" : 1
    },
    // "New Connection": {
    //   "SMETS2 1ph Elec": 4,
    //   "SMETS2 Gas": 5,
    //   "SMETS2 Dual": 6,
    //   "SMETS2 3ph Elec": 7
    // }
  };

  CheckCloseJobModel checkCloseJobModel;
  String pincode;
  ApiService _apiService = ApiService();
  List<Appointment> appointMentList = [];
  List<ActivityDetailsModel> activityDetailsList = [];
  AppointmentDetails appointmentDetails;
  List<ElectricAndGasMeterModel> electricGasMeterList = [];
  List<ElectricAndGasMeterModel> electricMeterList = [];
  List<ElectricAndGasMeterModel> gasMeterList = [];
  CustomerDetails customerDetails;
  Map<String, bool> isformfilled = {};
  String selectedStatus;
  String latlngmap = "";
  UserModel user;
  final Connectivity _connectivity = Connectivity();
  SharedPreferences preferences;

  List<String> statusList = [
    AppStrings.enRoute,
    AppStrings.onSite_,
    AppStrings.unScheduled,
    AppStrings.started,
    AppStrings.cancelled,
    AppStrings.aborted,
    AppStrings.completed
  ];

  void onSelectStatus(String value) {
    setState(ViewState.Busy);
    selectedStatus = value;

    setState(ViewState.Idle);
  }

  String _updateConnectionStatus(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.wifi:
        return "WIFI";
        break;
      case ConnectivityResult.mobile:
        return "MOBILE";
        break;
      case ConnectivityResult.none:
        return "NONE";
        break;
      default:
        return "NO RECORD";
        break;
    }
  }

  void getActivityDetailsList(String appointmentID) async {
    setState(ViewState.Busy);
    print('appId=${appointmentID}');
    activityDetailsList = await _apiService.getActivityLogsAppointmentId(
        appointmentID, user.intCompanyId);
    setState(ViewState.Idle);
  }


  String vals_enroute;
  void checkifEnrouted() async {

    UserModel user = await Prefs.getUser();
    vals_enroute = await _apiService.checkIfEnrouted(user);

  }



  void initializeData(String appointmentID, String customerID) async {
    setState(ViewState.Busy);
    preferences = await SharedPreferences.getInstance();
    user = await Prefs.getUser();
    ConnectivityResult result = await _connectivity.checkConnectivity();
    String status = _updateConnectionStatus(result);
    if (status != "NONE") {
      activityDetailsList = await _apiService.getActivityLogsAppointmentId(
          appointmentID, user.intCompanyId);
      appointmentDetails = await _apiService.getAppointmentDetails(
          appointmentID, user.intCompanyId);
      electricGasMeterList = await _apiService.getCustomerMeterListByCustomer(
          customerID , user.intCompanyId);
      customerDetails =
          await _apiService.getCustomerById(customerID, user.intCompanyId);
      checkCloseJobModel =
          await _apiService.getTableById(appointmentID, user.intCompanyId);

      final location = await GeoLocationService.getAddressFromPinCode(customerDetails.strPostCode);
      latlngmap = location.coordinates.latitude.toString()+","+location.coordinates.longitude.toString();

      setMeterData();
      int id = _checkbuttonindex(appointmentDetails);
      if (id != null) {
        if (id != 2 && id != 6) {
          isformfilled[_smest2displaybutton[id]] = await _formfilledornot(
              customerID, _processid[_smest2displaybutton[id]]);
        } else {
          List<String> _elementlist = _smest2displaybutton[id].split("+");
          for (int i = 0; i < 2; i++) {
            isformfilled[_elementlist[i]] =
                await _formfilledornot(customerID, _processid[_elementlist[i]]);
          }
        }
      }

      if (statusList
          .contains(appointmentDetails.appointment.appointmentEventType)) {
        selectedStatus = appointmentDetails.appointment.appointmentEventType;
      } else {
        if (appointmentDetails.appointment.appointmentEventType ==
            AppStrings.onSite) {
          selectedStatus = AppStrings.onSite_;
        }
      }
    }

    setState(ViewState.Idle);
  }

  void setMeterData() {
    electricMeterList = electricGasMeterList
        .where((element) => element.strFuel == AppStrings.ELECTRICITY)
        .toList();
    gasMeterList = electricGasMeterList
        .where((element) => element.strFuel == AppStrings.GAS)
        .toList();


  }

  int _checkbuttonindex(appointmentDetails) {
    int id;
    id = _appointmenttype[appointmentDetails.appointment.strJobType.trim()];

    // _appointmentandjobtype.forEach((key, value) {
    //   if (key
    //       .contains(appointmentDetails.appointment.strAppointmentType.trim())) {
    //   }
    // });
    return id;
  }

  bool isSurveyEnable() {
    bool isEnable = true;
    if (appointmentDetails.appointment.bisAbortRequested == true) {
      isEnable = false;
    }
    if (appointmentDetails.appointment.bisAbortRequestApproved == true) {
      isEnable = false;
    }
    if (appointmentDetails.appointment.appointmentEventType == "Scheduled") {
      isEnable = false;
    }
    return isEnable;
  }

  Future<bool> _formfilledornot(String customerID, String processId) async {
    UserModel user = await Prefs.getUser();
    ResponseModel responseModel = await _apiService.getMAICheckProcess(
        customerID, processId, user.intCompanyId);
    if (responseModel.statusCode == 1) {
      return true;
    } else {
      return false;
    }
  }

  void onUpdateStatus(BuildContext context, String appointmentID) async {
    setState(ViewState.Busy);
    if (selectedStatus != null) {
      ResponseModel response = await _apiService.updateAppointmentStatus(
          AppointmentStatusUpdateCredentials(
              strStatus: selectedStatus != AppStrings.enRoute
                  ? selectedStatus
                  : AppStrings.onRoute,
              intBookedBy: user.intEngineerId.toString(),
              intEngineerId: user.intEngineerId.toString(),
              strEmailActionby: "Send by Engineer",
              intId: appointmentDetails.appointment.intId.toString(),
              intCompanyId: user.intCompanyId));
      if (response.statusCode == 1) {
        appointmentDetails = await _apiService.getAppointmentDetails(
            appointmentID, user.intCompanyId);
        Navigator.pop(context);
      } else {
        AppConstants.showFailToast(context, response.response);
      }
    } else {
      AppConstants.showFailToast(context, 'Please select status');
    }

    setState(ViewState.Idle);
  }

  bool isSurveySubmitted() {
    List<String> _listofEachKey = preferences
            .getStringList("saved+${appointmentDetails.appointment.intId}") ??
        [];
    if (appointmentDetails.appointment.surveyReceived != "No") {
      return true;
    } else if (_listofEachKey.isNotEmpty) {
      return true;
    }
    return false;
  }

  bool showChangeAppointmentStatusButton() {
    String eventType = appointmentDetails.appointment.appointmentEventType;
    print("Appointment status =======> " + eventType);
    bool surveySubmitted = isSurveySubmitted();
    if (eventType == AppStrings.EnRoute) {
      return true;
    } else if (eventType == AppStrings.onSite && !surveySubmitted) {
      return true;
    }
    return false;
  }

  Future<bool> onUpdateStatusOnSchedule(
      BuildContext context, String appointmentID) async {
    ConnectivityResult result = await _connectivity.checkConnectivity();
    String status = _updateConnectionStatus(result);
    if (status != "NONE") {
      try {
        ResponseModel response = await _apiService.assignEnginerAppointment(
            AppointmentStatusUpdateCredentials(
                strStatus: user.username,
                intBookedBy: user.intEngineerId.toString(),
                intEngineerId: user.intEngineerId.toString(),
                strEmailActionby: "Send by User",
                intId: appointmentID,
                intUserId: user.id,
                intCompanyId: user.intCompanyId));

        print(AppointmentStatusUpdateCredentials(
            strStatus: "",
            intBookedBy: user.intEngineerId.toString(),
            intEngineerId: user.intEngineerId.toString(),
            strEmailActionby: "Send by User",
            intId: appointmentID,
            intUserId: user.id).toString());
        if (response.statusCode == 1) {
          GlobalVar.isloadAppointmentDetail = true;
          GlobalVar.isloadDashboard = true;
          return true;
        } else {
          AppConstants.showFailToast(context, response.response);
          return false;
        }
      } catch (e) {
        AppConstants.showFailToast(context, e.toString());
        return false;
      }
    }
    return false;
  }

  void onUpdateStatusOnSite(BuildContext context, String appointmentID) async {

    try {
      ResponseModel response = await _apiService.updateAppointmentStatus(
          AppointmentStatusUpdateCredentials(
              strStatus: "On Site",
              intBookedBy: user.intEngineerId.toString(),
              intEngineerId: user.intEngineerId.toString(),
              strEmailActionby: "Send by Engineer",
              intId: appointmentID,
              intUserId: user.id));
      if (response.statusCode == 1) {
        GlobalVar.isloadAppointmentDetail = true;
        GlobalVar.isloadDashboard = true;
      } else {
        AppConstants.showFailToast(context, response.response);
      }
    } catch (e) {
      AppConstants.showFailToast(context, e.toString());
    }
  }

  void onUpdateStatusOnRoute(BuildContext context, String appointmentID) async {

    try {
      ResponseModel response = await _apiService.updateAppointmentStatus(
          AppointmentStatusUpdateCredentials(
              strStatus: "On Route",
              intBookedBy: user.intEngineerId.toString(),
              intEngineerId: user.intEngineerId.toString(),
              strEmailActionby: "Send by Engineer",
              intId: appointmentID,
              intUserId: user.id));
      if (response.statusCode == 1) {
        GlobalVar.isloadDashboard = true;
      } else {
        AppConstants.showFailToast(context, response.response);
      }
    } catch (e) {

      print(e.toString()+"________");
      AppConstants.showFailToast(context, e.toString());
    }
  }

  void onUpdateStatusOnCompleted(
      BuildContext context, String appointmentID) async {
    try {
      ResponseModel response = await _apiService.updateAppointmentStatus(
          AppointmentStatusUpdateCredentials(
              strStatus: "Completed",
              intBookedBy: user.intEngineerId.toString(),
              intEngineerId: user.intEngineerId.toString(),
              strEmailActionby: "Send by Engineer",
              intId: appointmentID,
              intCompanyId: user.intCompanyId));
      if (response.statusCode == 1) {
        //AppConstants.showSuccessToast(context, "Status Updated");
        GlobalVar.isloadAppointmentDetail = true;
        GlobalVar.isloadDashboard = true;
      } else {
        AppConstants.showFailToast(context, response.response);
      }
    } catch (e) {
      GlobalVar.isloadAppointmentDetail = true;
      GlobalVar.isloadDashboard = true;
      AppConstants.showFailToast(context, e.toString());
    }
  }

  void onRaiseButtonPressed(String customerid, String processId) async {
    setState(ViewState.Busy);
    UserModel userModel = await Prefs.getUser();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String ups = preferences.getString('ups');

    if (processId == "79" || processId == "81") {
      startGasProcess(processId, userModel, ups, customerid);
    } else {
      startElecProcess(processId, userModel, ups, customerid);
    }
    setState(ViewState.Idle);
  }



  startElecProcess(
      String processId, UserModel userModel, String ups, String customerID) {
    try {
      var custId = customerID;
      var DCCMAIWebUrl = 'https://mai.enpaas.com/';

      ElectricAndGasMeterModel model = electricGasMeterList
          .firstWhere((element) => element.strFuel == "ELECTRICITY");
      var mpan = model.strMpan;
      var em = userModel.email.toString();
      var sessionId = userModel.id.toString();
      if (mpan == null || mpan == '') {
      } else {
        var strUrl = '';
        var strPara = '';
        var strEncrypt;
        strPara += 'Enstaller/' +
            custId +
            '/' +
            processId +
            '/' +
            mpan +
            '/' +
            ups +
            '/' +
            sessionId +
            '/' +
            '108' +
            '/' +
            em;

        strEncrypt = encryption(strPara);
        strUrl += '' + DCCMAIWebUrl + '?returnUrl=' + strEncrypt + '';

        launchurl(strUrl);
      }
    } catch (err) {
      print(err);
    }
  }

  startGasProcess(
      String processId, UserModel userModel, String ups, String customerID) {
    var custId = customerID;
    try {
      ElectricAndGasMeterModel model = electricGasMeterList
          .firstWhere((element) => element.strFuel == "GAS");
      var mpan = model.strMpan;
      var em = userModel.email.toString();
      var sessionId = userModel.id.toString();
      var DCCMAIWebUrl = 'https://mai.enpaas.com/';
      if (mpan == null || mpan == '') {
      } else {
        var strUrl = '';
        var strEncrypt;
        var strPara = '';
        strPara += 'Enstaller/' +
            custId +
            '/' +
            processId +
            '/' +
            mpan +
            '/' +
            ups +
            '/' +
            sessionId +
            '/' +
            '109' +
            '/' +
            em;
        strEncrypt = encryption(strPara);
        strUrl += '' + DCCMAIWebUrl + '?returnUrl=' + strEncrypt + '';
        launchurl(strUrl);
      }
    } catch (err) {
      print(err);
    }
  }

  encryption(String value) {
    final key = AESencrypt.Key.fromUtf8('8080808080808080');
    final iv = AESencrypt.IV.fromUtf8('8080808080808080');
    final encrypter = AESencrypt.Encrypter(
        AESencrypt.AES(key, mode: AESencrypt.AESMode.cbc, padding: 'PKCS7'));

    final encrypted = encrypter.encrypt(value, iv: iv);

    return encrypted.base64
        .toString()
        .replaceAll('/', 'SLH')
        .replaceAll('+', 'PLS')
        .replaceAll('/', 'SLH')
        .replaceAll('/', 'SLH')
        .replaceAll('/', 'SLH')
        .replaceAll('/', 'SLH')
        .replaceAll('+', 'PLS')
        .replaceAll('+', 'PLS')
        .replaceAll('+', 'PLS')
        .replaceAll('+', 'PLS');
  }

  launchurl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not open the map.';
    }
  }
}
