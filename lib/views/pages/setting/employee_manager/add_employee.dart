import 'package:fltn_app/common/validate_form.dart';
import 'package:fltn_app/common/widgets/input_layout.dart';
import 'package:fltn_app/views/pages/setting/employee_manager/employee_manager.dart';
import 'package:flutter/material.dart';
import '../../../../api.dart';
import '../../../../common/date_form_field.dart';
import '../../../../common/widgets/showToast.dart';
import '../../../../consts/colorsTheme.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class AddEmployeeScreen extends StatefulWidget {
  const AddEmployeeScreen({super.key});

  @override
  State<AddEmployeeScreen> createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  int _gender = 0;
  String? error;
  late TextEditingController controllerPassWord;
  late TextEditingController controllerNumberPhone;
  late TextEditingController controllerUserName;
  late TextEditingController controllerName;
  late TextEditingController controllerBirthDay;
  late TextEditingController controllerSex;
  late TextEditingController controllerIdNumber;
  late TextEditingController controllerEmail;
  final formkey = GlobalKey<FormState>();

  callApiEmployee(object) async {
    try {
      var response = await httpPost('/api/auth/signup', object, context);
      if (response.containsKey("body")) {
        var body = response["body"]["message"];

        setState(() {
          if (body.toString().compareTo("User registered successfully!") == 0) {
            error = 'Thêm nhân viên thành công';
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const EmployeeScreen()));
          } else {
            error = 'Lỗi';
          }
        });
      }
    } catch (e) {
      return e;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controllerNumberPhone = TextEditingController(text: '');
    controllerPassWord = TextEditingController(text: '');
    controllerUserName = TextEditingController(text: '');
    controllerName = TextEditingController(text: '');
    controllerBirthDay = TextEditingController(text: '');
    controllerSex = TextEditingController(text: '');
    controllerIdNumber = TextEditingController(text: '');
    controllerEmail = TextEditingController(text: '');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controllerNumberPhone.dispose();
    controllerPassWord.dispose();
    controllerBirthDay.dispose();
    controllerIdNumber.dispose();
    controllerSex.dispose();
    controllerUserName.dispose();
    controllerName.dispose();
    controllerEmail.dispose();
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

  _onInputDate(value) {
    if (value != null) {
      setState(() {
        controllerBirthDay.value = controllerBirthDay.value.copyWith(
            text: value,
            selection:
                TextSelection.collapsed(offset: value.toString().length));
      });
    }
  }

  _onInPutEmail(value) {
    if (value != null) {
      controllerEmail.value = controllerEmail.value.copyWith(
          text: value,
          selection: TextSelection.collapsed(offset: value.toString().length));
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
            note: true,
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
            note: true,
            controller: controllerEmail,
            label: 'Email',
            callback: (value) {
              _onInPutEmail(value);
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
          renderDate(
              controller: controllerBirthDay,
              label: "Ngày sinh",
              onChanged: (value) {
                DateTime dateTime = DateTime.parse(value);
                String date = DateFormat("yyyy-MM-dd").format(dateTime);
                _onInputDate(date);
              }),
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
              // ignore: unused_local_variable
              var newEmployee = {
                'username': controllerUserName.text,
                'password': controllerPassWord.text,
                'name': controllerName.text,
                'phone': controllerNumberPhone.text,
                'email': controllerEmail.text,
                'sex': _gender,
                'cccd': controllerIdNumber.text,
                'birthDay': controllerBirthDay.text
              };
              print(newEmployee);
              if (formkey.currentState!.validate()) {
                callApiEmployee(newEmployee);
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
              value: 0,
              groupValue: _gender,
              onChanged: (value) {
                setState(() {
                  _gender = 0;
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
              value: 1,
              groupValue: _gender,
              onChanged: (value) {
                setState(() {
                  _gender = 1;
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
