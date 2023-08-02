class EngineerDocumentModel {
  int? intId;
  String? documentType;
  String? certificateStartDate;
  String? certificateEndDate;
  String? document;
  int? rownumber;
  int? rowsPerPage;
  int? pageNumber;
  String? strsearchtxt;
  int? allCOUNT;

  EngineerDocumentModel(
      {this.intId,
        this.documentType,
        this.certificateStartDate,
        this.certificateEndDate,
        this.document,
        this.rownumber,
        this.rowsPerPage,
        this.pageNumber,
        this.strsearchtxt,
        this.allCOUNT});

  EngineerDocumentModel.fromJson(Map<String, dynamic> json) {
    intId = json['intId'];
    documentType = json['documentType'];
    certificateStartDate = json['certificateStartDate'];
    certificateEndDate = json['certificateEndDate'];
    document = json['document'];
    rownumber = json['rownumber'];
    rowsPerPage = json['rowsPerPage'];
    pageNumber = json['pageNumber'];
    strsearchtxt = json['strsearchtxt'];
    allCOUNT = json['allCOUNT'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['intId'] = this.intId;
    data['documentType'] = this.documentType;
    data['certificateStartDate'] = this.certificateStartDate;
    data['certificateEndDate'] = this.certificateEndDate;
    data['document'] = this.document;
    data['rownumber'] = this.rownumber;
    data['rowsPerPage'] = this.rowsPerPage;
    data['pageNumber'] = this.pageNumber;
    data['strsearchtxt'] = this.strsearchtxt;
    data['allCOUNT'] = this.allCOUNT;
    return data;
  }
}