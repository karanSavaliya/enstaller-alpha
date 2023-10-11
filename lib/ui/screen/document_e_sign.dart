// @dart=2.9
import 'dart:convert';
import 'package:enstaller/core/constant/app_colors.dart';
import 'package:enstaller/core/constant/app_string.dart';
import 'package:enstaller/core/provider/base_view.dart';
import 'package:enstaller/core/viewmodel/documnet_viewmodel.dart';
import 'package:enstaller/ui/screen/document.dart';
import 'package:enstaller/ui/shared/app_drawer_widget.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter_signature_pad/flutter_signature_pad.dart';
import 'package:flutter/services.dart';
import '../../core/constant/appconstant.dart';
import '../../core/model/user_model.dart';
import '../../core/provider/app_state_provider.dart';
import 'package:provider/provider.dart';
import '../../core/service/pref_service.dart';

class DocumentESignScreen extends StatefulWidget {
  int intId;
  DocumentESignScreen({this.intId, Key key}) : super(key: key);
  @override
  _DocumentESignScreenState createState() => _DocumentESignScreenState();
}

class _DocumentESignScreenState extends State<DocumentESignScreen> {
  ByteData _img = ByteData(0);
  var color = Colors.red;
  var strokeWidth = 5.0;
  final _sign = GlobalKey<SignatureState>();

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController signatureBy = TextEditingController();

  FocusNode _textFieldFocusNode = FocusNode();

  @override
  void initState() {
    _textFieldFocusNode.unfocus();
    getEngineerName();
    super.initState();
  }

  void getEngineerName() async{
    UserModel user = await Prefs.getUser();
    signatureBy.text = user.strEngineerName;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    AppStateProvider appStateProvider = Provider.of<AppStateProvider>(context);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light));
    return BaseView<DocumnetViewModel>(
      onModelReady: (model) => model.getDocumnetList(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: AppColors.scafoldColor,
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
            centerTitle: true,
            title: Text(
              AppStrings.DOCUMNETSESIGN,
              style: getTextStyle(color: AppColors.whiteColor, isBold: false),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: <Widget>[
                TextFormField(
                  focusNode: _textFieldFocusNode,
                  controller: signatureBy,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: "Signature By",
                    isDense: true,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.appThemeColor),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.appThemeColor),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  height: MediaQuery.of(context).size.width / 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Signature(
                      color: color,
                      key: _sign,
                      onSign: () {
                        final sign = _sign.currentState;
                        debugPrint(
                            '${sign.points.length} points in the signature');
                      },
                      strokeWidth: strokeWidth,
                    ),
                  ),
                  color: Colors.black12,
                ),
                SizedBox(height: 15),
                Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            width: MediaQuery.of(context).size.width/2,
                            height: 50,
                            child: MaterialButton(
                              color: Colors.green,
                              onPressed: () async {
                                final sign = _sign.currentState;
                                if(sign.points.length == 0){
                                  AppConstants.showFailToast(context, "E-Signature Compulsory");
                                }
                                else{
                                  AppConstants.showSuccessToast(context, "Wait a Few seconds...");
                                  _textFieldFocusNode.unfocus();
                                  final image = await sign.getData();
                                  var data = await image.toByteData(format: ui.ImageByteFormat.png);
                                  final encoded = base64.encode(data.buffer.asUint8List());
                                  setState(() {
                                    _img = data;
                                  });

                                  String eSignStatus = await appStateProvider.insertSupplierEngineerImage(encoded);

                                  if(eSignStatus == "failed"){
                                    AppConstants.showFailToast(context, "Failed to upload signature");
                                  }
                                  else{
                                    String readStatus = await appStateProvider.updateSupplierDocumentEngineerRead(eSignStatus, widget.intId, signatureBy.text);
                                    setState(() {
                                      signatureBy.text = "";
                                      sign.clear();
                                    });
                                    if(readStatus == "True"){
                                      AppConstants.showSuccessToast(context, "Saved Successfully");
                                      Navigator.of(context).push(new MaterialPageRoute(builder: (context) => DocumentScreen()));
                                    }
                                    else{
                                      AppConstants.showFailToast(context, "Failed submitting Signature");
                                    }
                                  }
                                }
                              },
                              child: Text("Submit Signature"),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Container(
                            width: MediaQuery.of(context).size.width/2,
                            height: 50,
                            child: MaterialButton(
                              color: Colors.grey,
                              onPressed: () {
                                final sign = _sign.currentState;
                                sign.clear();
                                setState(() {
                                  _img = ByteData(0);
                                });
                              },
                              child: Text("Clear Signature"),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  TextStyle getTextStyle({Color color, bool isBold = false, num fontSize}) {
    return TextStyle(
      color: color,
      fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
      fontSize: fontSize,
    );
  }
} //KARAN (ADD THIS ON LIVE)
