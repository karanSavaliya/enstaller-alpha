// @dart=2.9

import 'dart:convert';
import 'dart:io';
import 'package:enstaller/core/constant/api_urls.dart';
import 'package:enstaller/core/constant/appconstant.dart';
import 'package:enstaller/core/model/user_model.dart';
import 'package:enstaller/core/service/pref_service.dart';
import 'package:enstaller/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'api_error.dart';

GetIt getIt = GetIt.instance;

abstract class BaseApi {
  
  final client = http.Client();
  // HttpClient client1 = HttpClient()
  //   ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;

  @protected
  static Future<Map<String, String>> getHeader(
      bool isAddToken, bool isAddContentType) async {
    UserModel user = await Prefs.getUser();
    Map<String, String> headers = Map<String, String>();
    if (isAddToken) {
      headers.addAll(
          <String, String>{'Authorization': 'Bearer ${user.accessToken}'});
    }
    if (isAddContentType) {
      headers.addAll(<String, String>{
        '${HttpHeaders.contentTypeHeader}': 'application/json'
      });
    }


    print("Request Headers ========> $headers");
    return headers;
  }

  @protected
  Future<dynamic> getRequest(
      String path, Function(Response) success, var param) async {
    print("URL: " + path);
    print("Parameters");
    print(param);

    return _processResponse(
        await client.get(
          Uri.parse(ApiUrls.baseUrl + '$path' + param),
          headers: await getHeader(true, false),
        ), success);
  }

  @protected
  Future<dynamic> getRequestwithoutParam(
      String path, Function(Response) success, var param) async {
    print("URL: " + path);
    return _processResponse(
        await client.get(
            Uri.parse('${ApiUrls.baseUrl}Stock/BindStockStatus' + '?' + param),
          headers: await getHeader(true, false),
        ),
        success);
  }

  @protected
  Future<dynamic> getRequestWithParam(
      String path, Function(Response) success, var param) async {
    print("URL: " + path);
    print("Parameters");
    print(param);
    print(ApiUrls.baseUrl + path + '?' + param);
    return _processResponse(
        await http.get(
            Uri.parse(ApiUrls.baseUrl + path + '?' + param),
          headers: await getHeader(true, false),
        ),
        success);
  }

  @protected
  Future<dynamic> getRequestWithParamOther(
      String path, Function(Response) success, var param) async {
    print("URL: " + path);
    print("Parameters");
    print(param);
    return _processResponse(
        await http.get(
          Uri.parse(ApiUrls.baseUrlOther + path + '?' + param),
          headers: await getHeader(true, false),
        ),
        success);
  }

  @protected
  Future<dynamic> postRequest(String path, Function(Response) success,
      [Map body]) async {
    print("URL: " + path);
    print("Parameters");
    print(body);

    return _processResponse(
        await client.post(
            Uri.parse(ApiUrls.baseUrl + path),
          headers: await getHeader(true, false),
          body: body != null ? body : null,
        ),
        success);
  }

  @protected
  Future<dynamic> postRequestMap(String path, Function(Response) success,
      [Map body]) async {
    print("URL: " + path);
    print("Parameters");
    print(body);

    return _processResponse(
        await client.post(
            Uri.parse(ApiUrls.baseUrl + path),
          headers: await getHeader(true, true),
          body: body != null ? json.encode(body) : null,
        ),
        success);
  }

  @protected
  Future<dynamic> postRequestList(String path, Function(Response) success,
      [var body]) async {
    print("URL: " + path);
    print("Parameters");
    print(body);

    final Directory directory = await getTemporaryDirectory();
    final File file = File('${directory.path}/post_body_file.txt');
    print("File path ---> $file");
    await file.writeAsString(body.toString());

    var response = await client.post(Uri.parse('${ApiUrls.baseUrl}/$path'),
        headers: await getHeader(true, true), body: (body));

    if (200 >= response.statusCode && response.statusCode < 300) {
      return success(response);
    } else {
      print(response.body);
      return ApiError.fromJson(json.decode(response.body));
    }
  }

  @protected
  Future<dynamic> putRequest(String path, Function(Response) success,
      [Map body]) async {
    print("URL: " + path);
    print("Parameters");
    print(body);

    return _processResponse(
        await client.put(Uri.parse('${ApiUrls.baseUrl}/$path'),
            headers: await getHeader(true, false),
            body: body != null ? jsonEncode(body) : null),
        success);
  }

  @protected
  Future<dynamic> deleteRequest(String path, Function(Response) success) async {
    print("URL: " + path);
    return _processResponse(
        await client.delete(Uri.parse('${ApiUrls.baseUrl}/$path'),
            headers: await getHeader(true, false)),
        success);
  }

  dynamic _processResponse(Response response, Function(Response) success) {
    if (200 >= response.statusCode && response.statusCode < 300) {
      return success(response);
    } else {
      print("000000000000000");
      print(response.body);
      final errorMessage = json.decode(response.body)['message'];
      if (errorMessage == "Authorization has been denied for this request." &&
          response.statusCode == 401) {
        Prefs.logOut();
        GlobalVariable.navState.currentState
            .pushNamedAndRemoveUntil("/login", (Route<dynamic> route) => false);
        AppConstants.showFailToast(GlobalVariable.navState.currentContext,
            "App login session is expired. Please login again.");
      }
      return ApiError.fromJson(json.decode(response.body));
    }
  }
}
