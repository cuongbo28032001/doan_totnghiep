import 'package:fltn_app/views/pages/inventory_management/inventory_management.dart';
import 'package:fltn_app/views/pages/setting/setting.dart';
import 'package:fltn_app/views/pages/sell/sell.dart';
import 'package:fltn_app/views/pages/enter_drugs/enter_drugs.dart';
import 'package:flutter/material.dart';

//log event insid console
import 'dart:developer' as dev;

import '../common/widgets/showToast.dart';
import '../consts/colorsTheme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "HOMESHOP",
      theme: ThemeData(scaffoldBackgroundColor: backgroundApp),
      home: AppContent(
        key: globalAppContent,
      ),
    );
  }
}

GlobalKey<AppContentState> globalAppContent = GlobalKey();

class AppContent extends StatefulWidget {
  const AppContent({super.key});

  @override
  State<AppContent> createState() => AppContentState();
}

class AppContentState extends State<AppContent> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _renderBody(),
      bottomNavigationBar: renderBottomBar(context),
    );
  }

  GlobalKey globalKeySell = GlobalKey();
  GlobalKey globalKeyTemporaryOrder = GlobalKey();
  GlobalKey globalKeyHistoryOrder = GlobalKey();
  GlobalKey globalKeyMoreAction = GlobalKey();
  late int role = 0;

  _renderBody() {
    GlobalKey globalKey = globalKeySell;

    switch (selectedIndex) {
      case 0:
        globalKey = globalKeySell;
        break;
      case 1:
        globalKey = globalKeyTemporaryOrder;
        break;
      case 2:
        globalKey = globalKeyHistoryOrder;
        break;
      case 3:
        globalKey = globalKeyMoreAction;
        break;
    }

    return Navigator(
        key: globalKey,
        onGenerateRoute: (settings) => _onGenerateRoute(settings, context));
  }

  _onGenerateRoute(settings, BuildContext context) {
    Widget page = renderContent(context);

    return MaterialPageRoute(builder: (_) => page);
  }

  renderContent(BuildContext context) {
    if (selectedIndex == 0) {
      return renderBodyBanThuoc();
    } else if (selectedIndex == 1) {
      return renderBodyNhapThuoc();
    } else if (selectedIndex == 2) {
      return renderBodyQuanLyKho();
    } else if (selectedIndex == 3) {
      return renderBodyCaiDat();
    } else {
      return renderBodyBanThuoc();
    }
  }

  Widget? currentScreen;
  renderBodyBanThuoc() {
    currentScreen = const SellScreen();
    return currentScreen;
  }

  renderBodyNhapThuoc() {
    currentScreen = const EnterdrugsScreen();
    return currentScreen;
  }

  renderBodyQuanLyKho() {
    currentScreen = const InventoryManagementScreen();
    return currentScreen;
  }

  renderBodyCaiDat() {
    currentScreen = SettingScreen(
      roles: role,
    );
    return currentScreen;
  }

  renderBottomBar(BuildContext context) {
    return Container(
      height: 70,
      width: MediaQuery.of(context).size.width,
      color: logoGreen,
      alignment: Alignment.topCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _renderBarButton(
              index: 0,
              title: 'Bán thuốc',
              icon: const Icon(
                Icons.sell_rounded,
                color: Colors.white,
                size: 26,
              ),
              activeIcon: Icon(
                Icons.sell_rounded,
                color: logoOrange,
                size: 30,
              ),
              color: Colors.white,
              activeColor: logoOrange),
          _renderBarButton(
              index: 1,
              title: 'Nhập thuốc',
              icon: const Icon(
                Icons.add_business_rounded,
                color: Colors.white,
                size: 26,
              ),
              activeIcon: Icon(
                Icons.add_business_rounded,
                color: logoOrange,
                size: 30,
              ),
              color: Colors.white,
              activeColor: logoOrange),
          if (role != 1)
            _renderBarButton(
                index: 2,
                title: 'Quản lý kho',
                icon: const Icon(
                  Icons.inventory_2_rounded,
                  color: Colors.white,
                  size: 26,
                ),
                activeIcon: Icon(
                  Icons.inventory_2_rounded,
                  color: logoOrange,
                  size: 30,
                ),
                color: Colors.white,
                activeColor: logoOrange),
          _renderBarButton(
              index: 3,
              title: 'Cài đặt',
              icon: const Icon(
                Icons.settings,
                color: Colors.white,
                size: 26,
              ),
              activeIcon: Icon(
                Icons.settings,
                color: logoOrange,
                size: 30,
              ),
              color: Colors.white,
              activeColor: logoOrange),
        ],
      ),
    );
  }

  _renderBarButton({index, title, icon, activeIcon, color, activeColor}) {
    Icon currentIcon = index == selectedIndex ? activeIcon : icon;
    Color currentColor = index == selectedIndex ? activeColor : color;
    return Expanded(
      flex: 1,
      child: InkWell(
        onTap: () => _onItemTapped(index),
        child: Container(
          height: 80,
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: Column(
            children: [
              currentIcon,
              Text(
                title,
                style: TextStyle(
                  color: currentColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<String> listToastBottomBar = [
    "Bán thuốc",
    "Nhập thuốc",
    "Quản lý kho",
    "Cài đặt"
  ];

  // globalAppContent.currentState?.selectSellTab(); để chuyển về màn bán hàng từ bất cứ đâu và xóa hết hàng đợi push
  static const sellScreenIndex = 0;
  selectSellTab() {
    Navigator.of(globalKeySell.currentContext ?? context)
        .popUntil((route) => route.isFirst);
    setState(
      () {
        selectedIndex = sellScreenIndex;
      },
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });

    //Show thông báo text
    toast(listToastBottomBar[selectedIndex].toString());
    dev.log("selected ${listToastBottomBar[selectedIndex].toString()}");
  }
}
