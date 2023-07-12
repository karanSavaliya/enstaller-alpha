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
    } else {
      _searchBool = true;
      notifyListeners();
    }
  }

  final List<EngineerDocumentModel> _filteredEngineerDocumentList = [];
  List<EngineerDocumentModel> get filteredEngineerDocumentList => _filteredEngineerDocumentList;

  bool _searchBoxType = false;
  bool get searchBoxType => _searchBoxType;

  void performSearch(String query) {
    query = query.toLowerCase();
    _filteredEngineerDocumentList.clear();
    if (query.isNotEmpty) {
      _searchBoxType = true;
      notifyListeners();
      for (var document in _engineerDocumentList) {
        if (document.docTypeName.toLowerCase().contains(query) ||
            document.strEngDocument.toLowerCase().contains(query)) {
          _filteredEngineerDocumentList.add(document);
        }
      }
    } else {
      _filteredEngineerDocumentList.addAll(_engineerDocumentList);
      _searchBoxType = false;
      notifyListeners();
    }
    notifyListeners();
  }
}