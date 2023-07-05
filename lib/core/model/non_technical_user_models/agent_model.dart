// @dart=2.9

class AgentModel {
  int intId;
  String strContractAccountNumber;
  String strBusinessPartner;
  String strContractNumber;
  String strSupplyPostcode;
  String strCustomerEmailAddress;
  String strPursuableDebt;
  String strTotalDebt;
  String strLastPaymentAmount;
  String strCustomerStatus;
  String strAgentName;
  int intAgentId;
  bool bIsMergeDownload;

  AgentModel(
      {this.intId,
      this.strContractAccountNumber,
      this.strBusinessPartner,
      this.strContractNumber,
      this.strSupplyPostcode,
      this.strCustomerEmailAddress,
      this.strPursuableDebt,
      this.strTotalDebt,
      this.strLastPaymentAmount,
      this.strCustomerStatus,
      this.strAgentName,
      this.intAgentId,
      this.bIsMergeDownload});

  AgentModel.fromJson(Map<String, dynamic> json) {
    intId = json['intId'];
    strContractAccountNumber = json['strContractAccountNumber'];
    strBusinessPartner = json['strBusinessPartner'];
    strContractNumber = json['strContractNumber'];
    strSupplyPostcode = json['strSupplyPostcode'];
    strCustomerEmailAddress = json['strCustomerEmailAddress'];
    strPursuableDebt = json['strPursuableDebt'];
    strTotalDebt = json['strTotalDebt'];
    strLastPaymentAmount = json['strLastPaymentAmount'];
    strCustomerStatus = json['strCustomerStatus'];
    strAgentName = json['strAgentName'];
    intAgentId = json['intAgentId'];
    bIsMergeDownload = json['bIsMergeDownload'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['intId'] = this.intId;
    data['strContractAccountNumber'] = this.strContractAccountNumber;
    data['strBusinessPartner'] = this.strBusinessPartner;
    data['strContractNumber'] = this.strContractNumber;
    data['strSupplyPostcode'] = this.strSupplyPostcode;
    data['strCustomerEmailAddress'] = this.strCustomerEmailAddress;
    data['strPursuableDebt'] = this.strPursuableDebt;
    data['strTotalDebt'] = this.strTotalDebt;
    data['strLastPaymentAmount'] = this.strLastPaymentAmount;
    data['strCustomerStatus'] = this.strCustomerStatus;
    data['strAgentName'] = this.strAgentName;
    data['intAgentId'] = this.intAgentId;
    data['bIsMergeDownload'] = this.bIsMergeDownload;
    return data;
  }
}
