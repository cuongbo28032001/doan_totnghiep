import 'dart:math';

import 'package:fltn_app/common/widgets/card_layout.dart';
import 'package:fltn_app/common/widgets/input_layout.dart';
import 'package:fltn_app/common/widgets/showToast.dart';
import 'package:fltn_app/model/productModel.dart';
import 'package:fltn_app/url.dart';
import 'package:fltn_app/views/App.dart';
import 'package:fltn_app/views/pages/Sell/sell.dart';
import 'package:fltn_app/views/pages/enter_drugs/add_update_drugs.dart';
import 'package:flutter/material.dart';
import '../../api.dart';
import '../../consts/colorsTheme.dart';

// ignore: must_be_immutable
class InfomationDrugs extends StatefulWidget {
  ProductModel productModel;
  InfomationDrugs({super.key, required this.productModel});

  @override
  State<InfomationDrugs> createState() => _InfomationDrugsState();
}

class _InfomationDrugsState extends State<InfomationDrugs> {
  late int numberOrderProduct = 0;
  String? error;
  late TextEditingController controllerSoLo = TextEditingController();

  callAPILoThuoc(object) async {
    try {
      var response = await httpPost('/api/lothuoc/create', object, context);
      if (response.containsKey("body")) {
        var body = response["body"];
        print(body);
        setState(() {
          error = body["desc"];
        });
        if (error!.compareTo("THÊM MỚI THÀNH CÔNG") == 0) {
          toast(error!);
        } else {
          toast(error!);
        }
      }
    } catch (e) {
      return e;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controllerSoLo.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: logoGreen,
        centerTitle: true,
        title: const Text("Thông tin thuốc"),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: renderInfomationDrugs(),
        ),
      ),
    );
  }

  renderInfomationDrugs() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 200,
          decoration: BoxDecoration(
            border: Border.all(width: 0.1, color: logoGreen),
            image: widget.productModel.image == null
                ? const DecorationImage(
                    image: AssetImage("assets/images/image_local.png"),
                    fit: BoxFit.contain)
                : DecorationImage(
                    image: NetworkImage(
                      '$baseUrl/api/thuoc/image/${widget.productModel.id}?timestamp=${Random().nextInt(10000)}',
                    ),
                  ),
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
          ),
        ),
        const SizedBox(
          height: 16.0,
        ),
        CardLayoutWidget(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.productModel.tenThuoc!,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      widget.productModel.maThuoc ?? '',
                      style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                          fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              ),
              const Text(
                "Mô tả",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Thành phần",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    widget.productModel.thanhPhan ?? '',
                    style: const TextStyle(height: 1.5),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const Text(
                    "Chỉ định",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    widget.productModel.huongDanSuDung ?? '',
                    style: const TextStyle(height: 1.5),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const Text(
                    "Liều dùng và cách sử dụng",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    widget.productModel.lieuLuong ?? '',
                    style: const TextStyle(height: 1.5),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const Text(
                    "Chống chỉ định",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    widget.productModel.chongChiDinh ?? '',
                    style: const TextStyle(height: 1.5),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const Text(
                    "Bảo quản",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    widget.productModel.baoQuan ?? '',
                    style: const TextStyle(height: 1.5),
                  ),
                ],
              )
            ],
          ),
        ),
        const SizedBox(
          height: 16.0,
        ),
        Align(
            alignment: Alignment.centerRight,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext contextDialog) {
                          return AlertDialog(
                            title: const Text(
                              "Thêm lô thuốc",
                              textAlign: TextAlign.center,
                            ),
                            titleTextStyle: TextStyle(
                                color: logoGreen,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                            content: InputFormWidget(
                              controller: controllerSoLo,
                            ),
                            actions: [
                              TextButton(
                                child: Text(
                                  "Tiếp tục",
                                  style: TextStyle(color: logoOrange),
                                ),
                                onPressed: () async {
                                  await callAPILoThuoc({
                                    'soLo': controllerSoLo.text,
                                    'thuoc': widget.productModel.id
                                  });
                                  if (error
                                          .toString()
                                          .compareTo('THÊM MỚI THÀNH CÔNG') ==
                                      0) {
                                    Navigator.pop(contextDialog);
                                    Navigator.pop(context);
                                  }
                                },
                              )
                            ],
                          );
                        },
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10.0),
                      decoration: BoxDecoration(
                          color: logoOrange,
                          border: Border.all(width: 0.5, color: logoOrange),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(5.0),
                          )),
                      child: const Text(
                        "Thêm lô thuốc",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20.0,
                ),
                Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddUpdateInfoDrugsSCreen(
                            title: "Chỉnh sửa",
                            productModel: widget.productModel,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10.0),
                      decoration: BoxDecoration(
                          color: logoOrange,
                          border: Border.all(width: 0.5, color: logoOrange),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(5.0),
                          )),
                      child: const Text(
                        "Chỉnh sửa",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ],
    );
  }
}
