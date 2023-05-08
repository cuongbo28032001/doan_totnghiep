import 'package:fltn_app/views/App.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../api.dart';
import '../../../common/widgets/common_app.dart';
import '../../../consts/colorsTheme.dart';
import '../../../model/securityModel.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Future<void> processing() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool forgotPassword = false;
  late bool _passwordVisible = true;

  Future<bool> handleLogin({required String userName, required String password}) async {
    var loginRequest = {"username": userName, "password": password, "captcha": "A"};
    var loginResponse = await httpPost("/api/auth/signin", loginRequest, context);
    if (loginResponse.containsKey("body")) {
      var body = loginResponse["body"];
      print(body);
      // ignore: use_build_context_synchronously
      Provider.of<SecurityModel>(context, listen: false).setAuthorization(
        authorization: body["token"],
        userName: _username.text,
        passWord: _password.text,
        role: body["roles"],
      );
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 236, 249, 251),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CommonApp().sizeBoxWidget(height: 20),
            Text(
              "Đăng nhập",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600, color: logoGreen),
            ),

            CommonApp().sizeBoxWidget(height: 50),
            renderUserName(),
            CommonApp().sizeBoxWidget(height: 30),
            renderPasword(),
            CommonApp().sizeBoxWidget(height: 50),
            // renderRowBottom(),
            // CommonApp().sizeBoxWidget(height: 23),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(color: logoOrange, borderRadius: BorderRadius.circular(8)),
              child: InkWell(
                onTap: () async {
                  bool result = false;
                  if (_username.text.isNotEmpty && _password.text.isNotEmpty) {
                    // res =
                    result = await handleLogin(userName: _username.text, password: _password.text);
                    if (result == true) {
                      // ignore: use_build_context_synchronously
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const App()));
                    }
                  } else {
                    // showToast(
                    // context: context, msg: "yêu cầu nhập tài khoản và mật khẩu", color: Colors.red, icon: Icon(Icons.error_outline));
                  }
                },
                child: const Text(
                  'Đăng nhập',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  // renderRowBottom() {
  //   return Row(
  //     children: [
  //       Expanded(
  //         child: Row(
  //           children: [
  //             Theme(
  //               data: ThemeData(
  //                 primarySwatch: Colors.blue,
  //                 unselectedWidgetColor: Colors.black, // Your color
  //               ),
  //               child: Checkbox(
  //                 value: rememberMe,
  //                 onChanged: (value) {
  //                   rememberMe = !rememberMe;
  //                   setState(() {
  //                     // _username.text = Provider.of<SecurityModel>(context, listen: false).userName!;
  //                   });
  //                 },
  //               ),
  //             ),
  //             const SizedBox(
  //               width: 10,
  //             ),
  //             Text(
  //               'Ghi nhớ tài khoản',
  //               style: textBtnBlack,
  //             ),
  //           ],
  //         ),
  //       ),
  //       InkWell(
  //         onTap: () {
  //           setState(() {
  //             forgetPass = !forgetPass;
  //             print(forgetPass);
  //           });
  //         },
  //         child: Text(
  //           'Quên mật khẩu?',
  //           style: textBtnBlack,
  //         ),
  //       )
  //     ],
  //   );
  // }

  renderPasword() {
    return TextFormField(
      onFieldSubmitted: (value) {
        if (_username.text.isNotEmpty && _password.text.isNotEmpty) {
          // handleLogin(userName: _username.text, password: _password.text);
        } else {
          // showToast(context: context, msg: "yêu cầu nhập tài khoản và mật khẩu", color: Colors.red, icon: Icon(Icons.error_outline));
        }
      },
      enableSuggestions: true,
      autofillHints: const [AutofillHints.password],
      controller: _password,
      // maxLines: 1,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      // style: textInput,
      obscureText: _passwordVisible,
      obscuringCharacter: '*',
      decoration: InputDecoration(
        labelText: 'Mật khẩu',
        // labelStyle: textInput,
        // hintStyle: textInput,
        labelStyle: TextStyle(color: logoGreen),
        border:
            const OutlineInputBorder(borderSide: BorderSide(width: 0.5, color: Colors.black), borderRadius: BorderRadius.all(Radius.circular(10))),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              color: logoGreen,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        suffixIcon: IconButton(
          icon: Icon(
            !_passwordVisible ? Icons.visibility : Icons.visibility_off,
            color: !_passwordVisible ? logoGreen : Colors.black38,
          ),
          onPressed: () {
            setState(() {
              _passwordVisible = !_passwordVisible;
            });
          },
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Mật khẩu không được để trống';
        } else {
          return null;
        }
      },
    );
  }

  renderUserName() {
    return TextFormField(
      enableSuggestions: true,
      // maxLines: 1,
      controller: _username,
      autofillHints: const [AutofillHints.username],
      autovalidateMode: AutovalidateMode.onUserInteraction,
      // style: TextStyle(color: Colors.red),
      decoration: InputDecoration(
        labelText: 'Tên đăng nhập',
        labelStyle: TextStyle(color: logoGreen),
        // hintStyle: GoogleFonts.montserrat(color: Colors.black),
        border:
            const OutlineInputBorder(borderSide: BorderSide(width: 0.5, color: Colors.black), borderRadius: BorderRadius.all(Radius.circular(10))),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              color: logoGreen,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        hintText: 'Tên đăng nhập',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Không được để trống';
        } else {
          return null;
        }
        // if (!value.contains('@')) {
        //   return 'Tên đăng nhập là gmail';
        // }
      },
    );
  }
}
