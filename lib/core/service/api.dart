//@dart=2.9
import 'dart:convert';
import 'package:enstaller/core/service/pref_service.dart';
import 'package:http/http.dart' as http;
import '../model/engineer_document_model.dart';
import '../model/user_model.dart';

class Api {
  Future<List<EngineerDocumentModel>> fetchEngineerDocuments(String apiUrl) async {
    UserModel user = await Prefs.getUser();
    Uri uri = Uri.parse('$apiUrl?intEngineerId=${int.parse(user.intEngineerId)}');
    final response = await http.get(
      uri,
      headers: {
        'Authorization': 'Bearer ${user.accessToken}',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((json) => EngineerDocumentModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch data');
    }
  }
}