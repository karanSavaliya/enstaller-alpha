// @dart=2.9

import 'package:enstaller/core/model/non_technical_user_models/agent_model.dart';
import 'package:enstaller/core/model/non_technical_user_models/agent_report_model.dart';

class AgentResponseModel {
  List<AgentModel> agentList;
  List<AgentReportModel> agentReportList;

  AgentResponseModel({
    this.agentList,
    this.agentReportList,
  });

  AgentResponseModel.fromJson(Map<String, dynamic> json) {
    agentList =
        (json['firstList'] as List).map((e) => AgentModel.fromJson(e)).toList();

    agentReportList = (json['secondList'] as List)
        .map((e) => AgentReportModel.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstList'] = this.agentList.map((e) => e.toJson());
    data['secondList'] = this.agentList.map((e) => e.toJson());
    return data;
  }
}
