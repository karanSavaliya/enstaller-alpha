//@dart=2.9
import 'package:flutter/material.dart';
import '../../core/constant/app_colors.dart';
import '../../core/constant/app_string.dart';
import '../../core/constant/image_file.dart';
import '../../core/model/send/answer_credential.dart';
import '../shared/app_drawer_widget.dart';
import '../shared/warehouse_app_drawer.dart';
import 'widget/electricity/electricity_text_field_widget.dart';

class Gas extends StatefulWidget {
  @override
  _GasState createState() => _GasState();
}

class _GasState extends State<Gas> {

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
  List<TextEditingController> listAssetProviderMPIDController = [TextEditingController()];
  List<TextEditingController> listAssetClassCodeController = [TextEditingController()];
  List<TextEditingController> listPaymentMethodCodeController = [TextEditingController()];
  List<TextEditingController> listModelCodeController = [TextEditingController()];
  List<TextEditingController> listManufacturerCodeController = [TextEditingController()];
  List<TextEditingController> listYearOfManufacturerController = [TextEditingController()];
  List<TextEditingController> listSerialNumberController = [TextEditingController()];
  List<TextEditingController> listLocationCodeController = [TextEditingController()];
  List<TextEditingController> listLocationNoteController = [TextEditingController()];
  List<TextEditingController> listAssetStatusCodeController = [TextEditingController()];
  List<TextEditingController> listMeterTypeController = [TextEditingController()];
  List<TextEditingController> listMechanismCodeController = [TextEditingController()];
  List<TextEditingController> listMeasuringCapacityController = [TextEditingController()];
  List<TextEditingController> listMeterUsageCodeController = [TextEditingController()];
  List<TextEditingController> listCollarStatusCodeController = [TextEditingController()];
  List<TextEditingController> listOAMIInspectionDateController = [TextEditingController()];
  List<TextEditingController> listPulseValueController = [TextEditingController()];
  List<TextEditingController> listGasActOwnerRoleController = [TextEditingController()];
  List<TextEditingController> listAssetRemovalDateController = [TextEditingController()];

  List<TextEditingController> listNumberOfDigitsController = [TextEditingController()];
  List<TextEditingController> listUnitsOfMeasureController = [TextEditingController()];
  List<TextEditingController> listMultiplicationFactorController = [TextEditingController()];
  List<TextEditingController> listReadingIndexController = [TextEditingController()];

  DateTime _selectedOAMIInspectionDate;
  Future<void> _selectOAMIInspectionDate(BuildContext context, int index) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _selectedOAMIInspectionDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _selectedOAMIInspectionDate = picked;
        listOAMIInspectionDateController[index].text = _formatDate(picked);
      });
    }
  }

  DateTime _selectedAssetRemovalDate;
  Future<void> _selectAssetRemovalDate(BuildContext context, int index) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _selectedAssetRemovalDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _selectedAssetRemovalDate = picked;
        listAssetRemovalDateController[index].text = _formatDate(picked);
      });
    }
  }

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
            if (_currentStep < 8 - 1) {
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
            title: Text('Gas Flow'),
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
                  hintText: "MPRN",
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
            title: Text('Existing Meter System'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElectricityTextFieldWidget(
                  hintText: "Meter Link Code",
                ),
                SizedBox(height: 10),
                ElectricityTextFieldWidget(
                  hintText: "Status Code",
                ),
                SizedBox(height: 10),
                ElectricityTextFieldWidget(
                  hintText: "Location Code",
                ),
                SizedBox(height: 10),
                ElectricityTextFieldWidget(
                  hintText: "Location Notes",
                  maxLine: 3,
                ),
                SizedBox(height: 10),
                ElectricityTextFieldWidget(
                  hintText: "Access Instructions",
                  maxLine: 3,
                ),
                SizedBox(height: 10),
                ElectricityTextFieldWidget(
                  hintText: "Conversion Factor",
                ),
                SizedBox(height: 10),
                ElectricityTextFieldWidget(
                  hintText: "Metering Pressure",
                ),
              ],
            ),
          ),
          Step(
            isActive: _currentStep == 2,
            state: _currentStep >= 2 ? StepState.complete : StepState.indexed,
            title: Text('Site Address'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElectricityTextFieldWidget(
                  hintText: "Postcode",
                ),
                SizedBox(height: 10),
                ElectricityTextFieldWidget(
                  hintText: "SubBuilding Name",
                ),
                SizedBox(height: 10),
                ElectricityTextFieldWidget(
                  hintText: "Building Name",
                ),
                SizedBox(height: 10),
                ElectricityTextFieldWidget(
                  hintText: "Dependent Through Fare",
                ),
                SizedBox(height: 10),
                ElectricityTextFieldWidget(
                  hintText: "Through Fare",
                ),
                SizedBox(height: 10),
                ElectricityTextFieldWidget(
                  hintText: "Double Dependent Locality",
                ),
                SizedBox(height: 10),
                ElectricityTextFieldWidget(
                  hintText: "Dependent Locality",
                ),
                SizedBox(height: 10),
                ElectricityTextFieldWidget(
                  hintText: "PostTown",
                ),
                SizedBox(height: 10),
                ElectricityTextFieldWidget(
                  hintText: "County",
                ),
              ],
            ),
          ),
          Step(
            isActive: _currentStep == 3,
            state: _currentStep >= 3 ? StepState.complete : StepState.indexed,
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
                  hintText: "Transaction Reference",
                ),
                SizedBox(height: 10),
                ElectricityTextFieldWidget(
                  hintText: "Transaction Type Code",
                ),
                SizedBox(height: 10),
                ElectricityTextFieldWidget(
                  hintText: "Transaction Type Reason Code",
                ),
              ],
            ),
          ),
          Step(
            isActive: _currentStep == 4,
            state: _currentStep >= 4 ? StepState.complete : StepState.indexed,
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
                  hintText: "Transaction Status Code",
                ),
                SizedBox(height: 10),
                ElectricityTextFieldWidget(
                  hintText: "Transaction Status Change Reason Code",
                ),
                SizedBox(height: 10),
                ElectricityTextFieldWidget(
                  hintText: "Site Visit Note",
                  maxLine: 3,
                ),
                SizedBox(height: 10),
                ElectricityTextFieldWidget(
                  hintText: "Transaction Type Code",
                ),
                SizedBox(height: 10),
                ElectricityTextFieldWidget(
                  hintText: "Transaction Type Reason Code",
                ),
              ],
            ),
          ),
          Step(
            isActive: _currentStep == 5,
            state: _currentStep >= 5 ? StepState.complete : StepState.indexed,
            title: Text('Meter System'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElectricityTextFieldWidget(
                  hintText: "Meter Link Code",
                ),
                SizedBox(height: 10),
                ElectricityTextFieldWidget(
                  hintText: "Status Code",
                ),
                SizedBox(height: 10),
                ElectricityTextFieldWidget(
                  hintText: "Location Code",
                ),
                SizedBox(height: 10),
                ElectricityTextFieldWidget(
                  hintText: "Location Note",
                  maxLine: 3,
                ),
                SizedBox(height: 10),
                ElectricityTextFieldWidget(
                  hintText: "Access Instructions",
                  maxLine: 3,
                ),
                SizedBox(height: 10),
                ElectricityTextFieldWidget(
                  hintText: "Conversion Factor",
                ),
                SizedBox(height: 10),
                ElectricityTextFieldWidget(
                  hintText: "Metering Pressure",
                ),
              ],
            ),
          ),
          Step(
            isActive: _currentStep == 6,
            state: _currentStep >= 6 ? StepState.complete : StepState.indexed,
            title: Text('Assets'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: listInstallationStatusController.length,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    listUseTemplate.add("null");
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
                                      Text("\t\tAssets ${index+1}",style: TextStyle(fontWeight: FontWeight.bold)),
                                      Row(
                                        children: [
                                          index != 0 ? GestureDetector(
                                            onTap: (){
                                              setState(() {
                                                listInstallationStatusController[index].clear();
                                                listInstallationStatusController[index].dispose();
                                                listInstallationStatusController.removeAt(index);
                                                listAssetProviderMPIDController[index].clear();
                                                listAssetProviderMPIDController[index].dispose();
                                                listAssetProviderMPIDController.removeAt(index);
                                                listAssetClassCodeController[index].clear();
                                                listAssetClassCodeController[index].dispose();
                                                listAssetClassCodeController.removeAt(index);
                                                listPaymentMethodCodeController[index].clear();
                                                listPaymentMethodCodeController[index].dispose();
                                                listPaymentMethodCodeController.removeAt(index);
                                                listModelCodeController[index].clear();
                                                listModelCodeController[index].dispose();
                                                listModelCodeController.removeAt(index);
                                                listManufacturerCodeController[index].clear();
                                                listManufacturerCodeController[index].dispose();
                                                listManufacturerCodeController.removeAt(index);
                                                listYearOfManufacturerController[index].clear();
                                                listYearOfManufacturerController[index].dispose();
                                                listYearOfManufacturerController.removeAt(index);
                                                listSerialNumberController[index].clear();
                                                listSerialNumberController[index].dispose();
                                                listSerialNumberController.removeAt(index);
                                                listLocationCodeController[index].clear();
                                                listLocationCodeController[index].dispose();
                                                listLocationCodeController.removeAt(index);
                                                listLocationNoteController[index].clear();
                                                listLocationNoteController[index].dispose();
                                                listLocationNoteController.removeAt(index);
                                                listAssetStatusCodeController[index].clear();
                                                listAssetStatusCodeController[index].dispose();
                                                listAssetStatusCodeController.removeAt(index);
                                                listMeterTypeController[index].clear();
                                                listMeterTypeController[index].dispose();
                                                listMeterTypeController.removeAt(index);
                                                listMechanismCodeController[index].clear();
                                                listMechanismCodeController[index].dispose();
                                                listMechanismCodeController.removeAt(index);
                                                listMeasuringCapacityController[index].clear();
                                                listMeasuringCapacityController[index].dispose();
                                                listMeasuringCapacityController.removeAt(index);
                                                listMeterUsageCodeController[index].clear();
                                                listMeterUsageCodeController[index].dispose();
                                                listMeterUsageCodeController.removeAt(index);
                                                listCollarStatusCodeController[index].clear();
                                                listCollarStatusCodeController[index].dispose();
                                                listCollarStatusCodeController.removeAt(index);
                                                listOAMIInspectionDateController[index].clear();
                                                listOAMIInspectionDateController[index].dispose();
                                                listOAMIInspectionDateController.removeAt(index);
                                                listPulseValueController[index].clear();
                                                listPulseValueController[index].dispose();
                                                listPulseValueController.removeAt(index);
                                                listGasActOwnerRoleController[index].clear();
                                                listGasActOwnerRoleController[index].dispose();
                                                listGasActOwnerRoleController.removeAt(index);
                                                listAssetRemovalDateController[index].clear();
                                                listAssetRemovalDateController[index].dispose();
                                                listAssetRemovalDateController.removeAt(index);
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
                                                listAssetProviderMPIDController.add(TextEditingController());
                                                listAssetClassCodeController.add(TextEditingController());
                                                listPaymentMethodCodeController.add(TextEditingController());
                                                listModelCodeController.add(TextEditingController());
                                                listManufacturerCodeController.add(TextEditingController());
                                                listYearOfManufacturerController.add(TextEditingController());
                                                listSerialNumberController.add(TextEditingController());
                                                listLocationCodeController.add(TextEditingController());
                                                listLocationNoteController.add(TextEditingController());
                                                listAssetStatusCodeController.add(TextEditingController());
                                                listMeterTypeController.add(TextEditingController());
                                                listMechanismCodeController.add(TextEditingController());
                                                listMeasuringCapacityController.add(TextEditingController());
                                                listMeterUsageCodeController.add(TextEditingController());
                                                listCollarStatusCodeController.add(TextEditingController());
                                                listOAMIInspectionDateController.add(TextEditingController());
                                                listPulseValueController.add(TextEditingController());
                                                listGasActOwnerRoleController.add(TextEditingController());
                                                listAssetRemovalDateController.add(TextEditingController());
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
                                  ElectricityTextFieldWidget(
                                    hintText: "Installation Status",
                                    controller: listInstallationStatusController[index],
                                  ),
                                  SizedBox(height: 10),
                                  ElectricityTextFieldWidget(
                                    hintText: "Asset Provider MPID",
                                    controller: listAssetProviderMPIDController[index],
                                  ),
                                  SizedBox(height: 10),
                                  ElectricityTextFieldWidget(
                                    hintText: "Asset Class Code",
                                    controller: listAssetClassCodeController[index],
                                  ),
                                  SizedBox(height: 10),
                                  ElectricityTextFieldWidget(
                                    hintText: "Payment Method Code",
                                    controller: listPaymentMethodCodeController[index],
                                  ),
                                  SizedBox(height: 10),
                                  ElectricityTextFieldWidget(
                                    hintText: "Model Code",
                                    controller: listModelCodeController[index],
                                  ),
                                  SizedBox(height: 10),
                                  ElectricityTextFieldWidget(
                                    hintText: "Manufacturer Code",
                                    controller: listManufacturerCodeController[index],
                                  ),
                                  SizedBox(height: 10),
                                  ElectricityTextFieldWidget(
                                    hintText: "Year Of Manufacturer",
                                    controller: listYearOfManufacturerController[index],
                                  ),
                                  SizedBox(height: 10),
                                  ElectricityTextFieldWidget(
                                    hintText: "Serial Number",
                                    controller: listSerialNumberController[index],
                                  ),
                                  SizedBox(height: 10),
                                  ElectricityTextFieldWidget(
                                    hintText: "Location Code",
                                    controller: listLocationCodeController[index],
                                  ),
                                  SizedBox(height: 10),
                                  ElectricityTextFieldWidget(
                                    hintText: "Location Note",
                                    controller: listLocationNoteController[index],
                                  ),
                                  SizedBox(height: 10),
                                  ElectricityTextFieldWidget(
                                    hintText: "Asset Status Code",
                                    controller: listAssetStatusCodeController[index],
                                  ),
                                  SizedBox(height: 10),
                                  ElectricityTextFieldWidget(
                                    hintText: "Meter Type",
                                    controller: listMeterTypeController[index],
                                  ),
                                  SizedBox(height: 10),
                                  ElectricityTextFieldWidget(
                                    hintText: "Mechanism Code",
                                    controller: listMechanismCodeController[index],
                                  ),
                                  SizedBox(height: 10),
                                  ElectricityTextFieldWidget(
                                    hintText: "Measuring Capacity",
                                    controller: listMeasuringCapacityController[index],
                                  ),
                                  SizedBox(height: 10),
                                  ElectricityTextFieldWidget(
                                    hintText: "Meter Usage Code",
                                    controller: listMeterUsageCodeController[index],
                                  ),
                                  SizedBox(height: 10),
                                  ElectricityTextFieldWidget(
                                    hintText: "Collar Status Code",
                                    controller: listCollarStatusCodeController[index],
                                  ),
                                  SizedBox(height: 10),
                                  ElectricityTextFieldWidget(
                                    hintText: "OAMI Inspection Date",
                                    onTap: () => _selectOAMIInspectionDate(context,index),
                                    controller: listOAMIInspectionDateController[index],
                                  ),
                                  SizedBox(height: 10),
                                  ElectricityTextFieldWidget(
                                    hintText: "Pulse Value",
                                    controller: listPulseValueController[index],
                                  ),
                                  SizedBox(height: 10),
                                  ElectricityTextFieldWidget(
                                    hintText: "Gas Act Owner Role",
                                    controller: listGasActOwnerRoleController[index],
                                  ),
                                  SizedBox(height: 10),
                                  ElectricityTextFieldWidget(
                                    hintText: "Asset Removal Date",
                                    onTap: () => _selectAssetRemovalDate(context,index),
                                    controller: listAssetRemovalDateController[index],
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
            title: Text('Registers'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: listNumberOfDigitsController.length,
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
                                      Text("\t\tRegister ${index+1}",style: TextStyle(fontWeight: FontWeight.bold)),
                                      Row(
                                        children: [
                                          index != 0 ? GestureDetector(
                                            onTap: (){
                                              setState(() {
                                                listNumberOfDigitsController[index].clear();
                                                listNumberOfDigitsController[index].dispose();
                                                listNumberOfDigitsController.removeAt(index);
                                                listUnitsOfMeasureController[index].clear();
                                                listUnitsOfMeasureController[index].dispose();
                                                listUnitsOfMeasureController.removeAt(index);
                                                listMultiplicationFactorController[index].clear();
                                                listMultiplicationFactorController[index].dispose();
                                                listMultiplicationFactorController.removeAt(index);
                                                listReadingIndexController[index].clear();
                                                listReadingIndexController[index].dispose();
                                                listReadingIndexController.removeAt(index);
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
                                                listNumberOfDigitsController.add(TextEditingController());
                                                listUnitsOfMeasureController.add(TextEditingController());
                                                listMultiplicationFactorController.add(TextEditingController());
                                                listReadingIndexController.add(TextEditingController());
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
                                    hintText: "Number Of Digits",
                                    controller: listNumberOfDigitsController[index],
                                  ),
                                  SizedBox(height: 10),
                                  ElectricityTextFieldWidget(
                                    hintText: "Units Of Measure",
                                    controller: listUnitsOfMeasureController[index],
                                  ),
                                  SizedBox(height: 10),
                                  ElectricityTextFieldWidget(
                                    hintText: "Multiplication Factor",
                                    controller: listMultiplicationFactorController[index],
                                  ),
                                  SizedBox(height: 10),
                                  ElectricityTextFieldWidget(
                                    hintText: "Reading Index",
                                    controller: listReadingIndexController[index],
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