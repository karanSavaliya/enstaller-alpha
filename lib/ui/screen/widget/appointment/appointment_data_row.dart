// @dart=2.9
import 'package:enstaller/core/constant/app_colors.dart';
import 'package:enstaller/core/constant/size_config.dart';
import 'package:flutter/material.dart';

class AppointmentDataRow extends StatelessWidget {
  final String firstText;
  final String secondText;
  final Widget secondChild;
  AppointmentDataRow({this.firstText,this.secondText,this.secondChild});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: firstText == "Serial Number" ? AppColors.appThemeColor : Colors.white,
        border: Border(
          bottom: BorderSide(
            color: AppColors.lightGrayDotColor
          )
        )
      ),
      child:  Padding(
        padding: SizeConfig.padding,
        child: Row(
          children: [
            Expanded(
                flex: 2,
                child: Text(
                  firstText,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: firstText == "Serial Number"? Colors.white: AppColors.darkGrayColor,
                    // fontWeight: firstText == "Serial Number"? FontWeight.bold: FontWeight.normal
                    fontWeight: FontWeight.bold,
                    ),
                )),
            SizeConfig.horizontalSpaceMedium(),
            Expanded(
                flex: 3,
                child: secondChild!=null?secondChild:Text(
                  secondText,
                  style: TextStyle(color: secondText == "Item Name"? Colors.white : AppColors.darkGrayColor,
                  fontWeight: secondText == "Item Name"? FontWeight.bold: FontWeight.normal),
                  textAlign: TextAlign.start,
                )),
          ],
        ),
      ),
    );
  }
}


class CheckAndAssignDataRow extends StatelessWidget {
  final String firstText;
  final String secondText;
  final Widget secondChild;
  CheckAndAssignDataRow({this.firstText,this.secondText,this.secondChild});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: firstText == "Items" ? AppColors.darkBlue : Colors.white,
        border: Border(
          bottom: BorderSide(
            color: AppColors.lightGrayDotColor
          )
        )
      ),
      child:  Padding(
        padding: SizeConfig.padding,
        child: Row(
          children: [
            Expanded(
                flex: 2,
                child: Text(
                  firstText,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: firstText == "Items"? Colors.white : AppColors.darkGrayColor,
                    fontWeight: FontWeight.bold),
                )),
            SizeConfig.horizontalSpaceMedium(),
            Expanded(
                flex: 3,
                child: secondChild!=null?secondChild:Text(
                  secondText,
                  style: TextStyle(color: secondText == "Quantity"? Colors.white : AppColors.darkGrayColor,
                  fontWeight: secondText == "Quantity"? FontWeight.bold: FontWeight.normal),
                  textAlign: TextAlign.start,
                )),
          ],
        ),
      ),
    );
  }
}
