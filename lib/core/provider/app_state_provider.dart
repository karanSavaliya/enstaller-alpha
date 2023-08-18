//@dart=2.9
import 'dart:io';
import 'package:flutter/material.dart';
import '../../ui/screen/home_screen.dart';
import '../constant/api_urls.dart';
import '../constant/appconstant.dart';
import '../model/engineer_document_model.dart';
import '../model/engineer_qualification_model.dart';
import '../model/save_sapphire_electricity_flow_model.dart';
import '../model/save_sapphire_gas_flow_model.dart';
import '../model/user_model.dart';
import '../service/api.dart';
import '../service/pref_service.dart';

class AppStateProvider extends ChangeNotifier {
  AppStateProvider();

  // =======> Engineer Documents Start <=======

  List<EngineerDocumentModel> engineerDocumentDoneObj;
  final List<EngineerDocumentModel> _engineerDocumentList = [];
  List<EngineerDocumentModel> get engineerDocumentList => _engineerDocumentList;
  bool _loading = false;
  bool get loading => _loading;

  Future<void> getEngineerDocument() async {
    _loading = true;
    _searchBoxType = false;
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
      _searchBoxType = false;
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

  List<bool> _isReadEngineerDocumentMain = [];
  List<bool> get isReadEngineerDocumentMain => _isReadEngineerDocumentMain;

  List<bool> _isReadEngineerDocumentFilter = [];
  List<bool> get isReadEngineerDocumentFilter => _isReadEngineerDocumentFilter;

  List<bool> _isReadEngineerDocumentSearch = [];
  List<bool> get isReadEngineerDocumentSearch => _isReadEngineerDocumentSearch;

  void performSearch(String query) {
    query = query.toLowerCase();
    _filteredEngineerDocumentList.clear();
    _isReadEngineerDocumentFilter.clear();
    _isReadEngineerDocumentFilter.addAll(_isReadEngineerDocumentMain);
    if (query.isNotEmpty) {
      _isReadEngineerDocumentSearch.clear();
      _searchBoxType = true;
      notifyListeners();
      for (var document in _engineerDocumentList) {
        if (document.documentType.toLowerCase().contains(query) ||
            document.document.toLowerCase().contains(query)) {
          _isReadEngineerDocumentSearch.add(_isReadEngineerDocumentFilter.elementAt(_engineerDocumentList.indexOf(document)));
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

  // =======> Save Sapphire Gas Flow Start <=======

  final List<String> _items = ['Gas Flow', 'Existing Meter System', 'Site Address', 'Create Work', 'Complete Work', 'Assets'];
  List<String> get items => _items;

  int _currentExpandedTileIndex = 0;
  int get currentExpandedTileIndex => _currentExpandedTileIndex;

  String _visitSuccessful = "true";
  String get visitSuccessful => _visitSuccessful;
  void handleVisitSuccessfulSelection(String visitSuccessful) {
    _visitSuccessful = visitSuccessful;
    notifyListeners();
  }

  String _readingTaken = "true";
  String get readingTaken => _readingTaken;
  void handleReadingTakenSelection(String readingTaken) {
    _readingTaken = readingTaken;
    notifyListeners();
  }

  final _textEditingControllerAppointmentDate = TextEditingController();
  TextEditingController get textEditingControllerAppointmentDate => _textEditingControllerAppointmentDate;
  DateTime _selectedAppointmentDate;
  DateTime get selectedAppointmentDate => _selectedAppointmentDate;
  Future<void> selectAppointmentDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _selectedAppointmentDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      _selectedAppointmentDate = picked;
      _textEditingControllerAppointmentDate.text = formatDate(picked);
      notifyListeners();
    }
    notifyListeners();
  }

  final _textEditingControllerSiteVisitDate = TextEditingController();
  TextEditingController get textEditingControllerSiteVisitDate => _textEditingControllerSiteVisitDate;
  DateTime _selectedSiteVisitDate;
  DateTime get selectedSiteVisitDate => _selectedSiteVisitDate;
  Future<void> selectSiteVisitDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _selectedSiteVisitDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      _selectedSiteVisitDate = picked;
      _textEditingControllerSiteVisitDate.text = formatDate(picked);
      notifyListeners();
    }
    notifyListeners();
  }

  String formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year.toString()}";
  }

  final TextEditingController _memMpId = TextEditingController();
  TextEditingController get memMpId => _memMpId;
  final _supplierMpId = TextEditingController();
  TextEditingController get supplierMpId => _supplierMpId;
  final _mprn = TextEditingController();
  TextEditingController get mprn => _mprn;
  final _externalSystemIdentity = TextEditingController();
  TextEditingController get externalSystemIdentity => _externalSystemIdentity;
  final _correlationId = TextEditingController();
  TextEditingController get correlationId => _correlationId;

  final _meterLinkCode = TextEditingController();
  TextEditingController get meterLinkCode => _meterLinkCode;
  final _statusCode = TextEditingController();
  TextEditingController get statusCode => _statusCode;
  final _locationCode = TextEditingController();
  TextEditingController get locationCode => _locationCode;
  final _locationNotes = TextEditingController();
  TextEditingController get locationNotes => _locationNotes;
  final _accessInstructions = TextEditingController();
  TextEditingController get accessInstructions => _accessInstructions;
  final _conversionFactor = TextEditingController();
  TextEditingController get conversionFactor => _conversionFactor;
  final _meteringPressure = TextEditingController();
  TextEditingController get meteringPressure => _meteringPressure;

  final _postCode = TextEditingController();
  TextEditingController get postCode => _postCode;
  final _buildingName = TextEditingController();
  TextEditingController get buildingName => _buildingName;
  final _postTown = TextEditingController();
  TextEditingController get postTown => _postTown;

  final _additionalInformationForWork = TextEditingController();
  TextEditingController get additionalInformationForWork => _additionalInformationForWork;
  final _transactionReference = TextEditingController();
  TextEditingController get transactionReference => _transactionReference;
  final _transactionTypeCode = TextEditingController();
  TextEditingController get transactionTypeCode => _transactionTypeCode;

  final _engineerName = TextEditingController();
  TextEditingController get engineerName => _engineerName;
  final _transactionStatusCode = TextEditingController();
  TextEditingController get transactionStatusCode => _transactionStatusCode;
  final _transactionStatusChange = TextEditingController();
  TextEditingController get transactionStatusChange => _transactionStatusChange;
  final _siteVisitNote = TextEditingController();
  TextEditingController get siteVisitNote => _siteVisitNote;

  void clearAllGasFormData(){
    _memMpId.text= "";
    _supplierMpId.text= "";
    _mprn.text= "";
    _externalSystemIdentity.text= "";
    _correlationId.text= "";
    notifyListeners();
    _meterLinkCode.text= "";
    _statusCode.text= "";
    _locationCode.text= "";
    _locationNotes.text= "";
    _accessInstructions.text= "";
    _conversionFactor.text= "";
    _meteringPressure.text= "";
    notifyListeners();
    _postCode.text= "";
    _buildingName.text= "";
    _postTown.text= "";
    notifyListeners();
    _textEditingControllerAppointmentDate.text= "";
    _additionalInformationForWork.text= "";
    _transactionReference.text= "";
    _transactionTypeCode.text= "";
    notifyListeners();
    _textEditingControllerSiteVisitDate.text= "";
    _engineerName.text= "";
    _transactionStatusCode.text= "";
    _transactionStatusChange.text= "";
    _siteVisitNote.text= "";
    notifyListeners();
    _formDataList.clear();
    notifyListeners();
    _currentExpandedTileIndex = 0;
    notifyListeners();
    initForm();
  }

  bool _isCheckData = false;
  bool get isCheckData => _isCheckData;

  bool areAllFieldsFilled() {
    for (var data in formDataList) {
      for (var key in data.keys) {
        if (data[key] is TextEditingController &&
            data[key].text.trim().isEmpty &&
            _isRequiredField(key)) {
          return false;
        }
      }
      if (data['registers'] != null &&
          data['registers'] is List &&
          data['registers'].isNotEmpty) {
        for (var register in data['registers']) {
          if (register is Map<String, dynamic>) {
            for (var key in register.keys) {
              if (register[key] is TextEditingController &&
                  register[key].text.trim().isEmpty &&
                  _isRequiredField(key)) {
                return false;
              }
            }
          }
        }
      } else {
        return false;
      }
    }
    return true;
  }

  bool _isRequiredField(String key) {
    List<String> nonRequiredFields = [
      'oamiInspectionDate',
      'collarStatusCode',
      'meterUsageCode',
      'locationNotes',
      'paymentMethodCode',
    ];
    return !nonRequiredFields.contains(key);
  }

  void fieldDataCheck(BuildContext context){
    if(_memMpId.text.isNotEmpty && _supplierMpId.text.isNotEmpty && _mprn.text.isNotEmpty && _externalSystemIdentity.text.isNotEmpty
        && _statusCode.text.isNotEmpty && _locationCode.text.isNotEmpty && _conversionFactor.text.isNotEmpty && _meteringPressure.text.isNotEmpty
        && _postCode.text.isNotEmpty
        && _textEditingControllerSiteVisitDate.text.isNotEmpty && _visitSuccessful!=null && _readingTaken!=null && _engineerName.text.isNotEmpty && _transactionStatusCode.text.isNotEmpty
        && areAllFieldsFilled()
    ){
      _isCheckData = true;
      notifyListeners();
    }
    else{
      _isCheckData = false;
      notifyListeners();
      AppConstants.showFailToast(context, "Required Fields Compulsory");
    }
  }

  List<Map<String, dynamic>> _formDataList = [];
  List<Map<String, dynamic>> get formDataList => _formDataList;

  void addForm() {
    _formDataList.add({
      'useTemplate': 'True',
      'installationStatus': TextEditingController(text: ''),
      'assetProviderMPID': TextEditingController(),
      'assetClassCode': TextEditingController(),
      'paymentMethodCode': TextEditingController(),
      'modelCode': TextEditingController(),
      'manufacturerCode': TextEditingController(),
      'yearOfManufacture': TextEditingController(),
      'serialNumber': TextEditingController(),
      'locationCode': TextEditingController(),
      'locationNotes': TextEditingController(),
      'assetStatusCode': TextEditingController(),
      'mechanismCode': TextEditingController(),
      'meterUsageCode': TextEditingController(),
      'collarStatusCode': TextEditingController(),
      'oamiInspectionDate': TextEditingController(),
      'gasActOwnerRole': TextEditingController(),
      'assetRemovalDate': TextEditingController(),
      'registers': [
        {
          'numberOfDigits': TextEditingController(),
          'readingIndex': TextEditingController(),
        },
      ],
    });
    notifyListeners();
  }

  void removeForm(int index) {
    _formDataList.removeAt(index);
    notifyListeners();
  }

  void addSubForm(int index) {
    _formDataList[index]['registers'].add({
      'numberOfDigits': TextEditingController(),
      'readingIndex': TextEditingController(),
    });
    notifyListeners();
  }

  void removeSubForm(int parentIndex, int subIndex) {
    _formDataList[parentIndex]['registers'].removeAt(subIndex);
    notifyListeners();
  }

  void initForm() {
    _formDataList.add({
      'useTemplate': 'False',
      'installationStatus': TextEditingController(),
      'assetProviderMPID': TextEditingController(),
      'assetClassCode': TextEditingController(),
      'paymentMethodCode': TextEditingController(),
      'modelCode': TextEditingController(),
      'manufacturerCode': TextEditingController(),
      'yearOfManufacture': TextEditingController(),
      'serialNumber': TextEditingController(),
      'locationCode': TextEditingController(),
      'locationNotes': TextEditingController(),
      'assetStatusCode': TextEditingController(),
      'mechanismCode': TextEditingController(),
      'meterUsageCode': TextEditingController(),
      'collarStatusCode': TextEditingController(),
      'oamiInspectionDate': TextEditingController(),
      'gasActOwnerRole': TextEditingController(),
      'assetRemovalDate': TextEditingController(),
      'registers': [
        {
          'numberOfDigits': TextEditingController(),
          'readingIndex': TextEditingController(),
        },
      ],
    });
  }

  DateTime _selectedOAMIDate;
  DateTime get selectedOAMIDate => _selectedOAMIDate;
  Future<void> selectOAMIDate(BuildContext context, int index) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _selectedOAMIDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      _selectedOAMIDate = picked;
      _formDataList[index]['oamiInspectionDate'].text = formatDate(picked);
      notifyListeners();
    }
    notifyListeners();
  }

  DateTime _selectedRemovalDate;
  DateTime get selectedRemovalDate => _selectedRemovalDate;
  Map<String, dynamic> testMap = {};
  Future<void> selectRemovalDate(BuildContext context, int index) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _selectedRemovalDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      _selectedRemovalDate = picked;
      _formDataList[index]['assetRemovalDate'].text = formatDate(picked);
      notifyListeners();
    }
    notifyListeners();
  }

  void saveSapphireGasFlow(BuildContext context,String customerID,String appointmentId, String type) async {

    UserModel user = await Prefs.getUser();

    for (var formData in _formDataList) {
      Map<String, dynamic> assetMap = {
        'intId': 0,
        'useTemplate': formData['useTemplate'],
        'installationStatus': formData['installationStatus'] is TextEditingController ? formData['installationStatus'].text : formData['installationStatus'],
        'assetProviderMPID': formData['assetProviderMPID'] is TextEditingController ? formData['assetProviderMPID'].text : formData['assetProviderMPID'],
        'assetClassCode': formData['assetClassCode'] is TextEditingController ? formData['assetClassCode'].text : formData['assetClassCode'],
        'paymentMethodCode': formData['paymentMethodCode'] is TextEditingController ? formData['paymentMethodCode'].text : formData['paymentMethodCode'],
        'modelCode': formData['modelCode'] is TextEditingController ? formData['modelCode'].text : formData['modelCode'],
        'manufacturerCode': formData['manufacturerCode'] is TextEditingController ? formData['manufacturerCode'].text : formData['manufacturerCode'],
        'yearOfManufacture': formData['yearOfManufacture'] is TextEditingController ? formData['yearOfManufacture'].text : formData['yearOfManufacture'],
        'serialNumber': formData['serialNumber'] is TextEditingController ? formData['serialNumber'].text : formData['serialNumber'],
        'locationCode': formData['locationCode'] is TextEditingController ? formData['locationCode'].text : formData['locationCode'],
        'locationNotes': formData['locationNotes'] is TextEditingController ? formData['locationNotes'].text : formData['locationNotes'],
        'assetStatusCode': formData['assetStatusCode'] is TextEditingController ? formData['assetStatusCode'].text : formData['assetStatusCode'],
        'mechanismCode': formData['mechanismCode'] is TextEditingController ? formData['mechanismCode'].text : formData['mechanismCode'],
        'meterUsageCode': formData['meterUsageCode'] is TextEditingController ? formData['meterUsageCode'].text : formData['meterUsageCode'],
        'collarStatusCode': formData['collarStatusCode'] is TextEditingController ? formData['collarStatusCode'].text : formData['collarStatusCode'],
        'oamiInspectionDate': formData['oamiInspectionDate'] is TextEditingController ? formData['oamiInspectionDate'].text : formData['oamiInspectionDate'],
        'gasActOwnerRole': formData['gasActOwnerRole'] is TextEditingController ? formData['gasActOwnerRole'].text : formData['gasActOwnerRole'],
        'assetRemovalDate': formData['assetRemovalDate'] is TextEditingController ? formData['assetRemovalDate'].text : formData['assetRemovalDate'],
      };

      List<Map<String, dynamic>> registersList = formData['registers'];
      List<Map<String, dynamic>> registerList = [];
      for (var subForm in registersList) {
        Map<String, dynamic> subFormField = {
          'intId': 0,
          'numberOfDigits': subForm['numberOfDigits'] is TextEditingController ? subForm['numberOfDigits'].text : subForm['numberOfDigits'],
          'readingIndex': subForm['readingIndex'] is TextEditingController ? subForm['readingIndex'].text : subForm['readingIndex'],
        };
        registerList.add(subFormField);
      }

      assetMap['registers'] = registerList;

      Map<String, dynamic> firstJsonData = {
        "intCustomerId": int.parse(customerID),
        "intUserId": user.id.toString(),
        "intappointmentId": int.parse(appointmentId),
        "memMpid": _memMpId.text,
        "supplierMpid": _supplierMpId.text,
        "mprn": _mprn.text,
        "externalSystemIdentity": _externalSystemIdentity.text,
        "correlationId": _correlationId.text,
        "existingMeterSystem": {
          "meterLinkCode": _meterLinkCode.text,
          "statusCode": _statusCode.text,
          "locationCode": _locationCode.text,
          "locationNotes": _locationNotes.text,
          "accessInstructions": _accessInstructions.text,
          "conversionFactor": _conversionFactor.text,
          "meteringPressure": _meteringPressure.text,
          "siteAddress": {
            "postcode": _postCode.text,
            "buildingName": _buildingName.text,
            "postTown": _postTown.text,
          }
        },
        "createWork": {
          "appointmentDateTime": _textEditingControllerAppointmentDate.text,
          "additionalInformationForWork": _additionalInformationForWork.text,
          "transactionReference": _transactionReference.text,
          "transactionTypeCode": _transactionTypeCode.text,
        },
        "completeWork": {
          "siteVisitDate": _textEditingControllerSiteVisitDate.text,
          "visitSuccessful": _visitSuccessful.toString(),
          "readingTaken": _readingTaken.toString(),
          "engineerName": _engineerName.text,
          "transactionStatusCode": _transactionStatusCode.text,
          "transactionStatusChangeReasonCode": _transactionStatusChange.text,
          "siteVisitNotes": _siteVisitNote.text,
          "meterSystem": {
            "assets": [assetMap],
          }
        }
      };

      try {
        Api api = Api();
        SaveSapphireGasFlow apiResponse = await api.saveSapphireGasFlow(context, firstJsonData);
        if (apiResponse.status == 5 && apiResponse.isCompleted == true) {
          clearAllGasFormData();
          notifyListeners();
          AppConstants.showSuccessToast(context, "Gas Flow Saved Successfully");
          if(type != "BOTH"){
            Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (context) => HomeScreen()));
          }
          else{
            saveSapphireElectricityFlow(context,customerID,appointmentId);
          }
        } else {
          AppConstants.showFailToast(context, "Failed to save data");
        }
      } catch (e) {
        AppConstants.showFailToast(context, e.toString());
      }
    }
  }

  // =======> Save Sapphire Electricity Flow Start <=======

  final List<String> _itemsElectricity = ['Electricity Flow', 'Create Work', 'Complete Work', 'Meter System', 'Meters'];
  List<String> get itemsElectricity => _itemsElectricity;

  int _currentExpandedTileIndexElectricity = 0;
  int get currentExpandedTileIndexElectricity => _currentExpandedTileIndexElectricity;

  final TextEditingController _memMpIdElectricity = TextEditingController();
  TextEditingController get memMpIdElectricity => _memMpIdElectricity;
  final _supplierMpIdElectricity = TextEditingController();
  TextEditingController get supplierMpIdElectricity => _supplierMpIdElectricity;
  final _mprnElectricity = TextEditingController();
  TextEditingController get mprnElectricity => _mprnElectricity;
  final _externalSystemIdentityElectricity = TextEditingController();
  TextEditingController get externalSystemIdentityElectricity => _externalSystemIdentityElectricity;
  final _correlationIdElectricity = TextEditingController();
  TextEditingController get correlationIdElectricity => _correlationIdElectricity;

  final TextEditingController _requestedEnergisationStatusForWorkElectricity = TextEditingController();
  TextEditingController get requestedEnergisationStatusForWorkElectricity => _requestedEnergisationStatusForWorkElectricity;

  final _textEditingControllerSiteVisitDateElectricity = TextEditingController();
  TextEditingController get textEditingControllerSiteVisitDateElectricity => _textEditingControllerSiteVisitDateElectricity;
  DateTime _selectedSiteVisitDateElectricity;
  DateTime get selectedSiteVisitDateElectricity => _selectedSiteVisitDateElectricity;
  Future<void> selectSiteVisitDateElectricity(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _selectedSiteVisitDateElectricity ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      _selectedSiteVisitDateElectricity = picked;
      _textEditingControllerSiteVisitDateElectricity.text = formatDate(picked);
      notifyListeners();
    }
  }

  String _visitSuccessfulElectricity = "true";
  String get visitSuccessfulElectricity => _visitSuccessfulElectricity;
  void handleVisitSuccessfulSelectionElectricity(String visitSuccessful) {
    _visitSuccessfulElectricity = visitSuccessful;
    notifyListeners();
  }

  String _readingTakenElectricity = "true";
  String get readingTakenElectricity => _readingTakenElectricity;
  void handleReadingTakenSelectionElectricity(String readingTaken) {
    _readingTakenElectricity = readingTaken;
    notifyListeners();
  }

  final TextEditingController _engineerNameElectricity = TextEditingController();
  TextEditingController get engineerNameElectricity => _engineerNameElectricity;
  final _siteVisitCheckCodeElectricity = TextEditingController();
  TextEditingController get siteVisitCheckCodeElectricity => _siteVisitCheckCodeElectricity;

  final _energisationStatusElectricity = TextEditingController();
  TextEditingController get energisationStatusElectricity => _energisationStatusElectricity;

  String _isSmartElectricity = "true";
  String get isSmartElectricity => _isSmartElectricity;
  void handleIsSmartSelectionElectricity(String isSmart) {
    _isSmartElectricity = isSmart;
    notifyListeners();
  }

  final _meterLocationCodeElectricity = TextEditingController();
  TextEditingController get meterLocationCodeElectricity => _meterLocationCodeElectricity;
  final _standardSettlementCodeForMeterSystemElectricity = TextEditingController();
  TextEditingController get standardSettlementCodeForMeterSystemElectricity => _standardSettlementCodeForMeterSystemElectricity;
  final _retrievalMethodForMeterSystemElectricity = TextEditingController();
  TextEditingController get retrievalMethodForMeterSystemElectricity => _retrievalMethodForMeterSystemElectricity;


  DateTime _selectedMeterRemovalDateForMetersElectricity;
  DateTime get selectedMeterRemovalDateElectricity => _selectedMeterRemovalDateForMetersElectricity;
  Future<void> selectedMeterRemovalDateForMetersElectricity(BuildContext context, int index) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _selectedMeterRemovalDateForMetersElectricity ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      _selectedMeterRemovalDateForMetersElectricity = picked;
      _formDataListElectricityMeters[index]['meterRemovalDateElectricity'].text = formatDate(picked);
      notifyListeners();
    }
    notifyListeners();
  }

  List<Map<String, dynamic>> _formDataListElectricityMeters = [];
  List<Map<String, dynamic>> get formDataListElectricityMeters => _formDataListElectricityMeters;

  void addFormElectricityMeters() {
    _formDataListElectricityMeters.add({
      'useTemplateElectricity': true,
      'installationStatusElectricity': TextEditingController(),
      'serialNumberElectricity': TextEditingController(),
      'equipmentTypeNameElectricity': TextEditingController(),
      'meterTypeElectricity': TextEditingController(),
      'ownerMpidElectricity': TextEditingController(),
      'currentRatingElectricity': TextEditingController(),
      'timingSerialNumberElectricity': TextEditingController(),
      'ctRatioElectricity': TextEditingController(),
      'vtRatioElectricity': TextEditingController(),
      'meterRemovalDateElectricity': TextEditingController(),
      'registers': [
        {
          'useTemplateForRegistersElectricity': true,
          'meterRegisterIdElectricity': TextEditingController(),
          'isSettlementElectricity': true,
          'registerTypeElectricity': TextEditingController(),
          'numberOfDigitsElectricity': TextEditingController(),
          'measurementQuantityElectricity': TextEditingController(),
          'multiplierElectricity': TextEditingController(),
          'registerReadingElectricity': TextEditingController(),
          'readingTypeElectricity': TextEditingController(),
          'prepaymentUnitRateElectricity': TextEditingController(),
          'readingNotValidReasonCodeElectricity': TextEditingController(),
          'timePatterns': [
            {
              'timePatternRegimeElectricity': TextEditingController(),
              'settlementMapCoefficientElectricity': TextEditingController(),
            },
          ],
        },
      ],
    });
    notifyListeners();
  }

  void initFormElectricityMeters() {
    _formDataListElectricityMeters.add({
      'useTemplateElectricity': true,
      'installationStatusElectricity': TextEditingController(),
      'serialNumberElectricity': TextEditingController(),
      'equipmentTypeNameElectricity': TextEditingController(),
      'meterTypeElectricity': TextEditingController(),
      'ownerMpidElectricity': TextEditingController(),
      'currentRatingElectricity': TextEditingController(),
      'timingSerialNumberElectricity': TextEditingController(),
      'ctRatioElectricity': TextEditingController(),
      'vtRatioElectricity': TextEditingController(),
      'meterRemovalDateElectricity': TextEditingController(),
      'registers': [
        {
          'useTemplateForRegistersElectricity': true,
          'meterRegisterIdElectricity': TextEditingController(),
          'isSettlementElectricity': true,
          'registerTypeElectricity': TextEditingController(),
          'numberOfDigitsElectricity': TextEditingController(),
          'measurementQuantityElectricity': TextEditingController(),
          'multiplierElectricity': TextEditingController(),
          'registerReadingElectricity': TextEditingController(),
          'readingTypeElectricity': TextEditingController(),
          'prepaymentUnitRateElectricity': TextEditingController(),
          'readingNotValidReasonCodeElectricity': TextEditingController(),
          'timePatterns': [
            {
              'timePatternRegimeElectricity': TextEditingController(),
              'settlementMapCoefficientElectricity': TextEditingController(),
            },
          ],
        },
      ],
    });
  }

  void removeFormElectricityMeters(int index) {
    _formDataListElectricityMeters.removeAt(index);
    notifyListeners();
  }

  void addSubFormElectricityMeters(int index) {
    _formDataListElectricityMeters[index]['registers'].add({
      'useTemplateForRegistersElectricity': true,
      'meterRegisterIdElectricity': TextEditingController(),
      'isSettlementElectricity': true,
      'registerTypeElectricity': TextEditingController(),
      'numberOfDigitsElectricity': TextEditingController(),
      'measurementQuantityElectricity': TextEditingController(),
      'multiplierElectricity': TextEditingController(),
      'registerReadingElectricity': TextEditingController(),
      'readingTypeElectricity': TextEditingController(),
      'prepaymentUnitRateElectricity': TextEditingController(),
      'readingNotValidReasonCodeElectricity': TextEditingController(),
      'timePatterns': [
        {
          'timePatternRegimeElectricity': TextEditingController(),
          'settlementMapCoefficientElectricity': TextEditingController(),
        },
      ],
    });
    notifyListeners();
  }

  void removeSubFormElectricityMeters(int parentIndex, int subIndex) {
    _formDataListElectricityMeters[parentIndex]['registers'].removeAt(subIndex);
    notifyListeners();
  }

  void addSubSubFormElectricityMeters(int parentIndex, int subIndex) {
    _formDataListElectricityMeters[parentIndex]['registers'][subIndex]['timePatterns'].add({
      'timePatternRegimeElectricity': TextEditingController(),
      'settlementMapCoefficientElectricity': TextEditingController(),
    });
    notifyListeners();
  }

  void removeSubSubFormElectricityMeters(int parentIndex, int subIndex, int subSubIndex) {
    _formDataListElectricityMeters[parentIndex]['registers'][subIndex]['timePatterns'].removeAt(subSubIndex);
    notifyListeners();
  }

  void clearAllElectricityFormData() {
    _memMpIdElectricity.text= "";
    _supplierMpIdElectricity.text= "";
    _mprnElectricity.text= "";
    _externalSystemIdentityElectricity.text= "";
    _correlationIdElectricity.text= "";
    notifyListeners();
    _requestedEnergisationStatusForWorkElectricity.text= "";
    notifyListeners();
    _textEditingControllerSiteVisitDateElectricity.text= "";
    _engineerNameElectricity.text= "";
    _siteVisitCheckCodeElectricity.text= "";
    notifyListeners();
    _energisationStatusElectricity.text= "";
    _meterLocationCodeElectricity.text= "";
    _standardSettlementCodeForMeterSystemElectricity.text= "";
    _retrievalMethodForMeterSystemElectricity.text= "";
    notifyListeners();
    _formDataListElectricityMeters.clear();
    notifyListeners();
    _currentExpandedTileIndexElectricity = 0;
    notifyListeners();
    initFormElectricityMeters();
  }

  bool _isCheckDataElectricity = false;
  bool get isCheckDataElectricity => _isCheckDataElectricity;

  void fieldDataCheckElectricity(BuildContext context){
    if(_memMpIdElectricity.text.isNotEmpty && _supplierMpIdElectricity.text.isNotEmpty && _mprnElectricity.text.isNotEmpty && _externalSystemIdentityElectricity.text.isNotEmpty && _correlationIdElectricity.text.isNotEmpty &&
        _requestedEnergisationStatusForWorkElectricity.text.isNotEmpty &&
        _textEditingControllerSiteVisitDateElectricity.text.isNotEmpty && _engineerNameElectricity.text.isNotEmpty && _siteVisitCheckCodeElectricity.text.isNotEmpty &&
        _energisationStatusElectricity.text.isNotEmpty && _meterLocationCodeElectricity.text.isNotEmpty && _standardSettlementCodeForMeterSystemElectricity.text.isNotEmpty && _retrievalMethodForMeterSystemElectricity.text.isNotEmpty
        && areAllFieldsFilledElectricity()
    ){
      _isCheckDataElectricity = true;
      notifyListeners();
    }
    else{
      _isCheckDataElectricity = false;
      notifyListeners();
      AppConstants.showFailToast(context, "Required Fields Compulsory");
    }
  }

  bool areAllFieldsFilledElectricity() {
    for (var formData in _formDataListElectricityMeters) {
      for (var key in formData.keys) {
        if (formData[key] is TextEditingController &&
            formData[key].text.trim().isEmpty) {
          return false;
        }
      }
      if (formData['registers'] != null &&
          formData['registers'] is List &&
          formData['registers'].isNotEmpty) {
        for (var subForm in formData['registers']) {
          if (subForm is Map<String, dynamic>) {
            for (var key in subForm.keys) {
              if (subForm[key] is TextEditingController &&
                  subForm[key].text.trim().isEmpty) {
                return false;
              }
            }
            List<Map<String, dynamic>> timePatternsList = subForm['timePatterns'];
            if (timePatternsList != null && timePatternsList.isNotEmpty) {
              for (var timePatternData in timePatternsList) {
                for (var key in timePatternData.keys) {
                  if (timePatternData[key] is TextEditingController &&
                      timePatternData[key].text.trim().isEmpty) {
                    return false;
                  }
                }
              }
            }
          }
        }
      } else {
        return false;
      }
    }
    return true;
  }

  void saveSapphireElectricityFlow(BuildContext context,String customerID,String appointmentId) async {

    UserModel user = await Prefs.getUser();

    for (var formData in _formDataListElectricityMeters) {
      Map<String, dynamic> assetMap = {
        'intId': 0,
        'useTemplate': formData['useTemplateElectricity'],
        'installationStatus': formData['installationStatusElectricity'] is TextEditingController ? formData['installationStatusElectricity'].text : formData['installationStatusElectricity'],
        'serialNumber': formData['serialNumberElectricity'] is TextEditingController ? formData['serialNumberElectricity'].text : formData['serialNumberElectricity'],
        'equipmentTypeName': formData['equipmentTypeNameElectricity'] is TextEditingController ? formData['equipmentTypeNameElectricity'].text : formData['equipmentTypeNameElectricity'],
        'meterType': formData['meterTypeElectricity'] is TextEditingController ? formData['meterTypeElectricity'].text : formData['meterTypeElectricity'],
        'ownerMpid': formData['ownerMpidElectricity'] is TextEditingController ? formData['ownerMpidElectricity'].text : formData['ownerMpidElectricity'],
        'currentRating': formData['currentRatingElectricity'] is TextEditingController ? formData['currentRatingElectricity'].text : formData['currentRatingElectricity'],
        'timingDeviceIdSerialNumber': formData['timingSerialNumberElectricity'] is TextEditingController ? formData['timingSerialNumberElectricity'].text : formData['timingSerialNumberElectricity'],
        'ctRatio': formData['ctRatioElectricity'] is TextEditingController ? formData['ctRatioElectricity'].text : formData['ctRatioElectricity'],
        'vtRatio': formData['vtRatioElectricity'] is TextEditingController ? formData['vtRatioElectricity'].text : formData['vtRatioElectricity'],
        'meterRemovalDate': formData['meterRemovalDateElectricity'] is TextEditingController ? formData['meterRemovalDateElectricity'].text : formData['meterRemovalDateElectricity'],
      };

      List<Map<String, dynamic>> registersList = formData['registers'];
      List<Map<String, dynamic>> registerList = [];
      for (var subForm in registersList) {
        Map<String, dynamic> subFormField = {
          'intId': 0,
          'useTemplate': subForm['useTemplateForRegistersElectricity'],
          'meterRegisterId': subForm['meterRegisterIdElectricity'] is TextEditingController ? subForm['meterRegisterIdElectricity'].text : subForm['meterRegisterIdElectricity'],
          'isSettlement': subForm['isSettlementElectricity'] is TextEditingController ? subForm['isSettlementElectricity'].text : subForm['isSettlementElectricity'],
          'registerType': subForm['registerTypeElectricity'] is TextEditingController ? subForm['registerTypeElectricity'].text : subForm['registerTypeElectricity'],
          'numberOfDigits': subForm['numberOfDigitsElectricity'] is TextEditingController ? subForm['numberOfDigitsElectricity'].text : subForm['numberOfDigitsElectricity'],
          'measurementQuantity': subForm['measurementQuantityElectricity'] is TextEditingController ? subForm['measurementQuantityElectricity'].text : subForm['measurementQuantityElectricity'],
          'multiplier': subForm['multiplierElectricity'] is TextEditingController ? subForm['multiplierElectricity'].text : subForm['multiplierElectricity'],
          'registerReading': subForm['registerReadingElectricity'] is TextEditingController ? subForm['registerReadingElectricity'].text : subForm['registerReadingElectricity'],
          'readingType': subForm['readingTypeElectricity'] is TextEditingController ? subForm['readingTypeElectricity'].text : subForm['readingTypeElectricity'],
          'prepaymentUnitRate': subForm['prepaymentUnitRateElectricity'] is TextEditingController ? subForm['prepaymentUnitRateElectricity'].text : subForm['prepaymentUnitRateElectricity'],
          'readingNotValidReasonCode': subForm['readingNotValidReasonCodeElectricity'] is TextEditingController ? subForm['readingNotValidReasonCodeElectricity'].text : subForm['readingNotValidReasonCodeElectricity'],
        };

        List<Map<String, dynamic>> timePatternsList = subForm['timePatterns'];
        List<Map<String, dynamic>> timePatterns = [];
        for (var timePatternData in timePatternsList) {
          Map<String, dynamic> timePattern = {
            'intId': 0,
            'timePatternRegime': timePatternData['timePatternRegimeElectricity'] is TextEditingController ? timePatternData['timePatternRegimeElectricity'].text : timePatternData['timePatternRegimeElectricity'],
            'settlementMapCoefficient': timePatternData['settlementMapCoefficientElectricity'] is TextEditingController ? timePatternData['settlementMapCoefficientElectricity'].text : timePatternData['settlementMapCoefficientElectricity'],
          };
          timePatterns.add(timePattern);
        }

        subFormField['timePatterns'] = timePatterns;
        registerList.add(subFormField);
      }

      assetMap['registers'] = registerList;

      Map<String, dynamic> firstJsonData = {
        "intCustomerId": int.parse(customerID),
        "intUserId": user.id.toString(),
        "intappointmentId": int.parse(appointmentId),
        "memMpid": _memMpIdElectricity.text,
        "supplierMpid": _supplierMpIdElectricity.text,
        "mpan": _mprnElectricity.text,
        "externalSystemIdentity": _externalSystemIdentityElectricity.text,
        "correlationId": _correlationIdElectricity.text,
        "createWork": {
          "requestedEnergisationStatus": _requestedEnergisationStatusForWorkElectricity.text,
        },
        "completeWork": {
          "siteVisitDate": _textEditingControllerSiteVisitDateElectricity.text,
          "visitSuccessful": _visitSuccessfulElectricity.toString(),
          "readingTaken": _readingTakenElectricity.toString(),
          "engineerName": _engineerNameElectricity.text,
          "siteVisitCheckCode": _siteVisitCheckCodeElectricity.text,
          "meterSystem": {
            "energisationStatus": _energisationStatusElectricity.text,
            "isSmart": _isSmartElectricity.toString(),
            "meterLocationCode": _meterLocationCodeElectricity.text,
            "standardSettlementCode": _standardSettlementCodeForMeterSystemElectricity.text,
            "retrievalMethod": _retrievalMethodForMeterSystemElectricity.text,
            "meters": [assetMap],
          }
        }
      };

      try {
        Api api = Api();
        SaveSapphireElectricityFlow apiResponse = await api.saveSapphireElectricityFlow(context, firstJsonData);
        if (apiResponse.status == 5 && apiResponse.isCompleted == true) {
          clearAllElectricityFormData();
          notifyListeners();
          AppConstants.showSuccessToast(context, "Electricity Flow Saved Successfully");
          Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (context) => HomeScreen()));
        } else {
          AppConstants.showFailToast(context, "Failed to save data");
        }
      } catch (e) {
        AppConstants.showFailToast(context, e.toString());
      }
    }
  }

  // =======> Engineer Qualification Start <=======

  List<EngineerQualificationModel> engineerQualificationDoneObj;
  final List<EngineerQualificationModel> _engineerQualificationList = [];
  List<EngineerQualificationModel> get engineerQualificationList => _engineerQualificationList;
  bool _loadingQualification = false;
  bool get loadingQualification => _loadingQualification;

  Future<void> getEngineerQualification() async {
    _loadingQualification = true;
    _searchBoxTypeQualification = false;
    notifyListeners();
    try {
      engineerQualificationDoneObj = await Api().fetchEngineerQualification(ApiUrls.engineerQualificationList);
      _engineerQualificationList.clear();
      for (var element in engineerQualificationDoneObj) {
        _engineerQualificationList.add(element);
      }
      _loadingQualification = false;
    } on SocketException {
      _loadingQualification = false;
    } catch (e) {
      _loadingQualification = false;
    }
    notifyListeners();
  }

  bool _searchBoolQualification = false;
  bool get searchBoolQualification => _searchBoolQualification;

  void onClickSearchQualification() {
    if (_searchBoolQualification) {
      _searchBoolQualification = false;
      _searchBoxTypeQualification = false;
      notifyListeners();
    } else {
      _searchBoolQualification = true;
      notifyListeners();
    }
  }

  final List<EngineerQualificationModel> _filteredEngineerQualificationList = [];
  List<EngineerQualificationModel> get filteredEngineerQualificationList => _filteredEngineerQualificationList;

  bool _searchBoxTypeQualification = false;
  bool get searchBoxTypeQualification => _searchBoxTypeQualification;

  List<bool> _isReadEngineerQualificationMain = [];
  List<bool> get isReadEngineerQualificationMain => _isReadEngineerQualificationMain;

  List<bool> _isReadEngineerQualificationFilter = [];
  List<bool> get isReadEngineerQualificationFilter => _isReadEngineerQualificationFilter;

  List<bool> _isReadEngineerQualificationSearch = [];
  List<bool> get isReadEngineerQualificationSearch => _isReadEngineerQualificationSearch;

  void performSearchQualification(String query) {
    query = query.toLowerCase();
    _filteredEngineerQualificationList.clear();
    _isReadEngineerQualificationFilter.clear();
    _isReadEngineerQualificationFilter.addAll(_isReadEngineerQualificationMain);
    if (query.isNotEmpty) {
      _isReadEngineerQualificationSearch.clear();
      _searchBoxTypeQualification = true;
      notifyListeners();
      for (var document in _engineerQualificationList) {
        if (document.documentType.toLowerCase().contains(query) ||
            document.document.toLowerCase().contains(query)) {
          _isReadEngineerQualificationSearch.add(_isReadEngineerQualificationFilter.elementAt(_engineerQualificationList.indexOf(document)));
          _filteredEngineerQualificationList.add(document);
        }
      }
    } else {
      _filteredEngineerQualificationList.addAll(_engineerQualificationList);
      _searchBoxTypeQualification = false;
      notifyListeners();
    }
    notifyListeners();
  }
}