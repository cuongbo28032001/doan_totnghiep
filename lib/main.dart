import 'package:fltn_app/views/App.dart';
import 'package:fltn_app/views/pages/login_page/login.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';

import 'consts/colorsTheme.dart';
import 'model/securityModel.dart';

void main() {
  var securityModel = SecurityModel(LocalStorage('storage'));

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
      title: "HOMESHOP",
      theme: ThemeData(scaffoldBackgroundColor: backgroundApp),
      home: const LoginPage(),
    );
  }
}
