import 'package:fltn_app/model/employeeModel.dart';
import 'package:fltn_app/views/pages/setting/employee_manager/add_employee.dart';
import 'package:fltn_app/views/pages/setting/employee_manager/infomation_employee.dart';
import 'package:flutter/material.dart';
import '../../../../api.dart';
import '../../../../common/widgets/divider.dart';
import '../../../../common/widgets/search.dart';
import '../../../../consts/colorsTheme.dart';
import 'dart:developer' as dev;
// ignore: unused_import, depend_on_referenced_packages
import 'package:intl/intl.dart';

class EmployeeScreen extends StatefulWidget {
  const EmployeeScreen({super.key});

  @override
  State<EmployeeScreen> createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {
  bool loading = false;
  List<dynamic> listEmployee = [];
  Map<String, dynamic> searchProduc = {};
  callApiEmployee() async {
    List<dynamic> listTemp = [];
    var search = {"pageNumber": 1, "pageSize": 100, "customize": searchProduc};
    try {
      var response = await httpPost('/api/auth/search', search, context);

      if (response.containsKey("body")) {
        var body = response["body"]["result"]["content"];
        if (response['body']['desc'].toString().compareTo('OK') == 0) {
          setState(() {
            listTemp = body.map((e) {
              return EmployeeModel.fromJson(e);
            }).toList();
            for (EmployeeModel item in listTemp) {
              if (item.deleted.toString().compareTo('N') == 0 &&
                  item.roles!.length == 1) {
                listEmployee.add(item);
              }
            }
            if (listEmployee.isNotEmpty) {
              loading = true;
            }
          });
        }
      }
    } catch (e) {
      return listEmployee;
    }
    return listEmployee;
  }

  String convertToDate(int value) {
    DateTime dateTime;
    dateTime = DateTime.fromMillisecondsSinceEpoch(value);
    var date = DateFormat('yyyy-MM-dd').format(dateTime);
    return date;
  }

  @override
  void initState() {
    // TODO: implement initState
    callApiEmployee();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: logoGreen,
        centerTitle: true,
        title: const Text("Thông tin nhân viên"),
      ),
      body: renderBodySell(context),
    );
  }

  renderBodySell(context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        renderSearch(context),
        const SizedBox(
          height: 10,
        ),
        listEmployee.isEmpty
            ? const Expanded(
                child: Center(
                  child: Text("Chưa có nhân viên"),
                ),
              )
            : renderContentSell(context),
      ],
    );
  }

  renderSearch(context) {
    return SizedBox(
        height: 50,
        child: inPutSearch(
          context: context,
          addIcon: Icons.add,
          addItem: const AddEmployeeScreen(),
          lable: 'Nhập tên, số điện thoại',
        ));
  }

  renderContentSell(context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            for (EmployeeModel item in listEmployee)
              Container(
                padding: const EdgeInsets.only(
                    top: 5, left: 15, right: 15, bottom: 0),
                color: Colors.white,
                child: Column(
                  children: [
                    renderProduct(context, item),
                    (listEmployee.indexOf(item) != listEmployee.length - 1)
                        ? divider(context: context)
                        : Container(
                            width: double.infinity,
                            height: 10.0,
                            color: Colors.white,
                          ),
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }

  renderProduct(context, EmployeeModel employeeModel) {
    return InkWell(
      onTap: () {
        dev.log("Select product $employeeModel");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => InfomaEmployee(
              employeeModel: employeeModel,
            ),
          ),
        );
      },
      child: Row(
        children: [
          const SizedBox(width: 20),
          Expanded(
            child: SizedBox(
              height: 60,
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(employeeModel.name ?? '',
                          style: const TextStyle(fontSize: 15)),
                      Text(
                        employeeModel.phone ?? '',
                        style: const TextStyle(
                            color: Colors.black54, fontSize: 14),
                      ),
                    ],
                  ),
                  const Expanded(
                    child: SizedBox(),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        employeeModel.sex == 0 ? 'nam' : 'nữ',
                        style: TextStyle(color: logoGreen, fontSize: 15),
                      ),
                      Text(
                        employeeModel.birthDay.toString().compareTo("null") != 0
                            ? convertToDate(employeeModel.birthDay!)
                            : '',
                        style: const TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
