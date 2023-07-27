//@dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../core/constant/app_colors.dart';
import '../../core/constant/app_string.dart';
import 'package:provider/provider.dart';
import '../../core/constant/image_file.dart';
import '../../core/model/send/answer_credential.dart';
import '../../core/provider/app_state_provider.dart';
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

  @override
  void initState() {
    super.initState();
    AppStateProvider appStateProvider = Provider.of<AppStateProvider>(context,listen: false);
    appStateProvider.initFormElectricityMeters();
    appStateProvider.initFormElectricityOutstation();
  }

  @override
  Widget build(BuildContext context) {
    AppStateProvider appStateProvider = Provider.of<AppStateProvider>(context);
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
        onStepTapped: (step) {
          return;
        },
        onStepContinue: () {
          setState(() {
            if (_currentStep < 7 - 1) {
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
                  controller: appStateProvider.memMpIdElectricity,
                ),
                SizedBox(height: 10),
                ElectricityTextFieldWidget(
                  hintText: "Supplier MpId",
                  controller: appStateProvider.supplierMpIdElectricity,
                ),
                SizedBox(height: 10),
                ElectricityTextFieldWidget(
                  hintText: "MPAN",
                  controller: appStateProvider.mprnElectricity,
                ),
                SizedBox(height: 10),
                ElectricityTextFieldWidget(
                  hintText: "External System Identity",
                  controller: appStateProvider.externalSystemIdentityElectricity,
                ),
                SizedBox(height: 10),
                ElectricityTextFieldWidget(
                  hintText: "Correlation Id",
                  controller: appStateProvider.correlationIdElectricity,
                ),
                SizedBox(height: 10),
                ElectricityTextFieldWidget(
                  controller: appStateProvider.sapphireWorkIdElectricity,
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
                  onTap: () => appStateProvider.selectAppointmentDateElectricity(context),
                  controller: appStateProvider.textEditingControllerAppointmentDateElectricity,
                ),
                SizedBox(height: 10),
                ElectricityTextFieldWidget(
                  hintText: "Additional Information For Work",
                  maxLine: 3,
                  controller: appStateProvider.additionalInformationForWorkElectricity,
                ),
                SizedBox(height: 10),
                ElectricityTextFieldWidget(
                  hintText: "Requested Energisation Status",
                  controller: appStateProvider.requestedEnergisationStatusElectricity,
                ),
                SizedBox(height: 10),
                ElectricityTextFieldWidget(
                  hintText: "Retrieval Method",
                  controller: appStateProvider.retrievalMethodElectricity,
                ),
                SizedBox(height: 10),
                ElectricityTextFieldWidget(
                  hintText: "Remove Metering Point Meters",
                  controller: appStateProvider.removeMeteringPointMetersElectricity,
                ),
                SizedBox(height: 10),
                ElectricityTextFieldWidget(
                  hintText: "Standard Settlement Code",
                  controller: appStateProvider.standardSettlementCodeElectricity,
                ),
                SizedBox(height: 10),
                ElectricityTextFieldWidget(
                  hintText: "Non Settlement Function Code",
                  controller: appStateProvider.nonSettlementFunctionCodeElectricity,
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
                  controller: appStateProvider.textEditingControllerSiteVisitDateElectricity,
                  onTap: () => appStateProvider.selectSiteVisitDateElectricity(context),
                ),
                SizedBox(height: 10),
                Text("\t\tVisit Successful"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("True"),
                    Radio(
                      value: 'true',
                      groupValue: appStateProvider.visitSuccessfulElectricity,
                      onChanged: appStateProvider.handleVisitSuccessfulSelectionElectricity,
                    ),
                    Text("False"),
                    Radio(
                      value: 'false',
                      groupValue: appStateProvider.visitSuccessfulElectricity,
                      onChanged: appStateProvider.handleVisitSuccessfulSelectionElectricity,
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
                      groupValue: appStateProvider.readingTakenElectricity,
                      onChanged: appStateProvider.handleReadingTakenSelectionElectricity,
                    ),
                    Text("False"),
                    Radio(
                      value: 'false',
                      groupValue: appStateProvider.readingTakenElectricity,
                      onChanged: appStateProvider.handleReadingTakenSelectionElectricity,
                    ),
                  ],
                ),
                SizedBox(height: 10),
                ElectricityTextFieldWidget(
                  hintText: "Engineer Name",
                  controller: appStateProvider.engineerNameElectricity,
                ),
                SizedBox(height: 10),
                ElectricityTextFieldWidget(
                  hintText: "Site Visit Notes",
                  controller: appStateProvider.siteVisitNotesElectricity,
                  maxLine: 3,
                ),
                SizedBox(height: 10),
                ElectricityTextFieldWidget(
                  controller: appStateProvider.failureToEneOrDeElectricity,
                  hintText: "Failure To Energies Or DeEnergise Reason Code",
                ),
                SizedBox(height: 10),
                ElectricityTextFieldWidget(
                  controller: appStateProvider.siteVisitCheckCodeElectricity,
                  hintText: "Site Visit Check Code",
                ),
                SizedBox(height: 10),
                ElectricityTextFieldWidget(
                  controller: appStateProvider.assetConditionCodeElectricity,
                  hintText: "Asset Condition Code",
                ),
                SizedBox(height: 10),
                ElectricityTextFieldWidget(
                  controller: appStateProvider.assetConditionAdditionalElectricity,
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
                  controller: appStateProvider.energisationStatusElectricity,
                ),
                SizedBox(height: 10),
                Text("\t\tIs Smart"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("True"),
                    Radio(
                      value: 'true',
                      groupValue: appStateProvider.isSmartElectricity,
                      onChanged: appStateProvider.handleIsSmartSelectionElectricity,
                    ),
                    Text("False"),
                    Radio(
                      value: 'false',
                      groupValue: appStateProvider.isSmartElectricity,
                      onChanged: appStateProvider.handleIsSmartSelectionElectricity,
                    ),
                  ],
                ),
                SizedBox(height: 10),
                ElectricityTextFieldWidget(
                  hintText: "Meter Location Code",
                  controller: appStateProvider.meterLocationCodeElectricity,
                ),
                SizedBox(height: 10),
                ElectricityTextFieldWidget(
                  hintText: "Standard Settlement Code",
                  controller: appStateProvider.standardSettlementCodeForMeterSystemElectricity,
                ),
                SizedBox(height: 10),
                ElectricityTextFieldWidget(
                  controller: appStateProvider.nonSettlementFunctionCodeForMeterSystemElectricity,
                  hintText: "Non Settlement Function Code",
                ),
                SizedBox(height: 10),
                ElectricityTextFieldWidget(
                  controller: appStateProvider.retrievalMethodForMeterSystemElectricity,
                  hintText: "Retrieval Method",
                ),
              ],
            ),
          ),
          Step(
            isActive: _currentStep == 4,
            state: _currentStep >= 4 ? StepState.complete : StepState.indexed,
            title: Text('Meters'),
            content: ListView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: appStateProvider.formDataListElectricityMeters.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Meters ${index + 1}"),
                          Row(
                            children: [
                              index != 0 ? GestureDetector(
                                onTap: () {
                                  appStateProvider.removeFormElectricityMeters(index);
                                },
                                child: Center(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: const Text("Remove", style: TextStyle(color: AppColors.whiteColor)),
                                  ),
                                ),
                              ) : const SizedBox(),
                              const SizedBox(width: 7),
                              GestureDetector(
                                onTap: () {
                                  appStateProvider.addFormElectricityMeters();
                                },
                                child: Center(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                                    decoration: BoxDecoration(
                                      color: AppColors.appThemeColor,
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: const Text("Add", style: TextStyle(color: AppColors.whiteColor)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text("\t\tUse Template"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text('True'),
                          Radio<bool>(
                            value: true,
                            groupValue: appStateProvider.formDataListElectricityMeters[index]['useTemplateElectricity'],
                            onChanged: (value) {
                              setState(() {
                                appStateProvider.formDataListElectricityMeters[index]['useTemplateElectricity'] = value;
                              });
                            },
                          ),
                          const Text('False'),
                          Radio<bool>(
                            value: false,
                            groupValue: appStateProvider.formDataListElectricityMeters[index]['useTemplateElectricity'],
                            onChanged: (value) {
                              setState(() {
                                appStateProvider.formDataListElectricityMeters[index]['useTemplateElectricity'] = value;
                              });
                            },
                          ),
                        ],
                      ),
                      ElectricityTextFieldWidget(
                        hintText: "Installation Status",
                        controller: appStateProvider.formDataListElectricityMeters[index]['installationStatusElectricity'],
                      ),
                      const SizedBox(height: 10),
                      ElectricityTextFieldWidget(
                        hintText: "Serial Number",
                        controller: appStateProvider.formDataListElectricityMeters[index]['serialNumberElectricity'],
                      ),
                      const SizedBox(height: 10),
                      ElectricityTextFieldWidget(
                        hintText: "Equipment Type Name",
                        controller: appStateProvider.formDataListElectricityMeters[index]['equipmentTypeNameElectricity'],
                      ),
                      const SizedBox(height: 10),
                      ElectricityTextFieldWidget(
                        hintText: "Meter Type",
                        controller: appStateProvider.formDataListElectricityMeters[index]['meterTypeElectricity'],
                      ),
                      const SizedBox(height: 10),
                      ElectricityTextFieldWidget(
                        hintText: "Owner Mpid",
                        controller: appStateProvider.formDataListElectricityMeters[index]['ownerMpidElectricity'],
                      ),
                      const SizedBox(height: 10),
                      ElectricityTextFieldWidget(
                        hintText: "Current Rating",
                        controller: appStateProvider.formDataListElectricityMeters[index]['currentRatingElectricity'],
                      ),
                      const SizedBox(height: 10),
                      ElectricityTextFieldWidget(
                        hintText: "Timing Deviceid Serial Number",
                        controller: appStateProvider.formDataListElectricityMeters[index]['timingSerialNumberElectricity'],
                      ),
                      const SizedBox(height: 10),
                      ElectricityTextFieldWidget(
                        hintText: "CT Ratio",
                        controller: appStateProvider.formDataListElectricityMeters[index]['ctRatioElectricity'],
                      ),
                      const SizedBox(height: 10),
                      ElectricityTextFieldWidget(
                        hintText: "VT Ratio",
                        controller: appStateProvider.formDataListElectricityMeters[index]['vtRatioElectricity'],
                      ),
                      const SizedBox(height: 10),
                      ElectricityTextFieldWidget(
                        hintText: "Prepayment Data Unavailable",
                        controller: appStateProvider.formDataListElectricityMeters[index]['prePaymentDataUnavailableElectricity'],
                      ),
                      const SizedBox(height: 10),
                      ElectricityTextFieldWidget(
                        hintText: "Debt Recovery Rate",
                        controller: appStateProvider.formDataListElectricityMeters[index]['debtRecoveryRateElectricity'],
                      ),
                      SizedBox(height: 10),
                      Text("\t\tHas Emergency Credit"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text('True'),
                          Radio<bool>(
                            value: true,
                            groupValue: appStateProvider.formDataListElectricityMeters[index]['hasEmergencyCredit'],
                            onChanged: (value) {
                              setState(() {
                                appStateProvider.formDataListElectricityMeters[index]['hasEmergencyCredit'] = value;
                              });
                            },
                          ),
                          const Text('False'),
                          Radio<bool>(
                            value: false,
                            groupValue: appStateProvider.formDataListElectricityMeters[index]['hasEmergencyCredit'],
                            onChanged: (value) {
                              setState(() {
                                appStateProvider.formDataListElectricityMeters[index]['hasEmergencyCredit'] = value;
                              });
                            },
                          ),
                        ],
                      ),
                      ElectricityTextFieldWidget(
                        hintText: "Initial Credit",
                        controller: appStateProvider.formDataListElectricityMeters[index]['initialCreditElectricity'],
                      ),
                      const SizedBox(height: 10),
                      ElectricityTextFieldWidget(
                        hintText: "Standing Change",
                        controller: appStateProvider.formDataListElectricityMeters[index]['standingChangeElectricity'],
                      ),
                      const SizedBox(height: 10),
                      ElectricityTextFieldWidget(
                        hintText: "Total Debit",
                        controller: appStateProvider.formDataListElectricityMeters[index]['totalDebitElectricity'],
                      ),
                      const SizedBox(height: 10),
                      ElectricityTextFieldWidget(
                        hintText: "Total Debit Outstanding",
                        controller: appStateProvider.formDataListElectricityMeters[index]['totalDebitOutstandingElectricity'],
                      ),
                      const SizedBox(height: 10),
                      ElectricityTextFieldWidget(
                        hintText: "Total Credit Accepted",
                        controller: appStateProvider.formDataListElectricityMeters[index]['totalCreditAcceptedElectricity'],
                      ),
                      const SizedBox(height: 10),
                      ElectricityTextFieldWidget(
                        hintText: "Total Tokens Inserted",
                        controller: appStateProvider.formDataListElectricityMeters[index]['totalTokensInsertedElectricity'],
                      ),
                      const SizedBox(height: 10),
                      ElectricityTextFieldWidget(
                        hintText: "Credit Balance",
                        controller: appStateProvider.formDataListElectricityMeters[index]['creditBalanceElectricity'],
                      ),
                      const SizedBox(height: 10),
                      ElectricityTextFieldWidget(
                        hintText: "Emergency Credit",
                        controller: appStateProvider.formDataListElectricityMeters[index]['emergencyCreditElectricity'],
                      ),
                      const SizedBox(height: 10),
                      ElectricityTextFieldWidget(
                        hintText: "Prepayment Meter Shutdown Status",
                        controller: appStateProvider.formDataListElectricityMeters[index]['prePaymentMeterShutdownStatusElectricity'],
                      ),
                      const SizedBox(height: 10),
                      ElectricityTextFieldWidget(
                        hintText: "Meter Removal Date",
                        onTap: () => appStateProvider.selectedMeterRemovalDateForMetersElectricity(context, index),
                        controller: appStateProvider.formDataListElectricityMeters[index]['meterRemovalDateElectricity'],
                      ),
                      const SizedBox(height: 10),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: appStateProvider.formDataListElectricityMeters[index]['subForms'].length,
                        itemBuilder: (context, subIndex) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Registers ${subIndex + 1}"),
                                    Row(
                                      children: [
                                        subIndex != 0 ? GestureDetector(
                                          onTap: () {
                                            appStateProvider.removeSubFormElectricityMeters(index, subIndex);
                                          },
                                          child: Center(
                                            child: Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                                              decoration: BoxDecoration(
                                                color: Colors.red,
                                                borderRadius: BorderRadius.circular(25),
                                              ),
                                              child: const Text("Remove", style: TextStyle(color: AppColors.whiteColor)),
                                            ),
                                          ),
                                        ) : const SizedBox(),
                                        const SizedBox(width: 7),
                                        GestureDetector(
                                          onTap: () {
                                            appStateProvider.addSubFormElectricityMeters(index);
                                          },
                                          child: Center(
                                            child: Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                                              decoration: BoxDecoration(
                                                color: AppColors.appThemeColor,
                                                borderRadius: BorderRadius.circular(25),
                                              ),
                                              child: const Text("Add", style: TextStyle(color: AppColors.whiteColor)),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Text("\t\tUse Template"),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const Text('True'),
                                    Radio<bool>(
                                      value: true,
                                      groupValue: appStateProvider.formDataListElectricityMeters[index]['subForms'][subIndex]['useTemplateForRegistersElectricity'],
                                      onChanged: (value) {
                                        setState(() {
                                          appStateProvider.formDataListElectricityMeters[index]['subForms'][subIndex]['useTemplateForRegistersElectricity'] = value;
                                        });
                                      },
                                    ),
                                    const Text('False'),
                                    Radio<bool>(
                                      value: false,
                                      groupValue: appStateProvider.formDataListElectricityMeters[index]['subForms'][subIndex]['useTemplateForRegistersElectricity'],
                                      onChanged: (value) {
                                        setState(() {
                                          appStateProvider.formDataListElectricityMeters[index]['subForms'][subIndex]['useTemplateForRegistersElectricity'] = value;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                ElectricityTextFieldWidget(
                                  hintText: "Meter RegisterId",
                                  controller: appStateProvider.formDataListElectricityMeters[index]['subForms'][subIndex]['meterRegisterIdElectricity'],
                                ),
                                SizedBox(height: 10),
                                Text("\t\tIs Settlement"),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const Text('True'),
                                    Radio<bool>(
                                      value: true,
                                      groupValue: appStateProvider.formDataListElectricityMeters[index]['subForms'][subIndex]['isSettlementElectricity'],
                                      onChanged: (value) {
                                        setState(() {
                                          appStateProvider.formDataListElectricityMeters[index]['subForms'][subIndex]['isSettlementElectricity'] = value;
                                        });
                                      },
                                    ),
                                    const Text('False'),
                                    Radio<bool>(
                                      value: false,
                                      groupValue: appStateProvider.formDataListElectricityMeters[index]['subForms'][subIndex]['isSettlementElectricity'],
                                      onChanged: (value) {
                                        setState(() {
                                          appStateProvider.formDataListElectricityMeters[index]['subForms'][subIndex]['isSettlementElectricity'] = value;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                ElectricityTextFieldWidget(
                                  hintText: "Register Type",
                                  controller: appStateProvider.formDataListElectricityMeters[index]['subForms'][subIndex]['registerTypeElectricity'],
                                ),
                                const SizedBox(height: 10),
                                ElectricityTextFieldWidget(
                                  hintText: "Number Of Digits",
                                  controller: appStateProvider.formDataListElectricityMeters[index]['subForms'][subIndex]['numberOfDigitsElectricity'],
                                ),
                                const SizedBox(height: 10),
                                ElectricityTextFieldWidget(
                                  hintText: "Measurement Quantity",
                                  controller: appStateProvider.formDataListElectricityMeters[index]['subForms'][subIndex]['measurementQuantityElectricity'],
                                ),
                                const SizedBox(height: 10),
                                ElectricityTextFieldWidget(
                                  hintText: "Multiplier",
                                  controller: appStateProvider.formDataListElectricityMeters[index]['subForms'][subIndex]['multiplierElectricity'],
                                ),
                                const SizedBox(height: 10),
                                ElectricityTextFieldWidget(
                                  hintText: "Register Reading",
                                  controller: appStateProvider.formDataListElectricityMeters[index]['subForms'][subIndex]['registerReadingElectricity'],
                                ),
                                const SizedBox(height: 10),
                                ElectricityTextFieldWidget(
                                  hintText: "Reading Type",
                                  controller: appStateProvider.formDataListElectricityMeters[index]['subForms'][subIndex]['readingTypeElectricity'],
                                ),
                                const SizedBox(height: 10),
                                ElectricityTextFieldWidget(
                                  hintText: "Reading NotValid Reason Code",
                                  controller: appStateProvider.formDataListElectricityMeters[index]['subForms'][subIndex]['readingNotValidReasonCodeElectricity'],
                                ),
                                const SizedBox(height: 10),
                                ElectricityTextFieldWidget(
                                  hintText: "Prepayment Unit Rate",
                                  controller: appStateProvider.formDataListElectricityMeters[index]['subForms'][subIndex]['prepaymentUnitRateElectricity'],
                                ),
                                const SizedBox(height: 10),
                                ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: appStateProvider.formDataListElectricityMeters[index]['subForms'][subIndex]['subSubForms'].length,
                                  itemBuilder: (context, subSubIndex) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Time Patterns ${subSubIndex + 1}"),
                                              Row(
                                                children: [
                                                  subSubIndex != 0 ? GestureDetector(
                                                    onTap: () {
                                                      appStateProvider.removeSubSubFormElectricityMeters(index, subIndex, subSubIndex);
                                                    },
                                                    child: Center(
                                                      child: Container(
                                                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                                                        decoration: BoxDecoration(
                                                          color: Colors.red,
                                                          borderRadius:
                                                          BorderRadius.circular(25),
                                                        ),
                                                        child: const Text("Remove", style: TextStyle(color: AppColors.whiteColor)),
                                                      ),
                                                    ),
                                                  ) : const SizedBox(),
                                                  const SizedBox(width: 7),
                                                  GestureDetector(
                                                    onTap: () {
                                                      appStateProvider.addSubSubFormElectricityMeters(index, subIndex);
                                                    },
                                                    child: Center(
                                                      child: Container(
                                                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                                                        decoration: BoxDecoration(
                                                          color: AppColors.appThemeColor,
                                                          borderRadius:
                                                          BorderRadius.circular(25),
                                                        ),
                                                        child: const Text("Add", style: TextStyle(color: AppColors.whiteColor)),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                          ElectricityTextFieldWidget(
                                            hintText: "Time Pattern Regime",
                                            controller: appStateProvider.formDataListElectricityMeters[index]['subForms'][subIndex]['subSubForms'][subSubIndex]['timePatternRegimeElectricity'],
                                          ),
                                          const SizedBox(height: 10),
                                          ElectricityTextFieldWidget(
                                            hintText: "Settlement Map Coefficient",
                                            controller: appStateProvider.formDataListElectricityMeters[index]['subForms'][subIndex]['subSubForms'][subSubIndex]['settlementMapCoefficientElectricity'],
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      Container(height: 3, color: AppColors.appThemeColor),
                    ],
                  ),
                );
              },
            ),
          ),
          Step(
            isActive: _currentStep == 5,
            state: _currentStep >= 5 ? StepState.complete : StepState.indexed,
            title: Text('Amr Details'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElectricityTextFieldWidget(
                  hintText: "Cop Ref",
                  controller: appStateProvider.copRefElectricity,
                ),
                SizedBox(height: 10),
                ElectricityTextFieldWidget(
                  hintText: "Cop Issue Number",
                  controller: appStateProvider.copIssueNumberElectricity,
                ),
                SizedBox(height: 10),
                Text("\t\tRemote Enable/Disable Capable"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("True"),
                    Radio(
                      value: 'true',
                      groupValue: appStateProvider.remoteEnableElectricity,
                      onChanged: appStateProvider.handleRemoteEnableSelectionElectricity,
                    ),
                    Text("False"),
                    Radio(
                      value: 'false',
                      groupValue: appStateProvider.remoteEnableElectricity,
                      onChanged: appStateProvider.handleRemoteEnableSelectionElectricity,
                    ),
                  ],
                ),
                SizedBox(height: 10),
                ElectricityTextFieldWidget(
                  hintText: "Event Indicator",
                  controller: appStateProvider.eventIndicatorElectricity,
                ),
              ],
            ),
          ),
          Step(
            isActive: _currentStep == 6,
            state: _currentStep >= 6 ? StepState.complete : StepState.indexed,
            title: Text('Outstation'),
            content: ListView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: appStateProvider.formDataListElectricityOutstation.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Outstation ${index + 1}"),
                          Row(
                            children: [
                              index != 0 ? GestureDetector(
                                onTap: () {
                                  appStateProvider.removeFormElectricityOutstation(index);
                                },
                                child: Center(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: const Text("Remove", style: TextStyle(color: AppColors.whiteColor)),
                                  ),
                                ),
                              ) : const SizedBox(),
                              const SizedBox(width: 7),
                              GestureDetector(
                                onTap: () {
                                  appStateProvider.addFormElectricityOutstation();
                                },
                                child: Center(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 15,
                                      vertical: 5,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.appThemeColor,
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: const Text("Add", style: TextStyle(color: AppColors.whiteColor)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      ElectricityTextFieldWidget(
                        hintText: "Serial Number",
                        controller: appStateProvider.formDataListElectricityOutstation[index]['serialNumberElectricityOutstation'],
                      ),
                      const SizedBox(height: 10),
                      ElectricityTextFieldWidget(
                        hintText: "Outstation Type",
                        controller: appStateProvider.formDataListElectricityOutstation[index]['outstationTypeElectricityOutstation'],
                      ),
                      const SizedBox(height: 10),
                      ElectricityTextFieldWidget(
                        hintText: "Number Of Channels",
                        controller: appStateProvider.formDataListElectricityOutstation[index]['numberOfChannelsElectricityOutstation'],
                      ),
                      const SizedBox(height: 10),
                      ElectricityTextFieldWidget(
                        hintText: "Number Of Digits",
                        controller: appStateProvider.formDataListElectricityOutstation[index]['numberOfDigitsElectricityOutstation'],
                      ),
                      const SizedBox(height: 10),
                      ElectricityTextFieldWidget(
                        hintText: "Pin",
                        controller: appStateProvider.formDataListElectricityOutstation[index]['pinElectricityOutstation'],
                      ),
                      const SizedBox(height: 10),
                      ElectricityTextFieldWidget(
                        hintText: "Multiplier",
                        controller: appStateProvider.formDataListElectricityOutstation[index]['multiplierElectricityOutstation'],
                      ),
                      const SizedBox(height: 10),
                      ElectricityTextFieldWidget(
                        hintText: "Username Level1",
                        controller: appStateProvider.formDataListElectricityOutstation[index]['usernameLevel1ElectricityOutstation'],
                      ),
                      const SizedBox(height: 10),
                      ElectricityTextFieldWidget(
                        hintText: "Password Level1",
                        controller: appStateProvider.formDataListElectricityOutstation[index]['passwordLevel1ElectricityOutstation'],
                      ),
                      const SizedBox(height: 10),
                      ElectricityTextFieldWidget(
                        hintText: "Username Level2",
                        controller: appStateProvider.formDataListElectricityOutstation[index]['usernameLevel2ElectricityOutstation'],
                      ),
                      const SizedBox(height: 10),
                      ElectricityTextFieldWidget(
                        hintText: "Password Level2",
                        controller: appStateProvider.formDataListElectricityOutstation[index]['passwordLevel2ElectricityOutstation'],
                      ),
                      const SizedBox(height: 10),
                      ElectricityTextFieldWidget(
                        hintText: "Username Level3",
                        controller: appStateProvider.formDataListElectricityOutstation[index]['usernameLevel3ElectricityOutstation'],
                      ),
                      const SizedBox(height: 10),
                      ElectricityTextFieldWidget(
                        hintText: "Password Level3",
                        controller: appStateProvider.formDataListElectricityOutstation[index]['passwordLevel3ElectricityOutstation'],
                      ),
                      const SizedBox(height: 10),
                      ElectricityTextFieldWidget(
                        hintText: "Comms Method",
                        controller: appStateProvider.formDataListElectricityOutstation[index]['commsMethodElectricityOutstation'],
                      ),
                      const SizedBox(height: 10),
                      ElectricityTextFieldWidget(
                        hintText: "Comms Address",
                        controller: appStateProvider.formDataListElectricityOutstation[index]['commsAddressElectricityOutstation'],
                      ),
                      const SizedBox(height: 10),
                      ElectricityTextFieldWidget(
                        hintText: "Comms Baud Rate",
                        controller: appStateProvider.formDataListElectricityOutstation[index]['commsBaudRateElectricityOutstation'],
                      ),
                      const SizedBox(height: 10),
                      ElectricityTextFieldWidget(
                        hintText: "Comms Dial InOut",
                        controller: appStateProvider.formDataListElectricityOutstation[index]['commsDialInOutElectricityOutstation'],
                      ),
                      const SizedBox(height: 10),
                      ElectricityTextFieldWidget(
                        hintText: "Comms Provider",
                        controller: appStateProvider.formDataListElectricityOutstation[index]['commsProviderElectricityOutstation'],
                      ),
                      const SizedBox(height: 10),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: appStateProvider.formDataListElectricityOutstation[index]['subForms1'].length,
                        itemBuilder: (context, subIndex) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Outstation Ch ${subIndex + 1}"),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        subIndex != 0 ? GestureDetector(
                                          onTap: () {
                                            appStateProvider.removeSubForm1ElectricityOutstation(index, subIndex);
                                          },
                                          child: Center(
                                            child: Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5,),
                                              decoration: BoxDecoration(
                                                color: Colors.red,
                                                borderRadius: BorderRadius.circular(25),
                                              ),
                                              child: const Text("Remove", style: TextStyle(color: AppColors.whiteColor),
                                              ),
                                            ),
                                          ),
                                        ) : const SizedBox(),
                                        const SizedBox(width: 7),
                                        GestureDetector(
                                          onTap: () {
                                            appStateProvider.addSubForm1ElectricityOutstation(index);
                                          },
                                          child: Center(
                                            child: Container(
                                              padding: const EdgeInsets.symmetric(
                                                horizontal: 15,
                                                vertical: 5,
                                              ),
                                              decoration: BoxDecoration(
                                                color: AppColors.appThemeColor,
                                                borderRadius: BorderRadius.circular(25),
                                              ),
                                              child: const Text("Add", style: TextStyle(color: AppColors.whiteColor)),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                ElectricityTextFieldWidget(
                                  hintText: "Channel Number",
                                  controller: appStateProvider.formDataListElectricityOutstation[index]['subForms1'][subIndex]['channelNumberElectricityOutstation'],
                                ),
                                const SizedBox(height: 10),
                                ElectricityTextFieldWidget(
                                  hintText: "Pulse Multiplier",
                                  controller: appStateProvider.formDataListElectricityOutstation[index]['subForms1'][subIndex]['pulseMultiplierElectricityOutstation'],
                                ),
                                const SizedBox(height: 10),
                                ElectricityTextFieldWidget(
                                  hintText: "Measurement Quantity",
                                  controller: appStateProvider.formDataListElectricityOutstation[index]['subForms1'][subIndex]['measurementQuantityElectricityOutstation'],
                                ),
                                const SizedBox(height: 10),
                              ],
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: appStateProvider.formDataListElectricityOutstation[index]['subForms2'].length,
                        itemBuilder: (context, subIndex) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Meter Mappings ${subIndex + 1}"),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        subIndex != 0 ? GestureDetector(
                                          onTap: () {
                                            appStateProvider.removeSubForm2ElectricityOutstation(index, subIndex);
                                          },
                                          child: Center(
                                            child: Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                                              decoration: BoxDecoration(
                                                color: Colors.red,
                                                borderRadius: BorderRadius.circular(25),
                                              ),
                                              child: const Text("Remove", style: TextStyle(color: AppColors.whiteColor)),
                                            ),
                                          ),
                                        ) : const SizedBox(),
                                        const SizedBox(width: 7),
                                        GestureDetector(
                                          onTap: () {
                                            appStateProvider.addSubForm2ElectricityOutstation(index);
                                          },
                                          child: Center(
                                            child: Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                                              decoration: BoxDecoration(
                                                color: AppColors.appThemeColor,
                                                borderRadius: BorderRadius.circular(25),
                                              ),
                                              child: const Text("Add", style: TextStyle(color: AppColors.whiteColor)),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                ElectricityTextFieldWidget(
                                  hintText: "Meter Serial Number",
                                  controller: appStateProvider.formDataListElectricityOutstation[index]['subForms2'][subIndex]['meterSerialNumberElectricityOutstation'],
                                ),
                                const SizedBox(height: 10),
                                ElectricityTextFieldWidget(
                                  hintText: "Meter Register Id",
                                  controller: appStateProvider.formDataListElectricityOutstation[index]['subForms2'][subIndex]['meterRegisterIdElectricityOutstation'],
                                ),
                                const SizedBox(height: 10),
                                ElectricityTextFieldWidget(
                                  hintText: "Meter Memory Location Type",
                                  controller: appStateProvider.formDataListElectricityOutstation[index]['subForms2'][subIndex]['meterMemoryLocationTypeElectricityOutstation'],
                                ),
                                const SizedBox(height: 10),
                                ElectricityTextFieldWidget(
                                  hintText: "Meter Memory Location",
                                  controller: appStateProvider.formDataListElectricityOutstation[index]['subForms2'][subIndex]['meterMemoryLocationElectricityOutstation'],
                                ),
                                const SizedBox(height: 10),
                                ElectricityTextFieldWidget(
                                  hintText: "Timestamp Memory Location",
                                  controller: appStateProvider.formDataListElectricityOutstation[index]['subForms2'][subIndex]['timestampMemoryLocationElectricityOutstation'],
                                ),
                                const SizedBox(height: 10),
                              ],
                            ),
                          );
                        },
                      ),
                      Container(height: 3, color: Colors.black),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}