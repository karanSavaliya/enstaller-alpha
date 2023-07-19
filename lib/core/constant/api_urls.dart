
class ApiUrls {
  static bool isLive = false;
  static String baseUrl = isLive
      ? 'https://enstallapi.enpaas.com/api/'
      : 'https://enstallapi.boshposh.com/api/';

  static String baseUrlOther = "https://api.geoapify.com/v1/";

  static String logInUrl = 'users/login';
  static String updateProfilePhoto = 'Engineer/UpdateEngineerProfile';
  static String getProfilePhoto = 'Engineer/getEngineerListOne';
  static String getAppointMentListUrl = 'appointments/GetAppointmentByEngineerId';
  static String getMeterSerialNoEngineerwiseUrl = 'Engineer/GetSTKMeterSerialNoEngineerwise';
  static String getappointmenttodaytomorrow = 'appointments/GetAppointmentByEngineerIdTodayTomorrow';
  static String getReasonUserList = 'ReasonUserMap/GetReasonUserList';
  static String updateAbortAppointment = 'appointments/UpdateAbortAppointment';
  static String getActivityLogsAppointmentIdUrl = 'appointments/GetActivityLogsAppointmentId';
  static String getAppointmentCommentsByAppointmentUrl = 'AppointmentComments/GetAppointmentCommentsByAppointment';
  static String getAppointmentCommentsByAppointmentUrl2 = 'AppointmentComments/GetAppointmentCommentsList';

  static String saveAppointmentComments = 'AppointmentComments/SaveAppointmentComments';
  static String getAppointmentDetailsUrl = 'appointments/Get';
  static String getUserRole = 'stkUser/GetUserRole';
  static String getStockLocation = 'WarehouseEngineer/BindLocationBasedOnWarehouseUser';
  static String getStockBatch = 'WarehouseEngineer/BindBatchesBasedOnWarehouseUserId';
  static String getStockStatus = 'Stock/BindStockStatus';
  static String getPallets = 'WarehouseEngineer/BindPalletListBasedOnBatchId';
  static String getOrderAssigned = 'AssignStock/IsOrderAssigned';
  static String checkSerialNo = 'AssignStock/CheckSerialNoForOrder';
  static String saveCheckandassignorder = 'AssignStock/SaveAssignStockToOrder';
  static String updateStatusBatchWise =
      'WarehouseEngineer/UpdateStatusBatchSerialWise';
  static String getorderByReference = 'AssignStock/GetOrderByReference';
  static String getCheckStockOrderLineDetails =
      'Order/GetStockOrderLineDetails';
  static String getdownloadformat = 'ConfigSetting/ConfigSettingListOne';
  static String getCustomerMeterListByCustomerUrl =
      'CustomerMeter/GetCustomerMeterListByCustomer';
  static String appointmentDataEventsbyEngineerUrl =
      'AppointmentEvents/AppointmentDataEventsbyEngineer';
  static String assignEngineerAppointmentUrl =
      'appointments/AssignEngineerAppointment';
  static String updateAppointmentStatusUrl =
      'appointments/UpdateAppointmentStatus';
  static String abortappointmentreason =
      'appointments/UpdateAbortAppointmentbyReason';
  static String getSurveyQuestionAppointmentWiseUrl =
      'SurveyQuetion/GetSurveyQuestionAppointmentWise';
  static String addSurveyQuestionAnswerDetailUrl =
      'SurveyQuestionAnswer/AddSurveyQuestionAnswerDetail';
  static String supplierDocumentUpdateEngineerRead =
      'SupplierDocument/SupplierDocumentUpdateEngineerRead';
  static String getCustomerByIdUrl = 'Customer/GetCustomerById';
  static String getJmbCloseAppointmentData =
      'jmbClose/GetJmbCloseAppointmentData';
  static String getEngineerAppointmentsUrl =
      'appointments/GetEngineerAppointments';
  static String getAppointmentByEngineerIdUrl =
      'appointments/GetAppointmentByEngineerId';
  static String getSurveyQuestionAnswerDetailUrl =
      'SurveyQuestionAnswer/GetSurveyQuestionAnswerDetail';
  static String getSupplierDocument =
      'SupplierDocument/GetSupplierDocumentListUserwise';
  static String getEmailTemplateSenderHistoryUserWise =
      'EmailTemplateSenderHistory/GetEmailTemplateSenderHistoryUserWise';
  static String getSMSClickSendNotificationUserWise =
      'SMSClickSendHistory/GetSMSClickSendNotificationUserWise';
  static String getMAICheckProcess = 'DCCMAI/GetMAICheckProcess';
  //order
  static String updateCallForwardAppointment =
      'appointments/UpdateCallForwardAppointment';
  static String getItemsForOrder = 'Order/BindUserContractWiseItemModel';
  static String getContractsForOrder = 'Location/GetStockContractList';
  static String saveOrder = 'Order/InsertUpdateDeleteOrder';
  static String saveOrderLine = 'Order/InsertUpdateDeleteOrderLineItems';
  static String getOrderListByEngId = 'Order/GetOrderListByEngId';
  static String getStockOrderById = 'Order/GetStockOrderById';
  static String getStockOrderLineDetails = 'Order/GetStockOrderLineDetails';
  static String getOrderExportCSVDetails = 'Order/OrderExportCSVDetails';
  //stock check
  static String getStockCheckRequestList =
      'StockCheckRequest/GetEngineerWiseStockRquestList';
  static String validateSerialsForReply = 'StockCheckRequest/ValidateSerials';
  static String saveEngineerReply = 'StockCheckRequest/SaveEngineerReply';
  static String getSerialsByRequestId =
      'StockCheckRequest/GetSerialsByRequestId';
  static String getStockOrderLineItemsByOrderId =
      'Order/GetStockOrderLineItemsByOrderId';
  static String getSerialListByEmployeeId =
      'stkEngineerWiseStock/GetSerialListByEmployeeId';
  static String saveCloseJobElectricity = 'jmbCloseJob/SaveCloseJobElectricity';
  static String saveCloseJobGas = 'jmbCloseJob/SaveCloseJobGas';

  static String agentListUrl = 'Agent/GetAgentWorkAllocationList';

  static String apiRoutePlanner = 'RoutePlanner/GetRoutePlanDetailEngineerWise';
  static String getRoutePlannerEngineerBaseLocation = 'RoutePlanner/GetRoutePlannerEngineerBaseLocation';
  static String getInsertUpdateRoutePlanData =  'RoutePlanner/InsertUpdateRoutePlanData';
  static String verifyEmail =  'UserLoginActivity/CheckEmail';
  static String resetEmail =  'UserLoginActivity/CheckCode';
  static String saveAppointments  = 'AppointmentComments/SaveAppointmentComments';
  static String insertAttachment = 'AppointmentComments/InsetAppointmentAttachmentFile';


  static String map_routing_url = 'routing';
  static String isEnrouted_url = "appointments/GetCheckInRouteAppointment";


  static String engineerDocumentList = baseUrl + "Engineer/GetEnginnerDocumentList";

  static String engineerProfilePhotoUrl = "https://enstall.boshposh.com/Upload/EngineerPhoto";
}