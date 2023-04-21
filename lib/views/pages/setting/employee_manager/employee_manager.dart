import 'package:fltn_app/stores/model/employeeModel.dart';
import 'package:fltn_app/views/pages/setting/employee_manager/add_employee.dart';
import 'package:fltn_app/views/pages/setting/employee_manager/infomation_employee.dart';
import 'package:flutter/material.dart';
import '../../../../common/widgets/divider.dart';
import '../../../../common/widgets/search.dart';
import '../../../../consts/colorsTheme.dart';
import 'dart:developer' as dev;

class EmployeeScreen extends StatefulWidget {
  const EmployeeScreen({super.key});

  @override
  State<EmployeeScreen> createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {
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
        renderContentSell(context),
      ],
    );
  }

  renderSearch(context) {
    return SizedBox(
        height: 50,
        child: inPutSearch(
          context: context,
          addIcon: Icons.add,
          addItem: AddEmployeeScreen(),
          lable: 'Nhập tên, số điện thoại',
        ));
  }

  renderContentSell(context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            for (EmployeeModel item in listEmployeeModel)
              Container(
                padding: const EdgeInsets.only(
                    top: 5, left: 15, right: 15, bottom: 0),
                color: Colors.white,
                child: Column(
                  children: [
                    renderProduct(context, item),
                    (listEmployeeModel.indexOf(item) !=
                            listEmployeeModel.length - 1)
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
                      Text(employeeModel.name,
                          style: const TextStyle(fontSize: 15)),
                      Text(
                        employeeModel.numberPhone,
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
                        employeeModel.age.toString(),
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
