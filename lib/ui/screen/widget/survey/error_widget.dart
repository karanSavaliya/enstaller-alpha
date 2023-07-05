import 'package:enstaller/core/constant/app_colors.dart';
import 'package:enstaller/core/constant/app_string.dart';
import 'package:enstaller/core/constant/size_config.dart';
import 'package:flutter/material.dart';

class ErrorTextWidget extends StatelessWidget {


  final String errorMessage;
  ErrorTextWidget({this.errorMessage = AppStrings.fieldErrorMessage});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: SizeConfig.verticalC13Padding,
      child: Container(
        color: AppColors.errorContainerColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(errorMessage),
        ),
      ),
    );
  }

}
