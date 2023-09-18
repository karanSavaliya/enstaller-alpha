import 'dart:convert';
import 'package:enstaller/core/constant/api_urls.dart';
import 'package:enstaller/core/constant/app_string.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:enstaller/core/model/EngineerBaseLocation.dart';
import 'package:enstaller/core/model/abort_appointment_model.dart';
import 'package:enstaller/core/model/activity_details_model.dart';
import 'package:enstaller/core/model/after_login_model.dart';
import 'package:enstaller/core/model/app_table.dart';
import 'package:enstaller/core/model/checkAndAssignModel.dart';
import 'package:enstaller/core/model/commentModel.dart' as cm;
import 'package:enstaller/core/model/contract_order_model.dart';
import 'package:enstaller/core/model/document_pdfopen_model.dart';
import 'package:enstaller/core/model/appointmentDetailsModel.dart';
import 'package:enstaller/core/model/elec_closejob_model.dart';
import 'package:enstaller/core/model/gas_job_model.dart';
import 'package:enstaller/core/model/item_oder_model.dart';
import 'package:enstaller/core/model/non_technical_user_models/agent_response_model.dart';
import 'package:enstaller/core/model/order_detail_model.dart';
import 'package:enstaller/core/model/order_export_model.dart';
import 'package:enstaller/core/model/order_line_detail_model.dart';
import 'package:enstaller/core/model/order_model.dart';
import 'package:enstaller/core/model/profile_details.dart';
import 'package:enstaller/core/model/route_making.dart';
import 'package:enstaller/core/model/save_order.dart';
import 'package:enstaller/core/model/save_order_line.dart';
import 'package:enstaller/core/model/serial_item_model.dart';
import 'package:enstaller/core/model/serial_model.dart';
import 'package:enstaller/core/model/email_notification_model.dart';
import 'package:enstaller/core/model/customer_details.dart';
import 'package:enstaller/core/model/document_model.dart';
import 'package:enstaller/core/model/electric_and_gas_metter_model.dart';
import 'package:enstaller/core/model/login_credentials.dart';
import 'package:enstaller/core/model/login_responsemodel.dart';
import 'package:enstaller/core/model/question_answer_model.dart';
import 'package:enstaller/core/model/response_model.dart';
import 'package:enstaller/core/model/send/answer_credential.dart';
import 'package:enstaller/core/model/send/appointmentStatusUpdateCredential.dart';
import 'package:enstaller/core/model/send/comment_credential.dart';
import 'package:enstaller/core/model/stock_check_model.dart';
import 'package:enstaller/core/model/stock_request_reply_model.dart';
import 'package:enstaller/core/model/stock_update_model.dart';
import 'package:enstaller/core/model/update_profile.dart';
import 'package:enstaller/core/model/update_status_model.dart';
import 'package:enstaller/core/model/user_model.dart';
import 'package:enstaller/core/service/base_api.dart';
import 'package:enstaller/core/model/survey_response_model.dart';
import 'package:enstaller/core/service/pref_service.dart';
import 'package:enstaller/ui/util/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'dart:io';
import 'package:path/path.dart' as p;
import '../constant/appconstant.dart';

class ApiService extends BaseApi {

  Future<dynamic> loginWithUserNamePassword(LoginCredential loginCredential) {

    return postRequest(ApiUrls.logInUrl, (r) {
      print("++++++++++++");
      print(json.decode(r.body));
      print("++++++++++++");
      final responseError = json.decode(r.body)['error_description'];
      if (responseError != null) {
        return LoginResponseModel(errorMessage: responseError);
      } else {
        return LoginResponseModel(
            errorMessage: null,
            userDetails: UserModel.fromJson(json.decode(r.body)));
      }
    }, loginCredential.toJson());

  }

  Future<dynamic> updateProfilePhoto(UpdateProfile profileInfo) {
    return postRequest(ApiUrls.updateProfilePhoto, (r) {
      print(json.decode(r.body));
      return r.body;
    }, profileInfo.toJson());
  }

  Future<dynamic> getProfileInformation(String userId) {
    if (userId == null || userId == "null") {
      userId = "4";
    }
    print(userId);
    return getRequestWithParam(ApiUrls.getProfilePhoto, (response) {
      print(response.body);
      return ProfileDetails.fromJson(json.decode(response.body));
    }, 'id=$userId');
  }

  Future<void> storeMeterSerialNoForEngineer(String userID) {
    if (userID == null || userID == "null") {
      userID = "4";
    }
    return getRequestWithParam(ApiUrls.getMeterSerialNoEngineerwiseUrl, (response) {
      print("Response: =====>" + response.body);
      Prefs.saveMeterSerialNoData(response.body);
    }, 'intUserId=$userID');
  }

  Future<dynamic> getAppointmentList(String userID) {
    if (userID == null || userID == "null") {
      userID = "4";
    }
    return getRequestWithParam(ApiUrls.getappointmenttodaytomorrow, (response) {
      print(response.body);
      return (json.decode(response.body) as List)
          .map((e) => Appointment.fromJson(e)).toList();
    }, 'id=$userID');
  }

  Future<dynamic> getAbortAppointmentList(UserModel user) {
    return getRequestWithParam(ApiUrls.getReasonUserList, (response) {
      print(response.body);
      return (json.decode(response.body) as List)
          .map((e) => AbortAppointmentModel.fromJson(e))
          .toList();
    },
        'UserId=${user.id}&type=Abort' +
            '&${AppStrings.intCompanyIdKey}=${user.intCompanyId}');
  }

  Future<dynamic> getEmailNotificationList(UserModel user) {
    return getRequestWithParam(ApiUrls.getEmailTemplateSenderHistoryUserWise,
        (response) {
      print(response.body);
      return (json.decode(response.body) as List)
          .map((e) => EmailNotificationModel.fromJson(e))
          .toList();
    },
        'intUserId=${user.id.toString()}' +
            '&${AppStrings.intCompanyIdKey}=${user.intCompanyId}');
  }

  Future<dynamic> getActivityLogsAppointmentId(String appointmentID, String companyId) {
    return getRequestWithParam(ApiUrls.getActivityLogsAppointmentIdUrl,
        (response) {
      print(response.body);
      return (json.decode(response.body) as List)
          .map((e) => ActivityDetailsModel.fromJson(e))
          .toList();
    }, 'intId=$appointmentID' + '&${AppStrings.intCompanyIdKey}=$companyId');
  }

  Future<dynamic> getAppointmentDetails(String appointmentID, String companyId) {
    return getRequest(ApiUrls.getAppointmentDetailsUrl, (response) {
      print("-----------res-----"+response.body);
      return AppointmentDetails.fromJson(json.decode(response.body));
    }, '/$appointmentID' + '?${AppStrings.intCompanyIdKey}=$companyId');
  }

  Future<dynamic> getStockLocation(String warehouseID, String companyId) {
    return getRequestWithParam(ApiUrls.getStockLocation, (response) {
      print(response.body);
      return (json.decode(response.body) as List)
          .map((e) => StockLocationModel.fromJson(e))
          .toList();
    },
        'intWarehouseUserId=$warehouseID' +
            '&${AppStrings.intCompanyIdKey}=$companyId');
  }

  Future<dynamic> getStockBatch(String warehouseID, String companyId) {
    return getRequestWithParam(ApiUrls.getStockBatch, (response) {
      print(response.body);
      return (json.decode(response.body) as List)
          .map((e) => StockBatchModel.fromJson(e))
          .toList();
    },
        'intWarehouseUserId=$warehouseID' +
            '&${AppStrings.intCompanyIdKey}=$companyId');
  }

  Future<dynamic> getStockStatus(UserModel user) {
    return getRequestwithoutParam(ApiUrls.getStockStatus, (response) {
      print(response.body);
      return (json.decode(response.body) as List)
          .map((e) => StockStatusModel.fromJson(e))
          .toList();
    }, '${AppStrings.intCompanyIdKey}=${user.intCompanyId}');
  }

  Future<dynamic> getPallet(String intBtachD, String companyId) {
    return getRequestWithParam(ApiUrls.getPallets, (response) {
      print(response.body);
      return (json.decode(response.body) as List)
          .map((e) => StockPalletModel.fromJson(e))
          .toList();
    }, 'intBatchId=$intBtachD' + '&${AppStrings.intCompanyIdKey}=$companyId');
  }

  Future<dynamic> getOrderAssigned(String strReference, String companyId) {
    return getRequestWithParam(ApiUrls.getOrderAssigned, (response) {
      print(response.body);
      return (json.decode(response.body) as List)
          .map((e) => IsOrderAssignedModel.fromJson(e))
          .toList();
    }, 'strReference=$strReference' + '&${AppStrings.intCompanyIdKey}=$companyId');
  }

  Future<dynamic> checkSerialNo(String strSerialNo, String orderID, String companyId) {
    return getRequestWithParam(ApiUrls.checkSerialNo, (response) {
      print(response.body);
      return (json.decode(response.body) as List)
          .map((e) => CheckSerialModel.fromJson(e))
          .toList();
    },
        'strSerialNo=$strSerialNo&intOrderId=$orderID' +
            '&${AppStrings.intCompanyIdKey}=$companyId');
  }

  Future<dynamic> saveCheckOrder(SaveCheckOrderModel model) {
    return postRequestMap(ApiUrls.saveCheckandassignorder, (r) {
      final response = json.decode(r.body);
      if (response) {
        return ResponseModel(
            statusCode: 1, response: 'Order Assigned Successfully');
      } else {
        return ResponseModel(statusCode: 0, response: 'Please try again');
      }
    }, model.toJson());
  }

  Future<dynamic> saveStatusUpdate(StockStatusSaveModel model) {
    return postRequestMap(ApiUrls.updateStatusBatchWise, (r) {
      final response = json.decode(r.body);
      if (response) {
        return ResponseModel(
            statusCode: 1, response: 'Status Updated Successfully');
      } else {
        return ResponseModel(statusCode: 0, response: 'Please try again');
      }
    }, model.toJson());
  }

  Future<dynamic> getOrderLineDetail(String orderId, String companyId) {
    return getRequestWithParam(ApiUrls.getCheckStockOrderLineDetails,
        (response) {
      print(response.body);
      return (json.decode(response.body) as List)
          .map((e) => OrderLineDetail.fromJson(e))
          .toList();
    }, 'intOrderId=$orderId' + '&${AppStrings.intCompanyIdKey}=$companyId');
  }

  Future<dynamic> getOrderByReference(String strReference, String companyId) {
    return getRequestWithParam(ApiUrls.getorderByReference, (response) {
      print(response.body);
      return OrderByRefernceModel.fromJson(json.decode(response.body));
    }, 'strReference=$strReference' + '&${AppStrings.intCompanyIdKey}=$companyId');
  }

  Future<dynamic> getDownloadFormat(String key, String companyId) {
    return getRequestWithParam(ApiUrls.getdownloadformat, (response) {
      print(response.body);
      return DownLoadFormatModel.fromJson(json.decode(response.body));
    }, 'strKey=$key' + '&${AppStrings.intCompanyIdKey}=$companyId');
  }

  Future<dynamic> getUserRole(String email) {
    return getRequest(ApiUrls.getUserRole, (response) {
      print(response.body);
      return AfterLoginModel.fromJson(json.decode(response.body));
    }, '?strEmail=$email');
  }

  Future<dynamic> getAppointmentCommentsByAppointment(
      String appointmentID , String companyId) {

    return getRequestWithParam(ApiUrls.getAppointmentCommentsByAppointmentUrl2,
        (response) {
      return  cm.commentModel.fromJson(json.decode(response.body));
    } , 'intappintmentid=$appointmentID');
  } //KARAN (ADD THIS ON LIVE)

  Future<dynamic> getAbortAppointmentCode(
      AppointmentStatusUpdateCredentials credentials) {
    print(credentials.toJson());
    return postRequest(ApiUrls.updateAppointmentStatusUrl, (r) {
      final response = json.decode(r.body);
      if (response) {
        return ResponseModel(statusCode: 1, response: 'Successfully Updated');
      } else {
        return ResponseModel(statusCode: 0, response: 'Please try again');
      }
    }, credentials.toJson());
  }

  Future<dynamic> saveElecJob(ElecCloseJobModel credentials) {
    print(credentials.toJson());
    return postRequestMap(ApiUrls.saveCloseJobElectricity, (r) {
      final response = json.decode(r.body);
      if (response) {
        return ResponseModel(
            statusCode: 1, response: 'Job Closed Successfully');
      } else {
        return ResponseModel(statusCode: 0, response: 'Please try again');
      }
    }, credentials.toJson());
  }

  Future<dynamic> saveGasJob(GasCloseJobModel credentials) {
    print(credentials.toJson());
    return postRequestMap(ApiUrls.saveCloseJobGas, (r) {
      final response = json.decode(r.body);
      if (response) {
        return ResponseModel(
            statusCode: 1, response: 'Job Closed Successfully');
      } else {
        return ResponseModel(statusCode: 0, response: 'Please try again');
      }
    }, credentials.toJson());
  }

  Future<dynamic> getDocumentList(DocumentModel documentModel) {
    print(documentModel.toJson());
    return postRequest(ApiUrls.getSupplierDocument, (r) {
      return (json.decode(r.body) as List)
          .map((e) => DocumentResponseModel.fromJson(e))
          .toList();
    }, documentModel.toJson());
  }

  Future<dynamic> getCustomerMeterListByCustomer(
      String customerID, String companyId) {
    return getRequestWithParam(ApiUrls.getCustomerMeterListByCustomerUrl,
        (response) {
      print(response.body);
      return (json.decode(response.body) as List)
          .map((e) => ElectricAndGasMeterModel.fromJson(e))
          .toList();
    }, 'intCustomerId=$customerID' + '&${AppStrings.intCompanyIdKey}=$companyId');
  }

  Future<dynamic> submitComment(CommentCredential commentCredential) {
    return postRequest(ApiUrls.saveAppointmentComments, (r) {
      final response = json.decode(r.body);
      if (response) {
        return ResponseModel(statusCode: 1, response: 'Successfully Submited');
      } else {
        return ResponseModel(statusCode: 0, response: 'Please try again');
      }
    }, commentCredential.toJson());
  }

  Future<dynamic> appointmentDataEventsbyEngineer(String engineerID, String companyId) {
    return getRequestWithParam(ApiUrls.appointmentDataEventsbyEngineerUrl, (response) {
      return (json.decode(response.body) as List).map((e) => StatusModel.fromJson(e)).toList();
    }, 'intId=$engineerID' + '&${AppStrings.intCompanyIdKey}=$companyId');
  }

  Future<dynamic> assignEnginerAppointment(AppointmentStatusUpdateCredentials credentials) {
    print(credentials.toJson());
    return postRequestMap(ApiUrls.assignEngineerAppointmentUrl, (r) {
      final response = json.decode(r.body);
      if (response) {
        return ResponseModel(statusCode: 1, response: 'Successfully Updated');
      } else {
        return ResponseModel(statusCode: 0, response: 'Please try again');
      }
    }, credentials.toJson());
  }

  Future<dynamic> updateAppointmentStatus(AppointmentStatusUpdateCredentials credentials) {
    return postRequestMap(ApiUrls.updateAppointmentStatusUrl, (r) {
      final response = json.decode(r.body);
      if (response) {
        return ResponseModel(statusCode: 1, response: 'Successfully Updated');
      } else {
        return ResponseModel(statusCode: 0, response: 'Please try again');
      }
    }, credentials.toJson());
  }

  Future<dynamic> abortappointmentbyreason(AbortAppointmentReasonModel credentials) {
    return postRequestMap(ApiUrls.abortappointmentreason, (r) {
      final response = json.decode(r.body);
      if (response) {
        return ResponseModel(
            statusCode: 1, response: 'Abort sent for approval');
      } else {
        return ResponseModel(statusCode: 0, response: 'Please try again');
      }
    }, credentials.toJson());
  }

  Future<dynamic> confirmAbortAppointment(ConfirmAbortAppointment credentials) {
    return postRequestMap(ApiUrls.updateAbortAppointment, (r) {
      final response = json.decode(r.body);
      if (response) {
        return ResponseModel(statusCode: 1, response: 'Successfully Updated');
      } else {
        return ResponseModel(statusCode: 0, response: 'Please try again');
      }
    }, credentials.toJson());
  }

  Future<dynamic> getSurveyQuestionAppointmentWise(String appointmentID, UserModel loginUser) {
    return getRequestWithParam(ApiUrls.getSurveyQuestionAppointmentWiseUrl, (response) {
      return (json.decode(response.body) as List).map((e) => SurveyResponseModel.fromJson(e)).toList();
    }, 'intappointmentId=$appointmentID' + '&${AppStrings.intCompanyIdKey}=${loginUser.intCompanyId}');
  }

  Future<dynamic> getSurveyQuestionAnswerDetail(String appointmentID, String companyId) {
    return getRequestWithParam(ApiUrls.getSurveyQuestionAnswerDetailUrl, (response) {
      return (json.decode(response.body) as List).map((e) => QuestionAnswer.fromJson(e)).toList();
    }, 'intappointmentId=$appointmentID' + '&${AppStrings.intCompanyIdKey}=$companyId');
  }

  Future<dynamic> updateCallForwardAppointment(String appointmentID, String companyId) {
    return getRequestWithParam(ApiUrls.updateCallForwardAppointment, (r) {
      final response = json.decode(r.body);
      if (response) {
        return ResponseModel(statusCode: 1, response: 'Successfully Updated');
      } else {
        return ResponseModel(statusCode: 0, response: 'Please try again');
      }
    }, 'intId=$appointmentID' + '&${AppStrings.intCompanyIdKey}=$companyId');
  }

  Future<dynamic> submitSurveyAnswer(AnswerCredential credentials) {
    return postRequest(ApiUrls.addSurveyQuestionAnswerDetailUrl, (r) {
      final response = json.decode(r.body);
      print('response$response');
      return ResponseModel(statusCode: 1, response: 'Successfully Updated');
    }, credentials.toJson());
  }

  Future<dynamic> onclickpdf(PDFOpenModel pdFopenModel) {
    return postRequest(ApiUrls.supplierDocumentUpdateEngineerRead, (r) {
      final response = json.decode(r.body);
      print('response$response');
      return ResponseModel(statusCode: 1, response: 'Successfully opened');
    }, pdFopenModel.toJson());
  }

  void updateStatus(String appointmentid) async{
    ApiService _apiService = ApiService();
    UserModel user = await Prefs.getUser();
    ResponseModel response = await _apiService.updateAppointmentStatus(
        AppointmentStatusUpdateCredentials(
          strStatus: "Completed",
          intBookedBy: user.intEngineerId.toString(),
          intEngineerId: user.intEngineerId.toString(),
          strEmailActionby: "Send by Engineer",
          intId: appointmentid,
          intCompanyId: user.intCompanyId,
          intUserId:"0",
        ));
  }

  Future<dynamic> submitListSurveyAnswer(List<AnswerCredential> credentials,BuildContext context,String appointmentid, String status) {
    return postRequestList(ApiUrls.addSurveyQuestionAnswerDetailUrl, (r) {
      if(r.statusCode == 200) {

        if(status == "NotAbort"){
          updateStatus(appointmentid);
          Fluttertoast.showToast(msg: 'Survey Successfully submitted', backgroundColor: Colors.green);
        }
        else if(status == "NotAbortButNextButton") {
          Fluttertoast.showToast(msg: 'This Survey Section Successfully submitted', backgroundColor: Colors.green);
        }
        else{
          Fluttertoast.showToast(msg: 'Survey Successfully submitted', backgroundColor: Colors.green);
        }
        return ResponseModel(statusCode: 1, response: 'Survey Successfully submitted');
      }else{
        AppConstants.showFailToast(context , "Failed submitting Survey");
        return ResponseModel(statusCode: 1, response: 'Failed submitting Survey');
      }
      }, json.encode(credentials));
  } //KARAN (ADD THIS ON LIVE)

  Future<dynamic> getCustomerById(String customerID, String companyId) {
    return getRequestWithParam(ApiUrls.getCustomerByIdUrl, (response) {
      return CustomerDetails.fromJson(json.decode(response.body));
    }, 'intCustomerId=$customerID' + '&${AppStrings.intCompanyIdKey}=$companyId');
  }

  Future<dynamic> getTableById(String appointmentID, String companyId) {
    return getRequestWithParam(ApiUrls.getJmbCloseAppointmentData, (response) {
      print(response.body);
      return CheckCloseJobModel.fromJson(json.decode(response.body));
    }, 'appointmentId=$appointmentID' + '&${AppStrings.intCompanyIdKey}=$companyId');
  }

  Future<dynamic> getEngineerAppointments(String engeenerID, String date, String companyId) {
    return getRequestWithParam(ApiUrls.getEngineerAppointmentsUrl, (response) {
      return (json.decode(response.body)['table'] as List).map((e) => AppTable.fromJson(e)).toList();
    }, 'today=$date' + '&intId=$engeenerID' + '&${AppStrings.intCompanyIdKey}=$companyId');
  }

  Future<dynamic> getTodaysAppointments(String engeenerID, String date, String companyId) {
    return getRequestWithParam(ApiUrls.getEngineerAppointmentsUrl, (response) {
      return (json.decode(response.body)['table'] as List).map((e) => Appointment.fromJson(e)).toList();
    }, 'today=$date' + '&intId=$engeenerID' + '&${AppStrings.intCompanyIdKey}=$companyId');
  }

  Future<dynamic> getRoutePlanDetailEngineerWise(String enginneerID, String dteDate) {
    return getRequestWithParam(ApiUrls.apiRoutePlanner, (response) {
      return (json.decode(response.body)['table1'] as List).map((e) => Table1.fromJson(e)).toList();
    }, 'dteDate=$dteDate' + '&${AppStrings.intEngineerid}=$enginneerID');
  }

  Future<dynamic> getRoutePlannerEngineerBaseLocation(String enginneerID) {
    return getRequestWithParam(ApiUrls.getRoutePlannerEngineerBaseLocation, (response) {
      return EngineerBaseLocation.fromJson(json.decode(response.body));
    }, '&${AppStrings.intEngineerid}=$enginneerID');
  }

  Future<dynamic> getMAICheckProcess(String customerID, String processId, String companyId) {
    return getRequestWithParam(ApiUrls.getMAICheckProcess, (r) {
      final response = json.decode(r.body);
      if (response.toString().toLowerCase() == 'true') {
        return ResponseModel(statusCode: 1, response: 'Successfully Updated');
      } else {
        return ResponseModel(statusCode: 0, response: 'Please try again');
      }
    }, 'intcustomerid=$customerID' + '&strProcessid=$processId' + '&${AppStrings.intCompanyIdKey}=$companyId');
  }

  Future<dynamic> getItemsForOrder(UserModel user) {print(user.id);
    return getRequestWithParam(ApiUrls.getItemsForOrder, (response) {
      return (json.decode(response.body) as List).map((e) => ItemOrder.fromJson(e)).toList();
    }, 'intUserId=${user.id.toString()}' + '&${AppStrings.intCompanyIdKey}=${user.intCompanyId}');
  }

  Future<dynamic> getContractsForOrder(UserModel user) {
    return getRequestWithParam(ApiUrls.getContractsForOrder, (response) {
      return (json.decode(response.body) as List).map((e) => ContractOrder.fromJson(e)).toList();
    }, 'intUserId=${user.id.toString()}' + '&${AppStrings.intCompanyIdKey}=${user.intCompanyId}');
  }

  Future<dynamic> saveOrder(SaveOrder saveOrder) {
    return postRequest(ApiUrls.saveOrder, (r) {
      final response = json.decode(r.body);
      if (response.runtimeType == int) {
        return ResponseModel(statusCode: 1, response: response.toString());
      } else {
        return ResponseModel(statusCode: 0, response: AppStrings.UNABLE_TO_SAVE);
      }
    }, saveOrder.toJson());
  }

  Future<dynamic> saveOrderLine(SaveOrderLine saveOrderLine) {
    return postRequestMap(ApiUrls.saveOrderLine, (r) {
      final response = json.decode(r.body);
      if (response) {
        return ResponseModel(statusCode: 1, response: response.toString());
      } else {
        return ResponseModel(statusCode: 0, response: AppStrings.UNABLE_TO_SAVE);
      }
    }, saveOrderLine.toJson());
  }

  Future<dynamic> getStockCheckRequestList(String intEngineerId, String companyId) {
    return getRequestWithParam(ApiUrls.getStockCheckRequestList, (response) {
      return (json.decode(response.body) as List).map((e) => StockCheckModel.fromJson(e)).toList();
    }, 'intEngineerId=$intEngineerId' + '&${AppStrings.intCompanyIdKey}=$companyId');
  }

  Future<dynamic> getSerialsByRequestId(String intRequestId, String companyId) {
    return getRequestWithParam(ApiUrls.getSerialsByRequestId, (response) {
      return (json.decode(response.body) as List).map((e) => SerialNoModel.fromJson(e)).toList();
    }, 'intRequestId=$intRequestId' + '&${AppStrings.intCompanyIdKey}=$companyId');
  }

  Future<dynamic> validateSerialsForReply(List<SerialNoModel> list, String companyId) {
    final Map<String, dynamic> map = new Map<String, dynamic>();
    map['listSerialModel'] = list.map((e) => e.toJson()).toList();
    map['${AppStrings.intCompanyIdKey}'] = companyId;
    return postRequestList(ApiUrls.validateSerialsForReply, (r) {
      final response = json.decode(r.body);
      if (response != null) {
        return (response as List).map((e) => SerialNoModel.fromJson1(e)).toList();
      } else {
        return ResponseModel(statusCode: 0, response: AppStrings.UNABLE_TO_VALIDATE);
      }
    }, json.encode(map));
  }

  Future<dynamic> saveEngineerReply(StockRequestReplyModel stockRequestReplyModel) {
    return postRequestList(ApiUrls.saveEngineerReply, (r) {
      final response = json.decode(r.body);
      if (response) {
        return ResponseModel(statusCode: 1, response: response.toString());
      } else {
        return ResponseModel(statusCode: 0, response: AppStrings.UNABLE_TO_SAVE);
      }
    }, json.encode(stockRequestReplyModel.toJson()));
  }

  Future<dynamic> getOrderListByEngId(String engId, String companyId) {
    return getRequestWithParam(ApiUrls.getOrderListByEngId, (response) {
      return (json.decode(response.body) as List).map((e) => OrderModel.fromJson(e)).toList();
    }, 'intEngId=$engId' + '&${AppStrings.intCompanyIdKey}=$companyId');
  }

  Future<dynamic> getStockOrderById(String intId, String companyId) {
    return getRequestWithParam(ApiUrls.getStockOrderById, (response) {
      return OrderDetailModel.fromJson(json.decode(response.body));
    }, 'intId=$intId' + '&${AppStrings.intCompanyIdKey}=$companyId');
  }

  Future<dynamic> getStockOrderLineDetails(String intOrderId, String companyId) {
    return getRequestWithParam(ApiUrls.getStockOrderLineDetails, (response) {
      return (json.decode(response.body) as List).map((e) => OrderLineDetailModel.fromJson(e)).toList();
    }, 'intOrderId=$intOrderId' + '&${AppStrings.intCompanyIdKey}=$companyId');
  }

  Future<dynamic> getStockOrderLineItemsByOrderId(String intOrderId, String companyId) {
    return getRequestWithParam(ApiUrls.getStockOrderLineItemsByOrderId, (response) {
      return (json.decode(response.body) as List).map((e) => OrderLineDetailModel.fromJson(e)).toList();
    }, 'intOrderId=$intOrderId' + '&${AppStrings.intCompanyIdKey}=$companyId');
  }

  Future<dynamic> getOrderExportCSVDetails(String intOrderId, String companyId) {
    return getRequestWithParam(ApiUrls.getOrderExportCSVDetails, (response) {
      return (json.decode(response.body) as List).map((e) => OrderExportModel.fromJson(e)).toList();
    }, 'intOrderId=$intOrderId' + '&${AppStrings.intCompanyIdKey}=$companyId');
  }

  Future<dynamic> getSerialListByEmployeeId(String intEngineerId, String companyId) {
    return getRequestWithParam(ApiUrls.getSerialListByEmployeeId, (response) {
      return (json.decode(response.body) as List).map((e) => SerialItemModel.fromJson(e)).toList();
    }, 'intEngineerId=$intEngineerId' + '&${AppStrings.intCompanyIdKey}=$companyId');
  }

  Future<dynamic> getMapRoutePlanner(String lat_lng_origin, String lat_lng_destination) {
    return getRequestWithParamOther(ApiUrls.map_routing_url , (response) {
      var responseval = response.body;
      return responseval;
    }, 'waypoints='+lat_lng_origin+'|'+lat_lng_destination+'&mode=drive&apiKey=41c4b45ff598430bb5417de5feef8f15');
  }

  Future<dynamic> getAgentListByLoginUser(UserModel user) {
    String userId = user.id;
    String companyId = user.intCompanyId;
    return getRequestWithParam(ApiUrls.agentListUrl, (response) {
      return AgentResponseModel.fromJson(json.decode(response.body));
    }, 'intId=30056' + '&${AppStrings.intCompanyIdKey}=$companyId');
  }

  saveSortorderofLocation(Map data) async {
    UserModel user = await Prefs.getUser();
    var url = ApiUrls.baseUrl + ApiUrls.getInsertUpdateRoutePlanData;
    final response = await http.post(Uri.parse(url) , body: jsonEncode(data) ,  headers: {
    'Authorization': 'Bearer ${user.accessToken}' , "Content-Type": "application/json"
    });
    return response.body.toString();
  }

   VerifyEmail(Map data) async {
    UserModel user = await Prefs.getUser();
    var url = ApiUrls.baseUrl + ApiUrls.verifyEmail;
    final response = await http.post(Uri.parse(url) , body: jsonEncode(data) ,  headers: {
      'Authorization': 'Bearer ${user.accessToken}' , "Content-Type": "application/json"
    });
    return response.body.toString();
  }

  Future<dynamic> checkIfEnrouted(UserModel model) {
    return getRequestWithParam(ApiUrls.isEnrouted_url, (response) {
      return response.body.toString();
    }, 'intEngineerId='+model.intEngineerId);
  }

  Future<String> saveAppointments(Map data) async {
    UserModel user = await Prefs.getUser();
    var url = ApiUrls.baseUrl + ApiUrls.saveAppointments;
    final response = await http.post(Uri.parse(url) , body: jsonEncode(data) ,  headers: {
      'Authorization': 'Bearer ${user.accessToken}' , "Content-Type": "application/json"
    });
    return response.body.toString();
  }

  Future<String> uploadFilesWithParameters(String url , List<File> files , Map<String,String> map) async {
    UserModel user = await Prefs.getUser();
    var token = user.accessToken;
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers['Authorization'] = 'Bearer $token';
    for (var file in files) {
      var stream = http.ByteStream(file.openRead());
      var length = await file.length();
      var multipartFile = http.MultipartFile(
        'esignFile',
        stream,
        length,
        filename: file.path.split('/').last,
        contentType: MediaType(CommonUtils().getFileMimeType(file.absolute.path)  , p.extension(file.absolute.path)), // Adjust the media type based on your file
      );
      request.files.add(multipartFile);
    }
    request.fields.addAll(map);
    var response = await request.send();
    return  response.stream.bytesToString();
  }
}