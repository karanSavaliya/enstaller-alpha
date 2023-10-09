//@dart=2.9
import 'package:enstaller/core/constant/app_colors.dart';
import 'package:enstaller/core/constant/app_string.dart';
import 'package:enstaller/core/constant/appconstant.dart';
import 'package:enstaller/core/constant/size_config.dart';
import 'package:enstaller/core/enums/view_state.dart';
import 'package:enstaller/core/model/appointmentDetailsModel.dart';
import 'package:enstaller/core/provider/base_view.dart';
import 'package:enstaller/core/viewmodel/today_appointment_viewmodel.dart';
import 'package:enstaller/ui/screen/detail_screen.dart';
import 'package:enstaller/ui/screen/maps_route_planner_plotmarker.dart';
import 'package:enstaller/ui/screen/today_appointments_planning.dart';
import 'package:enstaller/ui/screen/widget/appointment/appointment_data_row.dart';
import 'package:enstaller/ui/shared/app_drawer_widget.dart';
import 'package:enstaller/ui/shared/appbuttonwidget.dart';
import 'package:enstaller/ui/util/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodayAppointmentScreen extends StatefulWidget {
  @override
  _ApppointmentScreenState createState() => _ApppointmentScreenState();
}

class _ApppointmentScreenState extends State<TodayAppointmentScreen> {

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    setLocation();
  }

  List<String> list_lat_lng  = [];

  setLocation() async {
    final preferences = await SharedPreferences.getInstance();
   list_lat_lng =  preferences.getStringList(CommonUtils().currDate());

   if(list_lat_lng == null){
     list_lat_lng  = [];
   }

  }

  @override
  Widget build(BuildContext context) {
    return BaseView<TodayAppointmentViewModel>(
      onModelReady: (model) => model.getAppoinmentList(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: AppColors.scafoldColor,
          key: _scaffoldKey,
          drawer: Drawer(
            child: AppDrawerWidget(),
          ),
          appBar: AppBar(
            brightness: Brightness.dark,
            backgroundColor: AppColors.appThemeColor,
            leading: Padding(
              padding: const EdgeInsets.all(18.0),
              child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(Icons.arrow_back)),
            ),
            title: model.searchBool
                ? TextField(
                    controller: controller,
                    cursorColor: Colors.white,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: AppStrings.searchHere,
                      hintStyle: TextStyle(color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.white,
                      )),
                    ),
                    onChanged: (val) {
                      model.onSearch(val);
                    },
                  )
                : Text(
                    AppStrings.TODAY_APPOINTMENTS,
                    style:
                        getTextStyle(color: AppColors.whiteColor, isBold: true),
                  ),
            actions: [
              InkWell(
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Icon(
                    model.searchBool ? Icons.clear : Icons.search,
                    color: AppColors.whiteColor,
                  ),
                ),
                onTap: () {
                  model.onClickSerach();
                },
              ),
            ],
          ),
          body: model.state == ViewState.Busy
              ? AppConstants.circulerProgressIndicator()
              : RefreshIndicator(
                  onRefresh: () {
                    controller.clear();
                    return Future.delayed(Duration.zero)
                        .whenComplete(() => model.getAppoinmentList());
                  },
                  child: ConstrainedBox(
                      constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height),
                      child: (model.appointmentList.isNotEmpty == true)
                          ? Padding(
                              padding: SizeConfig.padding,
                              child: ListView.builder(
                                physics: const ScrollPhysics(
                                    parent: AlwaysScrollableScrollPhysics()),
                                itemCount: model.appointmentList.length,
                                itemBuilder: (context, i) {
                                  return Padding(
                                    padding: SizeConfig.verticalC13Padding,
                                    child: InkWell(
                                      child: model.appointmentList[i].appointmentEventType != "Cancelled" ? Container(
                                        decoration: BoxDecoration(
                                            color: AppColors
                                                .appointmentBackGroundColor,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Column(
                                          children: [
                                            _engineerInfo(
                                                model.appointmentList[i])
                                          ],
                                        ),
                                      ): Container(),
                                      onTap: () {
                                        Navigator.of(context).pushNamed(
                                            DetailScreen.routeName,
                                            arguments: DetailScreenArguments(
                                                appointmentID: model
                                                    .appointmentList[i].intId
                                                    .toString(),
                                                strBookingReference: model
                                                    .appointmentList[i]
                                                    .strBookingReference,
                                                customerID: model
                                                    .appointmentList[i]
                                                    .intCustomerId
                                                    .toString()));
                                      },
                                    ),
                                  );
                                },
                              ),
                            )
                          : Center(child: Text(AppStrings.noDataFound))),
                ),

            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
             floatingActionButton: model.appointmentList.isNotEmpty == true ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  list_lat_lng.length > 0 ?   FloatingActionButton.extended(
                    onPressed: () async {

                      Navigator.of(context).pushNamed(MapsPage.route,
                          arguments: MapRoutes(pincodes: list_lat_lng , firstloc: list_lat_lng[0]));

                    },
                    backgroundColor: Colors.blue,
                    label: const Text('View Route'),
                    icon: const Icon(Icons.navigation_sharp),
                  ) : Container(),
                  FloatingActionButton.extended(
                    onPressed: () {
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (context) => TodayAppointmentPlanningScreen()));
                    },
                    backgroundColor: Colors.green,
                    label: const Text('Get Route'),
                    icon: const Icon(Icons.navigation_sharp),
                  )
                ],
              ),
            ) : Container(),
        );
      },
    );
  }

  Widget _engineerInfo(Appointment appointment) {
    return Column(
      children: [
        AppointmentDataRow(
          firstText: AppStrings.bookingReference,
          secondText: appointment?.strBookingReference ?? "",
        ),
        AppointmentDataRow(
          firstText: AppStrings.supplier,
          secondText: appointment?.strCompanyName ?? "",
        ),
        AppointmentDataRow(
          firstText: AppStrings.subRegion,
          secondText: appointment?.patchCode ?? "",
        ),
        AppointmentDataRow(
          firstText: AppStrings.postCode,
          secondText: appointment?.strPostCode ?? "",
        ),
        AppointmentDataRow(
          firstText: AppStrings.date,
          secondText: appointment?.dteBookedDate != null
              ? AppConstants.formattedSingeDate(
                      DateTime.parse(appointment?.dteBookedDate)) ??
                  ""
              : '',
        ),
        AppointmentDataRow(
          firstText: AppStrings.timeSlot,
          secondText: appointment?.strBookedSlotType ?? "",
        ),
        AppointmentDataRow(
          firstText: AppStrings.workType,
          secondText: appointment?.strJobType ?? "",
        ),
        AppointmentDataRow(
          firstText: AppStrings.bookOn,
          secondText: AppConstants.getDateTime(appointment?.dteCreatedDate) ,
        ),
        AppointmentDataRow(
          firstText: AppStrings.bookBy,
          secondText: appointment?.strBookedBy ??  "",
        ),
        AppointmentDataRow(
          firstText: AppStrings.status,
          secondChild: Row(
            children: [
              SizedBox(
                height: 20,
                width: 20,
                child: SvgPicture.asset(
                    AppConstants.getStatusImageUrl(
                        appointment?.appointmentEventType),
                    semanticsLabel: 'Status'),
              ),
              SizeConfig.horizontalSpaceSmall(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  appointment?.appointmentEventType ?? "",
                  textAlign: TextAlign.left,
                  style: getTextStyle(
                      color: AppColors.statusColor(
                          appointment.appointmentEventType),
                      isBold: false),
                ),
              ),
            ],
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(7), bottomRight: Radius.circular(7)),
          child: AppButton(
            buttonText: AppStrings.view,
            color: AppColors.appThemeColor,
            textStyle: TextStyle(
                color: AppColors.whiteColor, fontWeight: FontWeight.bold),
            onTap: () {
              Navigator.of(context).pushNamed(DetailScreen.routeName,
                  arguments: DetailScreenArguments(
                      appointmentID: appointment.intId.toString(),
                      strBookingReference: appointment.strBookingReference,
                      customerID: appointment.intCustomerId.toString()));
            },
          ),
        ),
      ],
    );
  }

  TextStyle getTextStyle({Color color, bool isBold = false, num fontSize}) {
    return TextStyle(
        color: color,
        fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
        fontSize: fontSize);
  }
} //KARAN (ADD THIS ON LIVE)