//@dart=2.9
import 'dart:convert';
import 'package:enstaller/core/constant/api_urls.dart';
import 'package:enstaller/core/service/pref_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../model/engineer_document_model.dart';
import '../model/engineer_qualification_model.dart';
import '../model/last_appointment_status_model.dart';
import '../model/save_sapphire_electricity_flow_model.dart';
import '../model/save_sapphire_gas_flow_model.dart';
import '../model/user_model.dart';

class Api {
  Future<List<EngineerDocumentModel>> fetchEngineerDocuments(String apiUrl) async {
    UserModel user = await Prefs.getUser();
    Uri uri = Uri.parse(apiUrl);
    Map<String, dynamic> requestData = {
      'EngineerId': user.intEngineerId.toString(),
      'RowsPerPage': 10,
      'PageNumber': 1,
      'strsearchtxt': "",
    };
    final response = await http.post(
      uri,
      headers: {
        'Authorization': 'Bearer ${user.accessToken}',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestData),
    );
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((json) => EngineerDocumentModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  Future<SaveSapphireGasFlow> saveSapphireGasFlow(BuildContext context, Map<String, dynamic> jsonData) async {
    UserModel user = await Prefs.getUser();
    Uri uri = Uri.parse(ApiUrls.saveSapphireGasFlow);
    final response = await http.post(
      uri,
      headers: {
        'Authorization': 'Bearer ${user.accessToken}',
        'Content-Type': 'application/json',
      },
      body: json.encode(jsonData),
    );
    if (response.statusCode == 200) {
      SaveSapphireGasFlow apiResponse = SaveSapphireGasFlow.fromJson(json.decode(response.body));
      return apiResponse;
    } else {
      throw Exception('Failed to insert data');
    }
  }

  Future<SaveSapphireElectricityFlow> saveSapphireElectricityFlow(BuildContext context, Map<String, dynamic> jsonData) async {
    UserModel user = await Prefs.getUser();
    Uri uri = Uri.parse(ApiUrls.saveSapphireElectricityFlow);
    final response = await http.post(
      uri,
      headers: {
        'Authorization': 'Bearer ${user.accessToken}',
        'Content-Type': 'application/json',
      },
      body: json.encode(jsonData),
    );
    if (response.statusCode == 200) {
      SaveSapphireElectricityFlow apiResponse = SaveSapphireElectricityFlow.fromJson(json.decode(response.body));
      return apiResponse;
    } else {
      throw Exception('Failed to insert data');
    }
  }

  Future<List<EngineerQualificationModel>> fetchEngineerQualification(String apiUrl) async {
    UserModel user = await Prefs.getUser();
    Map<String, dynamic> queryParams = {
      'intEngineerId': user.intEngineerId.toString(),
    };
    Uri uri = Uri.parse(apiUrl).replace(queryParameters: queryParams);
    final response = await http.get(
      uri,
      headers: {
        'Authorization': 'Bearer ${user.accessToken}',
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((json) => EngineerQualificationModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  Future<List<LastAppointmentStatus>> fetchLastAppointmentStatus(String apiUrl,String appointmentId) async {
    UserModel user = await Prefs.getUser();
    Map<String, dynamic> queryParams = {
      'intAppointmentId': appointmentId.toString(),
    };
    Uri uri = Uri.parse(apiUrl).replace(queryParameters: queryParams);
    final response = await http.get(
      uri,
      headers: {
        'Authorization': 'Bearer ${user.accessToken}',
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((json) => LastAppointmentStatus.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  Future<bool> moveToBackOfficeStatusUpdate(String apiUrl,String intAppointmentId) async {
    UserModel user = await Prefs.getUser();
    final Map<String, dynamic> data = {
      "intAppointmentId": intAppointmentId.toString(),
      "bisSurveyBackoffice": true
    };
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Authorization': 'Bearer ${user.accessToken}',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      bool status = jsonResponse["status"];
      return status;
    } else {
      throw Exception('Failed to send POST request');
    }
  } //KARAN (ADD THIS ON LIVE)

  Future<bool> vehicleCheckLogInsert(String apiUrl) async {
    UserModel user = await Prefs.getUser();
    final Map<String, dynamic> data = {
      "intEngineerId":user.intEngineerId.toString(),
      "intUserid":user.id.toString(),
      "bisVehicleCheck":true,
      "intCreatedby":user.id.toString(),
      "intCompanyId":1,
    };
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Authorization': 'Bearer ${user.accessToken}',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      bool status = jsonResponse["status"];
      return status;
    } else {
      throw Exception('Failed to send POST request');
    }
  } //KARAN (ADD THIS ON LIVE)

  Future<bool> vehicleLogGet(String apiUrl) async {
    UserModel user = await Prefs.getUser();
    final Map<String, dynamic> data = {
      "intEngineerId":user.intEngineerId.toString(),
      "intUserid":user.id.toString(),
    };
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Authorization': 'Bearer ${user.accessToken}',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      bool status = jsonResponse["status"];
      return status;
    } else {
      throw Exception('Failed to send POST request');
    }
  } //KARAN (ADD THIS ON LIVE)
}