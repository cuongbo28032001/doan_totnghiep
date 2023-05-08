// ignore_for_file: use_build_context_synchronously

import 'package:fltn_app/common/date_form_field.dart';
import 'package:fltn_app/common/validate_form.dart';
import 'package:fltn_app/common/widgets/input_layout.dart';
import 'package:fltn_app/model/employeeModel.dart';
import 'package:fltn_app/views/pages/setting/employee_manager/employee_manager.dart';
import 'package:flutter/material.dart';

import '../../../../api.dart';
import '../../../../common/widgets/showToast.dart';
import '../../../../consts/colorsTheme.dart';
// ignore: unused_import, depend_on_referenced_packages
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class InfomaEmployee extends StatefulWidget {
  EmployeeModel employeeModel;
  InfomaEmployee({super.key, required this.employeeModel});

  @override
  State<InfomaEmployee> createState() => _InfomaEmployeeState();
}

class _InfomaEmployeeState extends State<InfomaEmployee> {
  late String error = '';
  late TextEditingController controllerNumberPhone;
  late TextEditingController controllerEmail;
  late TextEditingController controllerCCCD;
  late TextEditingController controllerBirthDay;
  final formkey = GlobalKey<FormState>();

  callApiDeleteEmployee(id) async {
    try {
      var response = await httpDelete('/api/auth/status/$id', context);
      if (response['body']['desc']
              .toString()
              .compareTo('CẬP NHẬT THÀNH CÔNG') ==
          0) {
        toast("Xóa thành công!");
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const EmployeeScreen()));
      }
    } catch (e) {
      return e;
    }
  }

  callApiUpdateEmployee(object) async {
    try {
      var response = await httpPut('/api/auth/update', object, context);
      if (response.containsKey("body")) {
        print(response["body"]);
        var body = response["body"]["desc"];
        setState(() {
          error = body;
        });
      }
    } catch (e) {
      toast('Lỗi!');
    }
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
    super.initState();
    controllerEmail =
        TextEditingController(text: widget.employeeModel.email ?? '');
    controllerCCCD =
        TextEditingController(text: widget.employeeModel.cccd ?? '');
    controllerNumberPhone =
        TextEditingController(text: widget.employeeModel.phone ?? '');
    controllerBirthDay = TextEditingController(
        text: widget.employeeModel.birthDay.toString().compareTo("null") == 0
            ? ''
            : convertToDate(widget.employeeModel.birthDay!));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controllerEmail.dispose();
    controllerNumberPhone.dispose();
    controllerBirthDay.dispose();
    controllerCCCD.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: logoGreen,
        centerTitle: true,
        title: const Text("Thông tin nhân viên"),
        actions: [
          IconButton(
              onPressed: () async {
                await callApiDeleteEmployee(widget.employeeModel.id);
              },
              icon: const Icon(Icons.delete))
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: renderInfomationEmployee(),
      ),
    );
  }

  renderInfomationEmployee() {
    return Form(
      key: formkey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InputFormWidget(
            controller: TextEditingController(text: widget.employeeModel.name),
            label: 'Tên nhân viên',
            redonly: true,
          ),
          const SizedBox(
            height: 10.0,
          ),
          InputFormWidget(
            controller: TextEditingController(
                text: widget.employeeModel.username ?? ''),
            label: 'Tài khoản',
            redonly: true,
          ),
          const SizedBox(
            height: 10.0,
          ),
          InputFormWidget(
            controller: controllerEmail,
            label: 'Email',
            valid: ValidateForm().validateEmail,
          ),
          const SizedBox(
            height: 10.0,
          ),
          InputFormWidget(
            controller: controllerNumberPhone,
            label: 'Số điện thoại',
            valid: ValidateForm().validateNumber,
          ),
          const SizedBox(
            height: 10.0,
          ),
          renderDate(
            controller: controllerBirthDay,
            label: "Ngày sinh",
          ),
          const SizedBox(
            height: 10.0,
          ),
          InputFormWidget(
            controller: TextEditingController(
                text: widget.employeeModel.sex == 0 ? 'nam' : 'nữ'),
            label: 'Giới tính',
            redonly: true,
          ),
          const SizedBox(
            height: 10.0,
          ),
          InputFormWidget(
            controller: TextEditingController(
                text: widget.employeeModel.cccd.toString()),
            label: 'Số CMT',
          ),
          const SizedBox(
            height: 32.0,
          ),
          InkWell(
            onTap: (controllerNumberPhone.text
                            .compareTo(widget.employeeModel.phone ?? '') !=
                        0 ||
                    controllerBirthDay.text.compareTo(
                            widget.employeeModel.birthDay.toString()) !=
                        0 ||
                    controllerCCCD.text
                            .compareTo(widget.employeeModel.cccd ?? '') !=
                        0)
                ? () async {
                    if (formkey.currentState!.validate()) {
                      var data = {
                        'id': widget.employeeModel.id,
                        'name': widget.employeeModel.name,
                        'email': controllerEmail.text,
                        'username': widget.employeeModel.username,
                        'password': widget.employeeModel.password,
                        'phone': controllerNumberPhone.text,
                        'sex': widget.employeeModel.sex,
                        'birthDay': controllerBirthDay.text,
                        'roles': widget.employeeModel.roles,
                        "deleted": widget.employeeModel.deleted,
                        'cccd': controllerCCCD.text
                      };
                      await callApiUpdateEmployee(data);
                      if (error.compareTo('CẬP NHẬT THÀNH CÔNG') == 0) {
                        toast(error);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const EmployeeScreen()));
                      } else {
                        toast(error);
                      }
                    }
                  }
                : null,
            child: Container(
              width: double.infinity,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                  color: (controllerNumberPhone.text.compareTo(
                                  widget.employeeModel.phone ?? '') !=
                              0 ||
                          controllerBirthDay.text.compareTo(
                                  widget.employeeModel.birthDay.toString()) !=
                              0 ||
                          controllerCCCD.text
                                  .compareTo(widget.employeeModel.cccd ?? '') !=
                              0)
                      ? logoOrange
                      : Colors.black12),
              child: const Text(
                'Sửa thông tin',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
            ),
          )
        ],
      ),
    );
  }
}
