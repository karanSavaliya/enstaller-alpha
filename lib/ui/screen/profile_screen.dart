// @dart=2.9
import 'dart:convert';
import 'dart:io';
import 'package:enstaller/core/constant/app_colors.dart';
import 'package:enstaller/core/constant/app_string.dart';
import 'package:enstaller/core/constant/appconstant.dart';
import 'package:enstaller/core/model/profile_details.dart';
import 'package:enstaller/core/model/user_model.dart';
import 'package:enstaller/core/service/api_service.dart';
import 'package:enstaller/core/service/pref_service.dart';
import 'package:enstaller/ui/shared/app_drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:progress_dialog/progress_dialog.dart';
import '../../core/constant/api_urls.dart';

class ProfilePage extends StatefulWidget {
  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  ProgressDialog progressDialog;
  bool _status = true;
  bool _isChangeImage = false;
  final FocusNode myFocusNode = FocusNode();

  UserModel user;
  String base64ProfilePhoto = '';
  File profilePhoto;
  String profilePhotoPath = '';
  String changedBase64ProfilePhoto = '';
  var image;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    progressDialog = ProgressDialog(context, type: ProgressDialogType.Normal, isDismissible: true, showLogs: true);
    progressDialog.style(message: 'Please Wait');
    getProfileData();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light));
    return new Scaffold(
        key: _scaffoldKey,
        drawer: Drawer(
          child: AppDrawerWidget(),
        ),
        appBar: AppBar(
          brightness: Brightness.dark,
          backgroundColor: AppColors.appThemeColor,
          leading: Padding(
            padding: const EdgeInsets.all(18.0),
            child: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Icon(Icons.arrow_back)),
          ),
          title: Text(
            AppStrings.profile,
            style: TextStyle(color: AppColors.whiteColor),
          ),
        ),
        body: new Container(
          color: Colors.white,
          child: new ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  new Container(
                    height: 250.0,
                    color: Colors.white,
                    child: new Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 20.0),
                          child:
                              new Stack(fit: StackFit.loose, children: <Widget>[
                            new Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                ((base64ProfilePhoto != '')
                                    ? new Container(
                                    width: 140.0,
                                    height: 140.0,
                                    decoration: new BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: AppColors.lightGreyColor,
                                            width: 1.0),
                                        image: new DecorationImage(
                                          image: NetworkImage('${ApiUrls.engineerProfilePhotoUrl}/$base64ProfilePhoto'),
                                          fit: BoxFit.cover,
                                        )))
                                    : new Container(
                                        width: 140.0,
                                        height: 140.0,
                                        decoration: new BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                color: AppColors.lightGreyColor,
                                                width: 1.0),
                                            image: (profilePhotoPath != '')
                                                ? new DecorationImage(
                                                    image: profilePhoto != null ? FileImage(profilePhoto) : ExactAssetImage(
                                                        profilePhotoPath),
                                                    fit: BoxFit.cover,
                                                  )
                                                : new DecorationImage(
                                                    image: new ExactAssetImage(
                                                        'assets/icon/profile.png'),
                                                    fit: BoxFit.cover,
                                                  )))),
                              ],
                            ),
                            Padding(
                                padding:
                                    EdgeInsets.only(top: 90.0, right: 100.0),
                                child: new Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      !_status
                                          ? InkWell(
                                              onTap: () {
                                                _showMyDialog();
                                              },
                                              child: new CircleAvatar(
                                                backgroundColor: Colors.red,
                                                radius: 25.0,
                                                child: new Icon(
                                                  Icons.camera_alt,
                                                  color: Colors.white,
                                                ),
                                              ))
                                          : new Container()
                                    ])),
                          ]),
                        )
                      ],
                    ),
                  ),
                  new Container(
                    color: Color(0xffFFFFFF),
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 25.0),
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: new Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        AppStrings.personalInformation,
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      _status ? _getEditIcon() : _getSaveIcon(),
                                    ],
                                  )
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        AppStrings.name,
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    new Flexible(
                                      child: Text(user?.username ?? ""),
                                    )
                                  ])),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        AppStrings.emailID,
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    new Flexible(
                                      child: Text(user?.email ?? ""),
                                    )
                                  ])),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ));
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    super.dispose();
  }

  Widget _getEditIcon() {
    return new GestureDetector(
      child: new CircleAvatar(
        backgroundColor: Colors.red,
        radius: 14.0,
        child: new Icon(
          Icons.edit,
          color: Colors.white,
          size: 16.0,
        ),
      ),
      onTap: () {
        setState(() {
          _status = false;
        });
      },
    );
  }

  Widget _getSaveIcon() {
    return new GestureDetector(
      child: new CircleAvatar(
        backgroundColor: Colors.red,
        radius: 14.0,
        child: new Icon(
          Icons.save,
          color: Colors.white,
          size: 16.0,
        ),
      ),
      onTap: () {
        setState(() {
          print("Image File Path ==> $profilePhotoPath");
          if (_isChangeImage) {
            _uploadImage();
          } else {
            AppConstants.showFailToast(context, "Please change image before updating profile photo.");
          }
        });
      },
    );
  }

  void getProfileData() async {
    user = await Prefs.getUser();
    setState(() {
      user;
    });
    ProfileDetails details = await _apiService.getProfileInformation(user.intEngineerId);
    //Uint8List _bytesImage = Base64Decoder().convert(details.strEngineerPhoto.replaceAll(AppConstants.base64Prefix, ''));
    final dir = await path_provider.getTemporaryDirectory();
    File file = createFile("${dir.absolute.path}/profile-photo/test.png");
    //file.writeAsBytesSync(_bytesImage);
    setState(() {
      profilePhotoPath = '';
      base64ProfilePhoto = details.strEngineerPhoto;
      _isChangeImage = false;
    });
  }

  void _uploadImage() async {
    progressDialog.show();
    if (image == null) {
      progressDialog.hide();
      return;
    }

    UserModel user = await Prefs.getUser();

    var request = http.MultipartRequest('POST', Uri.parse(ApiUrls.baseUrl + ApiUrls.updateProfilePhoto));
    request.headers['Authorization'] = 'Bearer ${user.accessToken}';
    request.fields['intUserId'] = user.id;
    request.fields['intEngineerId'] = user.intEngineerId;

    var imageFile = await http.MultipartFile.fromPath('strfile', image.path);
    request.files.add(imageFile);
    var response = await request.send();

    if (response.statusCode == 200) {
      AppConstants.showSuccessToast(context, "Profile photo updated successfully.");
      setState(() {
        _isChangeImage = false;
      });
    } else {
      AppConstants.showFailToast(context, "Error Occupied while update profile photo.");
    }

    setState(() {
      _status = true;
    });
    progressDialog.hide();
    getProfileData();
  }

  Future<void> _showMyDialog({File image}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                    onTap: () {
                      _chooseFile(mImage: image, context: context, imageSource: ImageSource.gallery);
                    },
                    child: new CircleAvatar(
                      radius: 30.0,
                      backgroundColor: Colors.grey[100],
                      child: Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Icon(Icons.filter),
                      ),
                    )),
                Padding(
                  padding: EdgeInsets.all(5.0),
                  child: new Text(
                    ' ${AppStrings.gallery}',
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ],
            ),
            // used  for the camera
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                    onTap: () {
                      _chooseFile(mImage: image, context: context, imageSource: ImageSource.camera);
                    },
                    child: new CircleAvatar(
                      radius: 30.0,
                      backgroundColor: Colors.grey[100],
                      child: Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Icon(Icons.camera),
                      ),
                    )),
                Padding(
                  padding: EdgeInsets.all(5.0),
                  child: new Text(
                    ' ${AppStrings.camera}',
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
      },
    );
  }

  File createFile(String path) {
    final file = File(path);
    if (!file.existsSync()) {
      file.createSync(recursive: true);
    }
    return file;
  }

  Future<void> _chooseFile({File mImage, BuildContext context, ImageSource imageSource}) async {
    image = await ImagePicker.pickImage(source: imageSource);
    setState(() {});
    if (image != null) {
      var compressedFile = await FlutterImageCompress.compressWithFile(
        image?.path,
        quality: 50,
        minWidth: 1800,
        minHeight: 1280,
      );
      final dir = await path_provider.getTemporaryDirectory();
      File file = createFile("${dir.absolute.path}/${image.path}/test.png");
      file.writeAsBytesSync(compressedFile);
      changedBase64ProfilePhoto = base64Encode(compressedFile);

      setState(() {
        base64ProfilePhoto = '';
        profilePhoto = file;
        profilePhotoPath = file.path;
        _isChangeImage = true;
      });
    }
    Navigator.pop(context);
  }
}