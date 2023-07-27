//@dart=2.9
import 'dart:io';
import 'package:flutter/material.dart';
import '../constant/api_urls.dart';
import '../constant/appconstant.dart';
import '../model/engineer_document_model.dart';
import '../model/save_sapphire_gas_flow_model.dart';
import '../service/api.dart';

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

  // =======> Save Sapphire Gas Flow Start <=======

  int _currentStep = 0;
  int get currentStep => _currentStep;

  void currentStepNext(){
    _currentStep += 1;
    notifyListeners();
  }

  void currentStepCancel(){
    _currentStep -= 1;
    notifyListeners();
  }

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
  final _sapphireWorkId = TextEditingController();
  TextEditingController get sapphireWorkId => _sapphireWorkId;

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
  final _subBuildingName = TextEditingController();
  TextEditingController get subBuildingName => _subBuildingName;
  final _buildingName = TextEditingController();
  TextEditingController get buildingName => _buildingName;
  final _dependentThroughFare = TextEditingController();
  TextEditingController get dependentThroughFare => _dependentThroughFare;
  final _throughFare = TextEditingController();
  TextEditingController get throughFare => _throughFare;
  final _doubleDependentLocality = TextEditingController();
  TextEditingController get doubleDependentLocality => _doubleDependentLocality;
  final _dependentLocality = TextEditingController();
  TextEditingController get dependentLocality => _dependentLocality;
  final _postTown = TextEditingController();
  TextEditingController get postTown => _postTown;
  final _county = TextEditingController();
  TextEditingController get county => _county;

  final _additionalInformationForWork = TextEditingController();
  TextEditingController get additionalInformationForWork => _additionalInformationForWork;
  final _transactionReference = TextEditingController();
  TextEditingController get transactionReference => _transactionReference;
  final _transactionTypeCode = TextEditingController();
  TextEditingController get transactionTypeCode => _transactionTypeCode;
  final _transactionTypeReasonCode = TextEditingController();
  TextEditingController get transactionTypeReasonCode => _transactionTypeReasonCode;

  final _engineerName = TextEditingController();
  TextEditingController get engineerName => _engineerName;
  final _transactionStatusCode = TextEditingController();
  TextEditingController get transactionStatusCode => _transactionStatusCode;
  final _transactionStatusChange = TextEditingController();
  TextEditingController get transactionStatusChange => _transactionStatusChange;
  final _siteVisitNote = TextEditingController();
  TextEditingController get siteVisitNote => _siteVisitNote;
  final _transactionTypeCodeForCompleteWork = TextEditingController();
  TextEditingController get transactionTypeCodeForCompleteWork => _transactionTypeCodeForCompleteWork;
  final _transactionTypeReasonCodeForCompleteWork = TextEditingController();
  TextEditingController get transactionTypeReasonCodeForCompleteWork => _transactionTypeReasonCodeForCompleteWork;

  void clearAllGasFormData(){
    _memMpId.text= "";
    _supplierMpId.text= "";
    _mprn.text= "";
    _externalSystemIdentity.text= "";
    _correlationId.text= "";
    _sapphireWorkId.text= "";
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
    _subBuildingName.text= "";
    _buildingName.text= "";
    _dependentThroughFare.text= "";
    _throughFare.text= "";
    _doubleDependentLocality.text= "";
    _dependentLocality.text= "";
    _postTown.text= "";
    _county.text= "";
    notifyListeners();
    _textEditingControllerAppointmentDate.text= "";
    _additionalInformationForWork.text= "";
    _transactionReference.text= "";
    _transactionTypeCode.text= "";
    _transactionTypeReasonCode.text= "";
    notifyListeners();
    _textEditingControllerSiteVisitDate.text= "";
    _engineerName.text= "";
    _transactionStatusCode.text= "";
    _transactionStatusChange.text= "";
    _siteVisitNote.text= "";
    _transactionTypeCodeForCompleteWork.text= "";
    _transactionTypeReasonCodeForCompleteWork.text= "";
    notifyListeners();
    _meterLinkCodeForMeterSystem.text= "";
    _statusCodeForMeterSystem.text= "";
    _locationCodeForMeterSystem.text= "";
    _locationNotesForMeterSystem.text= "";
    _accessInstructionsForMeterSystem.text= "";
    _conversionFactorForMeterSystem.text= "";
    _meteringPressureForMeterSystem.text= "";
    notifyListeners();
    _formDataList.clear();
    notifyListeners();
    initForm();
  }

  final _meterLinkCodeForMeterSystem = TextEditingController();
  TextEditingController get meterLinkCodeForMeterSystem => _meterLinkCodeForMeterSystem;
  final _statusCodeForMeterSystem = TextEditingController();
  TextEditingController get statusCodeForMeterSystem => _statusCodeForMeterSystem;
  final _locationCodeForMeterSystem = TextEditingController();
  TextEditingController get locationCodeForMeterSystem => _locationCodeForMeterSystem;
  final _locationNotesForMeterSystem = TextEditingController();
  TextEditingController get locationNotesForMeterSystem => _locationNotesForMeterSystem;
  final _accessInstructionsForMeterSystem = TextEditingController();
  TextEditingController get accessInstructionsForMeterSystem => _accessInstructionsForMeterSystem;
  final _conversionFactorForMeterSystem = TextEditingController();
  TextEditingController get conversionFactorForMeterSystem => _conversionFactorForMeterSystem;
  final _meteringPressureForMeterSystem = TextEditingController();
  TextEditingController get meteringPressureForMeterSystem => _meteringPressureForMeterSystem;

  bool _isCheckData = false;
  bool get isCheckData => _isCheckData;

  bool areAllFieldsFilled() {
    for (var data in formDataList) {
      if (data['useTemplate'] == 'False') {
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

  void fieldDataCheck(int _currentStep, BuildContext context){
    if(_currentStep == 0){
      if(_memMpId.text.isNotEmpty && _supplierMpId.text.isNotEmpty && _mprn.text.isNotEmpty && _externalSystemIdentity.text.isNotEmpty && _sapphireWorkId.text.isNotEmpty){
        _isCheckData = true;
        notifyListeners();
      }
      else{
        _isCheckData = false;
        notifyListeners();
        AppConstants.showFailToast(context, "Required Fields Compulsory");
      }
    }
    else if(_currentStep == 1){
      if(_statusCode.text.isNotEmpty && _locationCode.text.isNotEmpty && _conversionFactor.text.isNotEmpty && _meteringPressure.text.isNotEmpty){
        _isCheckData = true;
        notifyListeners();
      }
      else{
        _isCheckData = false;
        notifyListeners();
        AppConstants.showFailToast(context, "Required Fields Compulsory");
      }
    }
    else if(_currentStep == 2){
      if(_postCode.text.isNotEmpty){
        _isCheckData = true;
        notifyListeners();
      }
      else{
        _isCheckData = false;
        notifyListeners();
        AppConstants.showFailToast(context, "Required Fields Compulsory");
      }
    }
    else if(_currentStep == 3){
      _isCheckData = true;
      notifyListeners();
    }
    else if(_currentStep == 4){
      if(_textEditingControllerSiteVisitDate.text.isNotEmpty && _visitSuccessful!=null && _readingTaken!=null && _engineerName.text.isNotEmpty && _transactionStatusCode.text.isNotEmpty){
        _isCheckData = true;
        notifyListeners();
      }
      else{
        _isCheckData = false;
        notifyListeners();
        AppConstants.showFailToast(context, "Required Fields Compulsory");
      }
    }
    else if(_currentStep == 5){
      _isCheckData = true;
      notifyListeners();
    }
    else{
      if (areAllFieldsFilled()) {
        _isCheckData = true;
        notifyListeners();
      } else {
        _isCheckData = false;
        notifyListeners();
        AppConstants.showFailToast(context, "Required Fields Compulsory");
      }
    }
  }

  void isCheckDataFalseSet(){
    _isCheckData = false;
    notifyListeners();
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
      'meterType': TextEditingController(),
      'mechanismCode': TextEditingController(),
      'measuringCapacity': TextEditingController(),
      'meterUsageCode': TextEditingController(),
      'collarStatusCode': TextEditingController(),
      'oamiInspectionDate': TextEditingController(),
      'pulseValue': TextEditingController(),
      'gasActOwnerRole': TextEditingController(),
      'assetRemovalDate': TextEditingController(),
      'registers': [
        {
          'numberOfDigits': TextEditingController(),
          'unitsOfMeasure': TextEditingController(),
          'multiplicationFactor': TextEditingController(),
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
      'unitsOfMeasure': TextEditingController(),
      'multiplicationFactor': TextEditingController(),
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
      'meterType': TextEditingController(),
      'mechanismCode': TextEditingController(),
      'measuringCapacity': TextEditingController(),
      'meterUsageCode': TextEditingController(),
      'collarStatusCode': TextEditingController(),
      'oamiInspectionDate': TextEditingController(),
      'pulseValue': TextEditingController(),
      'gasActOwnerRole': TextEditingController(),
      'assetRemovalDate': TextEditingController(),
      'registers': [
        {
          'numberOfDigits': TextEditingController(),
          'unitsOfMeasure': TextEditingController(),
          'multiplicationFactor': TextEditingController(),
          'readingIndex': TextEditingController(),
        },
      ],
    });
    notifyListeners();
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

  void saveSapphireGasFlow(BuildContext context) async {
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
        'meterType': formData['meterType'] is TextEditingController ? formData['meterType'].text : formData['meterType'],
        'mechanismCode': formData['mechanismCode'] is TextEditingController ? formData['mechanismCode'].text : formData['mechanismCode'],
        'measuringCapacity': formData['measuringCapacity'] is TextEditingController ? formData['measuringCapacity'].text : formData['measuringCapacity'],
        'meterUsageCode': formData['meterUsageCode'] is TextEditingController ? formData['meterUsageCode'].text : formData['meterUsageCode'],
        'collarStatusCode': formData['collarStatusCode'] is TextEditingController ? formData['collarStatusCode'].text : formData['collarStatusCode'],
        'oamiInspectionDate': formData['oamiInspectionDate'] is TextEditingController ? formData['oamiInspectionDate'].text : formData['oamiInspectionDate'],
        'pulseValue': formData['pulseValue'] is TextEditingController ? formData['pulseValue'].text : formData['pulseValue'],
        'gasActOwnerRole': formData['gasActOwnerRole'] is TextEditingController ? formData['gasActOwnerRole'].text : formData['gasActOwnerRole'],
        'assetRemovalDate': formData['assetRemovalDate'] is TextEditingController ? formData['assetRemovalDate'].text : formData['assetRemovalDate'],
      };

      List<Map<String, dynamic>> registersList = formData['registers'];
      List<Map<String, dynamic>> registerList = [];
      for (var subForm in registersList) {
        Map<String, dynamic> subFormField = {
          'intId': 0,
          'numberOfDigits': subForm['numberOfDigits'] is TextEditingController ? subForm['numberOfDigits'].text : subForm['numberOfDigits'],
          'unitsOfMeasure': subForm['unitsOfMeasure'] is TextEditingController ? subForm['unitsOfMeasure'].text : subForm['unitsOfMeasure'],
          'multiplicationFactor': subForm['multiplicationFactor'] is TextEditingController ? subForm['multiplicationFactor'].text : subForm['multiplicationFactor'],
          'readingIndex': subForm['readingIndex'] is TextEditingController ? subForm['readingIndex'].text : subForm['readingIndex'],
        };
        registerList.add(subFormField);
      }

      assetMap['registers'] = registerList;

      Map<String, dynamic> firstJsonData = {
        "intCustomerId": 0,
        "intUserId": "20025",
        "intappointmentId": 0,
        "memMpid": _memMpId.text,
        "supplierMpid": _supplierMpId.text,
        "mprn": _mprn.text,
        "externalSystemIdentity": _externalSystemIdentity.text,
        "correlationId": _correlationId.text,
        "sapphireWorkId": _sapphireWorkId.text,
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
            "subBuildingName": _subBuildingName.text,
            "buildingName": _buildingName.text,
            "dependentThoroughfare": _dependentThroughFare.text,
            "thoroughfare": _throughFare.text,
            "doubleDependentLocality": _doubleDependentLocality.text,
            "dependentLocality": _dependentLocality.text,
            "postTown": _postTown.text,
            "county": _county.text,
          }
        },
        "createWork": {
          "appointmentDateTime": _textEditingControllerAppointmentDate.text,
          "additionalInformationForWork": _additionalInformationForWork.text,
          "transactionReference": _transactionReference.text,
          "transactionTypeCode": _transactionTypeCode.text,
          "transactionTypeReasonCode": _transactionTypeReasonCode.text,
        },
        "completeWork": {
          "siteVisitDate": _textEditingControllerSiteVisitDate.text,
          "visitSuccessful": _visitSuccessful.toString(),
          "readingTaken": _readingTaken.toString(),
          "engineerName": _engineerName.text,
          "transactionStatusCode": _transactionStatusCode.text,
          "transactionStatusChangeReasonCode": _transactionStatusChange.text,
          "siteVisitNotes": _siteVisitNote.text,
          "transactionTypeCode": _transactionTypeCodeForCompleteWork.text,
          "transactionTypeReasonCode": _transactionTypeReasonCodeForCompleteWork.text,
          "meterSystem": {
            "meterLinkCode": _meterLinkCodeForMeterSystem.text,
            "statusCode": _statusCodeForMeterSystem.text,
            "locationCode": _locationCodeForMeterSystem.text,
            "locationNotes": _locationNotesForMeterSystem.text,
            "accessInstructions": _accessInstructionsForMeterSystem.text,
            "conversionFactor": _conversionFactorForMeterSystem.text,
            "meteringPressure": _meteringPressureForMeterSystem.text,
            "assets": [assetMap],
          }
        }
      };

      try {
        Api api = Api();
        SaveSapphireGasFlow apiResponse = await api.saveSapphireGasFlow(context, firstJsonData);
        if (apiResponse.status == 5 && apiResponse.isCompleted == true) {
          clearAllGasFormData();
          _currentStep = 0;
          notifyListeners();
          AppConstants.showSuccessToast(context, "Saved Successfully");
        } else {
          AppConstants.showFailToast(context, "Failed to save data");
        }
      } catch (e) {
        AppConstants.showFailToast(context, e.toString());
      }
    }
  }

  // =======> Save Sapphire Electricity Gas Flow Start <=======

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
  final _sapphireWorkIdElectricity = TextEditingController();
  TextEditingController get sapphireWorkIdElectricity => _sapphireWorkIdElectricity;

  final _textEditingControllerAppointmentDateElectricity = TextEditingController();
  TextEditingController get textEditingControllerAppointmentDateElectricity => _textEditingControllerAppointmentDateElectricity;
  DateTime _selectedAppointmentDateElectricity;
  DateTime get selectedAppointmentDateElectricity => _selectedAppointmentDateElectricity;
  Future<void> selectAppointmentDateElectricity(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _selectedAppointmentDateElectricity ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      _selectedAppointmentDateElectricity = picked;
      _textEditingControllerAppointmentDateElectricity.text = formatDate(picked);
      notifyListeners();
    }
  }

  final TextEditingController _additionalInformationForWorkElectricity = TextEditingController();
  TextEditingController get additionalInformationForWorkElectricity => _additionalInformationForWorkElectricity;
  final _requestedEnergisationStatusElectricity = TextEditingController();
  TextEditingController get requestedEnergisationStatusElectricity => _requestedEnergisationStatusElectricity;
  final _retrievalMethodElectricity = TextEditingController();
  TextEditingController get retrievalMethodElectricity => _retrievalMethodElectricity;
  final _removeMeteringPointMetersElectricity = TextEditingController();
  TextEditingController get removeMeteringPointMetersElectricity => _removeMeteringPointMetersElectricity;
  final _standardSettlementCodeElectricity = TextEditingController();
  TextEditingController get standardSettlementCodeElectricity => _standardSettlementCodeElectricity;
  final _nonSettlementFunctionCodeElectricity = TextEditingController();
  TextEditingController get nonSettlementFunctionCodeElectricity => _nonSettlementFunctionCodeElectricity;

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
  final _siteVisitNotesElectricity = TextEditingController();
  TextEditingController get siteVisitNotesElectricity => _siteVisitNotesElectricity;
  final _failureToEneOrDeElectricity = TextEditingController();
  TextEditingController get failureToEneOrDeElectricity => _failureToEneOrDeElectricity;
  final _siteVisitCheckCodeElectricity = TextEditingController();
  TextEditingController get siteVisitCheckCodeElectricity => _siteVisitCheckCodeElectricity;
  final _assetConditionCodeElectricity = TextEditingController();
  TextEditingController get assetConditionCodeElectricity => _assetConditionCodeElectricity;
  final _assetConditionAdditionalElectricity = TextEditingController();
  TextEditingController get assetConditionAdditionalElectricity => _assetConditionAdditionalElectricity;

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
  final _nonSettlementFunctionCodeForMeterSystemElectricity = TextEditingController();
  TextEditingController get nonSettlementFunctionCodeForMeterSystemElectricity => _nonSettlementFunctionCodeForMeterSystemElectricity;
  final _retrievalMethodForMeterSystemElectricity = TextEditingController();
  TextEditingController get retrievalMethodForMeterSystemElectricity => _retrievalMethodForMeterSystemElectricity;

  final _copRefElectricity = TextEditingController();
  TextEditingController get copRefElectricity => _copRefElectricity;
  final _copIssueNumberElectricity = TextEditingController();
  TextEditingController get copIssueNumberElectricity => _copIssueNumberElectricity;

  String _remoteEnableElectricity = "true";
  String get remoteEnableElectricity => _remoteEnableElectricity;
  void handleRemoteEnableSelectionElectricity(String remoteEnable) {
    _remoteEnableElectricity = remoteEnable;
    notifyListeners();
  }

  final _eventIndicatorElectricity = TextEditingController();
  TextEditingController get eventIndicatorElectricity => _eventIndicatorElectricity;

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
      'prePaymentDataUnavailableElectricity': TextEditingController(),
      'debtRecoveryRateElectricity': TextEditingController(),
      'hasEmergencyCredit': true,
      'initialCreditElectricity': TextEditingController(),
      'standingChangeElectricity': TextEditingController(),
      'totalDebitElectricity': TextEditingController(),
      'totalDebitOutstandingElectricity': TextEditingController(),
      'totalCreditAcceptedElectricity': TextEditingController(),
      'totalTokensInsertedElectricity': TextEditingController(),
      'creditBalanceElectricity': TextEditingController(),
      'emergencyCreditElectricity': TextEditingController(),
      'prePaymentMeterShutdownStatusElectricity': TextEditingController(),
      'meterRemovalDateElectricity': TextEditingController(),
      'subForms': [
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
          'readingNotValidReasonCodeElectricity': TextEditingController(),
          'prepaymentUnitRateElectricity': TextEditingController(),
          'subSubForms': [
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
      'prePaymentDataUnavailableElectricity': TextEditingController(),
      'debtRecoveryRateElectricity': TextEditingController(),
      'hasEmergencyCredit': true,
      'initialCreditElectricity': TextEditingController(),
      'standingChangeElectricity': TextEditingController(),
      'totalDebitElectricity': TextEditingController(),
      'totalDebitOutstandingElectricity': TextEditingController(),
      'totalCreditAcceptedElectricity': TextEditingController(),
      'totalTokensInsertedElectricity': TextEditingController(),
      'creditBalanceElectricity': TextEditingController(),
      'emergencyCreditElectricity': TextEditingController(),
      'prePaymentMeterShutdownStatusElectricity': TextEditingController(),
      'meterRemovalDateElectricity': TextEditingController(),
      'subForms': [
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
          'readingNotValidReasonCodeElectricity': TextEditingController(),
          'prepaymentUnitRateElectricity': TextEditingController(),
          'subSubForms': [
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

  void removeFormElectricityMeters(int index) {
    _formDataListElectricityMeters.removeAt(index);
    notifyListeners();
  }

  void addSubFormElectricityMeters(int index) {
    _formDataListElectricityMeters[index]['subForms'].add({
      'useTemplateForRegistersElectricity': true,
      'meterRegisterIdElectricity': TextEditingController(),
      'isSettlementElectricity': true,
      'registerTypeElectricity': TextEditingController(),
      'numberOfDigitsElectricity': TextEditingController(),
      'measurementQuantityElectricity': TextEditingController(),
      'multiplierElectricity': TextEditingController(),
      'registerReadingElectricity': TextEditingController(),
      'readingTypeElectricity': TextEditingController(),
      'readingNotValidReasonCodeElectricity': TextEditingController(),
      'prepaymentUnitRateElectricity': TextEditingController(),
      'subSubForms': [
        {
          'timePatternRegimeElectricity': TextEditingController(),
          'settlementMapCoefficientElectricity': TextEditingController(),
        },
      ],
    });
    notifyListeners();
  }

  void removeSubFormElectricityMeters(int parentIndex, int subIndex) {
    _formDataListElectricityMeters[parentIndex]['subForms'].removeAt(subIndex);
    notifyListeners();
  }

  void addSubSubFormElectricityMeters(int parentIndex, int subIndex) {
    _formDataListElectricityMeters[parentIndex]['subForms'][subIndex]['subSubForms'].add({
      'timePatternRegimeElectricity': TextEditingController(),
      'settlementMapCoefficientElectricity': TextEditingController(),
    });
    notifyListeners();
  }

  void removeSubSubFormElectricityMeters(int parentIndex, int subIndex, int subSubIndex) {
    _formDataListElectricityMeters[parentIndex]['subForms'][subIndex]['subSubForms'].removeAt(subSubIndex);
    notifyListeners();
  }

  List<Map<String, dynamic>> _formDataListElectricityOutstation = [];
  List<Map<String, dynamic>> get formDataListElectricityOutstation => _formDataListElectricityOutstation;

  void initFormElectricityOutstation() {
    _formDataListElectricityOutstation.add({
      'serialNumberElectricityOutstation': TextEditingController(),
      'outstationTypeElectricityOutstation': TextEditingController(),
      'numberOfChannelsElectricityOutstation': TextEditingController(),
      'numberOfDigitsElectricityOutstation': TextEditingController(),
      'pinElectricityOutstation': TextEditingController(),
      'multiplierElectricityOutstation': TextEditingController(),
      'usernameLevel1ElectricityOutstation': TextEditingController(),
      'passwordLevel1ElectricityOutstation': TextEditingController(),
      'usernameLevel2ElectricityOutstation': TextEditingController(),
      'passwordLevel2ElectricityOutstation': TextEditingController(),
      'usernameLevel3ElectricityOutstation': TextEditingController(),
      'passwordLevel3ElectricityOutstation': TextEditingController(),
      'commsMethodElectricityOutstation': TextEditingController(),
      'commsAddressElectricityOutstation': TextEditingController(),
      'commsBaudRateElectricityOutstation': TextEditingController(),
      'commsDialInOutElectricityOutstation': TextEditingController(),
      'commsProviderElectricityOutstation': TextEditingController(),
      'subForms1': [
        {
          'channelNumberElectricityOutstation': TextEditingController(),
          'pulseMultiplierElectricityOutstation': TextEditingController(),
          'measurementQuantityElectricityOutstation': TextEditingController(),
        },
      ],
      'subForms2': [
        {
          'meterSerialNumberElectricityOutstation': TextEditingController(),
          'meterRegisterIdElectricityOutstation': TextEditingController(),
          'meterMemoryLocationTypeElectricityOutstation': TextEditingController(),
          'meterMemoryLocationElectricityOutstation': TextEditingController(),
          'timestampMemoryLocationElectricityOutstation': TextEditingController(),
        },
      ],
    });
    notifyListeners();
  }

  void addFormElectricityOutstation() {
    _formDataListElectricityOutstation.add({
      'serialNumberElectricityOutstation': TextEditingController(),
      'outstationTypeElectricityOutstation': TextEditingController(),
      'numberOfChannelsElectricityOutstation': TextEditingController(),
      'numberOfDigitsElectricityOutstation': TextEditingController(),
      'pinElectricityOutstation': TextEditingController(),
      'multiplierElectricityOutstation': TextEditingController(),
      'usernameLevel1ElectricityOutstation': TextEditingController(),
      'passwordLevel1ElectricityOutstation': TextEditingController(),
      'usernameLevel2ElectricityOutstation': TextEditingController(),
      'passwordLevel2ElectricityOutstation': TextEditingController(),
      'usernameLevel3ElectricityOutstation': TextEditingController(),
      'passwordLevel3ElectricityOutstation': TextEditingController(),
      'commsMethodElectricityOutstation': TextEditingController(),
      'commsAddressElectricityOutstation': TextEditingController(),
      'commsBaudRateElectricityOutstation': TextEditingController(),
      'commsDialInOutElectricityOutstation': TextEditingController(),
      'commsProviderElectricityOutstation': TextEditingController(),
      'subForms1': [
        {
          'channelNumberElectricityOutstation': TextEditingController(),
          'pulseMultiplierElectricityOutstation': TextEditingController(),
          'measurementQuantityElectricityOutstation': TextEditingController(),
        },
      ],
      'subForms2': [
        {
          'meterSerialNumberElectricityOutstation': TextEditingController(),
          'meterRegisterIdElectricityOutstation': TextEditingController(),
          'meterMemoryLocationTypeElectricityOutstation': TextEditingController(),
          'meterMemoryLocationElectricityOutstation': TextEditingController(),
          'timestampMemoryLocationElectricityOutstation': TextEditingController(),
        },
      ],
    });
    notifyListeners();
  }

  void removeFormElectricityOutstation(int index) {
    _formDataListElectricityOutstation.removeAt(index);
    notifyListeners();
  }

  void addSubForm1ElectricityOutstation(int index) {
    _formDataListElectricityOutstation[index]['subForms1'].add({
      'channelNumberElectricityOutstation': TextEditingController(),
      'pulseMultiplierElectricityOutstation': TextEditingController(),
      'measurementQuantityElectricityOutstation': TextEditingController(),
    });
    notifyListeners();
  }

  void removeSubForm1ElectricityOutstation(int parentIndex, int subIndex) {
    _formDataListElectricityOutstation[parentIndex]['subForms1'].removeAt(subIndex);
    notifyListeners();
  }

  void addSubForm2ElectricityOutstation(int index) {
    _formDataListElectricityOutstation[index]['subForms2'].add({
      'meterSerialNumberElectricityOutstation': TextEditingController(),
      'meterRegisterIdElectricityOutstation': TextEditingController(),
      'meterMemoryLocationTypeElectricityOutstation': TextEditingController(),
      'meterMemoryLocationElectricityOutstation': TextEditingController(),
      'timestampMemoryLocationElectricityOutstation': TextEditingController(),
    });
    notifyListeners();
  }

  void removeSubForm2ElectricityOutstation(int parentIndex, int subIndex) {
    _formDataListElectricityOutstation[parentIndex]['subForms2'].removeAt(subIndex);
    notifyListeners();
  }
}