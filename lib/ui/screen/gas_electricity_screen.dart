import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constant/app_colors.dart';
import '../../core/constant/app_string.dart';
import '../../core/constant/appconstant.dart';
import '../../core/provider/app_state_provider.dart';
import 'widget/electricity/electricity_text_field_widget.dart';

class GasElectricity extends StatefulWidget{
  String jobType,customerID,appointmentId,correlationId;
  GasElectricity({required this.jobType,required this.customerID,required this.appointmentId,required this.correlationId, Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return GasElectricityState();
  }
}

class GasElectricityState extends State<GasElectricity> with TickerProviderStateMixin {

  bool isSubmit = false;

  @override
  void initState() {
    super.initState();
    AppStateProvider appStateProvider = Provider.of<AppStateProvider>(context,listen: false);
    appStateProvider.initForm();
    appStateProvider.initFormElectricityMeters();
    appStateProvider.correlationId.text = widget.correlationId;
    appStateProvider.correlationIdElectricity.text = widget.correlationId;
  }

  @override
  Widget build(BuildContext context) {
    AppStateProvider appStateProvider = Provider.of<AppStateProvider>(context);
    return WillPopScope(
      onWillPop: () async {
        showDialog<String>(context: context, builder: (BuildContext context) => AlertDialog(
          title: const Text('Exit?'),
          content: const Text('Are you sure you want to exit?',style: TextStyle(fontWeight: FontWeight.bold,letterSpacing: 1)),
          actions: <Widget>[
            TextButton(
              onPressed: () => exit(0),
              child: const Text('OK'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, 'CANCEL'),
              child: const Text('CANCEL'),
            ),
          ],
        ));
        return true;
      },
      child: Scaffold(
        backgroundColor: AppColors.scafoldColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          brightness: Brightness.dark,
          backgroundColor: AppColors.appThemeColor,
          title: Text(
            AppStrings.gasElectricityFlow,
            style: TextStyle(
              color: AppColors.whiteColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          centerTitle: true,
          actions: [],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Container(
                  color: AppColors.darkBlue,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text("GAS FLOW",style: TextStyle(color: AppColors.whiteColor,fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(7.0),
                child: ListView.builder(
                  itemCount: appStateProvider.items.length,
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ExpansionTile(
                        initiallyExpanded: appStateProvider.currentExpandedTileIndex == index,
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
                            Text(appStateProvider.items[index],style: TextStyle(color: AppColors.appThemeColor,fontWeight: FontWeight.bold)),
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
                                  hintText: "MEM MPID",
                                  controller: appStateProvider.memMpId,
                                  maxLength: 3,
                                  required: "required",
                                ),
                                SizedBox(height: 10),
                                ElectricityTextFieldWidget(
                                  hintText: "Supplier MPID",
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
                                  readOnly: true,
                                  controller: appStateProvider.correlationId,
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
                                  hintText: "Building Name",
                                  controller: appStateProvider.buildingName,
                                ),
                                SizedBox(height: 10),
                                ElectricityTextFieldWidget(
                                  hintText: "PostTown",
                                  controller: appStateProvider.postTown,
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
                                  keyboardType: "none",
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
                                  keyboardType: "none",
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
                                                showDialog<String>(context: context, builder: (BuildContext context) => AlertDialog(
                                                  title: const Text('Remove?'),
                                                  content: const Text('Are you sure you want to remove this form?',style: TextStyle(fontWeight: FontWeight.bold,letterSpacing: 1)),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      onPressed: () {
                                                        appStateProvider.removeForm(index);
                                                        Navigator.pop(context);
                                                      },
                                                      child: const Text('YES'),
                                                    ),
                                                    TextButton(
                                                      onPressed: () => Navigator.pop(context, 'NO'),
                                                      child: const Text('NO'),
                                                    ),
                                                  ],
                                                ));
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
                                                appStateProvider.fieldDataCheckWhenClickAddButtonGas(context);
                                                if(appStateProvider.isCheckData == true){
                                                  appStateProvider.addForm();
                                                }
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
                                      hintText: "Installation Status",
                                      controller: appStateProvider.formDataList[index]['installationStatus'],
                                      maxLength: 10,
                                    ),
                                    const SizedBox(height: 10),
                                    ElectricityTextFieldWidget(
                                      required: "required",
                                      hintText: "Asset Provider MPID",
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
                                      hintText: "Mechanism Code",
                                      maxLength: 5,
                                      required: "required",
                                      controller: appStateProvider.formDataList[index]['mechanismCode'],
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
                                      keyboardType: "none",
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
                                      keyboardType: "none",
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
                                                        showDialog<String>(context: context, builder: (BuildContext context) => AlertDialog(
                                                          title: const Text('Remove?'),
                                                          content: const Text('Are you sure you want to remove this form?',style: TextStyle(fontWeight: FontWeight.bold,letterSpacing: 1)),
                                                          actions: <Widget>[
                                                            TextButton(
                                                              onPressed: () {
                                                                appStateProvider.removeSubForm(index, subIndex);
                                                                Navigator.pop(context);
                                                              },
                                                              child: const Text('YES'),
                                                            ),
                                                            TextButton(
                                                              onPressed: () => Navigator.pop(context, 'NO'),
                                                              child: const Text('NO'),
                                                            ),
                                                          ],
                                                        ));
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
                                                        appStateProvider.fieldDataCheckWhenClickAddButtonGas(context);
                                                        if(appStateProvider.isCheckData == true){
                                                          appStateProvider.addSubForm(index);
                                                        }
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
                                              maxLength: 2,
                                              controller: appStateProvider.formDataList[index]['registers'][subIndex]['numberOfDigits'],
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
                        ],
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Container(
                  color: AppColors.darkBlue,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text("ELECTRICITY FLOW",style: TextStyle(color: AppColors.whiteColor,fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
              Padding(
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
                                  hintText: "MEM MPID",
                                  required: "required",
                                  maxLength: 4,
                                  controller: appStateProvider.memMpIdElectricity,
                                ),
                                SizedBox(height: 10),
                                ElectricityTextFieldWidget(
                                  hintText: "Supplier MPID",
                                  required: "required",
                                  maxLength: 4,
                                  controller: appStateProvider.supplierMpIdElectricity,
                                ),
                                SizedBox(height: 10),
                                ElectricityTextFieldWidget(
                                  hintText: "MPAN",
                                  required: "required",
                                  maxLength: 13,
                                  controller: appStateProvider.mprnElectricity,
                                ),
                                SizedBox(height: 10),
                                ElectricityTextFieldWidget(
                                  hintText: "External System Identity",
                                  required: "required",
                                  controller: appStateProvider.externalSystemIdentityElectricity,
                                ),
                                SizedBox(height: 10),
                                ElectricityTextFieldWidget(
                                  hintText: "Correlation Id",
                                  readOnly: true,
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
                                  required: "required",
                                  maxLength: 1,
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
                                  required: "required",
                                  controller: appStateProvider.textEditingControllerSiteVisitDateElectricity,
                                  onTap: () => appStateProvider.selectSiteVisitDateElectricity(context),
                                  keyboardType: "none",
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
                                  required: "required",
                                ),
                                SizedBox(height: 10),
                                ElectricityTextFieldWidget(
                                  controller: appStateProvider.siteVisitCheckCodeElectricity,
                                  hintText: "Site Visit Check Code",
                                  required: "required",
                                  maxLength: 2,
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
                                  maxLength: 1,
                                  hintText: "Energisation Status",
                                  required: "required",
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
                                  required: "required",
                                  maxLength: 1,
                                  controller: appStateProvider.meterLocationCodeElectricity,
                                ),
                                SizedBox(height: 10),
                                ElectricityTextFieldWidget(
                                  hintText: "Standard Settlement Code",
                                  required: "required",
                                  maxLength: 4,
                                  controller: appStateProvider.standardSettlementCodeForMeterSystemElectricity,
                                ),
                                SizedBox(height: 10),
                                ElectricityTextFieldWidget(
                                  controller: appStateProvider.retrievalMethodForMeterSystemElectricity,
                                  hintText: "Retrieval Method",
                                  required: "required",
                                  maxLength: 1,
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
                                                  showDialog<String>(context: context, builder: (BuildContext context) => AlertDialog(
                                                    title: const Text('Remove?'),
                                                    content: const Text('Are you sure you want to remove this form?',style: TextStyle(fontWeight: FontWeight.bold,letterSpacing: 1)),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        onPressed: () {
                                                          appStateProvider.removeFormElectricityMeters(index);
                                                          Navigator.pop(context);
                                                        },
                                                        child: const Text('YES'),
                                                      ),
                                                      TextButton(
                                                        onPressed: () => Navigator.pop(context, 'NO'),
                                                        child: const Text('NO'),
                                                      ),
                                                    ],
                                                  ));
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
                                                  appStateProvider.fieldDataCheckWhenClickAddButtonElectricity(context);
                                                  if(appStateProvider.isCheckDataElectricity == true){
                                                    appStateProvider.addFormElectricityMeters();
                                                  }
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
                                        required: "required",
                                        maxLength: 10,
                                        controller: appStateProvider.formDataListElectricityMeters[index]['installationStatusElectricity'],
                                      ),
                                      const SizedBox(height: 10),
                                      ElectricityTextFieldWidget(
                                        hintText: "Serial Number",
                                        required: "required",
                                        maxLength: 10,
                                        controller: appStateProvider.formDataListElectricityMeters[index]['serialNumberElectricity'],
                                      ),
                                      const SizedBox(height: 10),
                                      ElectricityTextFieldWidget(
                                        hintText: "Equipment Type Name",
                                        required: "required",
                                        controller: appStateProvider.formDataListElectricityMeters[index]['equipmentTypeNameElectricity'],
                                      ),
                                      const SizedBox(height: 10),
                                      ElectricityTextFieldWidget(
                                        hintText: "Meter Type",
                                        required: "required",
                                        maxLength: 5,
                                        controller: appStateProvider.formDataListElectricityMeters[index]['meterTypeElectricity'],
                                      ),
                                      const SizedBox(height: 10),
                                      ElectricityTextFieldWidget(
                                        hintText: "Owner MPID",
                                        required: "required",
                                        maxLength: 4,
                                        controller: appStateProvider.formDataListElectricityMeters[index]['ownerMpidElectricity'],
                                      ),
                                      const SizedBox(height: 10),
                                      ElectricityTextFieldWidget(
                                        hintText: "Current Rating",
                                        required: "required",
                                        keyboardType: "number",
                                        maxLength: 3,
                                        controller: appStateProvider.formDataListElectricityMeters[index]['currentRatingElectricity'],
                                      ),
                                      const SizedBox(height: 10),
                                      ElectricityTextFieldWidget(
                                        required: "required",
                                        hintText: "Timing Deviceid Serial Number",
                                        maxLength: 10,
                                        controller: appStateProvider.formDataListElectricityMeters[index]['timingSerialNumberElectricity'],
                                      ),
                                      const SizedBox(height: 10),
                                      ElectricityTextFieldWidget(
                                        hintText: "CT Ratio",
                                        required: "required",
                                        maxLength: 6,
                                        controller: appStateProvider.formDataListElectricityMeters[index]['ctRatioElectricity'],
                                      ),
                                      const SizedBox(height: 10),
                                      ElectricityTextFieldWidget(
                                        hintText: "VT Ratio",
                                        maxLength: 10,
                                        required: "required",
                                        controller: appStateProvider.formDataListElectricityMeters[index]['vtRatioElectricity'],
                                      ),
                                      const SizedBox(height: 10),
                                      ElectricityTextFieldWidget(
                                        hintText: "Meter Removal Date",
                                        required: "required",
                                        onTap: () => appStateProvider.selectedMeterRemovalDateForMetersElectricity(context, index),
                                        controller: appStateProvider.formDataListElectricityMeters[index]['meterRemovalDateElectricity'],
                                        keyboardType: "none",
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
                                                            showDialog<String>(context: context, builder: (BuildContext context) => AlertDialog(
                                                              title: const Text('Remove?'),
                                                              content: const Text('Are you sure you want to remove this form?',style: TextStyle(fontWeight: FontWeight.bold,letterSpacing: 1)),
                                                              actions: <Widget>[
                                                                TextButton(
                                                                  onPressed: () {
                                                                    appStateProvider.removeSubFormElectricityMeters(index, subIndex);
                                                                    Navigator.pop(context);
                                                                  },
                                                                  child: const Text('YES'),
                                                                ),
                                                                TextButton(
                                                                  onPressed: () => Navigator.pop(context, 'NO'),
                                                                  child: const Text('NO'),
                                                                ),
                                                              ],
                                                            ));
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
                                                            appStateProvider.fieldDataCheckWhenClickAddButtonElectricity(context);
                                                            if(appStateProvider.isCheckDataElectricity == true){
                                                              appStateProvider.addSubFormElectricityMeters(index);
                                                            }
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
                                                  hintText: "Meter Register Id",
                                                  required: "required",
                                                  maxLength: 2,
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
                                                  required: "required",
                                                  maxLength: 1,
                                                  controller: appStateProvider.formDataListElectricityMeters[index]['registers'][subIndex]['registerTypeElectricity'],
                                                ),
                                                const SizedBox(height: 10),
                                                ElectricityTextFieldWidget(
                                                  hintText: "Number Of Digits",
                                                  required: "required",
                                                  maxLength: 14,
                                                  keyboardType: "number",
                                                  controller: appStateProvider.formDataListElectricityMeters[index]['registers'][subIndex]['numberOfDigitsElectricity'],
                                                ),
                                                const SizedBox(height: 10),
                                                ElectricityTextFieldWidget(
                                                  hintText: "Measurement Quantity",
                                                  required: "required",
                                                  maxLength: 2,
                                                  controller: appStateProvider.formDataListElectricityMeters[index]['registers'][subIndex]['measurementQuantityElectricity'],
                                                ),
                                                const SizedBox(height: 10),
                                                ElectricityTextFieldWidget(
                                                  hintText: "Multiplier",
                                                  required: "required",
                                                  keyboardType: "number",
                                                  controller: appStateProvider.formDataListElectricityMeters[index]['registers'][subIndex]['multiplierElectricity'],
                                                ),
                                                const SizedBox(height: 10),
                                                ElectricityTextFieldWidget(
                                                  hintText: "Register Reading",
                                                  required: "required",
                                                  keyboardType: "number",
                                                  controller: appStateProvider.formDataListElectricityMeters[index]['registers'][subIndex]['registerReadingElectricity'],
                                                ),
                                                const SizedBox(height: 10),
                                                ElectricityTextFieldWidget(
                                                  hintText: "Reading Type",
                                                  required: "required",
                                                  maxLength: 1,
                                                  controller: appStateProvider.formDataListElectricityMeters[index]['registers'][subIndex]['readingTypeElectricity'],
                                                ),
                                                const SizedBox(height: 10),
                                                ElectricityTextFieldWidget(
                                                  hintText: "Reading Not Valid Reason Code",
                                                  required: "required",
                                                  maxLength: 2,
                                                  controller: appStateProvider.formDataListElectricityMeters[index]['registers'][subIndex]['readingNotValidReasonCodeElectricity'],
                                                ),
                                                const SizedBox(height: 10),
                                                ElectricityTextFieldWidget(
                                                  hintText: "Prepayment Unit Rate",
                                                  required: "required",
                                                  keyboardType: "number",
                                                  controller: appStateProvider.formDataListElectricityMeters[index]['registers'][subIndex]['prepaymentUnitRateElectricity'],
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
                                                                      showDialog<String>(context: context, builder: (BuildContext context) => AlertDialog(
                                                                        title: const Text('Remove?'),
                                                                        content: const Text('Are you sure you want to remove this form?',style: TextStyle(fontWeight: FontWeight.bold,letterSpacing: 1)),
                                                                        actions: <Widget>[
                                                                          TextButton(
                                                                            onPressed: () {
                                                                              appStateProvider.removeSubSubFormElectricityMeters(index, subIndex, subSubIndex);
                                                                              Navigator.pop(context);
                                                                            },
                                                                            child: const Text('YES'),
                                                                          ),
                                                                          TextButton(
                                                                            onPressed: () => Navigator.pop(context, 'NO'),
                                                                            child: const Text('NO'),
                                                                          ),
                                                                        ],
                                                                      ));
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
                                                                      appStateProvider.fieldDataCheckWhenClickAddButtonElectricity(context);
                                                                      if(appStateProvider.isCheckDataElectricity == true){
                                                                        appStateProvider.addSubSubFormElectricityMeters(index, subIndex);
                                                                      }
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
                                                            required: "required",
                                                            maxLength: 5,
                                                            controller: appStateProvider.formDataListElectricityMeters[index]['registers'][subIndex]['timePatterns'][subSubIndex]['timePatternRegimeElectricity'],
                                                          ),
                                                          const SizedBox(height: 10),
                                                          ElectricityTextFieldWidget(
                                                            hintText: "Settlement Map Coefficient",
                                                            required: "required",
                                                            keyboardType: "number",
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
                                appStateProvider.fieldDataCheck(context);
                                appStateProvider.fieldDataCheckElectricity(context);
                                if(appStateProvider.isCheckData == true && appStateProvider.isCheckDataElectricity == true){
                                  if(!isSubmit){
                                    AppConstants.showSuccessToast(context, "Wait a Few seconds...");
                                    setState(() {
                                      isSubmit = true;
                                    });
                                    appStateProvider.saveSapphireGasFlow(context,widget.customerID,widget.appointmentId,"BOTH");
                                  }
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
            ],
          ),
        ),
      ),
    );
  }
}