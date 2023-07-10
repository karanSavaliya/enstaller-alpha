//@dart=2.9
import 'package:enstaller/ui/screen/widget/electricity/electricity_text_field_widget.dart';
import 'package:flutter/material.dart';
import '../../core/constant/app_colors.dart';
import '../../core/constant/app_string.dart';
import '../../core/constant/image_file.dart';
import '../../core/constant/size_config.dart';
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
  List<Step> _steps = [
    Step(
      title: Text('Electricity Flow'),
      content: Column(
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
        children: [
          ElectricityTextFieldWidget(
            hintText: "Appointment Date",
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
      title: Text('Step 3'),
      content: Text('Content for Step 3'),
    ),
    Step(
      title: Text('Step 4'),
      content: Text('Content for Step 4'),
    ),
    Step(
      title: Text('Step 5'),
      content: Text('Content for Step 5'),
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
  ];

  TextEditingController _textEditingController = TextEditingController();
  DateTime _selectedAppointmentDate;
  Future<void> _selectAppointmentDate() async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _selectedAppointmentDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != _selectedAppointmentDate) {
      setState(() {
        _selectedAppointmentDate = picked;
        _textEditingController.text = _selectedAppointmentDate.toString();
        print(_textEditingController.text);
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
            if (_currentStep < _steps.length - 1) {
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
        steps: _steps,
      ),
    );
  }
}