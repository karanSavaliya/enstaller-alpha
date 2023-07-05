// @dart=2.9


import 'package:enstaller/core/constant/app_colors.dart';
import 'package:enstaller/core/constant/size_config.dart';
import 'package:enstaller/core/model/non_technical_user_models/agent_report_model.dart';
import 'package:enstaller/core/viewmodel/non_technical_user_viewmodel/customer_list_viewmodel.dart';
import 'package:enstaller/ui/screen/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomerListReportWidget extends StatelessWidget {
  final List<AgentReportModel> tables;
  final CustomerListScreenVM viewModel;

  CustomerListReportWidget({this.tables, this.viewModel});
  @override
  Widget build(BuildContext context) {
    print('view customer report list');
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemCount: tables.length,
      padding: EdgeInsets.all(0),
      itemBuilder: (context, childrenIndex) {
        return InkWell(
          onTap: () {
            print(tables[childrenIndex].strName +
                " ---- " +
                tables[childrenIndex].intId.toString());
          },
          child: Container(
            height: SizeConfig.screenHeight * (childrenIndex == 2 ? .10 : .05),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: AppColors.lightGrayDotColor)),
            padding: EdgeInsets.all(0),
            width: double.infinity,
            child: FittedBox(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: Row(
                  children: [
                    Text(tables[childrenIndex].strName.replaceAll("_", " "),
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.w300))
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
