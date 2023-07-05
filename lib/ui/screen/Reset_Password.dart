// @dart=2.9

import 'package:enstaller/core/constant/app_colors.dart';
import 'package:enstaller/core/constant/app_string.dart';
import 'package:enstaller/core/constant/appconstant.dart';
import 'package:enstaller/core/constant/image_file.dart';
import 'package:enstaller/core/constant/size_config.dart';
import 'package:enstaller/core/constant/text_style.dart';
import 'package:enstaller/core/enums/view_state.dart';
import 'package:enstaller/core/provider/base_view.dart';
import 'package:enstaller/core/viewmodel/login_viewmodel.dart';
import 'package:enstaller/ui/screen/widget/app_text_field_widget.dart';
import 'package:enstaller/ui/shared/appbuttonwidget.dart';
import 'package:flutter/material.dart';


class ResetScreenArguments {

  String emailId;
  ResetScreenArguments({
     this.emailId,
  });

}


class ResetPassword extends StatefulWidget {

  String emailId;
  ResetPassword({ this.emailId});

  @override
  ResetPasswordState createState() => ResetPasswordState();

}

class ResetPasswordState extends State<ResetPassword> {

  bool isChecked = false;
  bool autoValidation = false;
  var _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    print(widget.emailId);



  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

        body: BaseView<LogInViewModel>(
            builder: (context, model, child) {

              model.EmailidController.text = widget.emailId;

              return SingleChildScrollView(child:Column(

                children: <Widget>[

                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),
                  Container(
                    width: SizeConfig.screenWidth,
                    height: SizeConfig.screenHeight * .2,
                    child: Center(
                      child: Image.asset(
                        ImageFile.logo,
                        height: MediaQuery.of(context).size.height * 0.068,
                      ),
                    ),
                    decoration: BoxDecoration(color: AppColors.whiteColor),
                  ),
                  Container(
//                width: SizeConfig.screenWidth,
                    height: SizeConfig.screenHeight * .76,
                    decoration: BoxDecoration(
                      color: AppColors.loginBottomColor,
                    ),
                    child: Column(
                      children: [
                        SizeConfig.verticalSpace(SizeConfig.screenHeight * .05),
                        Text(
                          AppStrings.reset_password,
                          style: AppStyles.loginTitle,
                        ),
                        SizeConfig.verticalSpace(SizeConfig.screenHeight * .04),
                        AppTextFieldWidget(
                          width: SizeConfig.screenWidth * .8,
                          controller: model.EmailidController,
                          hintText: widget.emailId,
                          preFix: Icons.person_outline,
                          assetPath: ImageFile.loginUser,
                        ),

                        SizeConfig.verticalSpace(SizeConfig.screenHeight * .03),
                        AppTextFieldWidget(
                          width: SizeConfig.screenWidth * .8,
                          controller: model.passwordController,
                          hintText: AppStrings.enter_new_password,
                          preFix: Icons.person_outline,
                          assetPath: ImageFile.loginPass,
                        ),

                        SizeConfig.verticalSpace(SizeConfig.screenHeight * .03),
                        AppTextFieldWidget(
                          width: SizeConfig.screenWidth * .8,
                          controller: model.confirmPasswordController,
                          hintText: AppStrings.confirm_password,
                          preFix: Icons.person_outline,
                          assetPath: ImageFile.loginPass,
                        ),

                        SizeConfig.verticalSpace(SizeConfig.screenHeight * .03),
                        AppTextFieldWidget(
                          width: SizeConfig.screenWidth * .8,
                          controller: model.otpController,
                          hintText: AppStrings.enter_otp,
                          preFix: Icons.person_outline,
                          assetPath: ImageFile.otp,
                        ),


                        SizeConfig.verticalSpace(SizeConfig.screenHeight * .05),
                        model.state == ViewState.Busy
                            ? AppConstants.circulerProgressIndicator()
                            : AppButton(
                          buttonText: AppStrings.reset_password,
                          textStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: AppColors.whiteColor,
                              fontSize: SizeConfig.screenHeight * .02),
                          height:
                          MediaQuery.of(context).size.height * 0.06,
                          width: SizeConfig.screenWidth * .8,
                          color: AppColors.appThemeColor,
                          radius: 20,
                          onTap: () {

                               model.ResetPasswordModel(context);
                          },
                        ),

                      ],
                    ),
                  )

                ],

              ));

            })




    );

  }


}