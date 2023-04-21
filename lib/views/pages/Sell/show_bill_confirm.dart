import 'package:fltn_app/common/widgets/card_layout.dart';
import 'package:fltn_app/common/widgets/showToast.dart';
import 'package:flutter/material.dart';
import '../../../consts/colorsTheme.dart';
import '../../../stores/model/productModel.dart';
import '../../App.dart';

class ShowBillConfirmScreen extends StatelessWidget {
  Map<ProductModel, int> productSelect;
  ShowBillConfirmScreen({super.key, required this.productSelect});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: logoGreen,
        title: const Center(child: Text("Thông tin đơn hàng")),
      ),
      body: renderBody(),
    );
  }

  int sumMoney() {
    int totalPrice = 0;
    // Lấy số lượng mua của từng sản phẩm từ map orderQuantities
    productSelect.forEach((product, quantity) {
      if (quantity > 0) {
        // Tính tổng số tiền của sản phẩm hiện tại
        int productPrice = 20;
        int productTotalPrice = productPrice * quantity;
        // Cộng vào tổng số tiền
        totalPrice += productTotalPrice;
      }
    });
    return totalPrice;
  }

  renderBody() {
    int sumMoeny = sumMoney();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Column(
        children: [
          CardLayoutWidget(
            child: Column(
              children: [
                // const Align(
                //   alignment: Alignment.centerRight,
                //   child: Text("Mã hóa đơn: "),
                // ),
                // const SizedBox(
                //   height: 16.0,
                // ),
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
                  children: const [
                    Text("Thời gian: ",
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    Text("07:12 AM - 11/11/2022")
                  ],
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Thành tiền: ",
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    Text("$sumMoeny VND", style: TextStyle(color: logoGreen))
                  ],
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Sản phẩm mua: ",
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        for (var item in productSelect.entries)
                          if (item.value > 0)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                      "KHông - SL: ${item.value}"),
                                  const SizedBox(
                                    height: 8.0,
                                  ),
                                  Text(
                                    "200 VND",
                                    style: TextStyle(color: logoGreen),
                                  ),
                                ],
                              ),
                            ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Expanded(
            child: SizedBox(),
          ),
          InkWell(
            onTap: () {
              toast("Thành công");
              globalAppContent.currentState?.selectSellTab();
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
