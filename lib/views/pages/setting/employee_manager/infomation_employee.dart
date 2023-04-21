import 'package:fltn_app/common/validate_form.dart';
import 'package:fltn_app/common/widgets/card_layout.dart';
import 'package:fltn_app/common/widgets/input_layout.dart';
import 'package:fltn_app/stores/model/employeeModel.dart';
import 'package:fltn_app/stores/model/productModel.dart';
import 'package:flutter/material.dart';

import '../../../../common/widgets/showToast.dart';
import '../../../../consts/colorsTheme.dart';

class InfomaEmployee extends StatefulWidget {
  EmployeeModel employeeModel;
  InfomaEmployee({super.key, required this.employeeModel});

  @override
  State<InfomaEmployee> createState() => _InfomaEmployeeState();
}

class _InfomaEmployeeState extends State<InfomaEmployee> {
  late String _passWord = '';
  late String _numberPhone = '';
  late TextEditingController controllerPassWord;
  late TextEditingController controllerNumberPhone;
  final formkey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controllerNumberPhone =
        TextEditingController(text: widget.employeeModel.numberPhone);
    controllerPassWord =
        TextEditingController(text: widget.employeeModel.passWord);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controllerNumberPhone.dispose();
    controllerPassWord.dispose();
  }

  _onInputNewPass(value) {
    setState(() {
      _passWord = value;
    });
  }

  _onInputNewNumberPhone(value) {
    setState(() {
      _numberPhone = value;
    });
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
              onPressed: () {
                toast("Xóa nhân viên mã ${widget.employeeModel.id}");
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
            controller:
                TextEditingController(text: widget.employeeModel.userName),
            label: 'Tài khoản',
            redonly: true,
          ),
          const SizedBox(
            height: 10.0,
          ),
          InputFormWidget(
            note: true,
            controller: controllerPassWord,
            label: 'Mật khẩu',
            callback: (value) {
              _onInputNewPass(value);
            },
            valid: ValidateForm().validatePass,
          ),
          const SizedBox(
            height: 10.0,
          ),
          InputFormWidget(
            controller: controllerNumberPhone,
            label: 'Số điện thoại',
            callback: (value) {
              _onInputNewNumberPhone(value);
            },
            valid: ValidateForm().validateNumber,
          ),
          const SizedBox(
            height: 10.0,
          ),
          InputFormWidget(
            controller: TextEditingController(
                text: widget.employeeModel.age.toString()),
            label: 'Tuổi',
            redonly: true,
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
            controller:
                TextEditingController(text: widget.employeeModel.idNumber),
            label: 'Số CMT',
            redonly: true,
          ),
          const SizedBox(
            height: 32.0,
          ),
          InkWell(
            onTap: (controllerNumberPhone.text
                            .compareTo(widget.employeeModel.numberPhone) !=
                        0 ||
                    controllerPassWord.text
                            .compareTo(widget.employeeModel.passWord) !=
                        0)
                ? () {
                    if (formkey.currentState!.validate()) {
                      toast("Sửa thành công");
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
                                  widget.employeeModel.numberPhone) !=
                              0 ||
                          controllerPassWord.text
                                  .compareTo(widget.employeeModel.passWord) !=
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
