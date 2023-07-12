// @dart=2.9
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../core/constant/app_colors.dart';
import '../../core/constant/app_string.dart';
import '../../core/constant/appconstant.dart';
import '../../core/constant/size_config.dart';
import '../../core/provider/app_state_provider.dart';
import '../shared/app_drawer_widget.dart';
import 'document_view.dart';

class EngineerDocumentScreen extends StatefulWidget {
  @override
  _EngineerDocumentScreenState createState() => _EngineerDocumentScreenState();
}

class _EngineerDocumentScreenState extends State<EngineerDocumentScreen> {

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    AppStateProvider appStateProvider = Provider.of<AppStateProvider>(context,listen: false);
    appStateProvider.getEngineerDocument();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light));
    AppStateProvider appStateProvider = Provider.of<AppStateProvider>(context);
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
            child: Icon(Icons.arrow_back),
          ),
        ),
        centerTitle: true,
        title: appStateProvider.searchBool ? TextField(
          controller: controller,
          cursorColor: Colors.white,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: AppStrings.searchHere,
            hintStyle: TextStyle(color: Colors.white),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
              ),
            ),
          ),
          onChanged: (val) {
            appStateProvider.performSearch(val);
          },
        ) : Text(AppStrings.ENGINEER_DOCUMNETS,
          style: getTextStyle(color: AppColors.whiteColor, isBold: false),
        ),
        actions: [
          InkWell(
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(
                appStateProvider.searchBool ? Icons.clear : Icons.search,
                color: AppColors.whiteColor,
              ),
            ),
            onTap: () {
              appStateProvider.onClickSearch();
            },
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.04,
          ),
        ],
      ),
      body: appStateProvider.loading == true ? AppConstants.circulerProgressIndicator() : RefreshIndicator(
        onRefresh: () {
          return Future.delayed(Duration.zero).whenComplete(() => appStateProvider.getEngineerDocument());
        },
        child: appStateProvider.engineerDocumentList.isNotEmpty ? ConstrainedBox(
          constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
          child: Padding(
            padding: SizeConfig.padding,
            child: ListView.builder(
              physics: const ScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
              itemCount: appStateProvider.searchBoxType == false ? appStateProvider.engineerDocumentList.length : appStateProvider.filteredEngineerDocumentList.length,
              itemBuilder: (context, i) {
                return Padding(
                  padding: SizeConfig.verticalC13Padding,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.appointmentBackGroundColor,
                      borderRadius:BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(color: AppColors.lightGrayDotColor)),
                            color: AppColors.darkBlue,
                          ),
                          child: Padding(
                            padding: SizeConfig.padding,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    AppStrings.documentType,
                                    textAlign: TextAlign.end,
                                    style: TextStyle(color: AppColors.whiteColor),
                                  ),
                                ),
                                SizeConfig.horizontalSpaceMedium(),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    appStateProvider.searchBoxType == false ? appStateProvider.engineerDocumentList[i].docTypeName : appStateProvider.filteredEngineerDocumentList[i].docTypeName ?? "",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(color: AppColors.whiteColor),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.lightGrayDotColor))),
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
                                  ),
                                ),
                                SizeConfig.horizontalSpaceMedium(),
                                Expanded(
                                  flex: 3,
                                  child: InkWell(
                                    onTap: () async {
                                      String _url = appStateProvider.searchBoxType == false ? "https://enstall.boshposh.com/Upload/EngineerDocument/" + appStateProvider.engineerDocumentList[i].strEngDocument :
                                      "https://enstall.boshposh.com/Upload/EngineerDocument/" + appStateProvider.filteredEngineerDocumentList[i].strEngDocument;
                                      String extension = _url.split('.').last;
                                      if (extension.toUpperCase() == "PDF") {
                                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => DocumentView(doc: _url)));
                                      } else {
                                        try {
                                          var response = await http.get(Uri.parse(_url));
                                          var dir = await getTemporaryDirectory();
                                          File file = new File(appStateProvider.searchBoxType == false ? dir.path + appStateProvider.engineerDocumentList[i].strEngDocument : dir.path + appStateProvider.filteredEngineerDocumentList[i].strEngDocument);
                                          file.writeAsBytesSync(response.bodyBytes, flush: true);
                                          share(file.path);
                                        } catch (e) {
                                          print("error..........................");
                                          print(e);
                                        }
                                      }
                                    },
                                    child: Text(
                                      appStateProvider.searchBoxType == false ? appStateProvider.engineerDocumentList[i].strEngDocument : appStateProvider.filteredEngineerDocumentList[i].strEngDocument ?? "",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(color: AppColors.darkGrayColor,fontWeight: FontWeight.normal),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ) : Center(child: Text(AppStrings.noDataFound)),
      ),
    );
  }

  Future<void> share(String _url) async {
    await FlutterShare.shareFile(
        title: 'Open Document', text: '', filePath: _url);
  }

  TextStyle getTextStyle({Color color, bool isBold = false, num fontSize}) {
    return TextStyle(
        color: color,
        fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
        fontSize: fontSize);
  }
}