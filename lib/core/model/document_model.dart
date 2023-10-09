// @dart=2.9
import 'package:enstaller/core/constant/app_string.dart';

class DocumentModel {
  String strDocUser;
  String intCreatedBy;
  String intSupplierId;
  String strKey;
  String intCompanyId;

  DocumentModel({
    this.strDocUser,
    this.intCreatedBy,
    this.intSupplierId,
    this.strKey,
    this.intCompanyId,
  });

  DocumentModel.fromJson(Map<String, dynamic> json) {
    strDocUser = json['strDocUser'];
    intCreatedBy = json['intCreatedBy'];
    intSupplierId = json['intSupplierId'];
    strKey = json['strKey'];
    intCompanyId = json[AppStrings.intCompanyIdKey];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['strDocUser'] = this.strDocUser;
    data['intCreatedBy'] = this.intCreatedBy;
    data['intSupplierId'] = this.intSupplierId;
    data['strKey'] = this.strKey;
    data[AppStrings.intCompanyIdKey] = this.intCompanyId;
    return data;
  }
}

class DocumentResponseModel {
  int intId;
  String strDocUser;
  int intDocTypeId;
  String strDocType;
  String strFileName;
  String strName;
  int intSupplierId;
  String strSignedby;
  String strSignedImage;
  String dteSigndate;
  String strSignedName;
  int intModifiedby;
  bool bisEngineerRead;
  bool bisEngineerRead1;
  String strValue;
  String strCreatedDate;
  int intCreatedBy;
  int rownumber;
  int allCOUNT;

  DocumentResponseModel(
      {this.intId,
        this.strDocUser,
        this.intDocTypeId,
        this.strDocType,
        this.strFileName,
        this.strName,
        this.intSupplierId,
        this.strSignedby,
        this.strSignedImage,
        this.dteSigndate,
        this.strSignedName,
        this.intModifiedby,
        this.bisEngineerRead,
        this.bisEngineerRead1,
        this.strValue,
        this.strCreatedDate,
        this.intCreatedBy,
        this.rownumber,
        this.allCOUNT});

  DocumentResponseModel.fromJson(Map<String, dynamic> json) {
    intId = json['intId'];
    strDocUser = json['strDocUser'];
    intDocTypeId = json['intDocTypeId'];
    strDocType = json['strDocType'];
    strFileName = json['strFileName'];
    strName = json['strName'];
    intSupplierId = json['intSupplierId'];
    strSignedby = json['strSignedby'];
    strSignedImage = json['strSignedImage'];
    dteSigndate = json['dteSigndate'];
    strSignedName = json['strSignedName'];
    intModifiedby = json['intModifiedby'];
    bisEngineerRead = json['bisEngineerRead'];
    bisEngineerRead1 = json['bisEngineerRead1'];
    strValue = json['strValue'];
    strCreatedDate = json['strCreatedDate'];
    intCreatedBy = json['intCreatedBy'];
    rownumber = json['rownumber'];
    allCOUNT = json['allCOUNT'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['intId'] = this.intId;
    data['strDocUser'] = this.strDocUser;
    data['intDocTypeId'] = this.intDocTypeId;
    data['strDocType'] = this.strDocType;
    data['strFileName'] = this.strFileName;
    data['strName'] = this.strName;
    data['intSupplierId'] = this.intSupplierId;
    data['strSignedby'] = this.strSignedby;
    data['strSignedImage'] = this.strSignedImage;
    data['dteSigndate'] = this.dteSigndate;
    data['strSignedName'] = this.strSignedName;
    data['intModifiedby'] = this.intModifiedby;
    data['bisEngineerRead'] = this.bisEngineerRead;
    data['bisEngineerRead1'] = this.bisEngineerRead1;
    data['strValue'] = this.strValue;
    data['strCreatedDate'] = this.strCreatedDate;
    data['intCreatedBy'] = this.intCreatedBy;
    data['rownumber'] = this.rownumber;
    data['allCOUNT'] = this.allCOUNT;
    return data;
  }
}