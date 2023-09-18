// @dart=2.9

import 'dart:io';

import 'package:enstaller/core/constant/app_string.dart';
import 'package:enstaller/core/constant/appconstant.dart';
import 'package:enstaller/core/enums/view_state.dart';
import 'package:enstaller/core/model/response_model.dart';
import 'package:enstaller/core/model/send/answer_credential.dart';
import 'package:enstaller/core/model/stock_update_model.dart';
import 'package:enstaller/core/model/user_model.dart';
import 'package:enstaller/core/provider/base_model.dart';
import 'package:enstaller/core/service/api_service.dart';
import 'package:enstaller/core/service/pref_service.dart';
import 'package:enstaller/ui/util/MessagingService/FirebaseMessaging.dart';
import 'package:external_path/external_path.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class StockUpdateStatusViewModel extends BaseModel {
  List<StockLocationModel> stockLocationList = [];
  List<StockStatusModel> stockStatusList = [];
  List<StockBatchModel> stockBatchList = [];

  List<DropdownMenuItem<String>> stockLocationListItems = [];
  List<DropdownMenuItem<String>> stockStatusListItems = [];
  List<DropdownMenuItem<String>> stockBatchListItems = [];

  List<StockPalletModel> stockPalletList = [];
  DownLoadFormatModel downLoadFormatModel = DownLoadFormatModel();
  String lValue;
  int lid;
  String sValue;
  int sid;
  String bValue;
  String comment;
  String strType;
  int count = 1;

  ApiService _apiService = ApiService();

  initializeData() async {
    setState(ViewState.Busy);
    stockLocationList = [];
    stockStatusList = [];
    stockBatchList = [];
    stockPalletList = [];
    print("warehouse id  ${GlobalVar.warehosueID}");
    UserModel user = await Prefs.getUser();
    stockLocationList = await _apiService.getStockLocation(
        GlobalVar.warehosueID, user.intCompanyId);
    stockStatusList = await _apiService.getStockStatus(user);
    stockBatchList = await _apiService.getStockBatch(
        GlobalVar.warehosueID, user.intCompanyId);

    stockLocationListItems = [];
    stockLocationList.forEach((element) {
      var locationName = element.locationName;
      var isExist = stockLocationListItems
          .where((element) => element.value == locationName.toString());
      if (isExist.length > 0) {
        locationName = "$locationName⠀";
      }
      stockLocationListItems.add(DropdownMenuItem<String>(
          child: Text(locationName), value: locationName.toString()));
    });

    stockStatusListItems = [];
    stockStatusList.forEach((element) {
      var strStatusName = element.strStatusName;
      var isExist = stockStatusListItems
          .where((element) => element.value == strStatusName.toString());
      if (isExist.length > 0) {
        strStatusName = "$strStatusName⠀";
      }
      stockStatusListItems.add(DropdownMenuItem<String>(
          child: Text(strStatusName), value: strStatusName.toString()));
    });

    stockBatchListItems = [];
    stockBatchList.forEach((element) {
      var strBatchNumber = element.strBatchNumber;
      var isExist = stockBatchListItems
          .where((element) => element.value == strBatchNumber.toString());
      if (isExist.length > 0) {
        strBatchNumber = "$strBatchNumber";
      }
      stockBatchListItems.add(DropdownMenuItem<String>(
          child: Text(strBatchNumber), value: strBatchNumber.toString()));
    });

    setState(ViewState.Idle);
  }

  getPallets(int batchId) async {
    setState(ViewState.Busy);
    UserModel user = await Prefs.getUser();
    stockPalletList = [];
    stockPalletList =
        await _apiService.getPallet(batchId.toString(), user.intCompanyId);
    print("pallet length ----${stockPalletList.length}");
    setState(ViewState.Idle);
  }

  onDownloadPressed(BuildContext context) async {
    setState(ViewState.Busy);
    UserModel user = await Prefs.getUser();
    downLoadFormatModel = await _apiService.getDownloadFormat(
        "GetStockDemoFilesPath", user.intCompanyId);

    print(downLoadFormatModel.strKey);
    String url = downLoadFormatModel.strValue + "Upload/Demo/demo_stocks.csv";

    var request = await HttpClient().getUrl(Uri.parse(url));
    var response = await request.close();
    var bytes = await consolidateHttpClientResponseBytes(response);
    var storagePermission = await Permission.storage.status;

    if (!storagePermission.isGranted) {
      await Permission.storage.request();
    }

    storagePermission = await Permission.storage.status;
    if (storagePermission.isGranted) {
      final String dir = await ExternalPath.getExternalStoragePublicDirectory(
          ExternalPath.DIRECTORY_DOWNLOADS);
      final String path = '$dir/${count}demoStock.csv';
      count++;
      final File file = File(path);
      await file.writeAsBytesSync(bytes);
      // final String dir = await ExternalPath.getExternalStoragePublicDirectory(ExtStorage.DIRECTORY_DOCUMENTS);
      // path = '$dir/demoStock.csv';
      // final File file = File(path);
      // await file.writeAsBytesSync(bytes);

      AppConstants.showSuccessToast(context, AppStrings.SAVED_SUCCESSFULLY);
      FirebaseMessagingService.showNotification("File Downloaded", path);
    } else {
      AppConstants.showFailToast(context, AppStrings.UNABLE_TO_SAVE);
    }
    setState(ViewState.Idle);
  }

  save(BuildContext context, StockStatusSaveModel stockStatusSaveModel) async {
    setState(ViewState.Busy);
    try {
      ResponseModel responseModel =
          await _apiService.saveStatusUpdate(stockStatusSaveModel);
      if (responseModel.statusCode == 1) {
        AppConstants.showSuccessToast(context, responseModel.response);
        Navigator.pop(context);
      } else {
        AppConstants.showFailToast(
            context, "Please select correct location and try again.");
      }
    } catch (e) {
      AppConstants.showFailToast(context, e.toString());
      print(e);
    }
    setState(ViewState.Idle);
  }
}
