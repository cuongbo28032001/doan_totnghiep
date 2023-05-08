import 'package:fltn_app/common/widgets/card_layout.dart';
import 'package:fltn_app/common/widgets/divider.dart';
import 'package:fltn_app/common/widgets/showToast.dart';
import 'package:fltn_app/model/user.dart';
import 'package:fltn_app/views/pages/Sell/sell.dart';
import 'package:flutter/material.dart';
import '../../../api.dart';
import '../../../consts/colorsTheme.dart';

// ignore: unused_import, depend_on_referenced_packages
import 'package:intl/intl.dart';

// ignore: must_be_immutable

class ShowBillConfirmScreen extends StatefulWidget {
  Map<dynamic, int> productSelect;
  ShowBillConfirmScreen({super.key, required this.productSelect});

  @override
  State<ShowBillConfirmScreen> createState() => _ShowBillConfirmScreenState();
}

class _ShowBillConfirmScreenState extends State<ShowBillConfirmScreen> {
  List<dynamic> listProductSell = [];
  String? error;
  int? idHoaDon;

  callApiDonXuat(object) async {
    try {
      var response = await httpPost('/api/don-xuat/create', object, context);
      if (response.containsKey("body")) {
        var body = response["body"];
        print('api don: $body');
        setState(() {
          error = body["desc"];
        });
        if (error!.compareTo("THÊM MỚI THÀNH CÔNG") == 0) {
          setState(() {
            idHoaDon = body['result']['id'];
          });
        }
      }
    } catch (e) {
      return e;
    }
  }

  callApiChiTietDonXuat(List<dynamic> list) async {
    try {
      var response =
          await httpPost('/api/chi-tiet-don-xuat/create', list, context);
      if (response.containsKey("body")) {
        var body = response["body"];
        setState(() {
          error = body["desc"];
        });
      }
      if (error!.compareTo('THÊM MỚI THÀNH CÔNG') == 0) {
        toast(error!);
      } else {
        toast(error!);
      }
    } catch (e) {
      return e;
    }
  }

  addListProductSell() async {
    await callApiDonXuat({
      'nguoiXuat': User().userName,
      "ngayXuat": DateFormat("yyyy-MM-dd").format(DateTime.now())
    });
    for (var items in widget.productSelect.entries) {
      var itemTemp = {
        'donXuat': idHoaDon,
        'loThuoc': items.key.id,
        'soLuong': items.value,
      };
      bool isExist = false;
      for (var post in listProductSell) {
        if (post['loThuoc'] == itemTemp['loThuoc']) {
          isExist = true;
          break;
        }
      }
      if (!isExist) {
        listProductSell.add(itemTemp);
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    // addListProductSell();
    sumMoney();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: logoGreen,
        title: const Text("Xác nhận đơn bán"),
      ),
      body: renderBody(context),
    );
  }

  int sumMoney() {
    int totalPrice = 0;
    // Lấy số lượng mua của từng sản phẩm từ map orderQuantities
    widget.productSelect.forEach((product, quantity) {
      if (quantity > 0) {
        // Tính tổng số tiền của sản phẩm hiện tại
        int productPrice = product.giaBan;
        int productTotalPrice = productPrice * quantity;
        // Cộng vào tổng số tiền
        totalPrice += productTotalPrice;
      }
    });
    return totalPrice;
  }

  renderBody(context) {
    int sumMoeny = sumMoney();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
      child: Column(
        children: [
          CardLayoutWidget(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "Người tạo: ",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text("Đoàn Quốc Cường")
                  ],
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Thời gian: ",
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    // ignore: unnecessary_string_interpolations
                    Text("${DateFormat("yyyy-MM-dd").format(DateTime.now())}")
                  ],
                ),
                const SizedBox(
                  height: 10.0,
                ),
                divider(context: context),
                const SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Expanded(
                      flex: 7,
                      child: Text(
                        'Thuốc',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                    Expanded(
                        flex: 5,
                        child: Text(
                          'Số lô/Số lượng',
                          style: TextStyle(fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        )),
                    Expanded(
                      flex: 4,
                      child: Text(
                        'Đơn giá',
                        style: TextStyle(fontWeight: FontWeight.w600),
                        textAlign: TextAlign.end,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10.0,
                ),
                for (var items in widget.productSelect.entries)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 7,
                          child: Text('${items.key.tenThuoc}'),
                        ),
                        Expanded(
                            flex: 4,
                            child: Text(
                              '${items.key.soLo}/${items.value}',
                              textAlign: TextAlign.center,
                            )),
                        Expanded(
                          flex: 4,
                          child: Text(
                            '${items.key.giaBan} VND',
                            textAlign: TextAlign.end,
                          ),
                        )
                      ],
                    ),
                  ),
                divider(context: context),
                const SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text("Thành tiền: ",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.italic)),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Text("$sumMoeny VND",
                        style: TextStyle(
                            color: logoGreen, fontStyle: FontStyle.italic))
                  ],
                ),
              ],
            ),
          ),
          const Expanded(
            child: SizedBox(),
          ),
          InkWell(
            onTap: () async {
              await addListProductSell();
              await callApiChiTietDonXuat(listProductSell);
              Future.delayed(const Duration(seconds: 2), () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const SellScreen()),
                  (Route<dynamic> route) => false,
                );
              });
            },
            child: Container(
              alignment: Alignment.center,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              decoration: BoxDecoration(
                color: logoGreen,
                borderRadius: const BorderRadius.all(
                  Radius.circular(8.0),
                ),
              ),
              child: const Text(
                "Tiếp tục",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
