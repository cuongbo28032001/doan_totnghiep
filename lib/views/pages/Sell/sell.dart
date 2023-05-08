// ignore: unused_import
import 'dart:convert';
import 'dart:math';
import 'package:fltn_app/api.dart';
import 'package:fltn_app/url.dart';
import 'package:fltn_app/views/pages/infomation_drugs.dart';
import 'package:fltn_app/views/pages/sell/create_bill.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import '../../../common/widgets/divider.dart';
import '../../../common/widgets/loading.dart';
import '../../../common/widgets/search.dart';
import '../../../consts/colorsTheme.dart';
import 'dart:developer' as dev;
import '../../../model/lo_thuoc.dart';
import '../../../model/productModel.dart';

class SellScreen extends StatefulWidget {
  const SellScreen({super.key});

  @override
  State<SellScreen> createState() => _SellScreenState();
}

class _SellScreenState extends State<SellScreen> {
  Future<void> processing() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  bool loading = false;
  List<dynamic> listProduct = [];
  Map<String, dynamic> searchProduc = {};
  callApiProduct() async {
    // var idTopicHome = Provider.of<HomeModel>(context, listen: false);
    // if (idTopicHome.check == true) {
    //   idTopic = idTopicHome.valueid;
    var search = {"pageNumber": 1, "pageSize": 100, "customize": searchProduc};
    try {
      var response = await httpPost('/api/thuoc/search', search, context);
      if (response.containsKey("body")) {
        var body = response["body"]["result"]["content"];
        setState(() {
          listProduct = body.map((e) {
            return ProductModel.fromJson(e);
          }).toList();
          if (listProduct.isNotEmpty) {
            loading = true;
          }
        });
      }
    } catch (e) {
      return listProduct;
    }
    return listProduct;
  }

  @override
  void initState() {
    callApiProduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: logoGreen,
        title: const Center(child: Text("Lựa chọn bán hàng")),
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
        (loading == true)
            ? renderContentSell(context)
            : Expanded(child: loadingCallAPi()),
      ],
    );
  }

  renderSearch(context) {
    return SizedBox(
        height: 50,
        child: inPutSearch(
          context: context,
          lable: 'Nhập tên, mã, serial/IMEI, lô, hsd',
          addIcon: Icons.add,
          addItem: CreateBillSellScreen(
            listProducts: listProduct,
          ),
          callBack: (query) {
            print(query);
          },
        ));
  }

  renderContentSell(context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            for (ProductModel item in listProduct)
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    renderProduct(context, item),
                    (listProduct.length - 1 != listProduct.indexOf(item))
                        ? divider(context: context)
                        : Container(
                            height: 5.0,
                            color: Colors.white,
                          )
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }

  renderProduct(context, ProductModel productModel) {
    DefaultCacheManager().emptyCache();
    int sum = 0;
    if (productModel.loThuoc!.isEmpty) {
      sum = 0;
    } else {
      for (LoThuoc items in productModel.loThuoc!) {
        sum += items.soLuong!;
      }
    }
    return InkWell(
      onTap: () {
        dev.log("Select product $productModel");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => InfomationDrugs(
              productModel: productModel,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.only(top: 5, left: 15, right: 15, bottom: 0),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(children: [
              productModel.image != null
                  ? Image.network(
                      '$baseUrl/api/thuoc/image/${productModel.id}?timestamp=${Random().nextInt(10000)}',
                      height: 50,
                      width: 50,
                      fit: BoxFit.fitWidth,
                      key: UniqueKey(),
                    )
                  : Image.asset(
                      "assets/images/image_local.png",
                      height: 50,
                      width: 50,
                      fit: BoxFit.contain,
                    ),
              Container(
                height: 50,
                color: Colors.red,
              ),
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
                          Text(productModel.tenThuoc ?? '',
                              style: const TextStyle(fontSize: 15)),
                          Text(
                            productModel.maThuoc ?? '',
                            style: TextStyle(color: logoGreen, fontSize: 15),
                          ),
                        ],
                      ),
                      const Expanded(
                        child: SizedBox(),
                      ),
                      (productModel.loThuoc!.isNotEmpty)
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "SL kho: $sum",
                                  style: const TextStyle(fontSize: 15),
                                ),
                                Text(
                                  "Đơn vị tính: ${productModel.donViTinh}",
                                  style: const TextStyle(
                                      color: Colors.black54, fontSize: 14),
                                ),
                              ],
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "SL kho: $sum",
                                  style: const TextStyle(fontSize: 15),
                                ),
                                Text(
                                  "ĐV tính: ${productModel.donViTinh}",
                                  style: const TextStyle(
                                      color: Colors.black54, fontSize: 14),
                                ),
                              ],
                            ),
                    ],
                  ),
                ),
              )
            ]),
          ],
        ),
      ),
    );
  }
}
