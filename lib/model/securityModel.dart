import 'dart:convert';

import 'package:fltn_app/model/user.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'dart:developer' as dev;
import 'package:jwt_decode/jwt_decode.dart';
import '../url.dart';

class SecurityModel extends ChangeNotifier {
  late LocalStorage storage;
  bool authenticated = false;
  String? authorization;
  dynamic userLogin;
  // dynamic userRole;
  String? roleUser;
  String? userName;
  String? passWord;
  bool rememberMe = false;

  SecurityModel(this.storage) {
    roleUser = storage.getItem("roleUser");
    authorization = storage.getItem("authorization");
    userLogin = storage.getItem("userLogin");
    // userRole = storage.getItem("userRole");
    authenticated = authorization != null;
    userName = storage.getItem("userName");
    passWord = storage.getItem("passWord");
    User().userName = storage.getItem('userName');
  }

  void logout() {
    // logoutServer();
    // storage.setItem("userRole", null);
    storage.setItem("userLogin", null);
    storage.setItem("authorization", null);
    authenticated = false;
    // authorization = null;
    // reloadPage = null;
    // this.userRole = null;
    userLogin = null;
    User().userName = null;
    // storage.setItem("reloadPage", null);
    // storage.deleteItem('userName');
    notifyListeners();
  }

  logoutServer() async {
    try {
      Map<String, String> headers = {
        'content-type': 'application/json',
        'Authorization': "Bearer $authorization"
      };
      var response =
          await http.get(Uri.parse("$baseUrl/api/logout"), headers: headers);
      // if (response.statusCode == 200) {
      //   var userLoginGetResponse = json.decode(response.body);
      //   if (userLoginGetResponse["success"] == true) {
      //     userLogin = userLoginGetResponse["result"];
      //     storage.setItem("userLogin", userLogin!);
      //   }
      // }
    } catch (e) {
      dev.log(e.toString());
    }
  }

  setAuthorization(
      {String? authorization,
      var userName,
      String? passWord,
      List<dynamic>? role}) async {
    authenticated = (authorization != null) ? true : false;
    storage.setItem("authorization", "$authorization");
    dev.log(authorization.toString());
    // await setInforUser(userName: userName, authorization: authorization);
    this.authorization = authorization;
    this.userName = userName;
    storage.setItem("userName", userName);
    this.passWord = passWord;
    storage.setItem("passWord", passWord);
    print("-------------------");
    print(role);
    if (role != null) {
      if (role.contains("ROLE_ADMIN")) {
        this.roleUser = "ROLE_ADMIN";
        storage.setItem("roleUser", "ROLE_ADMIN");
      } else {
        this.roleUser = "ROLE_USER";
        storage.setItem("roleUser", "ROLE_USER");
      }
    } else {
      this.roleUser = null;
      storage.setItem("roleUser", null);
    }

    User().userName = userName;
    notifyListeners();
    SecurityModel(storage);
  }

  setInforUser({var userName, var authorization}) async {
    storage.setItem("reloadPage", null);

    if (authorization != null) {
      String token = authorization;
      Map<String, dynamic> user = Jwt.parseJwt(token);
      dev.log("objectL: $user");
      Map<String, String> headers = {
        'content-type': 'application/json',
        'Authorization': "Bearer $authorization"
      };
      var response = await http.get(
          Uri.parse("$baseUrl/api/tbl-user/get/${user["haivn"]["userId"]}"),
          headers: headers);
      if (response.statusCode == 200) {
        var userLoginGetResponse = json.decode(response.body);
        if (userLoginGetResponse["success"] == true) {
          userLogin = userLoginGetResponse["result"];
          storage.setItem("userLogin", userLogin!);
          // print("thông tin");
          // print(userLoginGetResponse);
          // print(userLogin!.toJson());
        }

        // var response1 = await http.get(Uri.parse(baseUrl + "/api/chucnang/get/navigation"), headers: headers);
        // if (response1.statusCode == 200) {
        //   var rule = json.decode(response1.body)['1'];
        //   this.listMenu = rule;
        // }
        // var getRole = await http.get(Uri.parse(baseUrl + "/api/tbl-user/get/fun_per-of-user"), headers: headers);
        // // print("111111111111111111111111111111111111111");
        // if (getRole.statusCode == 200) {
        //   var role = json.decode(response.body);
        //   if (role["success"] == true) {
        //     // userRole = role["result"];
        //     // storage.setItem("userRole", userRole!);
        //   }
        // }
        // var getRule = await http.get(Uri.parse(baseUrl + "/api/nhomquyen-chucnang/get/page?size=10000"), headers: headers);
        // if (getRule.statusCode == 200) {
        //   var rule = json.decode(getRule.body)['content'];
        //   this.rule = rule;
        // }
      } else {
        authenticated = false;
        storage.deleteItem("login");
        storage.deleteItem("authorization");
        storage.deleteItem("reloadPage");
        storage.deleteItem("listRule");
        storage.deleteItem('userName');
      }
    }
    notifyListeners();
  }

  reload() async {
    var authorization = storage.getItem("authorization");

    if (authorization != null) {}
    notifyListeners();
  }
}
