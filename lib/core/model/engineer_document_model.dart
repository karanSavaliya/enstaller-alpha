class EngineerDocumentModel {
  int? intId;
  int? intEngDocTypeId;
  String? docTypeName;
  String? dteCertificateStartDate;
  String? dteCertificateEndDate;
  String? strEngDocument;

  EngineerDocumentModel({
    this.intId,
    this.intEngDocTypeId,
    this.docTypeName,
    this.dteCertificateStartDate,
    this.dteCertificateEndDate,
    this.strEngDocument,
  });

  factory EngineerDocumentModel.fromJson(Map<String, dynamic> json) {
    return EngineerDocumentModel(
      intId: json['intId'],
      intEngDocTypeId: json['intEngDocTypeId'],
      docTypeName: json['docTypeName'],
      dteCertificateStartDate: json['dteCertificateStartDate'],
      dteCertificateEndDate: json['dteCertificateEndDate'],
      strEngDocument: json['strEngDocument'],
    );
  }
}