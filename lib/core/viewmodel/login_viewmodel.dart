import 'package:enstaller/core/constant/appconstant.dart';
import 'package:enstaller/core/enums/view_state.dart';
import 'package:enstaller/core/model/after_login_model.dart';
import 'package:enstaller/core/model/login_credentials.dart';
import 'package:enstaller/core/model/login_responsemodel.dart';
import 'package:enstaller/core/model/send/answer_credential.dart';
import 'package:enstaller/core/provider/base_model.dart';
import 'package:enstaller/core/service/api_service.dart';
import 'package:enstaller/core/service/pref_service.dart';
import 'package:enstaller/ui/login_screen.dart';
import 'package:enstaller/ui/screen/Reset_Password.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogInViewModel extends BaseModel {
  ApiService _apiService = ApiService();

  bool rememberMe = false;

  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  TextEditingController emailController = TextEditingController();

  TextEditingController EmailidController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  void onChangeRememberMe() {
    rememberMe = !rememberMe;
    setState(ViewState.Idle);
  }

  void logInWithUserNameAndPassword(BuildContext context) async {
    setState(ViewState.Busy);
    LoginResponseModel response = await _apiService.loginWithUserNamePassword(
        LoginCredential(
            userName: userNameController.text,
            password: passwordController.text,
            groupType: 'password'));
    if (response.errorMessage != null) {
      setState(ViewState.Idle);
      AppConstants.showFailToast(context , response.errorMessage);
    } else {
      AfterLoginModel afterLoginModel =
          await _apiService.getUserRole(userNameController.text.trim());
      GlobalVar.roleId = afterLoginModel.intRoleId;
      GlobalVar.warehosueID = afterLoginModel.intId.toString();
      if (response.errorMessage != null) {
        setState(ViewState.Idle);
        AppConstants.showFailToast(context, response.errorMessage);
      } else {
        setState(ViewState.Idle);

        Map<String, dynamic> decodedToken =
            JwtDecoder.decode(response.userDetails.accessToken);
        if (decodedToken != null) {
          print("decodedToken ===>");
          print(decodedToken);
          response.userDetails.username = decodedToken["unique_name"];
          response.userDetails.intEngineerId = decodedToken["EngineerId"];
          response.userDetails.strEngineerName = decodedToken["EngineerName"];
          response.userDetails.role = decodedToken["role"];
          response.userDetails.email = decodedToken["email"];
          response.userDetails.id = decodedToken['nameid'];
          response.userDetails.intCompanyId = decodedToken['CompanyId'];

          String strNonTechnical = decodedToken['bisNonTechnical'] ?? "";
          strNonTechnical = strNonTechnical.toLowerCase();
          bool bisNonTechnical = false;
          if (strNonTechnical.isNotEmpty && strNonTechnical == "true") {
            bisNonTechnical = true;
          }
          response.userDetails.bisNonTechnical = bisNonTechnical;
        }
        response.userDetails.rememberMe = true;

        Prefs.setUserProfile(response.userDetails,
            roleId: GlobalVar.roleId, wareHouseId: GlobalVar.warehosueID);

        final SharedPreferences preferences =
            await SharedPreferences.getInstance();
        preferences.setString('ups', passwordController.text);
        if (response.userDetails.bisNonTechnical == true) {
          Navigator.of(context).pushReplacementNamed("/customerListScreen");
        } else {
          if (GlobalVar.roleId == 5)
            Navigator.of(context).pushReplacementNamed("/checkAssignOrder");
          else
            Navigator.of(context).pushReplacementNamed("/home");
        }
      }
    }
  }

  Future<void> verifyEmail(BuildContext context) async {

    setState(ViewState.Busy);


    Map data = {"stremail": emailController.text.toString()};
    final res =  await _apiService.VerifyEmail(data);

    print(res);

    if(res == "false"){
      AppConstants.showFailToast(context, "Please try again! this Email is not verified or other problem occured");
    }else{
      AppConstants.showSuccessToast(context, "Email sent Successfully");

      print(emailController.text.toString());

      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ResetPassword(
            emailId: emailController.text.toString(),
          )));

     // Navigator.of(context).pushNamed("/resetPassword" , arguments: ResetScreenArguments(emailId :emailController.text.toString()));

    }

    setState(ViewState.Idle);

  }

  Future<void> ResetPasswordModel(BuildContext context) async {

    setState(ViewState.Busy);

    print(otpController.text.toString()+"--"+passwordController.text.toString()+"---"+confirmPasswordController.text.toString());
    if(passwordController.text.toString().isEmpty || confirmPasswordController.text.toString().isEmpty || otpController.text.toString().isEmpty){
      AppConstants.showFailToast(context, "All Fields are Compulsory");
    }else if(passwordController.text.toString() != confirmPasswordController.text.toString()){
      AppConstants.showFailToast(context, "Password and Confirm Password should be same");
    }else{

      Map data = {
        "strusername": EmailidController.text.toString(),
        "strCode": otpController.text.toString(),
        "newPassword": passwordController.text.toString()
      };

      print(data.toString());
      final res =  await _apiService.resetPassword(data);

      AppConstants.showFailToast(context, res.result);

      if(res.result == "Password Change Sucess."){
        AppConstants.showSuccessToast(context, res.result+" , you are redirected to Login Screen");
        Navigator.of(context).pushReplacementNamed("/login");
      }else{

        AppConstants.showFailToast(context, res.result);
      }




    }

    setState(ViewState.Idle);

  }



}
