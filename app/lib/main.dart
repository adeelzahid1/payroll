import 'package:app/route/globals.dart';
import 'package:flutter/material.dart';
import 'package:network/SharedPrefManager.dart';
import 'package:network/models/SettingsBms.dart';
import 'package:network/models/theme/EAppTheme.dart';
import 'package:network/models/theme/ThemeProvider.dart';
import 'package:payroll/payroll.dart';
import 'package:payroll/routes/PayRollAppPagesConstants.dart';
import 'package:payroll/routes/PayrollRouter.dart';

import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  PayRoll.initAuth("http://192.168.18.14:8090/");

  SettingsBms settingsBms = SettingsBms();
  SharedPrefManagerUser? pref = await SharedPrefManagerUser.getInstance();
  if(pref!=null){
    settingsBms = pref.getSettings();
  }

  runApp(ChangeNotifierProvider(
    create: (_) => ThemeProvider(appTheme: EAppTheme.whiteTheme),
    child: MyApp(),
  ));

}


class MyApp extends StatefulWidget with WidgetsBindingObserver {
  // final ThemeProvider themeProvider;

  const MyApp({Key? key}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      theme: themeProvider.themeData(),

      debugShowCheckedModeBanner: false,
      initialRoute: PayRollAppPagesConstants.splashPayRollPageRoute,
      navigatorObservers: [
        AppGlobals.routeObserver,
      ],
      onGenerateRoute: PayrollRouter.generateRoute,

     // home: PayRollSplashScreen(),

      title: "PayRoll",

      // localizationsDelegates: [
      //   AppLocalizationDelegate(),
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      //   GlobalCupertinoLocalizations.delegate,
      // ],
      supportedLocales: [
        const Locale('en', ''), // English, no country code
        const Locale('ar', ''), // Arabic, no country code
      ],

    );
  }
}

