// @dart=2.9
import 'package:enstaller/core/constant/app_colors.dart';
import 'package:enstaller/core/constant/app_string.dart';
import 'package:enstaller/core/constant/appconstant.dart';
import 'package:enstaller/core/constant/size_config.dart';
import 'package:enstaller/core/enums/view_state.dart';
import 'package:enstaller/core/model/appointmentDetailsModel.dart';
import 'package:enstaller/core/provider/base_view.dart';
import 'package:enstaller/core/viewmodel/appointment_viewmodel.dart';
import 'package:enstaller/ui/screen/detail_screen.dart';
import 'package:enstaller/ui/screen/widget/appointment/appointment_data_row.dart';
import 'package:enstaller/ui/shared/app_drawer_widget.dart';
import 'package:enstaller/ui/shared/appbuttonwidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppointmentScreen extends StatefulWidget {
  @override
  _ApppointmentScreenState createState() => _ApppointmentScreenState();
}

class _ApppointmentScreenState extends State<AppointmentScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<AppointmentViewModel>(
      onModelReady: (model) => model.getAppointmentList(),
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
              centerTitle: true,
              title: model.searchBool
                  ? TextField(
                      controller: controller,
                      cursorColor: Colors.white,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: AppStrings.searchHere,
                        hintStyle: TextStyle(color: Colors.white),
                        fillColor: Colors.white,
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
                      AppStrings.APPOINTMENTS,
                      style: getTextStyle(
                          color: AppColors.whiteColor, isBold: false),
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
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.04,
                ),
              ],
            ),
            body: model.state == ViewState.Busy
                ? AppConstants.circulerProgressIndicator()
                : RefreshIndicator(
                    onRefresh: () {
                      controller.clear();
                      return Future.delayed(Duration.zero)
                          .whenComplete(() => model.getAppointmentList());
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
                                      ) : Visibility(visible: false , child: Container(height: 0,)),
                                    );
                                  },
                                ),
                              )
                            : Center(child: Text(AppStrings.noDataFound))),
                  ));
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
          secondText: AppConstants.formattedSingeDate(
                  DateTime.parse(appointment?.dteBookedDate)) ??
              "",
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
          secondText: AppConstants.getDateTime((
              appointment?.dteCreatedDate)) ??
              "",
        ),
        AppointmentDataRow(
          firstText: AppStrings.bookBy,
          secondText: appointment?.strBookedBy ?? "",
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
}
