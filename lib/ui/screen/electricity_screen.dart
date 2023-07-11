//@dart=2.9
import 'package:flutter/material.dart';
import '../../core/constant/app_colors.dart';
import '../../core/constant/app_string.dart';
import '../../core/constant/image_file.dart';
import '../../core/model/send/answer_credential.dart';
import '../shared/app_drawer_widget.dart';
import '../shared/warehouse_app_drawer.dart';
import 'widget/electricity/electricity_text_field_widget.dart';

class Electricity extends StatefulWidget {
  @override
  _ElectricityState createState() => _ElectricityState();
}

class _ElectricityState extends State<Electricity> {

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  int _currentStep = 0;

  String _visitSuccessful;
  void _handleVisitSuccessfulSelection(String visitSuccessful) {
    setState(() {
      _visitSuccessful = visitSuccessful;
    });
  }

  String _readingTaken;
  void _handleReadingTakenSelection(String readingTaken) {
    setState(() {
      _readingTaken = readingTaken;
    });
  }

  String _isSmart;
  void _handleIsSmartSelection(String isSmart) {
    setState(() {
      _isSmart = isSmart;
    });
  }

  TextEditingController _textEditingControllerAppointmentDate = TextEditingController();
  DateTime _selectedAppointmentDate;
  Future<void> _selectAppointmentDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _selectedAppointmentDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _selectedAppointmentDate = picked;
        _textEditingControllerAppointmentDate.text = _formatDate(picked);
      });
    }
  }

  TextEditingController _textEditingControllerSiteVisitDate = TextEditingController();
  DateTime _selectedSiteVisitDate;
  Future<void> _selectSiteVisitDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _selectedSiteVisitDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _selectedSiteVisitDate = picked;
        _textEditingControllerSiteVisitDate.text = _formatDate(picked);
      });
    }
  }

  String _formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year.toString()}";
  }

  List<String> listUseTemplate = [];
  void _handleUseTemplateSelection(String useTemplate, int index) {
    setState(() {
      listUseTemplate[index] = useTemplate;
    });
  }

  List<TextEditingController> listInstallationStatusController = [TextEditingController()];
  List<TextEditingController> listSerialNumberController = [TextEditingController()];
  List<TextEditingController> listEquipmentTypeNameController = [TextEditingController()];
  List<TextEditingController> listMeterTypeController = [TextEditingController()];
  List<TextEditingController> listOwnerMpidController = [TextEditingController()];
  List<TextEditingController> listCurrentRatingController = [TextEditingController()];
  List<TextEditingController> listTimingNumberController = [TextEditingController()];
  List<TextEditingController> listCtRatioController = [TextEditingController()];
  List<TextEditingController> listVtRatioController = [TextEditingController()];
  List<TextEditingController> listPrepaymentController = [TextEditingController()];
  List<TextEditingController> listDebtController = [TextEditingController()];

  List<String> listHasEmergencyCredit = [];
  void _handleHasEmergencyCreditSelection(String hasEmergencyCredit, int index) {
    setState(() {
      listHasEmergencyCredit[index] = hasEmergencyCredit;
    });
  }

  List<TextEditingController> listInitialController = [TextEditingController()];
  List<TextEditingController> listStandingController = [TextEditingController()];
  List<TextEditingController> listTotalDebtController = [TextEditingController()];
  List<TextEditingController> listTotalDebtOutstandingController = [TextEditingController()];
  List<TextEditingController> listTotalCreditAcceptedController = [TextEditingController()];
  List<TextEditingController> listTotalTokenController = [TextEditingController()];
  List<TextEditingController> listCreditBalanceController = [TextEditingController()];
  List<TextEditingController> listEmergencyCreditController = [TextEditingController()];
  List<TextEditingController> listPrepaymentMeterController = [TextEditingController()];

  List<TextEditingController> listMeterRemovalDateController = [TextEditingController()];
  DateTime _selectedMeterRemovalDate;
  Future<void> _selectMeterRemovalDate(BuildContext context, int index) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _selectedMeterRemovalDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _selectedMeterRemovalDate = picked;
        listMeterRemovalDateController[index].text = _formatDate(picked);
      });
    }
  }

  List<String> listUseTemplateRegister = [];
  void _handleUseTemplateRegisterSelection(String useTemplateRegister, int index) {
    setState(() {
      listUseTemplateRegister[index] = useTemplateRegister;
    });
  }

  List<TextEditingController> listMeterRegisterIdController = [TextEditingController()];

  List<String> listIsSettlement = [];
  void _handleIsSettlementSelection(String isSettlement, int index) {
    setState(() {
      listIsSettlement[index] = isSettlement;
    });
  }

  List<TextEditingController> listRegisterTypeController = [TextEditingController()];
  List<TextEditingController> listNumberOfDigitsController = [TextEditingController()];
  List<TextEditingController> listMeasurementQuantityController = [TextEditingController()];
  List<TextEditingController> listMultiplierController = [TextEditingController()];
  List<TextEditingController> listRegisterReadingController = [TextEditingController()];
  List<TextEditingController> listReadingTypeController = [TextEditingController()];
  List<TextEditingController> listReadingNotController = [TextEditingController()];
  List<TextEditingController> listPrePaymentController = [TextEditingController()];

  List<TextEditingController> listTimePatternController = [TextEditingController()];
  List<TextEditingController> listSettlementMapController = [TextEditingController()];

  String _remoteEnable;
  void _handleRemoteEnableSelection(String remoteEnable) {
    setState(() {
      _remoteEnable = remoteEnable;
    });
  }

  List<TextEditingController> listSerialNumberOutstationController = [TextEditingController()];
  List<TextEditingController> listOutstationTypeController = [TextEditingController()];
  List<TextEditingController> listNumberOfChannelsController = [TextEditingController()];
  List<TextEditingController> listNumberOfDialsController = [TextEditingController()];
  List<TextEditingController> listPinController = [TextEditingController()];
  List<TextEditingController> listMultiplierOutstationController = [TextEditingController()];
  List<TextEditingController> listUsernameLevel1Controller = [TextEditingController()];
  List<TextEditingController> listPasswordLevel1Controller = [TextEditingController()];
  List<TextEditingController> listUsernameLevel2Controller = [TextEditingController()];
  List<TextEditingController> listPasswordLevel2Controller = [TextEditingController()];
  List<TextEditingController> listUsernameLevel3Controller = [TextEditingController()];
  List<TextEditingController> listPasswordLevel3Controller = [TextEditingController()];
  List<TextEditingController> listCommMethodController = [TextEditingController()];
  List<TextEditingController> listCommAddressController = [TextEditingController()];
  List<TextEditingController> listCommBaudRateController = [TextEditingController()];
  List<TextEditingController> listCommDialInOutController = [TextEditingController()];
  List<TextEditingController> listCommProviderController = [TextEditingController()];

  List<TextEditingController> listChannelController = [TextEditingController()];
  List<TextEditingController> listPulseController = [TextEditingController()];
  List<TextEditingController> listMeasurementController = [TextEditingController()];

  List<TextEditingController> listMeterNumberController = [TextEditingController()];
  List<TextEditingController> listMeterIdController = [TextEditingController()];
  List<TextEditingController> listMeterMemoryLocationTypeController = [TextEditingController()];
  List<TextEditingController> listMeterMemoryLocationController = [TextEditingController()];
  List<TextEditingController> listTimestampController = [TextEditingController()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scafoldColor,
      key: _scaffoldKey,
      drawer: Drawer(
        child: GlobalVar.roleId == 5 ? WareHouseDrawerWidget() : AppDrawerWidget(),
      ),
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: AppColors.appThemeColor,
        leading: Padding(
          padding: const EdgeInsets.all(18.0),
          child: InkWell(
            onTap: () {
              _scaffoldKey.currentState.openDrawer();
            },
            child: Image.asset(
              ImageFile.menuIcon,
            ),
          ),
        ),
        title: Text(
          AppStrings.dashboard,
          style: TextStyle(
            color: AppColors.whiteColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        actions: [],
      ),
      body: Stepper(
        currentStep: _currentStep,
        onStepTapped: (int index) {
          setState(() {
            _currentStep = index;
          });
        },
        onStepContinue: () {
          setState(() {
            if (_currentStep < 11 - 1) {
              _currentStep += 1;
            }
          });
        },
        onStepCancel: () {
          setState(() {
            if (_currentStep > 0) {
              _currentStep -= 1;
            }
          });
        },
        steps: [
          Step(
            isActive: _currentStep == 0,
            state: _currentStep >= 0 ? StepState.complete : StepState.indexed,
            title: Text('Electricity Flow'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElectricityTextFieldWidget(
                  hintText: "MEM MpId",
                ),
                SizedBox(height: 10),
                ElectricityTextFieldWidget(
                  hintText: "Supplier MpId",
                ),
                SizedBox(height: 10),
                ElectricityTextFieldWidget(
                  hintText: "MPAN",
                ),
                SizedBox(height: 10),
                ElectricityTextFieldWidget(
                  hintText: "External System Identity",
                ),
                SizedBox(height: 10),
                ElectricityTextFieldWidget(
                  hintText: "Correlation Id",
                ),
                SizedBox(height: 10),
                ElectricityTextFieldWidget(
                  hintText: "Sapphire Work Id",
                ),
              ],
            ),
          ),
          Step(
            isActive: _currentStep == 1,
            state: _currentStep >= 1 ? StepState.complete : StepState.indexed,
            title: Text('Create Work'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElectricityTextFieldWidget(
                  hintText: "Appointment Date",
                  onTap: () => _selectAppointmentDate(context),
                  controller: _textEditingControllerAppointmentDate,
                ),
                SizedBox(height: 10),
                ElectricityTextFieldWidget(
                  hintText: "Additional Information For Work",
                  maxLine: 3,
                ),
                SizedBox(height: 10),
                ElectricityTextFieldWidget(
                  hintText: "Requested Energisation Status",
                ),
                SizedBox(height: 10),
                ElectricityTextFieldWidget(
                  hintText: "Retrieval Method",
                ),
                SizedBox(height: 10),
                ElectricityTextFieldWidget(
                  hintText: "Remove Metering Point Meters",
                ),
                SizedBox(height: 10),
                ElectricityTextFieldWidget(
                  hintText: "Standard Settlement Code",
                ),
                SizedBox(height: 10),
                ElectricityTextFieldWidget(
                  hintText: "Non Settlement Function Code",
                ),
              ],
            ),
          ),
          Step(
            isActive: _currentStep == 2,
            state: _currentStep >= 2 ? StepState.complete : StepState.indexed,
            title: Text('Complete Work'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElectricityTextFieldWidget(
                  hintText: "Site Visit Date",
                  controller: _textEditingControllerSiteVisitDate,
                  onTap: () => _selectSiteVisitDate(context),
                ),
                SizedBox(height: 10),
                Text("\t\tVisit Successful"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("True"),
                    Radio(
                      value: 'true',
                      groupValue: _visitSuccessful,
                      onChanged: _handleVisitSuccessfulSelection,
                    ),
                    Text("False"),
                    Radio(
                      value: 'false',
                      groupValue: _visitSuccessful,
                      onChanged: _handleVisitSuccessfulSelection,
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text("\t\tReading Taken"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("True"),
                    Radio(
                      value: 'true',
                      groupValue: _readingTaken,
                      onChanged: _handleReadingTakenSelection,
                    ),
                    Text("False"),
                    Radio(
                      value: 'false',
                      groupValue: _readingTaken,
                      onChanged: _handleReadingTakenSelection,
                    ),
                  ],
                ),
                SizedBox(height: 10),
                ElectricityTextFieldWidget(
                  hintText: "Engineer Name",
                ),
                SizedBox(height: 10),
                ElectricityTextFieldWidget(
                  hintText: "Site Visit Notes",
                  maxLine: 3,
                ),
                SizedBox(height: 10),
                ElectricityTextFieldWidget(
                  hintText: "Failure To Energies Or DeEnergise Reason Code",
                ),
                SizedBox(height: 10),
                ElectricityTextFieldWidget(
                  hintText: "Site Visit Check Code",
                ),
                SizedBox(height: 10),
                ElectricityTextFieldWidget(
                  hintText: "Asset Condition Code",
                ),
                SizedBox(height: 10),
                ElectricityTextFieldWidget(
                  hintText: "Asset Condition Additional Information",
                ),
              ],
            ),
          ),
          Step(
            isActive: _currentStep == 3,
            state: _currentStep >= 3 ? StepState.complete : StepState.indexed,
            title: Text('Meter System'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElectricityTextFieldWidget(
                  hintText: "Energisation Status",
                ),
                SizedBox(height: 10),
                Text("\t\tis Smart"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("True"),
                    Radio(
                      value: 'true',
                      groupValue: _isSmart,
                      onChanged: _handleIsSmartSelection,
                    ),
                    Text("False"),
                    Radio(
                      value: 'false',
                      groupValue: _isSmart,
                      onChanged: _handleIsSmartSelection,
                    ),
                  ],
                ),
                SizedBox(height: 10),
                ElectricityTextFieldWidget(
                  hintText: "Meter Location Code",
                ),
                SizedBox(height: 10),
                ElectricityTextFieldWidget(
                  hintText: "Standard Settlement Code",
                ),
                SizedBox(height: 10),
                ElectricityTextFieldWidget(
                  hintText: "Non Settlement Function Code",
                ),
                SizedBox(height: 10),
                ElectricityTextFieldWidget(
                  hintText: "Retrieval Method",
                ),
              ],
            ),
          ),
          Step(
            isActive: _currentStep == 4,
            state: _currentStep >= 4 ? StepState.complete : StepState.indexed,
            title: Text('Meters'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: listInstallationStatusController.length,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    listUseTemplate.add('null');
                    listHasEmergencyCredit.add('null');
                    return Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("\t\tMeter ${index+1}",style: TextStyle(fontWeight: FontWeight.bold)),
                                      Row(
                                        children: [
                                          index != 0 ? GestureDetector(
                                            onTap: (){
                                              setState(() {
                                                listInstallationStatusController[index].clear();
                                                listInstallationStatusController[index].dispose();
                                                listInstallationStatusController.removeAt(index);
                                                listSerialNumberController[index].clear();
                                                listSerialNumberController[index].dispose();
                                                listSerialNumberController.removeAt(index);
                                                listEquipmentTypeNameController[index].clear();
                                                listEquipmentTypeNameController[index].dispose();
                                                listEquipmentTypeNameController.removeAt(index);
                                                listMeterTypeController[index].clear();
                                                listMeterTypeController[index].dispose();
                                                listMeterTypeController.removeAt(index);
                                                listOwnerMpidController[index].clear();
                                                listOwnerMpidController[index].dispose();
                                                listOwnerMpidController.removeAt(index);
                                                listCurrentRatingController[index].clear();
                                                listCurrentRatingController[index].dispose();
                                                listCurrentRatingController.removeAt(index);
                                                listTimingNumberController[index].clear();
                                                listTimingNumberController[index].dispose();
                                                listTimingNumberController.removeAt(index);
                                                listCtRatioController[index].clear();
                                                listCtRatioController[index].dispose();
                                                listCtRatioController.removeAt(index);
                                                listVtRatioController[index].clear();
                                                listVtRatioController[index].dispose();
                                                listVtRatioController.removeAt(index);
                                                listPrepaymentController[index].clear();
                                                listPrepaymentController[index].dispose();
                                                listPrepaymentController.removeAt(index);
                                                listDebtController[index].clear();
                                                listDebtController[index].dispose();
                                                listDebtController.removeAt(index);
                                                listInitialController[index].clear();
                                                listInitialController[index].dispose();
                                                listInitialController.removeAt(index);
                                                listStandingController[index].clear();
                                                listStandingController[index].dispose();
                                                listStandingController.removeAt(index);
                                                listTotalDebtController[index].clear();
                                                listTotalDebtController[index].dispose();
                                                listTotalDebtController.removeAt(index);
                                                listTotalDebtOutstandingController[index].clear();
                                                listTotalDebtOutstandingController[index].dispose();
                                                listTotalDebtOutstandingController.removeAt(index);
                                                listTotalCreditAcceptedController[index].clear();
                                                listTotalCreditAcceptedController[index].dispose();
                                                listTotalCreditAcceptedController.removeAt(index);
                                                listTotalTokenController[index].clear();
                                                listTotalTokenController[index].dispose();
                                                listTotalTokenController.removeAt(index);
                                                listCreditBalanceController[index].clear();
                                                listCreditBalanceController[index].dispose();
                                                listCreditBalanceController.removeAt(index);
                                                listEmergencyCreditController[index].clear();
                                                listEmergencyCreditController[index].dispose();
                                                listEmergencyCreditController.removeAt(index);
                                                listPrepaymentMeterController[index].clear();
                                                listPrepaymentMeterController[index].dispose();
                                                listPrepaymentMeterController.removeAt(index);
                                                listUseTemplate.removeAt(index);
                                                listHasEmergencyCredit.removeAt(index);
                                                listMeterRemovalDateController[index].clear();
                                                listMeterRemovalDateController[index].dispose();
                                                listMeterRemovalDateController.removeAt(index);
                                              });
                                            },
                                            child: Center(
                                              child: Container(
                                                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                                                decoration: BoxDecoration(
                                                  color: Colors.red,
                                                  borderRadius: BorderRadius.circular(25),
                                                ),
                                                child: Text("Remove",style: TextStyle(color: AppColors.whiteColor)),
                                              ),
                                            ),
                                          ) : const SizedBox(),
                                          SizedBox(width: 7),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                listInstallationStatusController.add(TextEditingController());
                                                listSerialNumberController.add(TextEditingController());
                                                listEquipmentTypeNameController.add(TextEditingController());
                                                listMeterTypeController.add(TextEditingController());
                                                listOwnerMpidController.add(TextEditingController());
                                                listCurrentRatingController.add(TextEditingController());
                                                listTimingNumberController.add(TextEditingController());
                                                listCtRatioController.add(TextEditingController());
                                                listVtRatioController.add(TextEditingController());
                                                listPrepaymentController.add(TextEditingController());
                                                listDebtController.add(TextEditingController());
                                                listInitialController.add(TextEditingController());
                                                listStandingController.add(TextEditingController());
                                                listTotalDebtController.add(TextEditingController());
                                                listTotalDebtOutstandingController.add(TextEditingController());
                                                listTotalCreditAcceptedController.add(TextEditingController());
                                                listTotalTokenController.add(TextEditingController());
                                                listCreditBalanceController.add(TextEditingController());
                                                listEmergencyCreditController.add(TextEditingController());
                                                listPrepaymentMeterController.add(TextEditingController());
                                                listMeterRemovalDateController.add(TextEditingController());
                                              });
                                            },
                                            child: Center(
                                              child: Container(
                                                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                                                decoration: BoxDecoration(
                                                  color: AppColors.appThemeColor,
                                                  borderRadius: BorderRadius.circular(25),
                                                ),
                                                child: Text("Add",style: TextStyle(color: AppColors.whiteColor)),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 7),
                                  Text("\t\tUse Template"),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text("True"),
                                      Radio(
                                        value: 'true',
                                        groupValue: listUseTemplate[index],
                                        onChanged: (value){
                                          _handleUseTemplateSelection(value,index);
                                        },
                                      ),
                                      Text("False"),
                                      Radio(
                                        value: 'false',
                                        groupValue: listUseTemplate[index],
                                        onChanged: (value){
                                          _handleUseTemplateSelection(value,index);
                                        },
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  ElectricityTextFieldWidget(
                                    hintText: "Installation Status",
                                    controller: listInstallationStatusController[index],
                                  ),
                                  SizedBox(height: 10),
                                  ElectricityTextFieldWidget(
                                    hintText: "Serial Number",
                                    controller: listSerialNumberController[index],
                                  ),
                                  SizedBox(height: 10),
                                  ElectricityTextFieldWidget(
                                    hintText: "Equipment Type Name",
                                    controller: listEquipmentTypeNameController[index],
                                  ),
                                  SizedBox(height: 10),
                                  ElectricityTextFieldWidget(
                                    hintText: "Meter Type",
                                    controller: listMeterTypeController[index],
                                  ),
                                  SizedBox(height: 10),
                                  ElectricityTextFieldWidget(
                                    hintText: "Owner Mpid",
                                    controller: listOwnerMpidController[index],
                                  ),
                                  SizedBox(height: 10),
                                  ElectricityTextFieldWidget(
                                    hintText: "Current Rating",
                                    controller: listCurrentRatingController[index],
                                  ),
                                  SizedBox(height: 10),
                                  ElectricityTextFieldWidget(
                                    hintText: "Timing DeviceId Serial Number",
                                    controller: listTimingNumberController[index],
                                  ),
                                  SizedBox(height: 10),
                                  ElectricityTextFieldWidget(
                                    hintText: "Ct Ratio",
                                    controller: listCtRatioController[index],
                                  ),
                                  SizedBox(height: 10),
                                  ElectricityTextFieldWidget(
                                    hintText: "Vt Ratio",
                                    controller: listVtRatioController[index],
                                  ),
                                  SizedBox(height: 10),
                                  ElectricityTextFieldWidget(
                                    hintText: "Prepayment Data Unavailable",
                                    controller: listPrepaymentController[index],
                                  ),
                                  SizedBox(height: 10),
                                  ElectricityTextFieldWidget(
                                    hintText: "Debt Recovery Rate",
                                    controller: listDebtController[index],
                                  ),
                                  SizedBox(height: 10),
                                  Text("\t\tHas Emergency Credit"),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text("True"),
                                      Radio(
                                        value: 'true',
                                        groupValue: listHasEmergencyCredit[index],
                                        onChanged: (value){
                                          _handleHasEmergencyCreditSelection(value,index);
                                        },
                                      ),
                                      Text("False"),
                                      Radio(
                                        value: 'false',
                                        groupValue: listHasEmergencyCredit[index],
                                        onChanged: (value){
                                          _handleHasEmergencyCreditSelection(value,index);
                                        },
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  ElectricityTextFieldWidget(
                                    hintText: "Initial Credit",
                                    controller: listInitialController[index],
                                  ),
                                  SizedBox(height: 10),
                                  ElectricityTextFieldWidget(
                                    hintText: "Standing Charge",
                                    controller: listStandingController[index],
                                  ),
                                  SizedBox(height: 10),
                                  ElectricityTextFieldWidget(
                                    hintText: "Total Debt",
                                    controller: listTotalDebtController[index],
                                  ),
                                  SizedBox(height: 10),
                                  ElectricityTextFieldWidget(
                                    hintText: "Total Debt Outstanding",
                                    controller: listTotalDebtOutstandingController[index],
                                  ),
                                  SizedBox(height: 10),
                                  ElectricityTextFieldWidget(
                                    hintText: "Total Credit Accepted",
                                    controller: listTotalCreditAcceptedController[index],
                                  ),
                                  SizedBox(height: 10),
                                  ElectricityTextFieldWidget(
                                    hintText: "Total Token Inserted",
                                    controller: listTotalTokenController[index],
                                  ),
                                  SizedBox(height: 10),
                                  ElectricityTextFieldWidget(
                                    hintText: "Credit Balance",
                                    controller: listCreditBalanceController[index],
                                  ),
                                  SizedBox(height: 10),
                                  ElectricityTextFieldWidget(
                                    hintText: "Emergency Credit",
                                    controller: listEmergencyCreditController[index],
                                  ),
                                  SizedBox(height: 10),
                                  ElectricityTextFieldWidget(
                                    hintText: "Prepayment Meter Shutdown Status",
                                    controller: listPrepaymentMeterController[index],
                                  ),
                                  SizedBox(height: 10),
                                  ElectricityTextFieldWidget(
                                    hintText: "Mater Removal Date",
                                    onTap: () => _selectMeterRemovalDate(context,index),
                                    controller: listMeterRemovalDateController[index],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 7),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
          Step(
            isActive: _currentStep == 5,
            state: _currentStep >= 5 ? StepState.complete : StepState.indexed,
            title: Text('Registers'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: listMeterRegisterIdController.length,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    listUseTemplateRegister.add("null");
                    listIsSettlement.add("null");
                    return Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("\t\tRegister ${index+1}",style: TextStyle(fontWeight: FontWeight.bold)),
                                      Row(
                                        children: [
                                          index != 0 ? GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                listMeterRegisterIdController[index].clear();
                                                listMeterRegisterIdController[index].dispose();
                                                listMeterRegisterIdController.removeAt(index);
                                                listRegisterTypeController[index].clear();
                                                listRegisterTypeController[index].dispose();
                                                listRegisterTypeController.removeAt(index);
                                                listNumberOfDigitsController[index].clear();
                                                listNumberOfDigitsController[index].dispose();
                                                listNumberOfDigitsController.removeAt(index);
                                                listMeasurementQuantityController[index].clear();
                                                listMeasurementQuantityController[index].dispose();
                                                listMeasurementQuantityController.removeAt(index);
                                                listMultiplierController[index].clear();
                                                listMultiplierController[index].dispose();
                                                listMultiplierController.removeAt(index);
                                                listRegisterReadingController[index].clear();
                                                listRegisterReadingController[index].dispose();
                                                listRegisterReadingController.removeAt(index);
                                                listReadingTypeController[index].clear();
                                                listReadingTypeController[index].dispose();
                                                listReadingTypeController.removeAt(index);
                                                listReadingNotController[index].clear();
                                                listReadingNotController[index].dispose();
                                                listReadingNotController.removeAt(index);
                                                listPrePaymentController[index].clear();
                                                listPrePaymentController[index].dispose();
                                                listPrePaymentController.removeAt(index);
                                              });
                                            },
                                            child: Center(
                                              child: Container(
                                                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                                                decoration: BoxDecoration(
                                                  color: Colors.red,
                                                  borderRadius: BorderRadius.circular(25),
                                                ),
                                                child: Text("Remove",style: TextStyle(color: AppColors.whiteColor)),
                                              ),
                                            ),
                                          ) : const SizedBox(),
                                          SizedBox(width: 7),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                listMeterRegisterIdController.add(TextEditingController());
                                                listRegisterTypeController.add(TextEditingController());
                                                listNumberOfDigitsController.add(TextEditingController());
                                                listMeasurementQuantityController.add(TextEditingController());
                                                listMultiplierController.add(TextEditingController());
                                                listRegisterReadingController.add(TextEditingController());
                                                listReadingTypeController.add(TextEditingController());
                                                listReadingNotController.add(TextEditingController());
                                                listPrePaymentController.add(TextEditingController());
                                              });
                                            },
                                            child: Center(
                                              child: Container(
                                                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                                                decoration: BoxDecoration(
                                                  color: AppColors.appThemeColor,
                                                  borderRadius: BorderRadius.circular(25),
                                                ),
                                                child: Text("Add",style: TextStyle(color: AppColors.whiteColor)),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 7),
                                  Text("\t\tUse Template"),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text("True"),
                                      Radio(
                                        value: 'true',
                                        groupValue: listUseTemplateRegister[index],
                                        onChanged: (value){
                                          _handleUseTemplateRegisterSelection(value,index);
                                        },
                                      ),
                                      Text("False"),
                                      Radio(
                                        value: 'false',
                                        groupValue: listUseTemplateRegister[index],
                                        onChanged: (value){
                                          _handleUseTemplateRegisterSelection(value,index);
                                        },
                                      ),
                                    ],
                                  ),
                                  ElectricityTextFieldWidget(
                                    hintText: "Meter RegisterId",
                                    controller: listMeterRegisterIdController[index],
                                  ),
                                  SizedBox(height: 10),
                                  Text("\t\tIs Settlement"),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text("True"),
                                      Radio(
                                        value: 'true',
                                        groupValue: listIsSettlement[index],
                                        onChanged: (value){
                                          _handleIsSettlementSelection(value,index);
                                        },
                                      ),
                                      Text("False"),
                                      Radio(
                                        value: 'false',
                                        groupValue: listIsSettlement[index],
                                        onChanged: (value){
                                          _handleIsSettlementSelection(value,index);
                                        },
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  ElectricityTextFieldWidget(
                                    hintText: "Register Type",
                                    controller: listRegisterTypeController[index],
                                  ),
                                  SizedBox(height: 10),
                                  ElectricityTextFieldWidget(
                                    hintText: "Number Of Digits",
                                    controller: listNumberOfDigitsController[index],
                                  ),
                                  SizedBox(height: 10),
                                  ElectricityTextFieldWidget(
                                    hintText: "Measurement Quantity",
                                    controller: listMeasurementQuantityController[index],
                                  ),
                                  SizedBox(height: 10),
                                  ElectricityTextFieldWidget(
                                    hintText: "Multiplier",
                                    controller: listMultiplierController[index],
                                  ),
                                  SizedBox(height: 10),
                                  ElectricityTextFieldWidget(
                                    hintText: "Register Reading",
                                    controller: listRegisterReadingController[index],
                                  ),
                                  SizedBox(height: 10),
                                  ElectricityTextFieldWidget(
                                    hintText: "Reading Type",
                                    controller: listReadingTypeController[index],
                                  ),
                                  SizedBox(height: 10),
                                  ElectricityTextFieldWidget(
                                    hintText: "Reading NotValid Reason Code",
                                    controller: listReadingNotController[index],
                                  ),
                                  SizedBox(height: 10),
                                  ElectricityTextFieldWidget(
                                    hintText: "PrePayment Unit Rate",
                                    controller: listPrePaymentController[index],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 7),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
          Step(
            isActive: _currentStep == 6,
            state: _currentStep >= 6 ? StepState.complete : StepState.indexed,
            title: Text('Time Patterns'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: listTimePatternController.length,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("\t\tTime Patterns ${index+1}",style: TextStyle(fontWeight: FontWeight.bold)),
                                      Row(
                                        children: [
                                          index != 0 ? GestureDetector(
                                            onTap: (){
                                              setState(() {
                                                listTimePatternController[index].clear();
                                                listTimePatternController[index].dispose();
                                                listTimePatternController.removeAt(index);
                                                listSettlementMapController[index].clear();
                                                listSettlementMapController[index].dispose();
                                                listSettlementMapController.removeAt(index);
                                              });
                                            },
                                            child: Center(
                                              child: Container(
                                                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                                                decoration: BoxDecoration(
                                                  color: Colors.red,
                                                  borderRadius: BorderRadius.circular(25),
                                                ),
                                                child: Text("Remove",style: TextStyle(color: AppColors.whiteColor)),
                                              ),
                                            ),
                                          ) : const SizedBox(),
                                          SizedBox(width: 7),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                listTimePatternController.add(TextEditingController());
                                                listSettlementMapController.add(TextEditingController());
                                              });
                                            },
                                            child: Center(
                                              child: Container(
                                                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                                                decoration: BoxDecoration(
                                                  color: AppColors.appThemeColor,
                                                  borderRadius: BorderRadius.circular(25),
                                                ),
                                                child: Text("Add",style: TextStyle(color: AppColors.whiteColor)),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 7),
                                  ElectricityTextFieldWidget(
                                    hintText: "Time Pattern Regime",
                                    controller: listTimePatternController[index],
                                  ),
                                  SizedBox(height: 10),
                                  ElectricityTextFieldWidget(
                                    hintText: "Settlement Map Coefficient",
                                    controller: listSettlementMapController[index],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 7),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
          Step(
            isActive: _currentStep == 7,
            state: _currentStep >= 7 ? StepState.complete : StepState.indexed,
            title: Text('Amr Details'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElectricityTextFieldWidget(
                  hintText: "Cop Ref",
                ),
                SizedBox(height: 10),
                ElectricityTextFieldWidget(
                  hintText: "Cop Issue Number",
                ),
                SizedBox(height: 10),
                Text("\t\tRemote Enable/Disable Capable"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("True"),
                    Radio(
                      value: 'true',
                      groupValue: _remoteEnable,
                      onChanged: _handleRemoteEnableSelection,
                    ),
                    Text("False"),
                    Radio(
                      value: 'false',
                      groupValue: _remoteEnable,
                      onChanged: _handleRemoteEnableSelection,
                    ),
                  ],
                ),
                SizedBox(height: 10),
                ElectricityTextFieldWidget(
                  hintText: "Event Indicator",
                ),
              ],
            ),
          ),
          Step(
            isActive: _currentStep == 8,
            state: _currentStep >= 8 ? StepState.complete : StepState.indexed,
            title: Text('Outstation'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: listSerialNumberOutstationController.length,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("\t\tOutstation ${index+1}",style: TextStyle(fontWeight: FontWeight.bold)),
                                      Row(
                                        children: [
                                          index != 0 ? GestureDetector(
                                            onTap: (){
                                              setState(() {
                                                listSerialNumberOutstationController[index].clear();
                                                listSerialNumberOutstationController[index].dispose();
                                                listSerialNumberOutstationController.removeAt(index);
                                                listOutstationTypeController[index].clear();
                                                listOutstationTypeController[index].dispose();
                                                listOutstationTypeController.removeAt(index);
                                                listNumberOfChannelsController[index].clear();
                                                listNumberOfChannelsController[index].dispose();
                                                listNumberOfChannelsController.removeAt(index);
                                                listNumberOfDialsController[index].clear();
                                                listNumberOfDialsController[index].dispose();
                                                listNumberOfDialsController.removeAt(index);
                                                listPinController[index].clear();
                                                listPinController[index].dispose();
                                                listPinController.removeAt(index);
                                                listMultiplierOutstationController[index].clear();
                                                listMultiplierOutstationController[index].dispose();
                                                listMultiplierOutstationController.removeAt(index);
                                                listUsernameLevel1Controller[index].clear();
                                                listUsernameLevel1Controller[index].dispose();
                                                listUsernameLevel1Controller.removeAt(index);
                                                listPasswordLevel1Controller[index].clear();
                                                listPasswordLevel1Controller[index].dispose();
                                                listPasswordLevel1Controller.removeAt(index);
                                                listUsernameLevel2Controller[index].clear();
                                                listUsernameLevel2Controller[index].dispose();
                                                listUsernameLevel2Controller.removeAt(index);
                                                listPasswordLevel2Controller[index].clear();
                                                listPasswordLevel2Controller[index].dispose();
                                                listPasswordLevel2Controller.removeAt(index);
                                                listUsernameLevel3Controller[index].clear();
                                                listUsernameLevel3Controller[index].dispose();
                                                listUsernameLevel3Controller.removeAt(index);
                                                listPasswordLevel3Controller[index].clear();
                                                listPasswordLevel3Controller[index].dispose();
                                                listPasswordLevel3Controller.removeAt(index);
                                                listCommMethodController[index].clear();
                                                listCommMethodController[index].dispose();
                                                listCommMethodController.removeAt(index);
                                                listCommAddressController[index].clear();
                                                listCommAddressController[index].dispose();
                                                listCommAddressController.removeAt(index);
                                                listCommBaudRateController[index].clear();
                                                listCommBaudRateController[index].dispose();
                                                listCommBaudRateController.removeAt(index);
                                                listCommDialInOutController[index].clear();
                                                listCommDialInOutController[index].dispose();
                                                listCommDialInOutController.removeAt(index);
                                                listCommProviderController[index].clear();
                                                listCommProviderController[index].dispose();
                                                listCommProviderController.removeAt(index);
                                              });
                                            },
                                            child: Center(
                                              child: Container(
                                                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                                                decoration: BoxDecoration(
                                                  color: Colors.red,
                                                  borderRadius: BorderRadius.circular(25),
                                                ),
                                                child: Text("Remove",style: TextStyle(color: AppColors.whiteColor)),
                                              ),
                                            ),
                                          ) : const SizedBox(),
                                          SizedBox(width: 7),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                listSerialNumberOutstationController.add(TextEditingController());
                                                listOutstationTypeController.add(TextEditingController());
                                                listNumberOfChannelsController.add(TextEditingController());
                                                listNumberOfDialsController.add(TextEditingController());
                                                listPinController.add(TextEditingController());
                                                listMultiplierOutstationController.add(TextEditingController());
                                                listUsernameLevel1Controller.add(TextEditingController());
                                                listPasswordLevel1Controller.add(TextEditingController());
                                                listUsernameLevel2Controller.add(TextEditingController());
                                                listPasswordLevel2Controller.add(TextEditingController());
                                                listUsernameLevel3Controller.add(TextEditingController());
                                                listPasswordLevel3Controller.add(TextEditingController());
                                                listCommMethodController.add(TextEditingController());
                                                listCommAddressController.add(TextEditingController());
                                                listCommBaudRateController.add(TextEditingController());
                                                listCommDialInOutController.add(TextEditingController());
                                                listCommProviderController.add(TextEditingController());
                                              });
                                            },
                                            child: Center(
                                              child: Container(
                                                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                                                decoration: BoxDecoration(
                                                  color: AppColors.appThemeColor,
                                                  borderRadius: BorderRadius.circular(25),
                                                ),
                                                child: Text("Add",style: TextStyle(color: AppColors.whiteColor)),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 7),
                                  ElectricityTextFieldWidget(
                                    hintText: "Serial Number",
                                    controller: listSerialNumberOutstationController[index],
                                  ),
                                  SizedBox(height: 10),
                                  ElectricityTextFieldWidget(
                                    hintText: "Outstation Type",
                                    controller: listOutstationTypeController[index],
                                  ),
                                  SizedBox(height: 10),
                                  ElectricityTextFieldWidget(
                                    hintText: "Number Of Channels",
                                    controller: listNumberOfChannelsController[index],
                                  ),
                                  SizedBox(height: 10),
                                  ElectricityTextFieldWidget(
                                    hintText: "Number Of Dials",
                                    controller: listNumberOfDialsController[index],
                                  ),
                                  SizedBox(height: 10),
                                  ElectricityTextFieldWidget(
                                    hintText: "Pin",
                                    controller: listPinController[index],
                                  ),
                                  SizedBox(height: 10),
                                  ElectricityTextFieldWidget(
                                    hintText: "Multiplier",
                                    controller: listMultiplierOutstationController[index],
                                  ),
                                  SizedBox(height: 10),
                                  ElectricityTextFieldWidget(
                                    hintText: "Username Level1",
                                    controller: listUsernameLevel1Controller[index],
                                  ),
                                  SizedBox(height: 10),
                                  ElectricityTextFieldWidget(
                                    hintText: "Password Level1",
                                    controller: listPasswordLevel1Controller[index],
                                  ),
                                  SizedBox(height: 10),
                                  ElectricityTextFieldWidget(
                                    hintText: "Username Level2",
                                    controller: listUsernameLevel2Controller[index],
                                  ),
                                  SizedBox(height: 10),
                                  ElectricityTextFieldWidget(
                                    hintText: "Password Level2",
                                    controller: listPasswordLevel2Controller[index],
                                  ),
                                  SizedBox(height: 10),
                                  ElectricityTextFieldWidget(
                                    hintText: "Password Level3",
                                    controller: listUsernameLevel3Controller[index],
                                  ),
                                  SizedBox(height: 10),
                                  ElectricityTextFieldWidget(
                                    hintText: "Password Level3",
                                    controller: listPasswordLevel3Controller[index],
                                  ),
                                  SizedBox(height: 10),
                                  ElectricityTextFieldWidget(
                                    hintText: "Comms Method",
                                    controller: listCommMethodController[index],
                                  ),
                                  SizedBox(height: 10),
                                  ElectricityTextFieldWidget(
                                    hintText: "Comms Address",
                                    controller: listCommAddressController[index],
                                  ),
                                  SizedBox(height: 10),
                                  ElectricityTextFieldWidget(
                                    hintText: "Comms Baud Rate",
                                    controller: listCommBaudRateController[index],
                                  ),
                                  SizedBox(height: 10),
                                  ElectricityTextFieldWidget(
                                    hintText: "Comms Dial InOut",
                                    controller: listCommDialInOutController[index],
                                  ),
                                  SizedBox(height: 10),
                                  ElectricityTextFieldWidget(
                                    hintText: "Comms Provider",
                                    controller: listCommProviderController[index],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 7),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
          Step(
            isActive: _currentStep == 9,
            state: _currentStep >= 9 ? StepState.complete : StepState.indexed,
            title: Text('Outstation Channels'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: listChannelController.length,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("\t\tOutstation Ch ${index+1}",style: TextStyle(fontWeight: FontWeight.bold)),
                                      Row(
                                        children: [
                                          index != 0 ? GestureDetector(
                                            onTap: (){
                                              setState(() {
                                                listChannelController[index].clear();
                                                listChannelController[index].dispose();
                                                listChannelController.removeAt(index);
                                                listPulseController[index].clear();
                                                listPulseController[index].dispose();
                                                listPulseController.removeAt(index);
                                                listMeasurementController[index].clear();
                                                listMeasurementController[index].dispose();
                                                listMeasurementController.removeAt(index);
                                              });
                                            },
                                            child: Center(
                                              child: Container(
                                                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                                                decoration: BoxDecoration(
                                                  color: Colors.red,
                                                  borderRadius: BorderRadius.circular(25),
                                                ),
                                                child: Text("Remove",style: TextStyle(color: AppColors.whiteColor)),
                                              ),
                                            ),
                                          ) : const SizedBox(),
                                          SizedBox(width: 7),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                listChannelController.add(TextEditingController());
                                                listPulseController.add(TextEditingController());
                                                listMeasurementController.add(TextEditingController());
                                              });
                                            },
                                            child: Center(
                                              child: Container(
                                                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                                                decoration: BoxDecoration(
                                                  color: AppColors.appThemeColor,
                                                  borderRadius: BorderRadius.circular(25),
                                                ),
                                                child: Text("Add",style: TextStyle(color: AppColors.whiteColor)),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 7),
                                  ElectricityTextFieldWidget(
                                    hintText: "Channel Number",
                                    controller: listChannelController[index],
                                  ),
                                  SizedBox(height: 10),
                                  ElectricityTextFieldWidget(
                                    hintText: "Pulse Multiplier",
                                    controller: listPulseController[index],
                                  ),
                                  SizedBox(height: 10),
                                  ElectricityTextFieldWidget(
                                    hintText: "Measurement Quantity",
                                    controller: listMeasurementController[index],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 7),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
          Step(
            isActive: _currentStep == 10,
            state: _currentStep >= 10 ? StepState.complete : StepState.indexed,
            title: Text('Meter Mappings'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: listMeterNumberController.length,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("\t\tMappings ${index+1}",style: TextStyle(fontWeight: FontWeight.bold)),
                                      Row(
                                        children: [
                                          index != 0 ? GestureDetector(
                                            onTap: (){
                                              setState(() {
                                                listMeterNumberController[index].clear();
                                                listMeterNumberController[index].dispose();
                                                listMeterNumberController.removeAt(index);
                                                listMeterIdController[index].clear();
                                                listMeterIdController[index].dispose();
                                                listMeterIdController.removeAt(index);
                                                listMeterMemoryLocationTypeController[index].clear();
                                                listMeterMemoryLocationTypeController[index].dispose();
                                                listMeterMemoryLocationTypeController.removeAt(index);
                                                listMeterMemoryLocationController[index].clear();
                                                listMeterMemoryLocationController[index].dispose();
                                                listMeterMemoryLocationController.removeAt(index);
                                                listTimestampController[index].clear();
                                                listTimestampController[index].dispose();
                                                listTimestampController.removeAt(index);
                                              });
                                            },
                                            child: Center(
                                              child: Container(
                                                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                                                decoration: BoxDecoration(
                                                  color: Colors.red,
                                                  borderRadius: BorderRadius.circular(25),
                                                ),
                                                child: Text("Remove",style: TextStyle(color: AppColors.whiteColor)),
                                              ),
                                            ),
                                          ) : const SizedBox(),
                                          SizedBox(width: 7),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                listMeterNumberController.add(TextEditingController());
                                                listMeterIdController.add(TextEditingController());
                                                listMeterMemoryLocationTypeController.add(TextEditingController());
                                                listMeterMemoryLocationController.add(TextEditingController());
                                                listTimestampController.add(TextEditingController());
                                              });
                                            },
                                            child: Center(
                                              child: Container(
                                                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                                                decoration: BoxDecoration(
                                                  color: AppColors.appThemeColor,
                                                  borderRadius: BorderRadius.circular(25),
                                                ),
                                                child: Text("Add",style: TextStyle(color: AppColors.whiteColor)),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 7),
                                  ElectricityTextFieldWidget(
                                    hintText: "Meter Serial Number",
                                    controller: listMeterNumberController[index],
                                  ),
                                  SizedBox(height: 10),
                                  ElectricityTextFieldWidget(
                                    hintText: "Meter Register Id",
                                    controller: listMeterIdController[index],
                                  ),
                                  SizedBox(height: 10),
                                  ElectricityTextFieldWidget(
                                    hintText: "Meter Memory Location Type",
                                    controller: listMeterMemoryLocationTypeController[index],
                                  ),
                                  SizedBox(height: 10),
                                  ElectricityTextFieldWidget(
                                    hintText: "Meter Memory Location",
                                    controller: listMeterMemoryLocationController[index],
                                  ),
                                  SizedBox(height: 10),
                                  ElectricityTextFieldWidget(
                                    hintText: "Timestamp Memory Location",
                                    controller: listTimestampController[index],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 7),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}