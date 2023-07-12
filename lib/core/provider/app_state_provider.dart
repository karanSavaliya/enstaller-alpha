//@dart=2.9
import 'dart:io';
import 'package:flutter/material.dart';
import '../constant/api_urls.dart';
import '../model/engineer_document_model.dart';
import '../service/api.dart';

class AppStateProvider extends ChangeNotifier {
  AppStateProvider();

  List<EngineerDocumentModel> engineerDocumentDoneObj;
  final List<EngineerDocumentModel> _engineerDocumentList = [];
  List<EngineerDocumentModel> get engineerDocumentList => _engineerDocumentList;
  bool _loading = false;
  bool get loading => _loading;

  Future<void> getEngineerDocument() async {
    _loading = true;
    notifyListeners();
    try {
      engineerDocumentDoneObj = await Api().fetchEngineerDocuments(ApiUrls.engineerDocumentList);
      _engineerDocumentList.clear();
      for (var element in engineerDocumentDoneObj) {
        _engineerDocumentList.add(element);
      }
      _loading = false;
    } on SocketException {
      _loading = false;
    } catch (e) {
      _loading = false;
    }
    notifyListeners();
  }

  bool _searchBool = false;
  bool get searchBool => _searchBool;

  void onClickSearch() {
    if (_searchBool) {
      _searchBool = false;
      notifyListeners();
    }
    else{
      _searchBool = true;
      notifyListeners();
    }
  }

  List<EngineerDocumentModel> oldEngineerDocumentList = [];

  void onSearch(String val) {
    oldEngineerDocumentList = _engineerDocumentList;
    engineerDocumentList.clear();
    _engineerDocumentList.clear();
    notifyListeners();
    oldEngineerDocumentList.forEach((element) {
      if (element.docTypeName.toLowerCase().contains(val.toLowerCase()) ||
          element.strEngDocument.toLowerCase().contains(val.toLowerCase())) {
        _engineerDocumentList.add(element);
        notifyListeners();
      }
    });
  }
}