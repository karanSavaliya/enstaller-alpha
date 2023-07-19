// @dart=2.9


import 'dart:convert';

import 'package:enstaller/core/constant/app_string.dart';
import 'package:enstaller/core/model/meter_serial_number_model.dart';
import 'package:enstaller/core/model/send/answer_credential.dart';
import 'package:enstaller/core/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static Future<UserModel> getUser() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    String access_token = preferences.getString("access_token");
    String token_type = preferences.getString('token_type');
    String expires_in = preferences.getString('expires_in');
    String id = preferences.getString('id');
    String intCompanyId = preferences.getString(AppStrings.intCompanyIdKey);
    String username = preferences.getString('username');
    String name = preferences.getString('name');
    String email = preferences.getString('email');
    String role = preferences.getString('role');
    String intEngineerId = preferences.getString('intEngineerId');
    String strEngineerName = preferences.getString('strEngineerName');
    String issued = preferences.getString('.issued');
    String expires = preferences.getString('.expires');
    bool rememberMe = preferences.getBool('remember');
    bool bisNonTechnical = preferences.getBool('bisNonTechnical');

    GlobalVar.roleId = preferences.getInt("roleId");
    GlobalVar.warehosueID = preferences.getString("wareHouseId");
    GlobalVar.bisNonTechnical = bisNonTechnical;

    if (intEngineerId != null) {
      return UserModel(
          id: id,
          accessToken: access_token,
          tokenType: token_type,
          username: username,
          name: name,
          intCompanyId: intCompanyId,
          role: role,
          intEngineerId: intEngineerId,
          strEngineerName: strEngineerName,
          email: email,
          rememberMe: rememberMe,
          issued: issued,
          expires: expires,
          expiresIn: int.parse(expires_in),
          bisNonTechnical: bisNonTechnical);
    } else {
      return UserModel();
    }
  }

  static void setCurrentIndex(int currentIndex) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt("currentIndex", currentIndex);

    preferences.commit();
  }

  static Future getCurrentIndex() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    int currentIndex = preferences.getInt('currentIndex');
    return currentIndex;
  }

  static void setUserProfile(UserModel userModel, {int roleId, String wareHouseId}) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("access_token", userModel.accessToken.toString());
    preferences.setString("token_type", userModel.tokenType);
    preferences.setString("expires_in", userModel.expiresIn.toString());
    preferences.setString("id", userModel.id);
    preferences.setString(AppStrings.intCompanyIdKey, userModel.intCompanyId);
    preferences.setString("username", userModel.username);
    preferences.setString("email", userModel.email);
    preferences.setString("name", userModel.name);
    preferences.setString('role', userModel.role);
    preferences.setString('intEngineerId', userModel.intEngineerId);
    preferences.setString('strEngineerName', userModel.strEngineerName);
    preferences.setString('.issued', userModel.issued);
    preferences.setString('.expires', userModel.expires);
    preferences.setBool('remember', userModel.rememberMe);
    preferences.setInt('roleId', roleId);
    preferences.setString('wareHouseId', wareHouseId);
    preferences.setBool('bisNonTechnical', userModel.bisNonTechnical);
    preferences.commit();
  }

  static void logOut() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();

    preferences.setString("access_token", null);
    preferences.setString("token_type", null);
    preferences.setString("expires_in", null);
    preferences.setString("id", null);
    preferences.setString(AppStrings.intCompanyIdKey, null);
    preferences.setString("username", null);
    preferences.setString("name", null);
    preferences.setString('role', null);
    preferences.setString('intEngineerId', null);
    preferences.setString('strEngineerName', null);
    preferences.setString('.issued', null);
    preferences.setString('.expires', null);
    preferences.setInt('roleId', null);
    preferences.setString('wareHouseId', null);
    preferences.setBool('bisNonTechnical', null);
    preferences.commit();
  }

  static void setFirstTime() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool('isLogin', true);
    preferences.commit();
  }

  static Future<bool> getFirstTime() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool('isLogin') ?? false;
  }

  static Future<void> saveMeterSerialNoData(String response) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    UserModel loginUser = await getUser();
    preferences.setString("MeterSerialNo+${loginUser.id}}", response);
    preferences.commit();
    print("Response Saved: =====>");
  }

  static Future<List<MeterSerialNumber>> getMeterSerialNoList() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    UserModel loginUser = await getUser();
    String body = preferences.getString("MeterSerialNo+${loginUser.id}}");
    print("Meter Serial No List: --> " + body);
    if (body != null && body.isNotEmpty) {
      return (json.decode(body) as List)
          .map((e) => MeterSerialNumber.fromJson(e))
          .toList();
    }
    return [];
  }

  static List<String> validMSNSurveyQuestion = [
    "scan/type new electricity msn",
    "new regulator serial number",
    "scan electricity meter serial number",
    "scan gas meter serial number"
  ];

  static bool checkForSerialNoForQuestion(String questionText) {
    if (validMSNSurveyQuestion.contains(questionText.toLowerCase())) {
      return true;
    }
    return false;
  }

  static Future<bool> isValidSerialNoIsAssigned(
      String serialNo, String questionText) async {
    if (validMSNSurveyQuestion.contains(questionText.toLowerCase())) {
      List<MeterSerialNumber> list = await Prefs.getMeterSerialNoList();
      if (list.length > 0) {
        MeterSerialNumber model;
        list.forEach((element) {
          if (element.strSerialNo == serialNo) {
            model = element;
          }
        });
        return (model != null);
      } else {
        return false;
      }
    }
    return true; // Default
  }
}
