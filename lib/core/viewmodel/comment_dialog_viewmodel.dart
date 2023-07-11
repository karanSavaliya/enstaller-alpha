// @dart=2.9

import 'dart:io';

import 'package:enstaller/core/constant/api_urls.dart';
import 'package:enstaller/core/enums/view_state.dart';
import 'package:enstaller/core/model/commentModel.dart';
import 'package:enstaller/core/model/comment_model.dart';
import 'package:enstaller/core/model/response_model.dart';
import 'package:enstaller/core/model/send/comment_credential.dart';
import 'package:enstaller/core/model/user_model.dart';
import 'package:enstaller/core/provider/base_model.dart';
import 'package:enstaller/core/service/api_service.dart';
import 'package:enstaller/core/service/pref_service.dart';
import 'package:flutter/cupertino.dart';
import '../constant/appconstant.dart';


class CommentDialogViewModel extends BaseModel {
  ApiService _apiService = ApiService();
  List<CommentModel> comments = [];
  TextEditingController commentController = TextEditingController();
  bool showErrorMessage = false;

  List<AppointmentAttachemnts> appointmentAttachemnts= [];
  List<AppointmentDetails> appointmentDetails= [];

  void getComments(String appointmentID) async {
    setState(ViewState.Busy);
    UserModel user = await Prefs.getUser();
    comments = await _apiService.getAppointmentCommentsByAppointment(
        appointmentID, user.intCompanyId);
    setState(ViewState.Idle);
  }



  void getComments2(String appointmentID) async {
    setState(ViewState.Busy);

    UserModel user = await Prefs.getUser();

    commentModel model = await _apiService.getAppointmentCommentsByAppointment(
        appointmentID , user.intCompanyId);

    appointmentDetails    = model.appointmentDetails;
    appointmentAttachemnts = model.appointmentAttachemnts;

    setState(ViewState.Idle);
  }


  void onSubmitComment(String appointmentID) async {
    setState(ViewState.Busy);

    if (commentController.text.trim().length > 0) {
      showErrorMessage = false;
      UserModel userModel = await Prefs.getUser();
      print('usedId${userModel.id}');
      ResponseModel responseModel = await _apiService.submitComment(
          CommentCredential(
              strcomments: commentController.text,
              intappintmentid: appointmentID,
              intCreatedBy: userModel.id.toString(),
              intCompanyId: userModel.intCompanyId));
      if (responseModel.statusCode == 1) {
        commentController.clear();
        comments = await _apiService.getAppointmentCommentsByAppointment(
            appointmentID, userModel.intCompanyId);
      }
    } else {
      showErrorMessage = true;
    }

    setState(ViewState.Idle);
  }


  String response_body = "";
  void addComments(BuildContext context ,String appointmentID , String comments , List<Map<String ,dynamic>> liststr_files) async {
    if (commentController.text.trim().length > 0) {
      showErrorMessage = false;
      UserModel userModel = await Prefs.getUser();
      print('usedId${userModel.id}');
      String responseModel = await _apiService.saveAppointments(
          {
              "intDetailsId":"",
              "intAppointmentid": appointmentID,
              "strcomments": comments,
              "bisvisibleuser":"true",
              "intCreatedBy": userModel.id,
              "intUpdatedby": "",
              "intReturnId" : ""

          });
      if (responseModel != null) {
        var url = 'https://enstallapi.boshposh.com/api/'+ApiUrls.insertAttachment;
        var map = {
          'intDetailsId': responseModel,
          'intAppointmentId': appointmentID,
          'intCreatedBy': userModel.id,
        };

        List<File> list_files = [];
        liststr_files.forEach((element) {
          String filepath = element["value"].toString();
          list_files.add(File(filepath));
        });

        final response  = await _apiService.uploadFilesWithParameters(url , list_files , map);
        response_body  = response;
        print(response_body);
        commentController.clear();
        AppConstants.showSuccessToast(context, "Comment Submitted");
        Navigator.pop(context);
      }
    } else {
      showErrorMessage = true;
    }
  }



}
