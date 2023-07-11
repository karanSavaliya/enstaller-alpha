// @dart=2.9
import 'package:enstaller/core/constant/app_colors.dart';
import 'package:flutter/material.dart';

class ElectricityTextFieldWidget extends StatelessWidget {
  final String hintText;
  final int maxLine;
  final VoidCallback onTap;
  final TextEditingController controller;

  ElectricityTextFieldWidget({this.hintText,this.maxLine,this.onTap,this.controller});

  TextEditingController nullController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLine == null ? 1 : maxLine,
      onTap: onTap,
      controller: controller == null ? nullController : controller,
      decoration: InputDecoration(
        hintText: hintText,
        isDense: true,
        focusedBorder:OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.appThemeColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.appThemeColor),
        ),
      ),
      validator: (value){
        if(value.isEmpty){
          return 'required';
        }
        else
          return null;
      },
    );
  }
}