// @dart=2.9
import 'package:enstaller/core/enums/view_state.dart';
import 'package:enstaller/core/model/document_model.dart';
import 'package:enstaller/core/model/user_model.dart';
import 'package:enstaller/core/provider/base_model.dart';
import 'package:enstaller/core/service/api_service.dart';
import 'package:enstaller/core/service/pref_service.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class DocumnetViewModel extends BaseModel {
  ApiService _apiService = ApiService();
  List<DocumentResponseModel> documentList = [];
  List<DocumentResponseModel> _documentList = [];

  bool searchBool = false;

  void getDocumnetList() async {
    documentList = [];
    _documentList = [];
    setState(ViewState.Busy);
    UserModel user = await Prefs.getUser();
    DocumentModel documentModel = DocumentModel(
      intCreatedBy: user.intEngineerId.toString(),
      intSupplierId: "0",
      strDocUser: "Engineer",
      strKey: "GetDocumentWeb",
      intCompanyId: user.intCompanyId,
    );
    _documentList = await _apiService.getDocumentList(documentModel);
    documentList = _documentList;
    setState(ViewState.Idle);
  }

  void onClickSerach() {
    setState(ViewState.Busy);
    searchBool = !searchBool;
    if (!searchBool) {
      documentList = _documentList;
    }
    setState(ViewState.Idle);
  }

  void onSearch(String val) {
    setState(ViewState.Busy);
    documentList = [];
    _documentList.forEach((element) {
      if (element.strDocType.toLowerCase().contains(val.toLowerCase()) ||
          element.strFileName.toLowerCase().contains(val.toLowerCase())) {
        documentList.add(element);
      }
    });
    setState(ViewState.Idle);
  }

  Future<String> pdfview(String url) async {
    try {
      var reponse = await http.get(Uri.parse(url));
      var dir = await getTemporaryDirectory();
      File file = new File(dir.path + "pdf");
      file.writeAsBytesSync(reponse.bodyBytes, flush: true);
      return file.path;
    } catch (e) {
      print("error..........................");
      print(e);
    }
  }

  int getCurrentDay(DateTime date) {
    return date.day;
  }

  int getNextDay(DateTime date) {
    final tomorrow = DateTime(date.year, date.month, date.day + 1);
    return tomorrow.day;
  }
} //KARAN (ADD THIS ON LIVE)
