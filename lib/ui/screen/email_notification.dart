// @dart=2.9

import 'package:enstaller/core/constant/app_colors.dart';
import 'package:enstaller/core/constant/app_string.dart';
import 'package:enstaller/core/constant/appconstant.dart';
import 'package:enstaller/core/constant/size_config.dart';
import 'package:enstaller/core/enums/view_state.dart';
import 'package:enstaller/core/model/email_notification_model.dart';
import 'package:enstaller/core/provider/base_view.dart';
import 'package:enstaller/core/viewmodel/email_notification_viewmodel.dart';
import 'package:enstaller/ui/screen/email_notification_view.dart';
import 'package:enstaller/ui/screen/widget/appointment/appointment_data_row.dart';
import 'package:enstaller/ui/shared/app_drawer_widget.dart';
import 'package:enstaller/ui/shared/appbuttonwidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EmailNotificationScreen extends StatefulWidget {
  @override
  _EmailNotificationScreenState createState() => _EmailNotificationScreenState();
}

class _EmailNotificationScreenState extends State<EmailNotificationScreen> {
  //Declaration of scaffold key
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // FlutterStatusbarcolor.setStatusBarColor(AppColors.appThemeColor);
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light));
    return BaseView<EmailNotificationViewModel>(
      onModelReady: (model) => model.getEmailNotificationList(),
      builder: (context, model, child) {
        return Scaffold(
            backgroundColor: AppColors.scafoldColor,
            key: _scaffoldKey,
            drawer: Drawer(
              child: AppDrawerWidget(),
            ),
            appBar: AppBar(
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
                      decoration:
                          InputDecoration(hintText: AppStrings.searchHere),
                      onChanged: (val) {
                        model.onSearch(val);
                      },
                    )
                  : Text(
                      AppStrings.emailnotification,
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
                // Icon(
                //   Icons.notifications_none,
                //   size: MediaQuery.of(context).size.height * 0.035,
                // ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.04,
                ),
              ],
            ),
            body: model.state == ViewState.Busy
                ? AppConstants.circulerProgressIndicator()
                : RefreshIndicator(
                    onRefresh: () => Future.delayed(Duration.zero)
                        .whenComplete(() => model.getEmailNotificationList()),
                    child: ConstrainedBox(
                        constraints: BoxConstraints(
                            maxHeight: MediaQuery.of(context).size.height),
                        child: (model.emailNotificationList.isNotEmpty == true)
                            ? Padding(
                                padding: SizeConfig.padding,
                                child: ListView.builder(
                                  itemCount: model.emailNotificationList.length,
                                  itemBuilder: (context, i) {
                                    return Padding(
                                      padding: SizeConfig.verticalC13Padding,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: AppColors
                                                .appointmentBackGroundColor,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Column(
                                          children: [
                                            _engineerInfo(
                                                model.emailNotificationList[i]),
//                                Divider(
//                                  color: AppColors.darkGrayColor,
//                                  thickness: 1.0,
//                                ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )
                            : Center(child: Text(AppStrings.noDataFound))),
                  ));
      },
    );
  }

  // engineer info
  Widget _engineerInfo(EmailNotificationModel appointment) {
    return Column(
      children: [
        AppointmentDataRow(
          firstText: AppStrings.Date,
          secondText: AppConstants.formattedSingeDate(
                  DateTime.parse(appointment?.dteCreatedDate)) ??
              "",
        ),
        AppointmentDataRow(
          firstText: AppStrings.appointmentNo,
          secondText: appointment?.intAppointmentId.toString() ?? "",
        ),
        AppointmentDataRow(
          firstText: AppStrings.Email,
          secondText: appointment?.strEmail ?? "",
        ),
        AppointmentDataRow(
          firstText: AppStrings.customer,
          secondText: appointment?.customerName ?? "",
        ),
        AppointmentDataRow(
          firstText: AppStrings.Page,
          secondText: appointment?.strPageName ?? "",
        ),
        AppointmentDataRow(
          firstText: AppStrings.supplier,
          secondText: appointment?.supplierCompany ?? "",
        ),
        AppointmentDataRow(
          firstText: AppStrings.Engineer,
          secondText: appointment?.engineerName ?? "",
        ),
        AppointmentDataRow(
          firstText: AppStrings.ActionBy,
          secondText: appointment?.strActionby ?? "",
        ),
        ClipRRect(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(7), bottomRight: Radius.circular(7)),
          child: AppButton(
            buttonText: AppStrings.viewemail,
            color: AppColors.appThemeColor,
            textStyle: TextStyle(
                color: AppColors.whiteColor, fontWeight: FontWeight.bold),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => EmailView(
                        html: appointment?.strMailContent ?? "",
                      )));
            },
          ),
        ),
      ],
    );
  }

  //survey info

  TextStyle getTextStyle({Color color, bool isBold = false, num fontSize}) {
    return TextStyle(
        color: color,
        fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
        fontSize: fontSize);
  }
}
