// @dart=2.9

import 'package:enstaller/app_router.dart';
import 'package:enstaller/core/constant/app_string.dart';
import 'package:enstaller/core/constant/app_themes.dart';
import 'package:enstaller/core/get_it.dart';
import 'package:enstaller/core/model/send/answer_credential.dart';
import 'package:enstaller/core/model/user_model.dart';
import 'package:enstaller/core/service/pref_service.dart';
import 'package:enstaller/core/viewmodel/userprovider.dart';
import 'package:enstaller/ui/login_screen.dart';
import 'package:enstaller/ui/screen/Reset_Password.dart';
import 'package:enstaller/ui/screen/VerifyEmail.dart';
import 'package:enstaller/ui/screen/home_screen.dart';
import 'package:enstaller/ui/screen/non_technical_user_screens/customer_list_screen.dart';
import 'package:enstaller/ui/screen/warehouse_screens/check_order_assign_stcok.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'core/viewmodel/appthemeviewmodel.dart';
import 'ui/screen/maps_route_planner_plotmarker.dart';



void main() {

  WidgetsFlutterBinding.ensureInitialized();
  //HttpOverrides.global = new DevHttpOverrides();
  setupLocator();

  Prefs.getUser().then((value) {
    runApp(MyApp(
      logInUser: value,
    ));
  });

}


class MyApp extends StatelessWidget {

  UserModel logInUser;
  MyApp({this.logInUser});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: AppThemeViewModel(AppThemes.light)),
        ChangeNotifierProvider.value(value: UserProvider(logInUser))
      ],
      child: MainMaterialApp(
        loginUser: logInUser,
      ),
    );
  }
}

class MainMaterialApp extends StatelessWidget {

  UserModel loginUser;
  MainMaterialApp({this.loginUser});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<AppThemeViewModel>(context);

    if (loginUser.rememberMe) {

      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    }

    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appTitle,
      theme: themeProvider.getTheme(),
      routes: {
        '/login': (BuildContext context) => new LoginScreen(),
        '/home': (BuildContext context) => new HomeScreen(),
        '/checkAssignOrder': (BuildContext context) => new CheckAndAssignOrder(),
        '/customerListScreen': (BuildContext context) => new CustomerListScreen(),
        '/clusteringPage2': (BuildContext context) => new MapsPage(),
        '/verifyEmail' :  (BuildContext context) => new VerifyEmail(),
      },
      onGenerateRoute: AppRouter.generateRoute,
      navigatorKey: GlobalVariable.navState,
      home: loginUser.rememberMe
          ? (loginUser.bisNonTechnical == true
              ? CustomerListScreen()
              : (GlobalVar.roleId == 5 ? CheckAndAssignOrder() : HomeScreen()))
          : LoginScreen(),
//    home: TestPage(),
    );
  }
}


class GlobalVariable {
  static final GlobalKey<NavigatorState> navState = GlobalKey<NavigatorState>();
}
