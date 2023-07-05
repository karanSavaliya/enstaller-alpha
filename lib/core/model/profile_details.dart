// @dart=2.9

class ProfileDetails {
  int intId;
  String strName;
  String strEmail;
  String strEngineerPhoto;
  ProfileDetails(
      {this.intId, this.strName, this.strEmail, this.strEngineerPhoto});

  ProfileDetails.fromJson(Map<String, dynamic> json) {
    intId = json['intId'];
    strName = json['strName'];
    strEmail = json['strEmail'];
    strEngineerPhoto = json['strEngineerPhoto'];
  }
}
