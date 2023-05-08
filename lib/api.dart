import 'dart:convert';
import 'package:fltn_app/model/securityModel.dart';
import 'package:fltn_app/url.dart';
import 'package:provider/provider.dart';
import 'dart:developer' as dev;
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
// ignore: avoid_web_libraries_in_flutter

//lấy về bản ghi
httpGet(url, context) async {
  var securityModel = Provider.of<SecurityModel>(context, listen: false);
  // print("aam ${securityModel.authorization!}");
  Map<String, String> headers = {'content-type': 'application/json'};
  if (securityModel.authorization != null) {
    headers["Authorization"] = "Bearer ${securityModel.authorization!}";
  }
  var response = await http.get(Uri.parse('$baseUrl$url'), headers: headers);
  if (response.statusCode == 200 &&
      response.headers["content-type"] == 'application/json') {
    try {
      return {
        "headers": response.headers,
        "body": json.decode(utf8.decode(response.bodyBytes))
      };
    } on FormatException catch (e) {
      dev.log(e.toString());
    }
  } else if (response.statusCode == 403) {
    // showToast(
    //   context: context,
    //   msg: "Bạn không có quyền thực hiện chức năng này",
    //   color: colorOrange,
    //   icon: Icon(Icons.warning),
    // );
    return false;
  } else {
    return {
      "headers": response.headers,
      "body": utf8.decode(response.bodyBytes)
    };
  }
}

// void downloadFile(String fileName) {
//   html.AnchorElement anchorElement = new html.AnchorElement(href: "$baseUrl/api/files/$fileName");
//   anchorElement.download = "$baseUrl/api/files/$fileName";
//   anchorElement.click();
// }

//insert bản ghi
httpPost(url, requestBody, context) async {
  var securityModel = Provider.of<SecurityModel>(context, listen: false);
  Map<String, String> headers = {'content-type': 'application/json'};
  if (securityModel.authorization != null) {
    headers["Authorization"] = "Bearer ${securityModel.authorization!}";
  }
  var finalRequestBody = json.encode(requestBody);
  var response = await http.post(Uri.parse("$baseUrl$url".toString()),
      headers: headers, body: finalRequestBody);

  if (response.statusCode == 200 &&
      response.headers["content-type"] == 'application/json') {
    // print("thông tin cần thiết");
    // print(json.decode(utf8.decode(response.bodyBytes)));
    try {
      return {
        "headers": response.headers,
        "body": json.decode(utf8.decode(response.bodyBytes))
      };
      // ignore: unused_catch_clause
    } on FormatException catch (e) {
      //bypass
    }
  } else if (response.statusCode == 403) {
    return false;
  } else {
    return {
      "headers": response.headers,
      "body": utf8.decode(response.bodyBytes)
    };
  }
}

//xóa bản ghi
httpDelete(url, context) async {
  var securityModel = Provider.of<SecurityModel>(context, listen: false);
  Map<String, String> headers = {'content-type': 'application/json'};
  if (securityModel.authorization != null) {
    headers["Authorization"] = "Bearer ${securityModel.authorization!}";
  }
  var response = await http.delete(Uri.parse('$baseUrl$url'), headers: headers);
  if (response.statusCode == 200 &&
      response.headers["content-type"] == 'application/json') {
    try {
      return {
        "headers": response.headers,
        "body": json.decode(utf8.decode(response.bodyBytes))
      };
      // ignore: unused_catch_clause
    } on FormatException catch (e) {
      //bypass
    }
  } else if (response.statusCode == 403) {
    // showToast(
    //   context: context,
    //   msg: "Bạn không có quyền thực hiện chức năng này",
    //   color: colorOrange,
    //   icon: Icon(Icons.warning),
    // );
    return false;
  } else {
    return {
      "headers": response.headers,
      "body": utf8.decode(response.bodyBytes)
    };
  }
}

//update bản ghi
httpPut(url, requestBody, context) async {
  var securityModel = Provider.of<SecurityModel>(context, listen: false);
  Map<String, String> headers = {'content-type': 'application/json'};
  if (securityModel.authorization != null) {
    headers["Authorization"] = "Bearer ${securityModel.authorization!}";
  }
  var finalRequestBody = json.encode(requestBody);
  var response = await http.put(Uri.parse('$baseUrl$url'),
      headers: headers, body: finalRequestBody);
  if (response.statusCode == 200 &&
      response.headers["content-type"] == 'application/json') {
    try {
      return {
        "headers": response.headers,
        "body": json.decode(utf8.decode(response.bodyBytes))
      };
    } on FormatException catch (e) {
      dev.log(e.toString());
      //bypass
    }
  } else if (response.statusCode == 403) {
    // showToast(
    //   context: context,
    //   msg: "Bạn không có quyền thực hiện chức năng này",
    //   color: colorOrange,
    //   icon: Icon(Icons.warning),
    // );
    return false;
  } else {
    return {
      "headers": response.headers,
      "body": utf8.decode(response.bodyBytes)
    };
  }
}
