import 'package:enstaller/core/constant/app_colors.dart';
import 'package:enstaller/core/constant/app_string.dart';
import 'package:enstaller/core/constant/appconstant.dart';
import 'package:enstaller/core/constant/size_config.dart';
import 'package:enstaller/core/enums/view_state.dart';
import 'package:enstaller/core/provider/base_view.dart';
import 'package:enstaller/core/viewmodel/check_request_viewmodel.dart';
import 'package:enstaller/ui/shared/app_drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CheckRequestScreen extends StatefulWidget {
  @override
  _CheckRequestScreenState createState() => _CheckRequestScreenState();
}

class _CheckRequestScreenState extends State<CheckRequestScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light));
    return BaseView<CheckRequestViewModel>(
      onModelReady: (model) => model.initializeData(),
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
              title: Text(
                "${AppStrings.CHECK_REQUEST}",
                style: TextStyle(color: AppColors.whiteColor),
              ),
              centerTitle: true,
            ),
            body: model.state == ViewState.Busy
                ? AppConstants.circulerProgressIndicator()
                : RefreshIndicator(
                    onRefresh: () => Future.delayed(Duration.zero)
                        .whenComplete(() => model.initializeData()),
                    child: ConstrainedBox(
                        constraints: BoxConstraints(
                            maxHeight: MediaQuery.of(context).size.height),
                        child: (model.serialList.isNotEmpty == true)
                            ? ListView.builder(
                                physics: const ScrollPhysics(
                                    parent: AlwaysScrollableScrollPhysics()),
                                itemCount: model.serialList.length,
                                itemBuilder: (context, i) {
                                  EdgeInsets pedding = EdgeInsets.fromLTRB(
                                      12, ((i == 0) ? 12 : 0), 12, 0);
                                  return Padding(
                                    padding: pedding,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: AppColors
                                              .appointmentBackGroundColor),
                                      child: Column(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                color: i == 0
                                                    ? AppColors.appThemeColor
                                                    : Colors.white,
                                                border: Border(
                                                    bottom: BorderSide(
                                                        color: AppColors
                                                            .lightGrayDotColor))),
                                            child: Padding(
                                              padding: SizeConfig.padding,
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                      flex: 3,
                                                      child: Text(
                                                        model.serialList[i]
                                                                .strSerialNo ??
                                                            "",
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: TextStyle(
                                                          color: i == 0
                                                              ? AppColors
                                                                  .whiteColor
                                                              : AppColors
                                                                  .darkGrayColor,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      )),
                                                  SizeConfig
                                                      .horizontalSpaceMedium(),
                                                  Expanded(
                                                      flex: 3,
                                                      child: Text(
                                                        model.serialList[i]
                                                                .strItemName ??
                                                            "",
                                                        style: TextStyle(
                                                            color: i == 0
                                                                ? AppColors
                                                                    .whiteColor
                                                                : AppColors
                                                                    .darkGrayColor,
                                                            fontWeight: i == 0
                                                                ? FontWeight
                                                                    .bold
                                                                : FontWeight
                                                                    .normal),
                                                        textAlign:
                                                            TextAlign.start,
                                                      )),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              )
                            : Center(child: Text(AppStrings.noDataFound)))));
      },
    );
  }
}
