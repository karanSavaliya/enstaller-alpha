// @dart=2.9

import 'dart:async';
import 'dart:convert';
import 'package:connectivity/connectivity.dart';
import 'package:enstaller/core/constant/app_colors.dart';
import 'package:enstaller/core/constant/app_string.dart';
import 'package:enstaller/core/constant/appconstant.dart';
import 'package:enstaller/core/constant/image_file.dart';
import 'package:enstaller/core/constant/size_config.dart';
import 'package:enstaller/core/enums/view_state.dart';
import 'package:enstaller/core/model/appointmentDetailsModel.dart';
import 'package:enstaller/core/model/send/answer_credential.dart';
import 'package:enstaller/core/provider/base_view.dart';
import 'package:enstaller/core/viewmodel/home_screen_viewmodel.dart';
import 'package:enstaller/core/viewmodel/survey_screen_viewmodel.dart';
import 'package:enstaller/ui/screen/widget/homescreen/home_page_list_widget.dart';
import 'package:enstaller/ui/screen/widget/homescreen/homepage_expandsion_widget.dart';
import 'package:enstaller/ui/screen/widget/homescreen/view_appointment_list_widget.dart';
import 'package:enstaller/ui/screen/widget/homescreen/view_single_date_widget.dart';
import 'package:enstaller/ui/shared/app_drawer_widget.dart';
import 'package:enstaller/ui/shared/warehouse_app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;

  DateTime selectedDate = DateTime.now();
  ScrollController _scrollController = new ScrollController();
  SharedPreferences preferences;
  List<Appointment> _listofappointment = [];

  _subscribeconnectivity() async {
    preferences = await SharedPreferences.getInstance();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_change);
  }

  _submitOfflineSurveyForAppointmentId(String _id) async {
    var appointmentid = _id;
    print("Start sumitting survey for --> $_id");
    List<AnswerCredential> _answerlist = [];
    String sectionName = "Not Abort";
    List<String> _listofEachKey =
        preferences.getStringList("key+$appointmentid");
    if (_listofEachKey != null) {
      _listofEachKey.forEach((element) {
        AnswerCredential answerCredential =
            AnswerCredential.fromJson(jsonDecode(element));
        _answerlist.add(answerCredential);
        if (int.parse(answerCredential.intsurveyid.trim()) == 8 ||
            int.parse(answerCredential.intsurveyid.trim()) == 10)
          sectionName = "Abort";
      });
      await SurveyScreenViewModel()
          .onSubmitOffline(appointmentid, _answerlist, sectionName);
      print("End sumitting survey for --> $appointmentid");
    }
  }

  _removeAppointmentIdFromStore(String _id) async {
    List<String> _listOfUnSubmittedForm =
        preferences.getStringList("listOfUnSubmittedForm");
    _listOfUnSubmittedForm.remove(_id);
    preferences.setStringList(
        "listOfUnSubmittedForm", _listOfUnSubmittedForm.toList());
  }

  _change(ConnectivityResult result) async {
    print("change connectivity status");
    String status = _updateConnectionStatus(result);
    if (GlobalVar.offilineSSubmittionStarted == false) {
      GlobalVar.offilineSSubmittionStarted = true;
      print("Update Global Flag for offline process start.");
      try {
        if (status != "NONE" &&
            preferences.getStringList("listOfUnSubmittedForm") != null) {
          List<String> _listOfUnSubmittedForm =
              preferences.getStringList("listOfUnSubmittedForm");
          for (int i = 0; i < _listOfUnSubmittedForm.length; i++) {
            await _submitOfflineSurveyForAppointmentId(
                _listOfUnSubmittedForm[i]);
            await _removeAppointmentIdFromStore(_listOfUnSubmittedForm[i]);
          }
        }
        GlobalVar.offilineSSubmittionStarted = false;
        print("Update Global Flag for offline process end.");
      } catch (e) {
        GlobalVar.offilineSSubmittionStarted = false;
        print("Update Global Flag for offline process end with error.");
      }

    }

    if (status == "NONE") {
      print("Reset Update Global Flag for offline process.");
      GlobalVar.offilineSSubmittionStarted = false;
    }
  }

  String _updateConnectionStatus(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.wifi:
        return "WIFI";
        break;
      case ConnectivityResult.mobile:
        return "MOBILE";
        break;
      case ConnectivityResult.none:
        return "NONE";
        break;
      default:
        return "NO RECORD";
        break;
    }
  }

  @override
  void initState() {

    _subscribeconnectivity();

    super.initState();
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.sizeConfigInit(context);
    return SafeArea(
      child: BaseView<HomeScreenViewModel>(
        onModelReady: (model) => model.getAppointmentList(),
        builder: (context, model, child) {
          _listofappointment = model.masterAppointmentList;
          model.masterAppointmentList.removeWhere((element) => element.appointmentEventType == "Cancelled" || element.appointmentEventType == "Aborted"  || element.appointmentEventType == "Completed");
          _listofappointment = model.masterAppointmentList;
          return Scaffold(
            backgroundColor: AppColors.scafoldColor,
            key: _scaffoldKey,
            drawer: Drawer(
              child: GlobalVar.roleId == 5
                  ? WareHouseDrawerWidget()
                  : AppDrawerWidget(),
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
                    )),
              ),
              title: Text(
                AppStrings.dashboard,
                style: TextStyle(
                    color: AppColors.whiteColor, fontWeight: FontWeight.w500),
              ),
              centerTitle: true,
              actions: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.04,
                ),
              ],
            ),
            body: model.state == ViewState.Busy
                ? AppConstants.circulerProgressIndicator()
                : Padding(
                    padding: SizeConfig.padding,
                    child: model.dateSelected
                        ? RefreshIndicator(

                            onRefresh: () => Future.delayed(Duration.zero)
                                .whenComplete(() { model.getAppointmentList();  print("first"); }),
                            child: SingleChildScrollView(
                              physics: const ScrollPhysics(
                                  parent: AlwaysScrollableScrollPhysics()),
                              child: ViewSingleDateWidget(
                                date: model.uniqueDates[model.selectedIndex],
                                appointmentList: model.masterAppointmentList,
                                dateString: selectedDate.year.toString() +
                                    "-" +
                                    selectedDate.month.toString() +
                                    "-" +
                                    (selectedDate.day < 9
                                        ? "0${selectedDate.day}"
                                        : (selectedDate.day).toString()),
                              ),
                            ),
                          )
                        : RefreshIndicator(
                            onRefresh: () => Future.delayed(Duration.zero)
                                .whenComplete(() { model.getAppointmentList();}),
                            child: ListView.builder(
                                physics: const ScrollPhysics(
                                    parent: AlwaysScrollableScrollPhysics()),
                                controller: _scrollController,
                                itemCount: model.uniqueDates.length,
                                itemBuilder: (context, int index) {

                                  print("herrrrrrrrrreeeeeee");
                                  return Padding(
                                    padding: SizeConfig.verticalC8Padding,
                                    child: InkWell(
                                      onTap: () {},
                                      child: BaseView<HomeScreenViewModel>(
                                        builder: (context, pModel, child) {
                                          var date = model.uniqueDates[index];
                                          String dateString = DateFormat.MMMM()
                                                  .format(date) +
                                              " " +
                                              getCurrentDay(date).toString();
                                          print("date value --- $dateString");
                                          return HomePageExpansionWidget(
                                            onTap: () {
                                              model.onSelectIndex(index);
                                            },
                                            showSecondWidget:
                                                index == model.selectedIndex,
                                            firstWidget:  HomePageListWidget(
                                              height: SizeConfig.screenHeight * .15,
                                              dateString: dateString,
                                              expanded: index == model.selectedIndex,
                                            ),
                                            secondWidget: Container(
                                              child:
                                                  BaseView<HomeScreenViewModel>(
                                                onModelReady: (cModel) =>
                                                    cModel.setTableData(
                                                        model
                                                            .uniqueDates[index],
                                                        model
                                                            .masterAppointmentList),
                                                builder: (context, secondModel,
                                                    child) {

                                                  if (secondModel.state ==
                                                      ViewState.Busy) {
                                                    return AppConstants
                                                        .circulerProgressIndicator();
                                                  }
                                                  return Container(
                                                    child: ConstrainedBox(
                                                        constraints: BoxConstraints(
                                                            maxHeight: AppConstants
                                                                .getExpandedListHeight(
                                                                    secondModel
                                                                        .tables
                                                                        .isEmpty,
                                                                    secondModel
                                                                        .tables
                                                                        .length)),
                                                        child: (secondModel
                                                                    .tables
                                                                    .length >
                                                                0)
                                                            ? ViewAppointmentListWidget(
                                                                tables: secondModel.tables,
                                                                homeScreenViewModel:
                                                                    model,
                                                              )
                                                            : Container(
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            7),
                                                                    color: Colors
                                                                        .white,
                                                                    border: Border.all(
                                                                        color: AppColors
                                                                            .lightGrayDotColor)),
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(0),
                                                                height: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    0.0,
                                                                width: double
                                                                    .infinity,
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Text(
                                                                      AppStrings
                                                                          .noDataFound),
                                                                ),
                                                              )),
                                                  );
                                                },
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  );
                                }),
                          ),
                  ),
          );
        },
      ),
    );
  }


  int daysInMonth(DateTime date) {
    var firstDayThisMonth = new DateTime(date.year, date.month, date.day);
    var firstDayNextMonth = new DateTime(firstDayThisMonth.year,
        firstDayThisMonth.month + 1, firstDayThisMonth.day);

    return firstDayNextMonth.difference(firstDayThisMonth).inDays;
  }

  int getCurrentDay(DateTime date) {
    return date.day;
  }

  int getNextDay(DateTime date) {
    final tomorrow = DateTime(date.year, date.month, date.day + 1);
    return tomorrow.day;
  }

  getNextDate(DateTime date) {
    return DateTime(date.year, date.month, date.day + 1);
  }


}
