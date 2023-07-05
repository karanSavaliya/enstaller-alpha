// @dart=2.9


import 'package:enstaller/core/constant/app_colors.dart';
import 'package:enstaller/core/constant/image_file.dart';
import 'package:enstaller/core/constant/size_config.dart';
import 'package:enstaller/core/constant/text_style.dart';
import 'package:enstaller/core/model/non_technical_user_models/agent_model.dart';
import 'package:flutter/material.dart';

class AgentListWidget extends StatelessWidget {
  final bool expanded;
  final AgentModel agent;
  final double height;
  AgentListWidget({this.agent, this.expanded, this.height});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Container(
        height: height,
        decoration: BoxDecoration(
            color: AppColors.itemColor,
            border: Border(
              left: BorderSide(color: AppColors.appThemeColor, width: 10),
            ),
            boxShadow: [
              BoxShadow(
                  color: Colors.black54,
                  blurRadius: 15.0,
                  offset: Offset(0.0, 2.25))
            ]),
        child: Center(
          child: Padding(
            padding: SizeConfig.sidepadding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  agent.strAgentName,
                  style: AppStyles.BlackStyleWithBold_Font36(context)
                      .copyWith(fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  child: !expanded
                      ? Image.asset(ImageFile.rightArrow)
                      : RotatedBox(
                          quarterTurns: 1,
                          child: Image.asset(ImageFile.rightArrow)),
                  height: SizeConfig.screenHeight * 0.02,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
