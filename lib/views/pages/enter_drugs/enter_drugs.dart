import 'dart:math';

import 'package:fltn_app/common/widgets/card_layout.dart';
import 'package:fltn_app/common/widgets/showToast.dart';
import 'package:fltn_app/url.dart';
import 'package:flutter/material.dart';
import '../../../api.dart';
import '../../../common/widgets/check_box.dart';
import '../../../common/widgets/divider.dart';
import '../../../common/widgets/search.dart';
import '../../../consts/colorsTheme.dart';
import '../../../model/lo_thuoc.dart';
import '../../../model/productModel.dart';

// ignore: unused_import, depend_on_referenced_packages
import 'package:intl/intl.dart';

import 'add_update_drugs.dart';
import 'create_bill_enter_drugs.dart';

class EnterdrugsScreen extends StatefulWidget {
  const EnterdrugsScreen({super.key});

  @override
  State<EnterdrugsScreen> createState() => _EnterdrugsScreenState();
}

class _EnterdrugsScreenState extends State<EnterdrugsScreen> {
  List<dynamic> productSelect = [];
  List<dynamic> productListSell = [];
  int sumMoeny = 0;
  bool loading = false;
  late TextEditingController searchController;

  Future<void> processing() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  callApiProduct() async {
    var search = {"pageNumber": 1, "pageSize": 100, "customize": {}};
    try {
      var response = await httpPost('/api/thuoc/search', search, context);

      if (response.containsKey("body")) {
        var body = response["body"]["result"]["content"];
        setState(() {
          productListSell = body.map((e) {
            return ProductModel.fromJson(e);
          }).toList();
          if (productListSell.isNotEmpty) {
            loading = true;
          }
        });
      }
    } catch (e) {
      return productListSell;
    }

    return productListSell;
  }

  @override
  void initState() {
    // TODO: implement initState
    callApiProduct();
    super.initState();
    searchController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchController.dispose();
  }

  String convertToDate(int value) {
    DateTime dateTime;
    dateTime = DateTime.fromMillisecondsSinceEpoch(value);
    var date = DateFormat('yyyy-MM-dd').format(dateTime);
    return date;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: logoGreen,
        centerTitle: true,
        title: const Text("Nhập thuốc"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddUpdateInfoDrugsSCreen(
                              title: "Thêm thuốc",
                            )));
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: renderCreateBillSellDrugs(),
    );
  }

  renderCreateBillSellDrugs() {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        renderSearch(context),
        const SizedBox(
          height: 20,
        ),
        renderContentSell(context),
      ],
    );
  }

  renderSearch(context) {
    return Container(
        color: Colors.white,
        height: 50,
        child: Row(
          children: [
            Expanded(
              child: inPutSearch(
                context: context,
                controller: searchController,
                lable: 'Nhập tên, mã, serial/IMEI, lô, hsd',
                onSubmitted: (value) {
                  setState(() {});
                },
                callBack: searchAction,
              ),
            ),
            InkWell(
              onTap: productSelect.isNotEmpty
                  ? () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CreatBillEnterDrugs(
                                  productSelect: productSelect)));
                      for (var item in productSelect) {
                        print(item.soLo);
                      }
                      toast("Tạo đơn");
                    }
                  : null,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                color: (productSelect.isNotEmpty)
                    ? logoGreen
                    : logoGreen.withOpacity(0.5),
                height: 50,
                child: const Center(
                  child: Text(
                    "Tạo đơn",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            )
          ],
        ));
  }

  //Giao diện mới mà em muốn

  renderContentSell(context) {
    return Expanded(
      child: ListView(
        children: [
          for (ProductModel item in productListSell)
            if (item.loThuoc!.isNotEmpty)
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
                child: CardLayoutWidget(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          item.image == null
                              ? const Image(
                                  image:
                                      AssetImage("assets/images/LogoApp.png"),
                                  height: 50,
                                )
                              : Image.network(
                                  '$baseUrl/api/thuoc/image/${item.id}?timestamp=${Random().nextInt(10000)}',
                                  height: 50,
                                  width: 50,
                                  fit: BoxFit.fitWidth,
                                ),
                          const SizedBox(width: 20),
                          const Expanded(
                            child: SizedBox(),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(item.tenThuoc!,
                                  style: const TextStyle(fontSize: 15)),
                              const SizedBox(
                                height: 16,
                              ),
                              Text(
                                item.maThuoc ?? '',
                                style: const TextStyle(
                                    color: Colors.black54, fontSize: 14),
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      renderSoLo(item),
                    ],
                  ),
                ),
              ),
        ],
      ),
    );
  }

  renderSoLo(ProductModel productModel) {
    return Column(
      children: [
        for (LoThuoc loThuoc in productModel.loThuoc!)
          Column(
            children: [
              CheckBoxWidget(
                value: productSelect.contains(loThuoc),
                content: renderProduct(context, loThuoc),
                handleSelected: (bool? value) {
                  setState(() {
                    if (value!) {
                      productSelect.add(loThuoc);
                    } else {
                      productSelect.remove(loThuoc);
                    }
                  });
                },
              ),
              if (productModel.loThuoc!.length - 1 !=
                  productModel.loThuoc!.indexOf(loThuoc))
                divider(context: context)
            ],
          ),
      ],
    );
  }

  renderProduct(context, LoThuoc loThuoc) {
    return Container(
      padding: const EdgeInsets.only(top: 5, left: 5, right: 15, bottom: 0),
      color: Colors.white,
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        Expanded(
          child: SizedBox(
            height: 65,
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Số lô: ${loThuoc.soLo!}',
                        style: const TextStyle(fontSize: 15)),
                    Text(
                      loThuoc.giaBan == 0
                          ? 'Chưa có thông tin'
                          : loThuoc.giaBan!.toString(),
                      style: TextStyle(
                          color: logoGreen,
                          fontStyle: FontStyle.italic,
                          fontSize: 15),
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
                      'SL kho: ${loThuoc.soLuong!.toString()}',
                      style: const TextStyle(fontSize: 15),
                    ),
                    Text(
                      loThuoc.hsd.toString().compareTo('null') == 0
                          ? 'Chưa có thông tin'
                          : 'HSD: ${convertToDate(loThuoc.hsd!)}',
                      style: const TextStyle(
                          fontSize: 15,
                          fontStyle: FontStyle.italic,
                          color: Colors.black45),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }

  void searchAction(String query) {
    if (query.isNotEmpty) {
      final suggestions = productListSell.where((product) {
        final nameProduct = product.tenThuoc!.toLowerCase();
        final codeProduct = product.maThuoc!.toLowerCase();
        final input = query.toLowerCase();
        if (nameProduct.contains(input) || codeProduct.contains(input)) {
          return true;
        } else {
          return false;
        }
      }).toList();

      setState(() {
        productListSell = suggestions;
      });
    }
  }
}
