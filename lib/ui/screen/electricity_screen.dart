//@dart=2.9
import 'package:enstaller/ui/screen/widget/electricity/electricity_text_field_widget.dart';
import 'package:flutter/material.dart';
import '../../core/constant/app_colors.dart';
import '../../core/constant/app_string.dart';
import '../../core/constant/image_file.dart';
import '../../core/model/send/answer_credential.dart';
import '../shared/app_drawer_widget.dart';
import '../shared/warehouse_app_drawer.dart';

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
  List<TextEditingController> listInitialController = [TextEditingController()];
  List<TextEditingController> listStandingController = [TextEditingController()];
  List<TextEditingController> listTotalDebtController = [TextEditingController()];
  List<TextEditingController> listTotalDebtOutstandingController = [TextEditingController()];
  List<TextEditingController> listTotalCreditAcceptedController = [TextEditingController()];
  List<TextEditingController> listTotalTokenController = [TextEditingController()];
  List<TextEditingController> listCreditBalanceController = [TextEditingController()];
  List<TextEditingController> listEmergencyCreditController = [TextEditingController()];
  List<TextEditingController> listPrepaymentMeterController = [TextEditingController()];

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
            title: Text('Meters'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: listInstallationStatusController.length,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text("\t\tMeter ${index+1}",style: TextStyle(fontWeight: FontWeight.bold)),
                                  index != 0 ? GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        listInstallationStatusController[index].clear();
                                        listInstallationStatusController[index].dispose();
                                        listInstallationStatusController.removeAt(index);
                                      });
                                    },
                                    child: const Icon(
                                      Icons.delete,
                                      color: Color(0xFF6B74D6),
                                      size: 35,
                                    ),
                                  ) : const SizedBox(),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        listInstallationStatusController.add(TextEditingController());
                                      });
                                    },
                                    child: Center(
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 15),
                                        decoration: BoxDecoration(
                                            color: const Color(0xFF444C60),
                                            borderRadius: BorderRadius.circular(10)),
                                        child: Text("Add More"),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 7),
                              ElectricityTextFieldWidget(
                                hintText: "Installation Status",
                                controller: listInstallationStatusController[index],
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
          Step(
            title: Text('Step 6'),
            content: Text('Content for Step 6'),
          ),
          Step(
            title: Text('Step 7'),
            content: Text('Content for Step 7'),
          ),
          Step(
            title: Text('Step 8'),
            content: Text('Content for Step 8'),
          ),
          Step(
            title: Text('Step 9'),
            content: Text('Content for Step 9'),
          ),
          Step(
            title: Text('Step 10'),
            content: Text('Content for Step 10'),
          ),
          Step(
            title: Text('Step 11'),
            content: Text('Content for Step 11'),
          ),
        ],
      ),
    );
  }
}