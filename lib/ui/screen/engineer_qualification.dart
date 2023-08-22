// @dart=2.9
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../core/constant/api_urls.dart';
import '../../core/constant/app_colors.dart';
import '../../core/constant/app_string.dart';
import '../../core/constant/appconstant.dart';
import '../../core/constant/size_config.dart';
import '../../core/provider/app_state_provider.dart';
import '../shared/app_drawer_widget.dart';
import 'document_view.dart';

class EngineerQualificationScreen extends StatefulWidget {
  @override
  _EngineerQualificationScreenState createState() => _EngineerQualificationScreenState();
}

class _EngineerQualificationScreenState extends State<EngineerQualificationScreen> {

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    AppStateProvider appStateProvider = Provider.of<AppStateProvider>(context,listen: false);
    appStateProvider.isReadEngineerQualificationMain.clear();
    appStateProvider.isReadEngineerQualificationSearch.clear();
    appStateProvider.isReadEngineerQualificationFilter.clear();
    appStateProvider.getEngineerQualification();
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
        title: appStateProvider.searchBoolQualification ? TextField(
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
            appStateProvider.performSearchQualification(val);
          },
        ) : Text(AppStrings.ENGINEER_QUALIFICATION,
          style: getTextStyle(color: AppColors.whiteColor, isBold: false,fontSize: 17.0),
        ),
        actions: [
          InkWell(
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(
                appStateProvider.searchBoolQualification ? Icons.clear : Icons.search,
                color: AppColors.whiteColor,
              ),
            ),
            onTap: () {
              appStateProvider.onClickSearchQualification();
            },
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.04,
          ),
        ],
      ),
      body: appStateProvider.loadingQualification == true ? AppConstants.circulerProgressIndicator() : RefreshIndicator(
        onRefresh: () {
          appStateProvider.isReadEngineerQualificationSearch.clear();
          appStateProvider.isReadEngineerQualificationFilter.clear();
          appStateProvider.isReadEngineerQualificationMain.clear();
          return Future.delayed(Duration.zero).whenComplete(() => appStateProvider.getEngineerQualification());
        },
        child: appStateProvider.engineerQualificationList.isNotEmpty ? ConstrainedBox(
          constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
          child: Padding(
            padding: SizeConfig.padding,
            child: ListView.builder(
              physics: const ScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              itemCount: appStateProvider.searchBoxTypeQualification == false ? appStateProvider.engineerQualificationList.length : appStateProvider.filteredEngineerQualificationList.length,
              itemBuilder: (context, i) {
                if(appStateProvider.searchBoxTypeQualification == false){
                  appStateProvider.isReadEngineerQualificationMain.add(false);
                }
                return Padding(
                  padding: SizeConfig.verticalC13Padding,
                  child: InkWell(
                    onTap: () async {
                      if(appStateProvider.searchBoxTypeQualification == false){
                        setState(() {
                          appStateProvider.isReadEngineerQualificationMain[i] = true;
                        });
                      }
                      else{
                        setState(() {
                          int filteredList = appStateProvider.engineerQualificationList.indexOf(appStateProvider.filteredEngineerQualificationList[i]);
                          appStateProvider.isReadEngineerQualificationMain[filteredList] = true;
                          appStateProvider.isReadEngineerQualificationSearch[i] = true;
                        });
                      }
                      String _url = appStateProvider.searchBoxTypeQualification == false ? "${ApiUrls.engineerQualificationUrl}" + appStateProvider.engineerQualificationList[i].strEngQualificationDoc :
                      "${ApiUrls.engineerQualificationUrl}" + appStateProvider.filteredEngineerQualificationList[i].strEngQualificationDoc;
                      String extension = _url.split('.').last;
                      if (extension.toUpperCase() == "PDF") {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => DocumentView(doc: _url)));
                      } else {
                        try {
                          var response = await http.get(Uri.parse(_url));
                          var dir = await getTemporaryDirectory();
                          File file = new File(appStateProvider.searchBoxTypeQualification == false ? dir.path + appStateProvider.engineerQualificationList[i].strEngQualificationDoc : dir.path + appStateProvider.filteredEngineerQualificationList[i].strEngQualificationDoc);
                          file.writeAsBytesSync(response.bodyBytes, flush: true);
                          share(file.path);
                        } catch (e) {
                          print("error..........................");
                          print(e);
                        }
                      }
                    },
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
                              color: appStateProvider.searchBoxTypeQualification == false ? appStateProvider.isReadEngineerQualificationMain[i] == false ? AppColors.darkBlue : AppColors.whiteColor : appStateProvider.isReadEngineerQualificationSearch[i] == false ? AppColors.darkBlue : AppColors.whiteColor,
                            ),
                            child: Padding(
                              padding: SizeConfig.padding,
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      AppStrings.productType,
                                      textAlign: TextAlign.end,
                                      style: TextStyle(color: appStateProvider.searchBoxTypeQualification == false ? appStateProvider.isReadEngineerQualificationMain[i] == false ? AppColors.whiteColor : AppColors.black : appStateProvider.isReadEngineerQualificationSearch[i] == false ? AppColors.whiteColor : AppColors.black,fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizeConfig.horizontalSpaceMedium(),
                                  Expanded(
                                    flex: 3,
                                    child: Text(
                                      appStateProvider.searchBoxTypeQualification == false ? appStateProvider.engineerQualificationList[i].strProductTypeName : appStateProvider.filteredEngineerQualificationList[i].strProductTypeName ?? "",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(color: appStateProvider.searchBoxTypeQualification == false ? appStateProvider.isReadEngineerQualificationMain[i] == false ? AppColors.whiteColor : AppColors.darkGrayColor : appStateProvider.isReadEngineerQualificationSearch[i] == false ? AppColors.whiteColor : AppColors.darkGrayColor),
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
                                      AppStrings.qualificationType,
                                      textAlign: TextAlign.end,
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizeConfig.horizontalSpaceMedium(),
                                  Expanded(
                                    flex: 3,
                                    child: Text(
                                      appStateProvider.searchBoxTypeQualification == false ? appStateProvider.engineerQualificationList[i].strQualificationName : appStateProvider.filteredEngineerQualificationList[i].strQualificationName ?? "",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(color: AppColors.darkGrayColor,fontWeight: appStateProvider.searchBoxTypeQualification == false ? appStateProvider.isReadEngineerQualificationMain[i] == false ? FontWeight.bold : FontWeight.normal : appStateProvider.isReadEngineerQualificationSearch[i] == false ? FontWeight.bold : FontWeight.normal),
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
                                    child: Text(
                                      appStateProvider.searchBoxTypeQualification == false ? appStateProvider.engineerQualificationList[i].strEngQualificationDoc : appStateProvider.filteredEngineerQualificationList[i].strEngQualificationDoc ?? "",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(color: AppColors.darkGrayColor,fontWeight: appStateProvider.searchBoxTypeQualification == false ? appStateProvider.isReadEngineerQualificationMain[i] == false ? FontWeight.bold : FontWeight.normal : appStateProvider.isReadEngineerQualificationSearch[i] == false ? FontWeight.bold : FontWeight.normal),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
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