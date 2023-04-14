import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:fltn_app/common/widgets/card_layout.dart';
import 'package:fltn_app/views/pages/setting/Personal/PersonalScreen.dart';
import 'package:flutter/material.dart';
import '../../../common/widgets/divider.dart';
import '../../../common/widgets/menu_MorecAtion.dart';
import '../../../common/widgets/showToast.dart';
import '../../../consts/colorsTheme.dart';

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
                renderItemMenu(icon: Icons.group, title: "Danh sách nhân viên"),
                divider(context: context),
                renderItemMenu(
                    icon: Icons.person_add_alt_1, title: "Thêm nhân viên")
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
                    icon: Icons.receipt_long, title: "Danh sách hóa đơn"),
              ],
            ),
          ),
          const SizedBox(
            height: 16.0,
          ),
          CardLayoutWidget(
              child: renderItemMenu(icon: Icons.logout, title: "Đăng xuất")),
        ],
      ),
    );
  }

  renderItemMenu({icon, title}) {
    return InkWell(
      onTap: () {},
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
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87),
          ),
        ],
      ),
    );
  }

  _gotoPersonalScreen() {
    toast("Cá nhân");
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const PersonScreen()));
  }
}
