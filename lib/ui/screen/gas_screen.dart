//@dart=2.9
import 'package:flutter/material.dart';
import '../../core/constant/app_colors.dart';
import '../../core/constant/app_string.dart';
import '../../core/constant/image_file.dart';
import 'package:provider/provider.dart';
import '../../core/model/send/answer_credential.dart';
import '../../core/provider/app_state_provider.dart';
import '../shared/app_drawer_widget.dart';
import '../shared/warehouse_app_drawer.dart';
import 'widget/electricity/electricity_text_field_widget.dart';

class Gas extends StatefulWidget {
  @override
  _GasState createState() => _GasState();
}

class _GasState extends State<Gas> {

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState(){
    super.initState();
    AppStateProvider appStateProvider = Provider.of<AppStateProvider>(context,listen: false);
    appStateProvider.initForm();
  }

  final List<String> items = ['Gas Flow', 'Existing Meter System', 'Site Address', 'Create Work', 'Complete Work', 'Meter System', 'Assets'];

  int _currentExpandedTileIndex = 0;

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
          itemCount: items.length,
          physics: ScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Card(
              child: ExpansionTile(
                onExpansionChanged: (expanded) {
                  setState(() {
                    if (expanded) {
                      _currentExpandedTileIndex = index;
                    } else {
                      _currentExpandedTileIndex = 0;
                    }
                  });
                },
                initiallyExpanded: _currentExpandedTileIndex == index,
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
                    Text(items[index],style: TextStyle(color: AppColors.appThemeColor,fontWeight: FontWeight.bold)),
                  ],
                ),
                children: <Widget>[
                  index == 0 ?
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ElectricityTextFieldWidget(
                          hintText: "MEM MpId",
                          controller: appStateProvider.memMpId,
                          maxLength: 3,
                          required: "required",
                        ),
                        SizedBox(height: 10),
                        ElectricityTextFieldWidget(
                          hintText: "Supplier MpId",
                          controller: appStateProvider.supplierMpId,
                          maxLength: 3,
                          required: "required",
                        ),
                        SizedBox(height: 10),
                        ElectricityTextFieldWidget(
                          hintText: "MPRN",
                          controller: appStateProvider.mprn,
                          maxLength: 10,
                          required: "required",
                        ),
                        SizedBox(height: 10),
                        ElectricityTextFieldWidget(
                          hintText: "External System Identity",
                          controller: appStateProvider.externalSystemIdentity,
                          required: "required",
                        ),
                        SizedBox(height: 10),
                        ElectricityTextFieldWidget(
                          hintText: "Correlation Id",
                          controller: appStateProvider.correlationId,
                        ),
                        SizedBox(height: 10),
                        ElectricityTextFieldWidget(
                          hintText: "Sapphire Work Id",
                          controller: appStateProvider.sapphireWorkId,
                          required: "required",
                        ),
                      ],
                    ),
                  ) : index == 1 ?
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ElectricityTextFieldWidget(
                          hintText: "Meter Link Code",
                          controller: appStateProvider.meterLinkCode,
                          maxLength: 1,
                        ),
                        SizedBox(height: 10),
                        ElectricityTextFieldWidget(
                          hintText: "Status Code",
                          controller: appStateProvider.statusCode,
                          maxLength: 2,
                          required: "required",
                        ),
                        SizedBox(height: 10),
                        ElectricityTextFieldWidget(
                          hintText: "Location Code",
                          required: "required",
                          controller: appStateProvider.locationCode,
                          maxLength: 2,
                        ),
                        SizedBox(height: 10),
                        ElectricityTextFieldWidget(
                          hintText: "Location Notes",
                          maxLine: 3,
                          controller: appStateProvider.locationNotes,
                        ),
                        SizedBox(height: 10),
                        ElectricityTextFieldWidget(
                          hintText: "Access Instructions",
                          maxLine: 3,
                          controller: appStateProvider.accessInstructions,
                        ),
                        SizedBox(height: 10),
                        ElectricityTextFieldWidget(
                          hintText: "Conversion Factor",
                          required: "required",
                          controller: appStateProvider.conversionFactor,
                          keyboardType: "number",
                        ),
                        SizedBox(height: 10),
                        ElectricityTextFieldWidget(
                          hintText: "Metering Pressure",
                          required: "required",
                          controller: appStateProvider.meteringPressure,
                          keyboardType: "number",
                        ),
                      ],
                    ),
                  ) : index == 2 ?
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ElectricityTextFieldWidget(
                          hintText: "Postcode",
                          required: "required",
                          controller: appStateProvider.postCode,
                          maxLength: 10,
                        ),
                        SizedBox(height: 10),
                        ElectricityTextFieldWidget(
                          hintText: "SubBuilding Name",
                          controller: appStateProvider.subBuildingName,
                        ),
                        SizedBox(height: 10),
                        ElectricityTextFieldWidget(
                          hintText: "Building Name",
                          controller: appStateProvider.buildingName,
                        ),
                        SizedBox(height: 10),
                        ElectricityTextFieldWidget(
                          hintText: "Dependent Through Fare",
                          controller: appStateProvider.dependentThroughFare,
                        ),
                        SizedBox(height: 10),
                        ElectricityTextFieldWidget(
                          hintText: "Through Fare",
                          controller: appStateProvider.throughFare,
                        ),
                        SizedBox(height: 10),
                        ElectricityTextFieldWidget(
                          hintText: "Double Dependent Locality",
                          controller: appStateProvider.doubleDependentLocality,
                        ),
                        SizedBox(height: 10),
                        ElectricityTextFieldWidget(
                          hintText: "Dependent Locality",
                          controller: appStateProvider.dependentLocality,
                        ),
                        SizedBox(height: 10),
                        ElectricityTextFieldWidget(
                          hintText: "PostTown",
                          controller: appStateProvider.postTown,
                        ),
                        SizedBox(height: 10),
                        ElectricityTextFieldWidget(
                          hintText: "County",
                          controller: appStateProvider.county,
                        ),
                      ],
                    ),
                  ) : index == 3 ?
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ElectricityTextFieldWidget(
                          hintText: "Appointment Date",
                          onTap: () => appStateProvider.selectAppointmentDate(context),
                          controller: appStateProvider.textEditingControllerAppointmentDate,
                          maxLength: 10,
                        ),
                        SizedBox(height: 10),
                        ElectricityTextFieldWidget(
                          hintText: "Additional Information For Work",
                          maxLine: 3,
                          controller: appStateProvider.additionalInformationForWork,
                        ),
                        SizedBox(height: 10),
                        ElectricityTextFieldWidget(
                          hintText: "Transaction Reference",
                          controller: appStateProvider.transactionReference,
                          maxLength: 15,
                        ),
                        SizedBox(height: 10),
                        ElectricityTextFieldWidget(
                          hintText: "Transaction Type Code",
                          controller: appStateProvider.transactionTypeCode,
                          maxLength: 5,
                        ),
                        SizedBox(height: 10),
                        ElectricityTextFieldWidget(
                          hintText: "Transaction Type Reason Code",
                          controller: appStateProvider.transactionTypeReasonCode,
                          maxLength: 5,
                        ),
                      ],
                    ),
                  ) : index == 4 ?
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ElectricityTextFieldWidget(
                          hintText: "Site Visit Date",
                          required: "required",
                          controller: appStateProvider.textEditingControllerSiteVisitDate,
                          onTap: () => appStateProvider.selectSiteVisitDate(context),
                          maxLength: 10,
                        ),
                        SizedBox(height: 10),
                        Text("\t\tVisit Successful"),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("True"),
                            Radio(
                              value: 'true',
                              groupValue: appStateProvider.visitSuccessful,
                              onChanged: appStateProvider.handleVisitSuccessfulSelection,
                            ),
                            Text("False"),
                            Radio(
                              value: 'false',
                              groupValue: appStateProvider.visitSuccessful,
                              onChanged: appStateProvider.handleVisitSuccessfulSelection,
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
                              groupValue: appStateProvider.readingTaken,
                              onChanged: appStateProvider.handleReadingTakenSelection,
                            ),
                            Text("False"),
                            Radio(
                              value: 'false',
                              groupValue: appStateProvider.readingTaken,
                              onChanged: appStateProvider.handleReadingTakenSelection,
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        ElectricityTextFieldWidget(
                          required: "required",
                          hintText: "Engineer Name",
                          controller: appStateProvider.engineerName,
                        ),
                        SizedBox(height: 10),
                        ElectricityTextFieldWidget(
                          required: "required",
                          hintText: "Transaction Status Code",
                          maxLength: 5,
                          controller: appStateProvider.transactionStatusCode,
                        ),
                        SizedBox(height: 10),
                        ElectricityTextFieldWidget(
                          hintText: "Transaction Status Change Reason Code",
                          controller: appStateProvider.transactionStatusChange,
                          maxLength: 5,
                        ),
                        SizedBox(height: 10),
                        ElectricityTextFieldWidget(
                          hintText: "Site Visit Note",
                          controller: appStateProvider.siteVisitNote,
                          maxLine: 3,
                        ),
                        SizedBox(height: 10),
                        ElectricityTextFieldWidget(
                          hintText: "Transaction Type Code",
                          maxLength: 5,
                          controller: appStateProvider.transactionTypeCodeForCompleteWork,
                        ),
                        SizedBox(height: 10),
                        ElectricityTextFieldWidget(
                          hintText: "Transaction Type Reason Code",
                          maxLength: 5,
                          controller: appStateProvider.transactionTypeReasonCodeForCompleteWork,
                        ),
                      ],
                    ),
                  ) : index == 5 ?
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ElectricityTextFieldWidget(
                          hintText: "Meter Link Code",
                          maxLength: 1,
                          controller: appStateProvider.meterLinkCodeForMeterSystem,
                        ),
                        SizedBox(height: 10),
                        ElectricityTextFieldWidget(
                          hintText: "Status Code",
                          maxLength: 2,
                          controller: appStateProvider.statusCodeForMeterSystem,
                        ),
                        SizedBox(height: 10),
                        ElectricityTextFieldWidget(
                          hintText: "Location Code",
                          maxLength: 2,
                          controller: appStateProvider.locationCodeForMeterSystem,
                        ),
                        SizedBox(height: 10),
                        ElectricityTextFieldWidget(
                          hintText: "Location Note",
                          maxLine: 3,
                          controller: appStateProvider.locationNotesForMeterSystem,
                        ),
                        SizedBox(height: 10),
                        ElectricityTextFieldWidget(
                          hintText: "Access Instructions",
                          controller: appStateProvider.accessInstructionsForMeterSystem,
                          maxLine: 3,
                        ),
                        SizedBox(height: 10),
                        ElectricityTextFieldWidget(
                          hintText: "Conversion Factor",
                          controller: appStateProvider.conversionFactorForMeterSystem,
                          keyboardType: "number",
                        ),
                        SizedBox(height: 10),
                        ElectricityTextFieldWidget(
                          hintText: "Metering Pressure",
                          keyboardType: "number",
                          controller: appStateProvider.meteringPressureForMeterSystem,
                        ),
                      ],
                    ),
                  ) : Padding(
                    padding: const EdgeInsets.all(15),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemCount: appStateProvider.formDataList.length,
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Assets ${index + 1}",style: TextStyle(fontWeight: FontWeight.bold)),
                                Row(
                                  children: [
                                    index != 0 ? GestureDetector(
                                      onTap: () {
                                        appStateProvider.removeForm(index);
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
                                        appStateProvider.addForm();
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
                                Radio<String>(
                                  value: 'True',
                                  groupValue: appStateProvider.formDataList[index]['useTemplate'],
                                  onChanged: (value) {
                                    setState(() {
                                      appStateProvider.formDataList[index]['useTemplate'] = value;
                                    });
                                  },
                                ),
                                const Text('False'),
                                Radio<String>(
                                  value: 'False',
                                  groupValue: appStateProvider.formDataList[index]['useTemplate'],
                                  onChanged: (value) {
                                    setState(() {
                                      appStateProvider.formDataList[index]['useTemplate'] = value;
                                    });
                                  },
                                ),
                              ],
                            ),
                            ElectricityTextFieldWidget(
                              required: "required",
                              hintText: "InstallationStatus",
                              controller: appStateProvider.formDataList[index]['installationStatus'],
                              maxLength: 10,
                            ),
                            const SizedBox(height: 10),
                            ElectricityTextFieldWidget(
                              required: "required",
                              hintText: "Asset Provider Mpid",
                              maxLength: 3,
                              controller: appStateProvider.formDataList[index]['assetProviderMPID'],
                            ),
                            const SizedBox(height: 10),
                            ElectricityTextFieldWidget(
                              hintText: "Asset Class Mode",
                              maxLength: 5,
                              required: "required",
                              controller: appStateProvider.formDataList[index]['assetClassCode'],
                            ),
                            const SizedBox(height: 10),
                            ElectricityTextFieldWidget(
                              hintText: "Payment Method Mode",
                              maxLength: 2,
                              controller: appStateProvider.formDataList[index]['paymentMethodCode'],
                            ),
                            const SizedBox(height: 10),
                            ElectricityTextFieldWidget(
                              hintText: "Model Code",
                              required: "required",
                              controller: appStateProvider.formDataList[index]['modelCode'],
                              maxLength: 10,
                            ),
                            const SizedBox(height: 10),
                            ElectricityTextFieldWidget(
                              hintText: "Manufacturer Code",
                              maxLength: 3,
                              required: "required",
                              controller: appStateProvider.formDataList[index]['manufacturerCode'],
                            ),
                            const SizedBox(height: 10),
                            ElectricityTextFieldWidget(
                              hintText: "Year Of Manufacture",
                              required: "required",
                              controller: appStateProvider.formDataList[index]['yearOfManufacture'],
                              keyboardType: "number",
                            ),
                            const SizedBox(height: 10),
                            ElectricityTextFieldWidget(
                              hintText: "Serial Number",
                              required: "required",
                              controller: appStateProvider.formDataList[index]['serialNumber'],
                              maxLength: 14,
                            ),
                            const SizedBox(height: 10),
                            ElectricityTextFieldWidget(
                              hintText: "Location Code",
                              required: "required",
                              controller: appStateProvider.formDataList[index]['locationCode'],
                              maxLength: 2,
                            ),
                            const SizedBox(height: 10),
                            ElectricityTextFieldWidget(
                              hintText: "Location Notes",
                              controller: appStateProvider.formDataList[index]['locationNotes'],
                            ),
                            const SizedBox(height: 10),
                            ElectricityTextFieldWidget(
                              hintText: "Assets Status Code",
                              maxLength: 2,
                              required: "required",
                              controller: appStateProvider.formDataList[index]['assetStatusCode'],
                            ),
                            const SizedBox(height: 10),
                            ElectricityTextFieldWidget(
                              hintText: "Meter Type",
                              maxLength: 5,
                              required: "required",
                              controller: appStateProvider.formDataList[index]['meterType'],
                            ),
                            const SizedBox(height: 10),
                            ElectricityTextFieldWidget(
                              hintText: "Mechanism Code",
                              maxLength: 5,
                              required: "required",
                              controller: appStateProvider.formDataList[index]['mechanismCode'],
                            ),
                            const SizedBox(height: 10),
                            ElectricityTextFieldWidget(
                              hintText: "Measuring Capacity",
                              keyboardType: "number",
                              required: "required",
                              controller: appStateProvider.formDataList[index]['measuringCapacity'],
                            ),
                            const SizedBox(height: 10),
                            ElectricityTextFieldWidget(
                              hintText: "Meter Usage Code",
                              maxLength: 1,
                              controller: appStateProvider.formDataList[index]['meterUsageCode'],
                            ),
                            const SizedBox(height: 10),
                            ElectricityTextFieldWidget(
                              hintText: "Collar Status Code",
                              maxLength: 5,
                              controller: appStateProvider.formDataList[index]['collarStatusCode'],
                            ),
                            const SizedBox(height: 10),
                            ElectricityTextFieldWidget(
                              hintText: "OAMI Inspection Date",
                              controller: appStateProvider.formDataList[index]['oamiInspectionDate'],
                              onTap: () => appStateProvider.selectOAMIDate(context, index),
                              maxLength: 10,
                            ),
                            const SizedBox(height: 10),
                            ElectricityTextFieldWidget(
                              hintText: "Pulse Value",
                              required: "required",
                              keyboardType: "number",
                              controller: appStateProvider.formDataList[index]['pulseValue'],
                            ),
                            const SizedBox(height: 10),
                            ElectricityTextFieldWidget(
                              hintText: "Gas Act Owner Role",
                              required: "required",
                              maxLength: 1,
                              controller: appStateProvider.formDataList[index]['gasActOwnerRole'],
                            ),
                            const SizedBox(height: 10),
                            ElectricityTextFieldWidget(
                              hintText: "Asset Removal Date",
                              required: "required",
                              controller: appStateProvider.formDataList[index]['assetRemovalDate'],
                              onTap: () => appStateProvider.selectRemovalDate(context, index),
                              maxLength: 10,
                            ),
                            const SizedBox(height: 10),
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: appStateProvider.formDataList[index]['registers'].length,
                              itemBuilder: (context, subIndex) {
                                return Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Registers ${subIndex + 1}",style: TextStyle(fontWeight: FontWeight.bold)),
                                        Row(
                                          children: [
                                            subIndex != 0 ? GestureDetector(
                                              onTap: () {
                                                appStateProvider.removeSubForm(index, subIndex);
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
                                                appStateProvider.addSubForm(index);
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
                                    ElectricityTextFieldWidget(
                                      hintText: "Number Of Digits",
                                      keyboardType: "number",
                                      required: "required",
                                      controller: appStateProvider.formDataList[index]['registers'][subIndex]['numberOfDigits'],
                                    ),
                                    SizedBox(height: 10),
                                    ElectricityTextFieldWidget(
                                      hintText: "Units Of Measure",
                                      maxLength: 5,
                                      required: "required",
                                      controller: appStateProvider.formDataList[index]['registers'][subIndex]['unitsOfMeasure'],
                                    ),
                                    SizedBox(height: 10),
                                    ElectricityTextFieldWidget(
                                      hintText: "Multiplication Factor",
                                      keyboardType: "number",
                                      required: "required",
                                      controller: appStateProvider.formDataList[index]['registers'][subIndex]['multiplicationFactor'],
                                    ),
                                    SizedBox(height: 10),
                                    ElectricityTextFieldWidget(
                                      hintText: "Reading Index",
                                      maxLength: 12,
                                      required: "required",
                                      controller: appStateProvider.formDataList[index]['registers'][subIndex]['readingIndex'],
                                    ),
                                    SizedBox(height: 10),
                                  ],
                                );
                              },
                            ),
                            Container(height: 3, color: AppColors.appThemeColor),
                          ],
                        );
                      },
                    ),
                  ),
                  index == 6 ? Padding(
                    padding: const EdgeInsets.all(15),
                    child: InkWell(
                      onTap: (){
                        appStateProvider.fieldDataCheck(context);
                        if(appStateProvider.isCheckData == true){
                          appStateProvider.saveSapphireGasFlow(context);
                        }
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