import 'package:fltn_app/common/widgets/card_layout.dart';
import 'package:fltn_app/views/App.dart';
import 'package:fltn_app/views/pages/list_bill.dart';
import 'package:fltn_app/views/pages/setting/employee_manager/employee_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
    var securityModel = Provider.of<SecurityModel>(context, listen: false);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          securityModel.roleUser == "ROLE_ADMIN"
              ? CardLayoutWidget(
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
                )
              : Container(),
          const SizedBox(
            height: 16.0,
          ),
          CardLayoutWidget(
            child: Column(
              children: [
                renderItemMenu(
                    icon: Icons.receipt_long,
                    title: "Danh sách hóa đơn",
                    onClick: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ListBillScreen()));
                    }),
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
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87),
          ),
        ],
      ),
    );
  }
}
