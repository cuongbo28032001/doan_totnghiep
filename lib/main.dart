import 'package:fltn_app/views/pages/login_page/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';
import 'package:page_transition/page_transition.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'consts/colorsTheme.dart';
import 'model/securityModel.dart';

void main() async {
  var storage = LocalStorage('storage');
  await storage.ready;
  var securityModel = SecurityModel(storage);

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => securityModel),
    ],
    child: const QLBT(),
  ));
}

class QLBT extends StatefulWidget {
  const QLBT({super.key});

  @override
  State<QLBT> createState() => _QLBTState();
}

class _QLBTState extends State<QLBT> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "HOMESHOP",
        theme: ThemeData(
          scaffoldBackgroundColor: backgroundApp,
          // timePickerTheme: TimePickerThemeData(backgroundColor: logoGreen),
        ),
        localizationsDelegates: const [
          GlobalMaterialLocalizations
              .delegate, // Delegate của Material Localizations
          GlobalWidgetsLocalizations
              .delegate, // Delegate của Widgets Localizations
        ],
        supportedLocales: const [
          Locale('en', ''),
          Locale('vi', ''),
        ],
        home: AnimatedSplashScreen(
            duration: 1500,
            splash: SizedBox(
              height: 200,
              width: 200,
              child: Image.asset(
                "assets/images/logo_app.png",
                fit: BoxFit.contain,
              ),
            ),
            splashIconSize: 200,
            nextScreen: const LoginPage(),
            splashTransition: SplashTransition.fadeTransition,
            pageTransitionType: PageTransitionType.fade,
            backgroundColor: Colors.white));
  }
}
