// @dart=2.9

import 'package:enstaller/core/constant/app_colors.dart';
import 'package:enstaller/core/constant/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppTextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final double width;
  final IconData preFix;
  bool obsecureText;
  String assetPath;
  bool readOnly;

  AppTextFieldWidget({this.controller,this.hintText,this.width,this.preFix,this.assetPath,this.obsecureText:false,this.readOnly});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width??SizeConfig.screenWidth,
      decoration: BoxDecoration(
          color: AppColors.loginTextBacground,
        borderRadius: BorderRadius.circular(10)
      ),
      child: TextFormField(
        readOnly: readOnly == null ? false : readOnly,
        controller:controller,
        obscureText: obsecureText,
        decoration: InputDecoration(
          hintText:hintText,
          border: InputBorder.none,
          prefixIcon: SizedBox(
              height: 20,child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: !assetPath.endsWith(".svg")? Image(
                  image: AssetImage(assetPath),
                  ): SvgPicture.asset( 
                                      assetPath,
                                      ),
                  
              ))
        ),
        validator: (value){
          if(value.isEmpty){
            return 'required';
          }
          else
            return null;
        },
      ),
    );
  }
}
