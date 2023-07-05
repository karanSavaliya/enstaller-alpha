// @dart=2.9


import 'dart:async';

import 'package:enstaller/core/constant/app_colors.dart';
import 'package:enstaller/core/constant/app_string.dart';
import 'package:enstaller/core/constant/appconstant.dart';
import 'package:enstaller/core/constant/image_file.dart';
import 'package:enstaller/core/constant/size_config.dart';
import 'package:enstaller/core/enums/view_state.dart';
import 'package:enstaller/core/model/non_technical_user_models/agent_model.dart';
import 'package:enstaller/core/model/send/answer_credential.dart';
import 'package:enstaller/core/provider/base_view.dart';
import 'package:enstaller/core/viewmodel/non_technical_user_viewmodel/customer_list_viewmodel.dart';
import 'package:enstaller/ui/screen/non_technical_user_screens/widgets/customer_list_agent_widget.dart';
import 'package:enstaller/ui/screen/non_technical_user_screens/widgets/customer_list_report_widget.dart';
import 'package:enstaller/ui/screen/widget/homescreen/home_page_list_widget.dart';
import 'package:enstaller/ui/screen/widget/homescreen/homepage_expandsion_widget.dart';
import 'package:enstaller/ui/screen/widget/homescreen/view_appointment_list_widget.dart';
import 'package:enstaller/ui/shared/app_drawer_widget.dart';
import 'package:enstaller/ui/shared/non_technical_app_drawer.dart';
import 'package:enstaller/ui/shared/warehouse_app_drawer.dart';
import 'package:flutter/material.dart';

class CustomerListScreen extends StatefulWidget {
  @override
  _CustomerListScreenState createState() => _CustomerListScreenState();
}

class _CustomerListScreenState extends State<CustomerListScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  ScrollController _scrollController = new ScrollController();
  List<AgentModel> _listOfAgents = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.sizeConfigInit(context);
    return SafeArea(
      child: BaseView<CustomerListScreenVM>(
        onModelReady: (model) => model.getAgentList(),
        builder: (context, model, child) {
          _listOfAgents = model.masterAgentList;
          return Scaffold(
            backgroundColor: AppColors.scafoldColor,
            key: _scaffoldKey,
            drawer: Drawer(child: NonTechnicalUserDrawerWidget()),
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
                "Customer Journey",
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
                    child: RefreshIndicator(
                      onRefresh: () => Future.delayed(Duration.zero)
                          .whenComplete(() => model.getAgentList()),
                      child: ListView.builder(
                          physics: const ScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics()),
                          controller: _scrollController,
                          itemCount: model.masterAgentList.length,
                          itemBuilder: (context, int index) {
                            print("herrrrrrrrrreeeeeeee");
                            return Padding(
                              padding: SizeConfig.verticalC8Padding,
                              child: InkWell(
                                onTap: () {},
                                child: BaseView<CustomerListScreenVM>(
                                  builder: (context, pModel, child) {
                                    AgentModel agent =
                                        model.masterAgentList[index];
                                    return HomePageExpansionWidget(
                                      onTap: () {
                                        model.onSelectIndex(index);
                                      },
                                      showSecondWidget:
                                          index == model.selectedIndex,
                                      firstWidget: AgentListWidget(
                                        height: SizeConfig.screenHeight * .15,
                                        agent: agent,
                                        expanded: index == model.selectedIndex,
                                      ),
                                      secondWidget: Container(
                                        child: BaseView<CustomerListScreenVM>(
                                          builder:
                                              (context, secondModel, child) {
                                            print(
                                                "print value --> ${model.masterReportList}");
                                            if (model.state == ViewState.Busy) {
                                              return AppConstants
                                                  .circulerProgressIndicator();
                                            }
                                            return Container(
                                              child: ConstrainedBox(
                                                  constraints: BoxConstraints(
                                                      maxHeight: AppConstants
                                                          .getExpandedAgentListHeight(
                                                              model
                                                                  .masterReportList
                                                                  .isEmpty,
                                                              model
                                                                  .masterReportList
                                                                  .length)),
                                                  child: (model.masterReportList
                                                              .length >
                                                          0)
                                                      ? CustomerListReportWidget(
                                                          tables: model
                                                              .masterReportList,
                                                          viewModel: model,
                                                        )
                                                      : Container(
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          7),
                                                              color:
                                                                  Colors.white,
                                                              border: Border.all(
                                                                  color: AppColors
                                                                      .lightGrayDotColor)),
                                                          padding:
                                                              EdgeInsets.all(0),
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.21,
                                                          width:
                                                              double.infinity,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Text(AppStrings
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
