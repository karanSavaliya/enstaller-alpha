// @dart=2.9

import 'package:enstaller/core/enums/view_state.dart';
import 'package:enstaller/core/model/app_table.dart';
import 'package:enstaller/core/model/non_technical_user_models/agent_model.dart';
import 'package:enstaller/core/model/non_technical_user_models/agent_report_model.dart';
import 'package:enstaller/core/model/non_technical_user_models/agent_response_model.dart';
import 'package:enstaller/core/model/user_model.dart';
import 'package:enstaller/core/provider/base_model.dart';
import 'package:enstaller/core/service/api_service.dart';
import 'package:enstaller/core/service/pref_service.dart';

class CustomerListScreenVM extends BaseModel {
  ApiService _apiService = ApiService();

  List<AgentModel> masterAgentList = [];
  List<AgentReportModel> masterReportList = [];

  int selectedAgentId = 0;
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

  void onToggleSelectedAgentId(int agentId) {
    setState(ViewState.Busy);
    if (selectedAgentId == agentId) {
      selectedAgentId = 0;
    } else {
      selectedAgentId = agentId;
    }
    setState(ViewState.Idle);
  }

  Future getAgentList() async {
    UserModel userModel = await Prefs.getUser();
    // Fetch Appointment List
    setState(ViewState.Busy);
    AgentResponseModel model =
        await _apiService.getAgentListByLoginUser(userModel);
    masterAgentList = model.agentList;
    masterReportList = model.agentReportList;
    setState(ViewState.Idle);
  }
}
