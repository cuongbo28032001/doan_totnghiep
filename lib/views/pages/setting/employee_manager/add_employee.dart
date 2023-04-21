import 'package:fltn_app/common/validate_form.dart';
import 'package:fltn_app/common/widgets/card_layout.dart';
import 'package:fltn_app/common/widgets/input_layout.dart';
import 'package:fltn_app/stores/model/employeeModel.dart';
import 'package:fltn_app/stores/model/productModel.dart';
import 'package:flutter/material.dart';

import '../../../../common/widgets/showToast.dart';
import '../../../../consts/colorsTheme.dart';

class AddEmployeeScreen extends StatefulWidget {
  AddEmployeeScreen({super.key});

  @override
  State<AddEmployeeScreen> createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  int _gender = 1;

  late TextEditingController controllerPassWord;
  late TextEditingController controllerNumberPhone;
  late TextEditingController controllerUserName;
  late TextEditingController controllerName;
  late TextEditingController controllerAge;
  late TextEditingController controllerSex;
  late TextEditingController controllerIdNumber;
  final formkey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controllerNumberPhone = TextEditingController(text: '');
    controllerPassWord = TextEditingController(text: '');
    controllerUserName = TextEditingController(text: '');
    controllerName = TextEditingController(text: '');
    controllerAge = TextEditingController(text: '');
    controllerSex = TextEditingController(text: '');
    controllerIdNumber = TextEditingController(text: '');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controllerNumberPhone.dispose();
    controllerPassWord.dispose();
    controllerAge.dispose();
    controllerIdNumber.dispose();
    controllerSex.dispose();
    controllerUserName.dispose();
    controllerName.dispose();
  }

  _onInputNewPass(value) {
    if (value != null) {
      setState(() {
        controllerPassWord.value = controllerPassWord.value.copyWith(
            text: value,
            selection:
                TextSelection.collapsed(offset: value.toString().length));
      });
    }
  }

  _onInputNewNumberPhone(value) {
    if (value != null) {
      setState(() {
        controllerNumberPhone.value = controllerNumberPhone.value.copyWith(
            text: value,
            selection:
                TextSelection.collapsed(offset: value.toString().length));
      });
    }
  }

  _onInputNewName(value) {
    if (value != null) {
      setState(() {
        controllerName.value = controllerName.value.copyWith(
            text: value,
            selection:
                TextSelection.collapsed(offset: value.toString().length));
      });
    }
  }

  _onInputNewUserName(value) {
    if (value != null) {
      setState(() {
        controllerUserName.value = controllerUserName.value.copyWith(
            text: value,
            selection:
                TextSelection.collapsed(offset: value.toString().length));
      });
    }
  }

  _onInputNewDate(value) {
    if (value != null) {
      setState(() {
        controllerAge.value = controllerAge.value.copyWith(
            text: value,
            selection:
                TextSelection.collapsed(offset: value.toString().length));
      });
    }
  }

  _onInputNewCMT(value) {
    if (value != null) {
      setState(() {
        controllerIdNumber.value = controllerIdNumber.value.copyWith(
            text: value,
            selection:
                TextSelection.collapsed(offset: value.toString().length));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: logoGreen,
        centerTitle: true,
        title: const Text("Thêm nhân viên"),
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
            controller: controllerName,
            label: 'Tên nhân viên',
            valid: ValidateForm().validateText,
            callback: (value) {
              _onInputNewName(value);
            },
          ),
          const SizedBox(
            height: 10.0,
          ),
          _renderFormRadio(context),
          const SizedBox(
            height: 10.0,
          ),
          InputFormWidget(
            controller: controllerUserName,
            label: 'Tài khoản',
            note: true,
            valid: ValidateForm().validateUserName,
            callback: (value) {
              _onInputNewUserName(value);
            },
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
            note: true,
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
            controller: controllerAge,
            label: 'Tuổi',
            callback: (value) {
              _onInputNewDate(value);
            },
          ),
          const SizedBox(
            height: 10.0,
          ),
          InputFormWidget(
            controller: controllerIdNumber,
            label: 'Số CMT',
            callback: (value) {
              _onInputNewCMT(value);
            },
          ),
          const SizedBox(
            height: 32.0,
          ),
          InkWell(
            onTap: () {
              EmployeeModel newEmployee = EmployeeModel(
                  userName: controllerUserName.text,
                  passWord: controllerPassWord.text,
                  name: controllerName.text,
                  numberPhone: controllerNumberPhone.text,
                  age: int.parse(controllerAge.text),
                  sex: _gender,
                  idNumber: controllerIdNumber.text);
              if (formkey.currentState!.validate()) {
                toast("Thành công");
                print(newEmployee);
              }
            },
            child: Container(
              width: double.infinity,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(8.0),
                ),
                color: logoOrange,
              ),
              child: const Text(
                'Thêm',
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

  _renderFormRadio(BuildContext context) {
    return Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(left: 10, top: 20, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'Giới tính',
              style:
                  TextStyle(fontSize: 16, color: Colors.black.withOpacity(0.6)),
            ),
            const SizedBox(
              width: 20,
            ),
            Radio(
              value: 1,
              groupValue: _gender,
              onChanged: (value) {
                setState(() {
                  _gender = 1;
                });
              },
            ),
            Text('Nam',
                style: TextStyle(
                    fontSize: 16, color: Colors.black.withOpacity(0.6))),
            const SizedBox(
              width: 10,
            ),
            Radio(
              value: 0,
              groupValue: _gender,
              onChanged: (value) {
                setState(() {
                  _gender = 0;
                });
              },
            ),
            Text(
              'Nữ',
              style:
                  TextStyle(fontSize: 16, color: Colors.black.withOpacity(0.6)),
            ),
          ],
        ));
  }
}
