// @dart=2.9


import 'package:enstaller/core/constant/app_colors.dart';
import 'package:enstaller/core/constant/app_string.dart';
import 'package:enstaller/core/constant/appconstant.dart';
import 'package:enstaller/core/constant/image_file.dart';
import 'package:enstaller/core/constant/size_config.dart';
import 'package:enstaller/core/model/app_table.dart';
import 'package:enstaller/core/model/send/answer_credential.dart';
import 'package:enstaller/core/viewmodel/home_screen_viewmodel.dart';
import 'package:enstaller/ui/screen/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';


class ViewAppointmentListWidget extends StatelessWidget {

  final List<AppTable> tables;
  final HomeScreenViewModel homeScreenViewModel;
  Map<String, String> _jobtype = {
    "Dual SMETS2 Meter Exchange": "DSME",
    "Electric SMETS2 Meter Exchange": "ESME",
    "Gas SMETS2 Meter Exchange": "GSME",
    "Emergency Exchange Electric": "EEE",
    "Emergency Exchange Gas": "EEG",
    "Traditional Gas Exchange": "TGE",
    "Traditional Electric Exchange": "TEE",
    "AMR Install": "AI",
    "Site Survey": "SS",
    "Recommision": "RE",
    "Half Day Hire": "HDH",
    "Full Day Hire": "FDH"
  };

  ViewAppointmentListWidget({this.tables, this.homeScreenViewModel});


  String convertDateFormat(String dateTimeString, String oldFormat, String newFormat) {

    DateFormat newDateFormat = DateFormat(newFormat);
    DateTime dateTime = DateFormat(oldFormat).parse(dateTimeString);
    String selectedDate = newDateFormat.format(dateTime);

    return selectedDate;
  }




  @override
  Widget build(BuildContext context) {
    print('view apponintment list');
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemCount: tables.length,
      padding: EdgeInsets.all(0),
      itemBuilder: (context, childrenIndex) {
        return InkWell(
          onTap: () {

              if(tables[childrenIndex].appointmentEventType != "Cancelled") {
                Navigator.of(context)
                    .pushNamed(DetailScreen.routeName,
                    arguments: DetailScreenArguments(
                        appointmentID: tables[childrenIndex].intId.toString(),
                        strBookingReference: tables[childrenIndex].strBookingReference,
                        customerID: tables[childrenIndex].intCustomerId.toString()))
                    .then((value) {
                  // FlutterStatusbarcolor.setStatusBarColor(AppColors.appThemeColor);
                  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                      statusBarIconBrightness: Brightness.light));


                  if (GlobalVar.isloadDashboard) {
                    homeScreenViewModel.getAppointmentList();
                    GlobalVar.isloadDashboard = false;
                  }
                });
              }



          },
           child: tables[childrenIndex].appointmentEventType != "Cancelled" ? Container(
            height: SizeConfig.screenHeight * .15,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(7),
                border: Border.all(color: AppColors.lightGrayDotColor)),
            padding: EdgeInsets.all(0),
            width: double.infinity,
            child: FittedBox(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      child: Center(
                          child: Text(
                        _jobtype[(tables[childrenIndex].strJobType.trim())] ??
                            "",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: childrenIndex % 3 == 0
                              ? AppColors.thirdItemColor
                              : childrenIndex % 2 == 0
                                  ? AppColors.secondItemColor
                                  : AppColors.firstItemColor),
                    ),
                    SizeConfig.horizontalSpaceSmall(),
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              tables[childrenIndex].strContactName,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w300),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text(
                              "${AppStrings.bookingReference} : ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300),
                            ),
                            Text(
                              tables[childrenIndex].strBookingReference,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
//                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                    height: 15,
                                    child: Image.asset(ImageFile.time)),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "${AppStrings.time} : ",
                                  style: TextStyle(
                                      color: AppColors.appThemeColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12),
                                ),
                                Text(
                                  tables[childrenIndex].strBookedTime,
                                  style: TextStyle(
                                      color: AppColors.appThemeColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                  height: 15,
                                  width: 15,
                                  child: SvgPicture.asset(
                                      AppConstants.getStatusImageUrl(
                                          tables[childrenIndex]
                                              .appointmentEventType),
                                      semanticsLabel: 'Status'),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "${AppStrings.status} : ",
                                  style: TextStyle(
                                      color: AppColors.statusColor(
                                          tables[childrenIndex]
                                              .appointmentEventType),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  tables[childrenIndex].appointmentEventType ==
                                          "InRoute"
                                      ? "EnRoute"
                                      : tables[childrenIndex]
                                              .appointmentEventType ??
                                          "",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: AppColors.statusColor(
                                          tables[childrenIndex]
                                              .appointmentEventType),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                  ],
                ),
              ),
            ),
          ) :  Visibility(
           visible: false , child: Container(color: Colors.white , padding: EdgeInsets.all(10)  ,margin: EdgeInsets.only(top: 10) ,child:RichText(textScaleFactor: 1,
             text: TextSpan(
               text: " Booking Reference : "+tables[childrenIndex].strBookingReference+"\n "+ tables[childrenIndex].strContactName+"\n "+convertDateFormat(tables[childrenIndex].dteBookedDate ,  "yyyy-MM-dd", "d MMM yyyy")+"\n Time : "+tables[childrenIndex].strBookedTime,
               style: TextStyle(fontWeight: FontWeight.w400 , color: AppColors.blue , fontSize: 16),
               children: const <TextSpan>[

                 TextSpan(text: "\n Cancelled Appointment" , style: TextStyle(fontWeight: FontWeight.bold , color: Colors.red , fontSize: 18),),
                ],
             ),),
        )
        ));},
    );
  }
}
