import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:fltn_app/common/widgets/card_layout.dart';
import 'package:fltn_app/views/App.dart';
import 'package:fltn_app/views/pages/setting/Personal/PersonalScreen.dart';
import 'package:fltn_app/views/pages/setting/employee_manager/employee_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../common/widgets/divider.dart';
import '../../../common/widgets/menu_MorecAtion.dart';
import '../../../common/widgets/showToast.dart';
import '../../../consts/colorsTheme.dart';
import '../../../model/securityModel.dart';

// ignore: must_be_immutable
class SettingScreen extends StatefulWidget {
  int roles;
  SettingScreen({super.key, required this.roles});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: logoGreen,
          title: const Center(child: Text("Cài đặt")),
        ),
        body: _renderBodyMoreAction(context));
  }

  _renderBodyMoreAction(context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          CardLayoutWidget(
            child: Column(
              children: [
                renderItemMenu(icon: Icons.person, title: "Cá nhân"),
              ],
            ),
          ),
          const SizedBox(
            height: 16.0,
          ),
          CardLayoutWidget(
            child: Column(
              children: [
                renderItemMenu(
                  icon: Icons.group,
                  title: "Quản lý nhân viên",
                  onClick: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EmployeeScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16.0,
          ),
          CardLayoutWidget(
            child: Column(
              children: [
                renderItemMenu(icon: Icons.receipt_long, title: "Danh sách hóa đơn"),
              ],
            ),
          ),
          const SizedBox(
            height: 16.0,
          ),
          CardLayoutWidget(
              child: renderItemMenu(
                  icon: Icons.logout,
                  title: "Đăng xuất",
                  onClick: () {
                    globalAppContent.currentState!.selectLoginTab();
                    Provider.of<SecurityModel>(context, listen: false).logout();
                  })),
        ],
      ),
    );
  }

  renderItemMenu({icon, title, onClick}) {
    return InkWell(
      onTap: onClick,
      child: Row(
        children: [
          Icon(
            icon,
            color: logoGreen,
          ),
          const SizedBox(
            width: 32.0,
          ),
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black87),
          ),
        ],
      ),
    );
  }

  _gotoPersonalScreen() {
    toast("Cá nhân");
    Navigator.push(context, MaterialPageRoute(builder: (_) => const PersonScreen()));
  }
}
