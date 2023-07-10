// @dart=2.9

import 'package:enstaller/core/constant/appconstant.dart';
import 'package:enstaller/core/enums/view_state.dart';
import 'package:enstaller/core/model/abort_appointment_model.dart';
import 'package:enstaller/core/model/response_model.dart';
import 'package:enstaller/core/model/user_model.dart';
import 'package:enstaller/core/provider/base_model.dart';
import 'package:enstaller/core/service/api_service.dart';
import 'package:enstaller/core/service/pref_service.dart';
import 'package:flutter/cupertino.dart';

class AbortAppointmentViewModel extends BaseModel {
  ApiService _apiService = ApiService();
  List<AbortAppointmentModel> abortlist = [];
  List<String> listofReason = [];
  UserModel user;

  void getAbortAppointmentList() async {
    setState(ViewState.Busy);
    user = await Prefs.getUser();
    abortlist = await _apiService.getAbortAppointmentList(user);
    abortlist.forEach((element) {
      listofReason.add(element.strName);
    });
    setState(ViewState.Idle);
  }

  void onConfirmPressed(BuildContext context,
      ConfirmAbortAppointment confirmAbortAppointment) async {

    setState(ViewState.Busy);

    user = await Prefs.getUser();
    confirmAbortAppointment.intCompanyId = user.intCompanyId;
    ResponseModel response =
        await _apiService.confirmAbortAppointment(confirmAbortAppointment);
    setState(ViewState.Idle);
    if (response.statusCode == 1) {
      AppConstants.showSuccessToast(context, "Abort Appointment Successfull");
    } else {
      AppConstants.showFailToast(context, "Abort Appointment failed");
    }
    Navigator.of(context).pop();

    setState(ViewState.Idle);
  }

}
