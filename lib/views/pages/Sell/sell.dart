import 'dart:convert';

import 'package:fltn_app/api.dart';
import 'package:fltn_app/views/pages/infomation_drugs.dart';
import 'package:fltn_app/views/pages/sell/create_bill.dart';
import 'package:flutter/material.dart';
import '../../../common/widgets/divider.dart';
import '../../../common/widgets/loading.dart';
import '../../../common/widgets/search.dart';
import '../../../consts/colorsTheme.dart';
import 'dart:developer' as dev;

import '../../../stores/model/productModel.dart';

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
  callApiProduct() async {
    // var idTopicHome = Provider.of<HomeModel>(context, listen: false);
    // if (idTopicHome.check == true) {
    //   idTopic = idTopicHome.valueid;
    var search = {
      "pageNumber": 1,
      "pageSize": 5,
      "customize": {
        // "tenThuoc":"Thuốc dạ dày chữ Y"
      }
    };
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
        (loading == true) ? renderContentSell(context) : loadingCallAPi(),
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
          addItem: const CreateBillSellScreen(),
          filterIcon: Icons.filter_alt_rounded,
        ));
  }

  renderContentSell(context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [for (ProductModel item in listProduct) renderProduct(context, item)],
        ),
      ),
    );
  }

  renderProduct(context, ProductModel productModel) {
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
              Image.asset('assets/images/LogoApp.png', height: 50, filterQuality: FilterQuality.high),
              // Image(
              //   image: AssetImage(productModel.url),
              //   height: 50,
              // ),
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
                          Text(productModel.tenThuoc ?? '', style: const TextStyle(fontSize: 15)),
                          Text(
                            productModel.maThuoc ?? '',
                            style: TextStyle(color: logoGreen, fontSize: 15),
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
                            "Chưa làm",
                            style: TextStyle(color: logoGreen, fontSize: 15),
                          ),
                          Text(
                            "Hàm lượng",
                            style: const TextStyle(color: Colors.black54, fontSize: 14),
                          ),
                          Text(
                            "SL kho: ${listProduct.length}",
                            style: const TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ]),
            divider(context: context)
          ],
        ),
      ),
    );
  }
}
