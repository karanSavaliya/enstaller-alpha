// @dart=2.9
import 'package:enstaller/core/constant/app_colors.dart';
import 'package:enstaller/core/constant/appconstant.dart';
import 'package:enstaller/core/constant/image_file.dart';
import 'package:enstaller/core/constant/size_config.dart';
import 'package:enstaller/core/constant/text_style.dart';
import 'package:enstaller/core/enums/view_state.dart';
import 'package:enstaller/core/provider/base_view.dart';
import 'package:provider/provider.dart';
import 'package:enstaller/core/service/pref_service.dart';
import 'package:enstaller/core/viewmodel/get_user_details_viewmodel.dart';
import 'package:enstaller/ui/screen/appointments.dart';
import 'package:enstaller/ui/screen/check_request_screen.dart';
import 'package:enstaller/ui/screen/order_screen.dart';
import 'package:enstaller/ui/screen/document.dart';
import 'package:enstaller/ui/screen/home_screen.dart';
import 'package:enstaller/ui/screen/profile_screen.dart';
import 'package:enstaller/ui/screen/stock_check_request_screen.dart';
import 'package:enstaller/ui/screen/today_appointments.dart';
import 'package:enstaller/ui/screen/widget/drawer_row_widget.dart';
import 'package:flutter/material.dart';
import '../../core/constant/api_urls.dart';
import '../../core/model/profile_details.dart';
import '../../core/model/user_model.dart';
import '../../core/provider/app_state_provider.dart';
import '../../core/service/api_service.dart';
import '../screen/engineer_document.dart';
import '../screen/engineer_qualification.dart';

class AppDrawerWidget extends StatefulWidget {
  @override
  State<AppDrawerWidget> createState() => _AppDrawerWidgetState();
}

class _AppDrawerWidgetState extends State<AppDrawerWidget> {
  @override
  void initState() {
    super.initState();
    getVehicleStatus();
    getProfileData();
  } //KARAN (ADD THIS ON LIVE)

  UserModel user;
  String base64ProfilePhoto = '';
  ApiService _apiService = ApiService(); //KARAN (ADD THIS ON LIVE)
  bool getVehicleSuccess; //KARAN (ADD THIS ON LIVE)

  void getVehicleStatus() async {
    AppStateProvider appStateProvider = Provider.of<AppStateProvider>(context,listen: false);
    getVehicleSuccess = await appStateProvider.getVehicleLog();
  } //KARAN (ADD THIS ON LIVE)

  void getProfileData() async {
    user = await Prefs.getUser();
    setState(() {
      user;
    });
    ProfileDetails details =
        await _apiService.getProfileInformation(user.intEngineerId);
    setState(() {
      base64ProfilePhoto = details.strEngineerPhoto;
    });
  } //KARAN (ADD THIS ON LIVE)

  @override
  Widget build(BuildContext context) {
    AppStateProvider appStateProvider = Provider.of<AppStateProvider>(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DrawerHeader(
          child: BaseView<GetUserDetailsViewModel>(
            onModelReady: (model) => model.getUserDetails(),
            builder: (context, model, child) {
              if (model.state == ViewState.Busy) {
                return AppConstants.circulerProgressIndicator();
              } else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        ((base64ProfilePhoto.isNotEmpty)
                            ? InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                      new MaterialPageRoute(
                                          builder: (context) => ProfilePage()));
                                },
                                child: new Container(
                                    width: 50,
                                    height: 50,
                                    decoration: new BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: AppColors.lightGreyColor,
                                            width: 1.0),
                                        image: new DecorationImage(
                                          image: NetworkImage(
                                              '${ApiUrls.engineerProfilePhotoUrl}/$base64ProfilePhoto'),
                                          fit: BoxFit.cover,
                                        ))),
                              )
                            : InkWell(
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  child: Center(
                                    child: Text(
                                      AppConstants.nameTitle(
                                              model.user.username)
                                          .toUpperCase(),
                                      style: AppStyles.GreenStyle_Font,
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.whiteColor),
                                ),
                                onTap: () {
                                  Navigator.of(context).push(
                                      new MaterialPageRoute(
                                          builder: (context) => ProfilePage()));
                                },
                              )), //KARAN (ADD THIS ON LIVE)
                        SizeConfig.horizontalSpaceSmall(),
                        Expanded(
                          child: InkWell(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  model.user.username ?? "",
                                  style: AppStyles.WhiteStyle_Font20.copyWith(
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  model.user.email ?? "",
                                  style: AppStyles.WhiteStyle_Font20,
                                )
                              ],
                            ),
                            onTap: () {
                              Navigator.of(context).push(new MaterialPageRoute(
                                  builder: (context) => ProfilePage()));
                            },
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Align(
                          child: GestureDetector(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: getVehicleSuccess == true ? Colors.grey : AppColors.whiteColor,
                              ),
                              height: 30,
                              width: MediaQuery.of(context).size.width / 2,
                              child: Center(
                                child: Text(
                                  "Vehicle Checkout",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            onTap: () async {
                              getVehicleSuccess = await appStateProvider.getVehicleLog();
                              if(getVehicleSuccess){
                                AppConstants.showFailToast(context, "Vehicle Checkout Already Activated");
                              }
                              else{
                                bool success = await appStateProvider
                                    .insertVehicleCheckLog();
                                if (success) {
                                  AppConstants.showSuccessToast(
                                      context, "Vehicle Checkout Successfully");
                                } else {
                                  AppConstants.showFailToast(
                                      context, "Vehicle Checkout Failed");
                                }
                              }
                            },
                          ),
                          alignment: Alignment.centerRight,
                        ),
                      ],
                    ), //KARAN (ADD THIS ON LIVE)
                  ],
                );
              }
            },
          ),
          decoration: BoxDecoration(color: AppColors.appThemeColor),
        ),
        Expanded(
            child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: ListView(
                  children: [
                    DrawerRowWidget(
                      title: 'Dashboard',
                      assetPath: ImageFile.dashboard,
                      onTap: () {
                        Navigator.of(context).push(new MaterialPageRoute(
                            builder: (context) => HomeScreen()));
                      },
                    ),
                    DrawerRowWidget(
                      title: 'Today',
                      assetPath: ImageFile.today,
                      onTap: () {
                        Navigator.of(context).push(new MaterialPageRoute(
                            builder: (context) => TodayAppointmentScreen()));
                      },
                    ),
                    DrawerRowWidget(
                      title: 'Appointments',
                      assetPath: ImageFile.appointment,
                      onTap: () {
                        Navigator.of(context).push(new MaterialPageRoute(
                            builder: (context) => AppointmentScreen()));
                      },
                    ),
                    DrawerRowWidget(
                      title: 'Documents',
                      assetPath: ImageFile.document,
                      onTap: () {
                        Navigator.of(context).push(new MaterialPageRoute(
                            builder: (context) => DocumentScreen()));
                      },
                    ),
                    DrawerRowWidget(
                      title: 'Engineer Documents',
                      assetPath: ImageFile.document,
                      onTap: () {
                        Navigator.of(context).push(new MaterialPageRoute(
                            builder: (context) => EngineerDocumentScreen()));
                      },
                    ), //KARAN (ADD THIS ON LIVE)
                    DrawerRowWidget(
                      title: 'Engineer Qualification',
                      assetPath: ImageFile.document,
                      onTap: () {
                        Navigator.of(context).push(new MaterialPageRoute(
                            builder: (context) =>
                                EngineerQualificationScreen()));
                      },
                    ), //KARAN (ADD THIS ON LIVE)
                    DrawerRowWidget(
                      title: 'Orders',
                      assetPath: ImageFile.order,
                      onTap: () {
                        Navigator.of(context).push(
                          new MaterialPageRoute(
                            builder: (context) => OrderScreen(),
                          ),
                        );
                      },
                    ),
                    DrawerRowWidget(
                      title: 'Stock Check Request',
                      assetPath: ImageFile.stock_check_request,
                      onTap: () {
                        Navigator.of(context).push(new MaterialPageRoute(
                            builder: (context) => StockCheckRequestScreen()));
                      },
                    ),
                    DrawerRowWidget(
                      title: 'Available Stock',
                      assetPath: ImageFile.stock_check_request,
                      onTap: () {
                        Navigator.of(context).push(new MaterialPageRoute(
                            builder: (context) => CheckRequestScreen()));
                      },
                    ),
                    DrawerRowWidget(
                      title: 'My Profile',
                      assetPath: ImageFile.myProfile,
                      onTap: () {
                        Navigator.of(context).push(new MaterialPageRoute(
                            builder: (context) => ProfilePage()));
                      },
                    ),
                    DrawerRowWidget(
                      title: 'Logout',
                      assetPath: ImageFile.logout,
                      onTap: () async {
                        await Prefs.logOut();
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            "/login", (Route<dynamic> route) => false);
                      },
                    ),
                  ],
                )))
      ],
    );
  }
}
