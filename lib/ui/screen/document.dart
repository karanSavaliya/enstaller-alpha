// @dart=2.9
import 'package:enstaller/core/constant/app_colors.dart';
import 'package:enstaller/core/constant/app_string.dart';
import 'package:enstaller/core/constant/appconstant.dart';
import 'package:enstaller/core/constant/size_config.dart';
import 'package:enstaller/core/enums/view_state.dart';
import 'package:enstaller/core/model/document_model.dart';
import 'package:enstaller/core/provider/base_view.dart';
import 'package:enstaller/core/viewmodel/documnet_viewmodel.dart';
import 'package:enstaller/ui/screen/document_view.dart';
import 'package:enstaller/ui/shared/app_drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_share/flutter_share.dart';

class DocumentScreen extends StatefulWidget {
  @override
  _DocumentScreenState createState() => _DocumentScreenState();
}

class _DocumentScreenState extends State<DocumentScreen> {

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              title: model.searchBool
                  ? TextField(
                      controller: controller,
                      cursorColor: Colors.white,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: AppStrings.searchHere,
                        hintStyle: TextStyle(color: Colors.white),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.white,
                        )),
                      ),
                      onChanged: (val) {
                        model.onSearch(val);
                      },
                    )
                  : Text(
                      AppStrings.DOCUMNETS,
                      style: getTextStyle(
                          color: AppColors.whiteColor, isBold: false),
                    ),
              actions: [
                InkWell(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Icon(
                      model.searchBool ? Icons.clear : Icons.search,
                      color: AppColors.whiteColor,
                    ),
                  ),
                  onTap: () {
                    model.onClickSerach();
                  },
                ),
                // Icon(
                //   Icons.notifications_none,
                //   size: MediaQuery.of(context).size.height * 0.035,
                // ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.04,
                ),
              ],
            ),
            body: model.state == ViewState.Busy
                ? AppConstants.circulerProgressIndicator()
                : RefreshIndicator(
                    onRefresh: () {
                      controller.clear();
                      return Future.delayed(Duration.zero)
                          .whenComplete(() => model.getDocumnetList());
                    },
                    child: ConstrainedBox(
                        constraints: BoxConstraints(
                            maxHeight: MediaQuery.of(context).size.height),
                        child: (model.documentList.isNotEmpty == true)
                            ? Padding(
                                padding: SizeConfig.padding,
                                child: ListView.builder(
                                  physics: const ScrollPhysics(
                                      parent: AlwaysScrollableScrollPhysics()),
                                  itemCount: model.documentList.length,
                                  itemBuilder: (context, i) {
                                    return Padding(
                                      padding: SizeConfig.verticalC13Padding,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: AppColors
                                                .appointmentBackGroundColor,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Column(
                                          children: [
                                            _engineerInfo(
                                                model.documentList[i], model),
//                                Divider(
//                                  color: AppColors.darkGrayColor,
//                                  thickness: 1.0,
//                                ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )
                            : Center(child: Text(AppStrings.noDataFound))),
                  ));
      },
    );
  }

  Future<void> share(String _url) async {
    await FlutterShare.shareFile(
        title: 'Open Document', text: '', filePath: _url);
  }

  // engineer info
  Widget _engineerInfo(
      DocumentResponseModel document, DocumnetViewModel model) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              color: (document.bisEngineerRead ||
                      model.isfileopened[document.intId.toString()])
                  ? Colors.white
                  : AppColors.darkBlue,
              border: Border(
                  bottom: BorderSide(color: AppColors.lightGrayDotColor))),
          child: Padding(
            padding: SizeConfig.padding,
            child: Row(
              children: [
                Expanded(
                    flex: 2,
                    child: Text(
                      AppStrings.documentType,
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: (document.bisEngineerRead ||
                                model.isfileopened[document.intId.toString()])
                            ? Colors.black
                            : AppColors.whiteColor,
                      ),
                    )),
                SizeConfig.horizontalSpaceMedium(),
                Expanded(
                    flex: 3,
                    child: Text(
                      document?.strDocType ?? "",
                      style: TextStyle(
                          color: (document.bisEngineerRead ||
                                  model.isfileopened[document.intId.toString()])
                              ? AppColors.darkGrayColor
                              : Colors.white),
                      textAlign: TextAlign.start,
                    )),
              ],
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: AppColors.lightGrayDotColor))),
          child: Padding(
            padding: SizeConfig.padding,
            child: Row(
              children: [
                Expanded(
                    flex: 2,
                    child: Text(
                      AppStrings.file,
                      textAlign: TextAlign.end,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                SizeConfig.horizontalSpaceMedium(),
                Expanded(
                    flex: 3,
                    child: InkWell(
                      onTap: () async {
                        String _url = document.strValue +
                            "Upload/SupplierDoc/" +
                            document.strFileName;
                        print("url...................$_url");
                        String extension = _url.split('.').last;
                        //String doc = await model.pdfview(_url);
                        //print("doc..............................$doc");
                        if (extension.toUpperCase() == "PDF") {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => DocumentView(
                                    doc: _url,
                                  )));
                          model.onPDFOpen(context, document?.intId.toString());
                        } else {
                          // Open share activity controller.
                          try {
                            var reponse = await http.get(Uri.parse(_url));
                            var dir = await getTemporaryDirectory();
                            File file =
                                new File(dir.path + document.strFileName);
                            file.writeAsBytesSync(reponse.bodyBytes,
                                flush: true);
                            share(file.path);
                          } catch (e) {
                            print("error..........................");
                            print(e);
                          }
                        }
                      },
                      child: Text(
                        document?.strFileName ?? "",
                        style: TextStyle(
                            color: AppColors.darkGrayColor,
                            fontWeight: (document.bisEngineerRead ||
                                    model.isfileopened[
                                        document.intId.toString()])
                                ? FontWeight.normal
                                : FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                    )),
              ],
            ),
          ),
        ),
      ],
    );
  }

  //survey info

  TextStyle getTextStyle({Color color, bool isBold = false, num fontSize}) {
    return TextStyle(
        color: color,
        fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
        fontSize: fontSize);
  }
}
