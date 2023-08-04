//@dart=2.9
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

  @override
  void initState() {
    super.initState();
    AppStateProvider appStateProvider = Provider.of<AppStateProvider>(context,listen: false);
    appStateProvider.initFormElectricityMeters();
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
      body: Padding(
        padding: const EdgeInsets.all(7.0),
        child: ListView.builder(
          itemCount: appStateProvider.itemsElectricity.length,
          physics: ScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Card(
              child: ExpansionTile(
                initiallyExpanded: appStateProvider.currentExpandedTileIndexElectricity == index,
                title: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.appThemeColor,
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("${index+1}",style: TextStyle(color: AppColors.whiteColor)),
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                    Text(appStateProvider.itemsElectricity[index],style: TextStyle(color: AppColors.appThemeColor,fontWeight: FontWeight.bold)),
                  ],
                ),
                children: <Widget>[
                  index == 0 ? Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
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
                      ],
                    ),
                  ) :
                  index == 1 ? Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ElectricityTextFieldWidget(
                          hintText: "Requested Energisation Status",
                          controller: appStateProvider.requestedEnergisationStatusForWorkElectricity,
                        ),
                      ],
                    ),
                  ) :
                  index == 2 ? Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
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
                          controller: appStateProvider.siteVisitCheckCodeElectricity,
                          hintText: "Site Visit Check Code",
                        ),
                      ],
                    ),
                  ) :
                  index == 3 ? Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
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
                          controller: appStateProvider.retrievalMethodForMeterSystemElectricity,
                          hintText: "Retrieval Method",
                        ),
                      ],
                    ),
                  ) :
                  index == 4 ? Padding(
                    padding: const EdgeInsets.all(15),
                    child: ListView.builder(
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
                                  Text("Meters ${index + 1}",style: TextStyle(fontWeight: FontWeight.bold)),
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
                                hintText: "Meter Removal Date",
                                onTap: () => appStateProvider.selectedMeterRemovalDateForMetersElectricity(context, index),
                                controller: appStateProvider.formDataListElectricityMeters[index]['meterRemovalDateElectricity'],
                              ),
                              const SizedBox(height: 10),
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: appStateProvider.formDataListElectricityMeters[index]['registers'].length,
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
                                            Text("Registers ${subIndex + 1}",style: TextStyle(fontWeight: FontWeight.bold)),
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
                                              groupValue: appStateProvider.formDataListElectricityMeters[index]['registers'][subIndex]['useTemplateForRegistersElectricity'],
                                              onChanged: (value) {
                                                setState(() {
                                                  appStateProvider.formDataListElectricityMeters[index]['registers'][subIndex]['useTemplateForRegistersElectricity'] = value;
                                                });
                                              },
                                            ),
                                            const Text('False'),
                                            Radio<bool>(
                                              value: false,
                                              groupValue: appStateProvider.formDataListElectricityMeters[index]['registers'][subIndex]['useTemplateForRegistersElectricity'],
                                              onChanged: (value) {
                                                setState(() {
                                                  appStateProvider.formDataListElectricityMeters[index]['registers'][subIndex]['useTemplateForRegistersElectricity'] = value;
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                        ElectricityTextFieldWidget(
                                          hintText: "Meter RegisterId",
                                          controller: appStateProvider.formDataListElectricityMeters[index]['registers'][subIndex]['meterRegisterIdElectricity'],
                                        ),
                                        SizedBox(height: 10),
                                        Text("\t\tIs Settlement"),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            const Text('True'),
                                            Radio<bool>(
                                              value: true,
                                              groupValue: appStateProvider.formDataListElectricityMeters[index]['registers'][subIndex]['isSettlementElectricity'],
                                              onChanged: (value) {
                                                setState(() {
                                                  appStateProvider.formDataListElectricityMeters[index]['registers'][subIndex]['isSettlementElectricity'] = value;
                                                });
                                              },
                                            ),
                                            const Text('False'),
                                            Radio<bool>(
                                              value: false,
                                              groupValue: appStateProvider.formDataListElectricityMeters[index]['registers'][subIndex]['isSettlementElectricity'],
                                              onChanged: (value) {
                                                setState(() {
                                                  appStateProvider.formDataListElectricityMeters[index]['registers'][subIndex]['isSettlementElectricity'] = value;
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                        ElectricityTextFieldWidget(
                                          hintText: "Register Type",
                                          controller: appStateProvider.formDataListElectricityMeters[index]['registers'][subIndex]['registerTypeElectricity'],
                                        ),
                                        const SizedBox(height: 10),
                                        ElectricityTextFieldWidget(
                                          hintText: "Number Of Digits",
                                          controller: appStateProvider.formDataListElectricityMeters[index]['registers'][subIndex]['numberOfDigitsElectricity'],
                                        ),
                                        const SizedBox(height: 10),
                                        ElectricityTextFieldWidget(
                                          hintText: "Measurement Quantity",
                                          controller: appStateProvider.formDataListElectricityMeters[index]['registers'][subIndex]['measurementQuantityElectricity'],
                                        ),
                                        const SizedBox(height: 10),
                                        ElectricityTextFieldWidget(
                                          hintText: "Multiplier",
                                          controller: appStateProvider.formDataListElectricityMeters[index]['registers'][subIndex]['multiplierElectricity'],
                                        ),
                                        const SizedBox(height: 10),
                                        ElectricityTextFieldWidget(
                                          hintText: "Register Reading",
                                          controller: appStateProvider.formDataListElectricityMeters[index]['registers'][subIndex]['registerReadingElectricity'],
                                        ),
                                        const SizedBox(height: 10),
                                        ElectricityTextFieldWidget(
                                          hintText: "Reading Type",
                                          controller: appStateProvider.formDataListElectricityMeters[index]['registers'][subIndex]['readingTypeElectricity'],
                                        ),
                                        const SizedBox(height: 10),
                                        ElectricityTextFieldWidget(
                                          hintText: "Prepayment Unit Rate",
                                          controller: appStateProvider.formDataListElectricityMeters[index]['registers'][subIndex]['prepaymentUnitRateElectricity'],
                                        ),
                                        const SizedBox(height: 10),
                                        ElectricityTextFieldWidget(
                                          hintText: "Reading NotValid Reason Code",
                                          controller: appStateProvider.formDataListElectricityMeters[index]['registers'][subIndex]['readingNotValidReasonCodeElectricity'],
                                        ),
                                        const SizedBox(height: 10),
                                        ListView.builder(
                                          physics: const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: appStateProvider.formDataListElectricityMeters[index]['registers'][subIndex]['timePatterns'].length,
                                          itemBuilder: (context, subSubIndex) {
                                            return Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text("Time Patterns ${subSubIndex + 1}",style: TextStyle(fontWeight: FontWeight.bold)),
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
                                                    controller: appStateProvider.formDataListElectricityMeters[index]['registers'][subIndex]['timePatterns'][subSubIndex]['timePatternRegimeElectricity'],
                                                  ),
                                                  const SizedBox(height: 10),
                                                  ElectricityTextFieldWidget(
                                                    hintText: "Settlement Map Coefficient",
                                                    controller: appStateProvider.formDataListElectricityMeters[index]['registers'][subIndex]['timePatterns'][subSubIndex]['settlementMapCoefficientElectricity'],
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
                  ) : Container(),
                  index == 4 ? Padding(
                    padding: const EdgeInsets.all(15),
                    child: InkWell(
                      onTap: (){
                        appStateProvider.saveSapphireElectricityFlow(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.appThemeColor,
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text("SUBMIT",style: TextStyle(color: AppColors.whiteColor,fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),
                    ),
                  ) : Container(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}