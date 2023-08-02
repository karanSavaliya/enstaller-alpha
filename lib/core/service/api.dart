//@dart=2.9
import 'dart:convert';
import 'package:enstaller/core/constant/api_urls.dart';
import 'package:enstaller/core/service/pref_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../model/engineer_document_model.dart';
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
}