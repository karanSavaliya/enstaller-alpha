// @dart=2.9
import 'dart:async';
import 'package:configurable_expansion_tile/configurable_expansion_tile.dart';
import 'package:connectivity/connectivity.dart';
import 'package:encrypt/encrypt.dart' as AESencrypt;
import 'package:enstaller/core/constant/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:enstaller/core/constant/app_string.dart';
import 'package:enstaller/core/constant/appconstant.dart';
import 'package:enstaller/core/constant/image_file.dart';
import 'package:enstaller/core/constant/size_config.dart';
import 'package:enstaller/core/enums/view_state.dart';
import 'package:enstaller/core/model/response_model.dart';
import 'package:enstaller/core/model/send/answer_credential.dart';
import 'package:enstaller/core/model/user_model.dart';
import 'package:enstaller/core/provider/base_view.dart';
import 'package:enstaller/core/service/api_service.dart';
import 'package:enstaller/core/service/geo_service.dart';
import 'package:enstaller/core/service/pref_service.dart';
import 'package:enstaller/core/viewmodel/details_screen_viewmodel.dart';
import 'package:enstaller/ui/screen/survey.dart';
import 'package:enstaller/ui/screen/widget/appointment/appointment_data_row.dart';
import 'package:enstaller/ui/screen/widget/appointment_details/appointment_details_row_widget.dart';
import 'package:enstaller/ui/screen/widget/comment_dialog_widget.dart';
import 'package:custom_map_markers/custom_map_markers.dart';
import 'package:enstaller/ui/shared/appbuttonwidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/provider/app_state_provider.dart';
import '../shared/app_drawer_widget.dart';
import '../shared/warehouse_app_drawer.dart';

class DetailScreenArguments {
  String appointmentID;
  String strBookingReference;
  String customerID;

  DetailScreenArguments({
    this.appointmentID,
    this.strBookingReference,
    this.customerID,
  });
}

class DetailScreen extends StatefulWidget {
  static const String routeName = '/detail';
  final DetailScreenArguments arguments;

  DetailScreen({this.arguments});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final Connectivity connectivity = Connectivity();

  bool isToShowBottomBar = false;

  Map<String, String> _processid = {
    "EMREM": "6",
    "GMREM": "81",
    "GICOM": "79",
    "EICOM": "1"
  };

  Map<int, String> _smest2displaybutton = {
    0: "EMREM",
    1: "GMREM",
    2: "EMREM+GMREM",
    3: "EMREM",
    4: "EICOM",
    5: "GICON",
    6: "EICOM+GICOM",
    7: "EICOM"
  };

  Map<int, String> _disablesmest2displaybutton = {
    0: "EMREM for Electricity Generated",
    1: "GMREM for Gas Generated",
    2: "EMREM for Electricity Generated+GMREM for Gas Generated",
    3: "EMREM for Electricity Generated",
    4: "EICOM for Electricity Generated",
    5: "GICON for Gas Generated",
    6: "EICOM for Electricity Generated+GICOM for Gas Generated",
    7: "EICOM for Electricity Generated"
  };

  Map<String, int> _appointmenttype = {
    "Electric SMETS2 Meter Exchange": 0,
    "Dual SMETS2 Meter Exchange": 2,
    "Gas SMETS2 Meter Exchange": 1,
    "Emergency Exchange Electric": 0,
    "Emergency Exchange Gas": 1,
  };

  ApiService _apiService = ApiService();

  //Declaration of scaffold key
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  int selected;

  encryption(String value) {
    final key = AESencrypt.Key.fromUtf8('8080808080808080');
    final iv = AESencrypt.IV.fromUtf8('8080808080808080');
    final encrypter = AESencrypt.Encrypter(
        AESencrypt.AES(key, mode: AESencrypt.AESMode.cbc, padding: 'PKCS7'));
    final encrypted = encrypter.encrypt(value, iv: iv);

    return encrypted.base64
        .toString()
        .replaceAll('/', 'SLH')
        .replaceAll('+', 'PLS')
        .replaceAll('/', 'SLH')
        .replaceAll('/', 'SLH')
        .replaceAll('/', 'SLH')
        .replaceAll('/', 'SLH')
        .replaceAll('+', 'PLS')
        .replaceAll('+', 'PLS')
        .replaceAll('+', 'PLS')
        .replaceAll('+', 'PLS');
  }

  final List<MarkerData> _customMarkers = [];

  GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    AppStateProvider appStateProvider = Provider.of<AppStateProvider>(context);
    return BaseView<DetailsScreenViewModel>(
      onModelReady: (model) => model.initializeData(
          widget.arguments.appointmentID, widget.arguments.customerID),
      builder: (context, model, child) {
        model.checkifEnrouted(); //KARAN (ADD THIS ON LIVE)
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
                      color: AppColors.whiteColor,
                    )),
              ),
              title: Text(
                "${AppStrings.APPOINTMENT_DETAILS}",
                style: TextStyle(color: AppColors.whiteColor),
              ),
              centerTitle: true,
            ),
            body: model.state == ViewState.Busy
                ? AppConstants.circulerProgressIndicator()
                : RefreshIndicator(
                    onRefresh: () => Future.delayed(Duration.zero).whenComplete(
                        () => model.initializeData(
                            widget.arguments.appointmentID,
                            widget.arguments.customerID)),
                    child: SingleChildScrollView(
                      physics: const ScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      child: Column(
                        children: [
                          _engineerInfo(model),
                          _surveyInfo(
                              model,
                              appStateProvider,
                              widget.arguments.appointmentID,
                              widget.arguments.customerID),
                          Padding(
                            padding: SizeConfig.padding,
                            child: ListView.builder(
                                key: Key('builder ${selected.toString()}'),
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: 5,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext ctxt, int index) {
                                  return ConfigurableExpansionTile(
                                      key: Key(index.toString()),
                                      initiallyExpanded: index == selected,
                                      header: Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: 20,
                                              top: 20,
                                              bottom: 10,
                                              right: 20),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(
                                                _getHeaderText(index),
                                                style: getTextStyle(
                                                    color: Colors.white,
                                                    isBold: true,
                                                    fontSize: 16.0),
                                              ),
                                              Icon(
                                                Icons.add,
                                                color: AppColors.whiteColor,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      headerBackgroundColorStart:
                                          AppColors.appThemeColor,
                                      headerBackgroundColorEnd:
                                          AppColors.appThemeColor,
                                      onExpansionChanged: (value) {
                                        if (value) {
                                          setState(() {
                                            selected = index;
                                          });
                                          if (value == true && index == 4) {
                                            setState(() {
                                              isToShowBottomBar = true;
                                            });
                                          } else {
                                            setState(() {
                                              isToShowBottomBar = false;
                                            });
                                          }
                                        } else {
                                          setState(() {
                                            isToShowBottomBar = false;
                                            selected = -1;
                                          });
                                        }
                                      },
                                      headerExpanded: Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: 20,
                                              top: 20,
                                              bottom: 10,
                                              right: 20),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(
                                                _getHeaderText(index),
                                                style: getTextStyle(
                                                    color: Colors.white,
                                                    isBold: true,
                                                    fontSize: 16.0),
                                              ),
                                              RotatedBox(
                                                  quarterTurns: 2,
                                                  child: Icon(
                                                    Icons.remove,
                                                    color: AppColors.whiteColor,
                                                  ))
                                            ],
                                          ),
                                        ),
                                      ),
                                      children: [
                                        _getChildrenWidget(selected, model)
                                      ]);
                                }),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "AVAILABLE ACTION",
                            textAlign: TextAlign.start,
                            style: TextStyle(fontWeight: FontWeight.normal),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          if (model.appointmentDetails.appointment
                                      .appointmentEventType ==
                                  "Scheduled" ||
                              model.appointmentDetails.appointment
                                      .appointmentEventType ==
                                  "Rescheduled")
                            Padding(
                              padding: SizeConfig.sidepadding,
                              child: AppButton(
                                height: 40,
                                color: AppColors.darkBlue,
                                buttonText: model.appointmentDetails.appointment
                                            .bCompleteForwardCall ==
                                        false
                                    ? AppStrings.forward_button
                                    : AppStrings.forward_button_completed,
                                radius: 15,
                                textStyle:
                                    TextStyle(color: AppColors.whiteColor),
                                onTap: () async {
                                  UserModel user = await Prefs.getUser();
                                  ResponseModel responseModel =
                                      await _apiService
                                          .updateCallForwardAppointment(
                                              widget.arguments.appointmentID
                                                  .trim(),
                                              user.intCompanyId);
                                  print(responseModel.statusCode.toString() +
                                      "......line373");
                                  if (responseModel.statusCode == 1) {
                                    model.initializeData(
                                        widget.arguments.appointmentID,
                                        widget.arguments.customerID);
                                  }
                                },
                              ),
                            ),
                          if (model.appointmentDetails.appointment
                                  .appointmentEventType ==
                              "Scheduled")
                            SizedBox(
                              height: 10.0,
                            ),
                          if (model.appointmentDetails.appointment
                                  .bCompleteForwardCall &&
                              (model.appointmentDetails.appointment
                                          .appointmentEventType ==
                                      "Scheduled" ||
                                  model.appointmentDetails.appointment
                                          .appointmentEventType ==
                                      "Rescheduled"))
                            Padding(
                              padding:
                                  EdgeInsets.only(top: 10, left: 15, right: 15),
                              child: AppButton(
                                height: 40,
                                color: AppColors.darkBlue,
                                buttonText: "En Route",
                                radius: 15,
                                textStyle:
                                    TextStyle(color: AppColors.whiteColor),
                                onTap: () async {
                                  if (model.vals_enroute == "0") {
                                    model.onUpdateStatusOnRoute(context,
                                        widget.arguments.appointmentID);
                                    model.initializeData(
                                        widget.arguments.appointmentID,
                                        widget.arguments.customerID);
                                  } else {
                                    AppConstants.showFailToast(context,
                                        "There is already one enrouted Appointment for today");
                                  } //KARAN (ADD THIS ON LIVE)
                                },
                              ),
                            ),
                          if (model.showChangeAppointmentStatusButton() && model.appointmentDetails.appointment.bisAbortRequested == false && model.appointmentDetails.appointment.bisAbortRequestApproved == false)
                            Padding(
                              padding: SizeConfig.sidepadding,
                              child: AppButton(
                                height: 40,
                                color: AppColors.darkBlue,
                                buttonText: AppStrings.change_appointment_status_button,
                                radius: 15,
                                textStyle: TextStyle(color: AppColors.whiteColor),
                                onTap: () async {
                                  bool status = await model.onUpdateStatusOnSchedule(context, widget.arguments.appointmentID);
                                  if (status) {
                                    model.initializeData(widget.arguments.appointmentID, widget.arguments.customerID);
                                  }
                                },
                              ),
                            ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Padding(
                            padding: SizeConfig.sidepadding,
                            child: AppButton(
                              height: 40,
                              color: AppColors.darkBlue,
                              buttonText: AppStrings.ADD_COMMENT,
                              radius: 15,
                              textStyle: TextStyle(color: AppColors.whiteColor),
                              onTap: () {
                                AppConstants.showAppDialog(
                                  context: context,
                                  child: CommentDialogWidget(
                                    appointmentID: widget.arguments.appointmentID,
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          _getDisplayButton(_checkbuttonindex(model), model),
                          SizedBox(
                            height: 20,
                          ),
                          // Padding(
                          //   padding: SizeConfig.sidepadding,
                          //   child: Container(
                          //     height: 300,
                          //     child: CustomGoogleMapMarkerBuilder(
                          //       customMarkers: _customMarkers,
                          //       builder: (BuildContext context, Set<Marker> markers) {
                          //         return GoogleMap(
                          //           padding: EdgeInsets.only(
                          //             right: 20,
                          //             top: 55,
                          //           ),
                          //           onMapCreated: _onMapCreated,
                          //           initialCameraPosition: CameraPosition(
                          //             target: LatLng(double.parse(model.latlngmap.split(",")[0]), double.parse(model.latlngmap.split(",")[1])),
                          //             zoom: 11,
                          //           ),
                          //           myLocationEnabled: true,
                          //           myLocationButtonEnabled: false,
                          //           markers: markers ?? {},
                          //           zoomControlsEnabled: false,
                          //         );
                          //       },
                          //     ),
                          //   ),
                          // ),
                          SizeConfig.verticalSpaceSmall(),
                          Padding(
                            padding: SizeConfig.sidepadding,
                            child: InkWell(
                              onTap: () async {
                                if (model.latlngmap.split(",")[0] == "0.0") {
                                  AppConstants.showFailToast(context,
                                      "Google Maps can't find ${model.postCode}");
                                } else {
                                  final location = await GeoLocationService
                                      .getAddressFromPinCode(
                                          model.customerDetails.strPostCode);
                                  String url =
                                      "http://maps.google.com/maps?q=loc:" +
                                          location
                                              .coordinates.latitude
                                              .toString() +
                                          "," +
                                          location.coordinates.longitude
                                              .toString() +
                                          " (" +
                                          model.customerDetails.strPostCode +
                                          ")";

                                  if (await canLaunch(url)) {
                                    await launch(url);
                                  } else {
                                    throw 'Could not open the map.';
                                  }
                                }
                              },
                              child: Container(
                                width: SizeConfig.screenWidth,
                                height: 40,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                        height: SizeConfig.screenHeight * .02,
                                        width: SizeConfig.screenHeight * .02,
                                        child:
                                            Image.asset(ImageFile.direction)),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      AppStrings.GET_DIRECTIONS,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.whiteColor),
                                    ),
                                  ],
                                ),
                                decoration: BoxDecoration(
                                    color: AppColors.appThemeColor,
                                    borderRadius: BorderRadius.circular(15)),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 60,
                          ),
                        ],
                      ),
                    ),
                  ));
      },
    );
  }

  int _checkbuttonindex(DetailsScreenViewModel model) {
    print("------------------------------");
    print(
        "app type =============== ${model.appointmentDetails.appointment.strAppointmentType}");
    print(
        "job type =============== ${model.appointmentDetails.appointment.strJobType}");
    print("------------------------------");
    int id;
    id = _appointmenttype[
        model.appointmentDetails.appointment.strJobType.trim()];

    return id;
  }

  Widget _getDisplayButton(int id, DetailsScreenViewModel model) {
    print("id ================================id ===============$id");
    if (id != null) {
      return Column(
        children: [
          (id != 2 && id != 6)
              ? Column(
                  children: [
                    Text(
                      "SMETS2 XMREM ACTION",
                      textAlign: TextAlign.start,
                      style: TextStyle(fontWeight: FontWeight.normal),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: SizeConfig.sidepadding,
                      child: AppButton(
                        height: 40,
                        color: !model.isformfilled[_smest2displaybutton[id]]
                            ? AppColors.darkBlue
                            : AppColors.disablebuttonColor,
                        buttonText:
                            !model.isformfilled[_smest2displaybutton[id]]
                                ? "Raise " + _smest2displaybutton[id]
                                : _disablesmest2displaybutton[id],
                        radius: !model.isformfilled[_smest2displaybutton[id]]
                            ? 15
                            : 6,
                        textStyle: TextStyle(
                            color: !model.isformfilled[_smest2displaybutton[id]]
                                ? AppColors.whiteColor
                                : AppColors.black),
                        onTap: !model.isformfilled[_smest2displaybutton[id]]
                            ? () {
                                model.onRaiseButtonPressed(
                                    widget.arguments.customerID,
                                    _processid[_smest2displaybutton[id]]);
                              }
                            : () {},
                      ),
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          "SMETS2 XCHUB ACTION",
                          textAlign: TextAlign.start,
                          style: TextStyle(fontWeight: FontWeight.normal),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        id == 0
                            ? Padding(
                                padding: SizeConfig.sidepadding,
                                child: AppButton(
                                  height: 40,
                                  color: AppColors.darkBlue,
                                  buttonText: "Raise EXCHUB",
                                  radius: 15,
                                  textStyle:
                                      TextStyle(color: AppColors.whiteColor),
                                  onTap: () {
                                    model.onRaiseButtonPressed(
                                        widget.arguments.customerID, "3");
                                  },
                                ),
                              )
                            : id == 1
                                ? Padding(
                                    padding: SizeConfig.sidepadding,
                                    child: AppButton(
                                      height: 40,
                                      color: AppColors.darkBlue,
                                      buttonText: "Raise GXCHUB",
                                      radius: 15,
                                      textStyle: TextStyle(
                                          color: AppColors.whiteColor),
                                      onTap: () {
                                        model.onRaiseButtonPressed(
                                            widget.arguments.customerID, "91");
                                      },
                                    ),
                                  )
                                : SizedBox.shrink(),
                      ],
                    ), //KARAN (ADD THIS ON LIVE)
                  ],
                )
              : Column(
                  children: [
                    Text(
                      "SMETS2 XMREM ACTION",
                      textAlign: TextAlign.start,
                      style: TextStyle(fontWeight: FontWeight.normal),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: SizeConfig.sidepadding,
                      child: AppButton(
                        height: 40,
                        color: !model.isformfilled[
                                _smest2displaybutton[id].split("+")[0]]
                            ? AppColors.darkBlue
                            : AppColors.disablebuttonColor,
                        buttonText: !model.isformfilled[
                                _smest2displaybutton[id].split("+")[0]]
                            ? "Raise " + _smest2displaybutton[id].split("+")[0]
                            : _disablesmest2displaybutton[id].split("+")[0],
                        radius: !model.isformfilled[
                                _smest2displaybutton[id].split("+")[0]]
                            ? 15
                            : 6,
                        textStyle: TextStyle(
                            color: !model.isformfilled[
                                    _smest2displaybutton[id].split("+")[0]]
                                ? AppColors.whiteColor
                                : AppColors.black),
                        onTap: !model.isformfilled[
                                _smest2displaybutton[id].split("+")[0]]
                            ? () {
                                model.onRaiseButtonPressed(
                                    widget.arguments.customerID,
                                    _processid[_smest2displaybutton[id]
                                        .split("+")[0]]);
                              }
                            : () {},
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: SizeConfig.sidepadding,
                      child: AppButton(
                        height: 40,
                        color: !model.isformfilled[
                                _smest2displaybutton[id].split("+")[1]]
                            ? AppColors.darkBlue
                            : AppColors.disablebuttonColor,
                        buttonText: !model.isformfilled[
                                _smest2displaybutton[id].split("+")[1]]
                            ? "Raise " + _smest2displaybutton[id].split("+")[1]
                            : _disablesmest2displaybutton[id].split("+")[1],
                        radius: !model.isformfilled[
                                _smest2displaybutton[id].split("+")[1]]
                            ? 15
                            : 6,
                        textStyle: TextStyle(
                            color: !model.isformfilled[
                                    _smest2displaybutton[id].split("+")[1]]
                                ? AppColors.whiteColor
                                : AppColors.black),
                        onTap: !model.isformfilled[
                                _smest2displaybutton[id].split("+")[1]]
                            ? () {
                                model.onRaiseButtonPressed(
                                    widget.arguments.customerID,
                                    _processid[_smest2displaybutton[id]
                                        .split("+")[1]]);
                              }
                            : () {},
                      ),
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          "SMETS2 XCHUB ACTION",
                          textAlign: TextAlign.start,
                          style: TextStyle(fontWeight: FontWeight.normal),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Padding(
                          padding: SizeConfig.sidepadding,
                          child: AppButton(
                            height: 40,
                            color: AppColors.darkBlue,
                            buttonText: "Raise EXCHUB",
                            radius: 15,
                            textStyle: TextStyle(color: AppColors.whiteColor),
                            onTap: () {
                              model.onRaiseButtonPressed(
                                  widget.arguments.customerID, "3");
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Padding(
                          padding: SizeConfig.sidepadding,
                          child: AppButton(
                            height: 40,
                            color: AppColors.darkBlue,
                            buttonText: "Raise GXCHUB",
                            radius: 15,
                            textStyle: TextStyle(color: AppColors.whiteColor),
                            onTap: () {
                              model.onRaiseButtonPressed(
                                  widget.arguments.customerID, "91");
                            },
                          ),
                        ),
                      ],
                    ), //KARAN (ADD THIS ON LIVE)
                  ],
                )
        ],
      );
    }
    return Container();
  }

  // engineer info
  Widget _engineerInfo(DetailsScreenViewModel model) {
    return Padding(
      padding: SizeConfig.padding,
      child: Container(
        decoration: BoxDecoration(color: AppColors.whiteColor),
        child: Column(
          children: [
            AppointmentDetailsRowWidget(
              firstText: AppStrings.appointmentStatus,
              secondChild: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 20,
                    width: 20,
                    child: SvgPicture.asset(
                        AppConstants.getStatusImageUrl(model.appointmentDetails
                            .appointment.appointmentEventType),
                        semanticsLabel: 'Status'),
                  ),
                  SizeConfig.horizontalSpaceSmall(),
                  Text(
                    model.appointmentDetails.appointment.appointmentEventType ==
                            "InRoute"
                        ? "EnRoute"
                        : model.appointmentDetails.appointment
                                .appointmentEventType ??
                            "",
                    style: getTextStyle(
                        color: AppColors.statusColor(model.appointmentDetails
                            .appointment.appointmentEventType),
                        isBold: true),
                  ),
                ],
              ),
            ),
            AppointmentDetailsRowWidget(
              firstText: AppStrings.assignedEngineer,
              secondText:
                  model.appointmentDetails.appointment.engineerName ?? "",
            ),
            AppointmentDetailsRowWidget(
              borderEnable: false,
              firstText: AppStrings.bookingReference,
              secondText:
                  model.appointmentDetails.appointment.strBookingReference ??
                      "",
            ),
          ],
        ),
      ),
    );
  }

  //survey info
  Widget _surveyInfo(
      DetailsScreenViewModel model,
      AppStateProvider appStateProvider,
      String intAppointmentId,
      String customerID) {
    return Padding(
      padding: SizeConfig.padding,
      child: Container(
        decoration: BoxDecoration(color: AppColors.whiteColor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppointmentDetailsRowWidget(
              firstText: AppStrings.supplier,
              secondChild: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    model.appointmentDetails.appointment.strCompanyName,
                    textAlign: TextAlign.right,
                    style: getTextStyle(color: AppColors.black, isBold: true),
                  ),
                ],
              ),
            ),
            AppointmentDetailsRowWidget(
              firstText: AppStrings.appointmentSurvey,
              secondChild: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (model.appointmentDetails.appointment.strJobType.trim() !=
                          "Full Day Hire" &&
                      model.appointmentDetails.appointment.strJobType.trim() !=
                          "Half Day Hire")
                    AppButton(
                      color: model.isSurveyEnable() &&
                              model.appointmentDetails.appointment
                                      .appointmentEventType !=
                                  "Rescheduled" &&
                              (model.appointmentDetails.appointment
                                          .bisAbortRequested ==
                                      false &&
                                  model.appointmentDetails.appointment
                                          .bisAbortRequestApproved ==
                                      false)
                          ? AppColors.appThemeColor
                          : Colors.grey,
                      height: 30,
                      width: SizeConfig.screenWidth * .23,
                      buttonText: AppStrings.SURVEY,
                      textStyle: TextStyle(color: AppColors.whiteColor),
                      radius: 15,
                      onTap: () async {
                        await appStateProvider.getLastAppointmentStatusList(
                            widget.arguments.appointmentID);

                        if (appStateProvider.lastAppointmentStatus ==
                            "Cancelled") {
                          AppConstants.showFailToast(context,
                              "Appointment has been cancelled so cannot proceed further!");
                        } else {
                          if (model.customerDetails.bisSurveyBackoffice ==
                              true) {
                            AppConstants.showFailToast(
                                context, "Survey Transfer To Back Office");
                          } else {
                            if (model.appointmentDetails.appointment
                                        .bisAbortRequested ==
                                    true &&
                                model.appointmentDetails.appointment
                                        .bisAbortRequestApproved ==
                                    false) {
                              AppConstants.showFailToast(context,
                                  "You can not start survey as abort survey is requested");
                            } else if (model.appointmentDetails.appointment
                                        .bisAbortRequested ==
                                    true &&
                                model.appointmentDetails.appointment
                                        .bisAbortRequestApproved ==
                                    true) {
                              AppConstants.showFailToast(context,
                                  "You can not start survey as this survey is aborted");
                            } else {
                              if (model.isSurveyEnable() &&
                                  model.appointmentDetails.appointment
                                          .appointmentEventType !=
                                      "Rescheduled") {
                                bool _isedit = model.appointmentDetails
                                            .appointment.surveyReceived ==
                                        AppStrings.yes
                                    ? true
                                    : false;
                                String _status = model.appointmentDetails
                                        .appointment.appointmentEventType ??
                                    "";
                                if (!_isedit && _status != "OnSite")
                                  model.onUpdateStatusOnSite(
                                      context, widget.arguments.appointmentID);

                                Navigator.of(context)
                                    .pushNamed(SurveyScreen.routeName,
                                        arguments: SurveyArguments(
                                            correlationId: model
                                                .appointmentDetails
                                                .appointment
                                                .strBookingReference,
                                            jobType: model.appointmentDetails
                                                .appointment.strJobType,
                                            customerID:
                                                widget.arguments.customerID,
                                            dsmodel: model,
                                            appointmentID:
                                                widget.arguments.appointmentID,
                                            edit: model
                                                        .appointmentDetails
                                                        .appointment
                                                        .surveyReceived ==
                                                    AppStrings.yes
                                                ? true
                                                : false))
                                    .then((value) {
                                  if (GlobalVar.isloadAppointmentDetail) {
                                    model.initializeData(
                                        widget.arguments.appointmentID,
                                        widget.arguments.customerID);
                                    GlobalVar.isloadAppointmentDetail = false;
                                  }
                                });
                              }
                            }
                          }
                        }
                      },
                    )
                ],
              ),
            ),
            model.appointmentDetails.appointment.appointmentEventType ==
                    "OnSite"
                ? AppointmentDetailsRowWidget(
                    firstText: AppStrings.transferToBackOfficeSurvey,
                    secondChild: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        model.customerDetails.bisSurveyBackoffice == false
                            ? AppButton(
                                color: AppColors.appThemeColor,
                                height: 30,
                                width: SizeConfig.screenWidth * .23,
                                buttonText: AppStrings.TRANSFER,
                                textStyle:
                                    TextStyle(color: AppColors.whiteColor),
                                radius: 15,
                                onTap: () {
                                  _showMyDialog(model, intAppointmentId,
                                      appStateProvider, customerID);
                                },
                              )
                            : AppButton(
                                color: Colors.grey,
                                height: 30,
                                width: SizeConfig.screenWidth * .23,
                                buttonText: AppStrings.TRANSFER,
                                textStyle:
                                    TextStyle(color: AppColors.whiteColor),
                                radius: 15,
                                onTap: () {
                                  AppConstants.showFailToast(context,
                                      "Already Survey Transfer To Back Office");
                                },
                              ),
                      ],
                    ),
                  )
                : Container(), //KARAN (ADD THIS ON LIVE)
            AppointmentDetailsRowWidget(
              firstText: AppStrings.surveyReceived,
              secondText: model.appointmentDetails.appointment.surveyReceived,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showMyDialog(
      DetailsScreenViewModel model,
      String intAppointmentId,
      AppStateProvider appStateProvider,
      String customerID) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Close Down Jobs',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              fontSize: 20,
            ),
          ),
          content: Text(
            "Are You Sure Close Down Jobs From Back Office??",
            style: TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 15,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Yes',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () async {
                bool success = await appStateProvider
                    .updateBackOfficeStatus(intAppointmentId);
                if (success) {
                  AppConstants.showSuccessToast(
                      context, "Survey Transfer To Back Office Successfully");
                  Navigator.of(context).pop();
                  Future.delayed(Duration.zero).whenComplete(() =>
                      model.initializeData(widget.arguments.appointmentID,
                          widget.arguments.customerID));
                } else {
                  Navigator.of(context).pop();
                  AppConstants.showFailToast(
                      context, "Survey Transfer To Back Office Failed");
                }
              },
            ),
            TextButton(
              child: Text(
                'No',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  TextStyle getTextStyle({Color color, bool isBold = false, num fontSize}) {
    return TextStyle(
        color: color,
        fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
        fontSize: fontSize);
  }

  String _getHeaderText(int index) {
    switch (index) {
      case 0:
        return AppStrings.appointmentInformation;
        break;
      case 1:
        return AppStrings.customerDetail;
        break;
      case 2:
        return AppStrings.electricMeterInformation;
        break;
      case 3:
        return AppStrings.gasMeterInformation;
        break;
      case 4:
        return AppStrings.activityDetail;
        break;
    }
  }

  //get widgets data  as per text
  Widget _getChildrenWidget(int index, DetailsScreenViewModel model) {
    switch (index) {
      case 0:
        return _basicInfo(model);
      case 1:
        return _customerDetail(model);
      case 2:
        return _electricityInfo(model);
      case 3:
        return gasMeterData(model);
      case 4:
        return _activityData(model);
    }
    return (index == 4) ? _activityData(model) : _basicInfo(model);
  }

  //_demo data
  Widget _basicInfo(DetailsScreenViewModel model) {
    return Container(
      decoration: BoxDecoration(color: AppColors.expandedColor),
      child: Column(
        children: [
          AppointmentDataRow(
            firstText: AppStrings.date,
            secondText: AppConstants.formattedSingeDate(DateTime.parse(
                    model.appointmentDetails.appointment?.dteBookedDate)) ??
                "",
          ),
          AppointmentDataRow(
            firstText: AppStrings.timeSlot,
            secondText:
                model.appointmentDetails.appointment?.strBookedTime ?? "",
          ),
          AppointmentDataRow(
            firstText: AppStrings.workType,
            secondText:
                model.appointmentDetails.appointment.strAppointmentType +
                        ">" +
                        model.appointmentDetails.appointment?.strJobType ??
                    "",
          ),
          AppointmentDataRow(
              firstText: AppStrings.bookOn,
              secondText: AppConstants.getDateTime(
                  model.appointmentDetails.appointment?.dteCreatedDate)),
          AppointmentDataRow(
            firstText: AppStrings.bookBy,
            secondText: model.appointmentDetails.appointment?.strBookedBy ?? "",
          ),
        ],
      ),
    );
  }

  Widget _activityData(DetailsScreenViewModel model) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  height: 60,
                  color: AppColors.appThemeColor,
                  child: Center(
                      child: Text(
                    AppStrings.dateAndTime,
                    style: getTextStyle(color: Colors.white, isBold: true),
                  )),
                ),
              ),
              SizedBox(
                width: 2,
              ),
              Expanded(
                flex: 2,
                child: Container(
                  height: 60,
                  color: AppColors.appThemeColor,
                  child: Center(
                      child: Text(
                    AppStrings.user,
                    style: getTextStyle(color: Colors.white, isBold: true),
                  )),
                ),
              ),
              SizedBox(
                width: 2,
              ),
              Expanded(
                flex: 3,
                child: Container(
                  height: 60,
                  color: AppColors.appThemeColor,
                  child: Center(
                      child: Text(
                    AppStrings.comment,
                    style: getTextStyle(color: Colors.white, isBold: true),
                  )),
                ),
              )
            ],
          ),
        ),
        Container(
          color: Colors.transparent,
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: model.activityDetailsList.length,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext ctxt, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          height: 60,
                          color: Colors.grey[300],
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                AppConstants.getDateTime(model
                                    .activityDetailsList[index].dteCreatedDate),
                                textAlign: TextAlign.center),
                          )),
                        ),
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          height: 60,
                          color: Colors.grey[300],
                          child: Center(
                              child: Text(
                                  model.activityDetailsList[index].strUserName,
                                  textAlign: TextAlign.center)),
                        ),
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          height: 60,
                          color: Colors.grey[300],
                          child: Row(
                            children: [
                              SizeConfig.horizontalSpaceSmall(),
                              SizedBox(
                                height: 10,
                                width: 10,
                                child: SvgPicture.asset(
                                    AppConstants.getStatusImageUrl(
                                        AppConstants.getStatusFromStrEventType(
                                            model.activityDetailsList[index]
                                                .strEventType,
                                            model.activityDetailsList[index]
                                                .strComment)),
                                    semanticsLabel: 'Status'),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Flexible(
                                child: Text(
                                  model.activityDetailsList[index].strComment,
                                  textAlign: TextAlign.center,
                                  style: getTextStyle(
                                      color: Colors.black, isBold: true),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget _customerDetail(DetailsScreenViewModel model) {
    return Container(
      decoration: BoxDecoration(color: AppColors.expandedColor),
      child: Column(
        children: [
          AppointmentDataRow(
            firstText: AppStrings.name,
            secondText: "${model.customerDetails.customerName ?? ""}",
          ), //KARAN (ADD THIS ON LIVE)
          AppointmentDataRow(
            firstText: AppStrings.contactName,
            secondText: "${model.customerDetails.strContactName ?? ""}",
          ),
          AppointmentDataRow(
            firstText: AppStrings.contactNumber,
            secondText: model.customerDetails.strContactTelephone ?? '',
          ),
          AppointmentDataRow(
            firstText: AppStrings.email,
            secondText: model.customerDetails.strEmail != null
                ? model.customerDetails.strEmail
                : '',
          ),
          AppointmentDataRow(
            firstText: AppStrings.address,
            secondText: model.customerDetails.strAddress ?? "",
          ),
          AppointmentDataRow(
            firstText: AppStrings.postCode,
            secondText: model.customerDetails.strPostCode ?? "",
          ),
          AppointmentDataRow(
            firstText: AppStrings.accountNumber,
            secondText: model.customerDetails.strAccountNumber ?? "",
          ),
        ],
      ),
    );
  }

  Widget gasMeterData(DetailsScreenViewModel model) {
    return Container(
      decoration: BoxDecoration(color: AppColors.expandedColor),
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: model.gasMeterList.length,
        itemBuilder: (context, i) {
          if (model.gasMeterList[i].strFuel == AppStrings.GAS) {
            return Column(
              children: [
                AppointmentDataRow(
                  firstText: AppStrings.meterMode,
                  secondText: model.gasMeterList[i].strFuel ?? "",
                ),
                AppointmentDataRow(
                  firstText: AppStrings.mPRN,
                  secondText: model.gasMeterList[i].strMpan ?? "",
                ),
                AppointmentDataRow(
                  firstText: AppStrings.meterSerialNo,
                  secondText: model.gasMeterList[i].strMeterSerialNo ?? "",
                ),
                AppointmentDataRow(
                  firstText: AppStrings.pressure,
                  secondText: "",
                ),
              ],
            );
          }
          if (model.gasMeterList.length != 2)
            return Column(
              children: [
                AppointmentDataRow(
                  firstText: AppStrings.meterMode,
                  secondText: '',
                ),
                AppointmentDataRow(
                  firstText: AppStrings.mPRN,
                  secondText: '',
                ),
                AppointmentDataRow(
                  firstText: AppStrings.meterSerialNo,
                  secondText: '',
                ),
                AppointmentDataRow(
                  firstText: AppStrings.pressure,
                  secondText: '',
                ),
              ],
            );
          else {
            return SizedBox();
          }
        },
      ),
    );
  }

  Widget _electricityInfo(DetailsScreenViewModel model) {
    return Container(
      decoration: BoxDecoration(color: AppColors.expandedColor),
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: model.electricMeterList.length,
        itemBuilder: (context, i) {
          if (model.electricMeterList[i].strFuel == AppStrings.ELECTRICITY) {
            return Column(
              children: [
                AppointmentDataRow(
                  firstText: AppStrings.meterMode,
                  secondText: model.electricMeterList[i].strFuel ?? "",
                ),
                AppointmentDataRow(
                  firstText: AppStrings.mPAN,
                  secondText: model.electricMeterList[i].strMpan ?? "",
                ),
                AppointmentDataRow(
                  firstText: AppStrings.meterSerialNo,
                  secondText: model.electricMeterList[i].strMeterSerialNo ?? "",
                ),
                AppointmentDataRow(
                  firstText: AppStrings.profileClass,
                  secondText: model.electricMeterList[i].strProfileClass ?? "",
                ),
                AppointmentDataRow(
                  firstText: AppStrings.sSC,
                  secondText: model.electricMeterList[i].strSSC ?? "",
                ),
              ],
            );
          }

          if (model.electricMeterList.length != 2)
            return Column(
              children: [
                AppointmentDataRow(
                  firstText: AppStrings.meterMode,
                  secondText: '',
                ),
                AppointmentDataRow(
                  firstText: AppStrings.mPAN,
                  secondText: '',
                ),
                AppointmentDataRow(
                  firstText: AppStrings.meterSerialNo,
                  secondText: '',
                ),
                AppointmentDataRow(
                  firstText: AppStrings.profileClass,
                  secondText: '',
                ),
                AppointmentDataRow(
                  firstText: AppStrings.sSC,
                  secondText: '',
                ),
              ],
            );
          else {
            return SizedBox();
          }
        },
      ),
    );
  }
}
