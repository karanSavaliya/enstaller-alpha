//@dart=2.9

class CustomerDetails {
  String customerName;
  int intId;
  String strTitle;
  String strFirstName;
  String strLastName;
  String strContactName;
  String strCustomerNumber;
  String strAccountNumber;
  String strContactTelephone;
  String strContactSMS;
  String strAddress;
  String strPostCode;
  String strEmail;
  String strSupplyStatus;
  String dteSupplyStartDate;
  bool bisVIP;
  String strUserName;
  String strPassword;
  int intCompanyId;
  String strNotificationPreference;
  String strDataConsent;
  int intCreatedBy;
  String dteCreatedDate;
  String strComment;
  bool bisActive;
  int intOutwardPostCodeId;
  String strFuel;
  double decBalance;
  String strVulnerabilities;
  String strPasswordHash;
  String strPasswordSalt;
  String strBusinessName;
  String strPhoneNo;
  bool isManuallyData;
  bool strVisibleEngineer;
  int intNewCustomerCNT;
  int intTotalCustomerCNT;
  int intAttemptToCrvCNT;
  int intForceStopCNT;
  int intPreCRvLettersendCNT;
  int intHrLettersendCNT;
  int intMeterInstallationCNT;
  int intIssueWarrentCNT;
  String lstCustDasboardCount;
  String strFileName;
  String strFileDate;
  int intCustomercount;
  String dtCreatedDate;
  int rownumber;
  int iTotalItems;
  int iCurrentPage;
  int iPageSize;
  int iTotalPages;
  int iStartPage;
  int iEndPage;
  String pager;
  int intTotalEntries;
  int intShowingEntries;
  String lstHRleterCustomerDetail;
  int intCustomerId;
  String strContractAccountNumber;
  String strContractNumber;
  String strCustomerName;
  int intWorkAllocationId;
  int intHrLetterId;
  String lstHRleterDetail;
  String strMprn;
  String strPursuableDebt;
  String strTotalDebt;

  CustomerDetails(
      {this.customerName,
        this.intId,
        this.strTitle,
        this.strFirstName,
        this.strLastName,
        this.strContactName,
        this.strCustomerNumber,
        this.strAccountNumber,
        this.strContactTelephone,
        this.strContactSMS,
        this.strAddress,
        this.strPostCode,
        this.strEmail,
        this.strSupplyStatus,
        this.dteSupplyStartDate,
        this.bisVIP,
        this.strUserName,
        this.strPassword,
        this.intCompanyId,
        this.strNotificationPreference,
        this.strDataConsent,
        this.intCreatedBy,
        this.dteCreatedDate,
        this.strComment,
        this.bisActive,
        this.intOutwardPostCodeId,
        this.strFuel,
        this.decBalance,
        this.strVulnerabilities,
        this.strPasswordHash,
        this.strPasswordSalt,
        this.strBusinessName,
        this.strPhoneNo,
        this.isManuallyData,
        this.strVisibleEngineer,
        this.intNewCustomerCNT,
        this.intTotalCustomerCNT,
        this.intAttemptToCrvCNT,
        this.intForceStopCNT,
        this.intPreCRvLettersendCNT,
        this.intHrLettersendCNT,
        this.intMeterInstallationCNT,
        this.intIssueWarrentCNT,
        this.lstCustDasboardCount,
        this.strFileName,
        this.strFileDate,
        this.intCustomercount,
        this.dtCreatedDate,
        this.rownumber,
        this.iTotalItems,
        this.iCurrentPage,
        this.iPageSize,
        this.iTotalPages,
        this.iStartPage,
        this.iEndPage,
        this.pager,
        this.intTotalEntries,
        this.intShowingEntries,
        this.lstHRleterCustomerDetail,
        this.intCustomerId,
        this.strContractAccountNumber,
        this.strContractNumber,
        this.strCustomerName,
        this.intWorkAllocationId,
        this.intHrLetterId,
        this.lstHRleterDetail,
        this.strMprn,
        this.strPursuableDebt,
        this.strTotalDebt});

  CustomerDetails.fromJson(Map<String, dynamic> json) {
    customerName = json['customerName'];
    intId = json['intId'];
    strTitle = json['strTitle'];
    strFirstName = json['strFirstName'];
    strLastName = json['strLastName'];
    strContactName = json['strContactName'];
    strCustomerNumber = json['strCustomerNumber'];
    strAccountNumber = json['strAccountNumber'];
    strContactTelephone = json['strContact_Telephone'];
    strContactSMS = json['strContact_SMS'];
    strAddress = json['strAddress'];
    strPostCode = json['strPostCode'];
    strEmail = json['strEmail'];
    strSupplyStatus = json['strSupply_Status'];
    dteSupplyStartDate = json['dteSupply_Start_Date'];
    bisVIP = json['bisVIP'];
    strUserName = json['strUserName'];
    strPassword = json['strPassword'];
    intCompanyId = json['intCompanyId'];
    strNotificationPreference = json['strNotification_Preference'];
    strDataConsent = json['strData_Consent'];
    intCreatedBy = json['intCreatedBy'];
    dteCreatedDate = json['dteCreatedDate'];
    strComment = json['strComment'];
    bisActive = json['bisActive'];
    intOutwardPostCodeId = json['intOutwardPostCodeId'];
    strFuel = json['strFuel'];
    decBalance = json['decBalance'];
    strVulnerabilities = json['strVulnerabilities'];
    strPasswordHash = json['strPasswordHash'];
    strPasswordSalt = json['strPasswordSalt'];
    strBusinessName = json['strBusinessName'];
    strPhoneNo = json['strPhoneNo'];
    isManuallyData = json['isManuallyData'];
    strVisibleEngineer = json['strVisibleEngineer'];
    intNewCustomerCNT = json['intNewCustomerCNT'];
    intTotalCustomerCNT = json['intTotalCustomerCNT'];
    intAttemptToCrvCNT = json['intAttemptToCrvCNT'];
    intForceStopCNT = json['intForceStopCNT'];
    intPreCRvLettersendCNT = json['intPreCRvLettersendCNT'];
    intHrLettersendCNT = json['intHrLettersendCNT'];
    intMeterInstallationCNT = json['intMeterInstallationCNT'];
    intIssueWarrentCNT = json['intIssueWarrentCNT'];
    lstCustDasboardCount = json['lstCustDasboardCount'];
    strFileName = json['strFileName'];
    strFileDate = json['strFileDate'];
    intCustomercount = json['intCustomercount'];
    dtCreatedDate = json['dtCreatedDate'];
    rownumber = json['rownumber'];
    iTotalItems = json['iTotalItems'];
    iCurrentPage = json['iCurrentPage'];
    iPageSize = json['iPageSize'];
    iTotalPages = json['iTotalPages'];
    iStartPage = json['iStartPage'];
    iEndPage = json['iEndPage'];
    pager = json['pager'];
    intTotalEntries = json['intTotalEntries'];
    intShowingEntries = json['intShowingEntries'];
    lstHRleterCustomerDetail = json['lstHRleterCustomerDetail'];
    intCustomerId = json['intCustomerId'];
    strContractAccountNumber = json['strContractAccountNumber'];
    strContractNumber = json['strContractNumber'];
    strCustomerName = json['strCustomerName'];
    intWorkAllocationId = json['intWorkAllocationId'];
    intHrLetterId = json['intHrLetterId'];
    lstHRleterDetail = json['lstHRleterDetail'];
    strMprn = json['strMprn'];
    strPursuableDebt = json['strPursuableDebt'];
    strTotalDebt = json['strTotalDebt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customerName'] = this.customerName;
    data['intId'] = this.intId;
    data['strTitle'] = this.strTitle;
    data['strFirstName'] = this.strFirstName;
    data['strLastName'] = this.strLastName;
    data['strContactName'] = this.strContactName;
    data['strCustomerNumber'] = this.strCustomerNumber;
    data['strAccountNumber'] = this.strAccountNumber;
    data['strContact_Telephone'] = this.strContactTelephone;
    data['strContact_SMS'] = this.strContactSMS;
    data['strAddress'] = this.strAddress;
    data['strPostCode'] = this.strPostCode;
    data['strEmail'] = this.strEmail;
    data['strSupply_Status'] = this.strSupplyStatus;
    data['dteSupply_Start_Date'] = this.dteSupplyStartDate;
    data['bisVIP'] = this.bisVIP;
    data['strUserName'] = this.strUserName;
    data['strPassword'] = this.strPassword;
    data['intCompanyId'] = this.intCompanyId;
    data['strNotification_Preference'] = this.strNotificationPreference;
    data['strData_Consent'] = this.strDataConsent;
    data['intCreatedBy'] = this.intCreatedBy;
    data['dteCreatedDate'] = this.dteCreatedDate;
    data['strComment'] = this.strComment;
    data['bisActive'] = this.bisActive;
    data['intOutwardPostCodeId'] = this.intOutwardPostCodeId;
    data['strFuel'] = this.strFuel;
    data['decBalance'] = this.decBalance;
    data['strVulnerabilities'] = this.strVulnerabilities;
    data['strPasswordHash'] = this.strPasswordHash;
    data['strPasswordSalt'] = this.strPasswordSalt;
    data['strBusinessName'] = this.strBusinessName;
    data['strPhoneNo'] = this.strPhoneNo;
    data['isManuallyData'] = this.isManuallyData;
    data['strVisibleEngineer'] = this.strVisibleEngineer;
    data['intNewCustomerCNT'] = this.intNewCustomerCNT;
    data['intTotalCustomerCNT'] = this.intTotalCustomerCNT;
    data['intAttemptToCrvCNT'] = this.intAttemptToCrvCNT;
    data['intForceStopCNT'] = this.intForceStopCNT;
    data['intPreCRvLettersendCNT'] = this.intPreCRvLettersendCNT;
    data['intHrLettersendCNT'] = this.intHrLettersendCNT;
    data['intMeterInstallationCNT'] = this.intMeterInstallationCNT;
    data['intIssueWarrentCNT'] = this.intIssueWarrentCNT;
    data['lstCustDasboardCount'] = this.lstCustDasboardCount;
    data['strFileName'] = this.strFileName;
    data['strFileDate'] = this.strFileDate;
    data['intCustomercount'] = this.intCustomercount;
    data['dtCreatedDate'] = this.dtCreatedDate;
    data['rownumber'] = this.rownumber;
    data['iTotalItems'] = this.iTotalItems;
    data['iCurrentPage'] = this.iCurrentPage;
    data['iPageSize'] = this.iPageSize;
    data['iTotalPages'] = this.iTotalPages;
    data['iStartPage'] = this.iStartPage;
    data['iEndPage'] = this.iEndPage;
    data['pager'] = this.pager;
    data['intTotalEntries'] = this.intTotalEntries;
    data['intShowingEntries'] = this.intShowingEntries;
    data['lstHRleterCustomerDetail'] = this.lstHRleterCustomerDetail;
    data['intCustomerId'] = this.intCustomerId;
    data['strContractAccountNumber'] = this.strContractAccountNumber;
    data['strContractNumber'] = this.strContractNumber;
    data['strCustomerName'] = this.strCustomerName;
    data['intWorkAllocationId'] = this.intWorkAllocationId;
    data['intHrLetterId'] = this.intHrLetterId;
    data['lstHRleterDetail'] = this.lstHRleterDetail;
    data['strMprn'] = this.strMprn;
    data['strPursuableDebt'] = this.strPursuableDebt;
    data['strTotalDebt'] = this.strTotalDebt;
    return data;
  }
}