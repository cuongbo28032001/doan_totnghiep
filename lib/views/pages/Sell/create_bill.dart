import 'package:fltn_app/common/widgets/check_box.dart';
import 'package:fltn_app/common/widgets/showToast.dart';
import 'package:fltn_app/views/pages/sell/show_bill_confirm.dart';
import 'package:flutter/material.dart';

import '../../../common/widgets/divider.dart';
import '../../../common/widgets/search.dart';
import '../../../consts/colorsTheme.dart';
import '../../../stores/model/productModel.dart';

class CreateBillSellScreen extends StatefulWidget {
  const CreateBillSellScreen({super.key});

  @override
  State<CreateBillSellScreen> createState() => _CreateBillSellScreenState();
}

class _CreateBillSellScreenState extends State<CreateBillSellScreen> {
  Map<ProductModel, int> productSelect = {};
  List<ProductModel> productListSell = [];
  int sumMoeny = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // for (ProductModel item in items) {
    //   if (item.quantityInStock > 0) {
    //     productListSell.add(item);
    //   }
    // }
  }

  int calculateTotalPrice() {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: logoGreen,
        centerTitle: true,
        title: const Text("Tạo đơn "),
      ),
      body: renderCreateBillSellDrugs(),
    );
  }

  renderCreateBillSellDrugs() {
    setState(() {
      sumMoeny = calculateTotalPrice();
    });
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        renderSearch(context),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Đã chọn (${productSelect.length}) sản phẩm"),
              InkWell(
                  onTap: () {
                    print(productSelect);
                    productSelect.forEach((product, count) {
                      if (count > 0) {
                        // print(
                        //     'Sản phẩm: ${product.nameProduct}, Số lượng: $count');
                      }
                    });
                  },
                  child: Text("Thành tiền: $sumMoeny")),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        // renderContentSell(context),
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
                lable: 'Nhập tên, mã, serial/IMEI, lô, hsd',
                filterIcon: Icons.filter_alt_rounded,
              ),
            ),
            InkWell(
              onTap: (sumMoeny > 0)
                  ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ShowBillConfirmScreen(
                            productSelect: productSelect,
                          ),
                        ),
                      );
                      toast("Tạo đơn");
                    }
                  : null,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                color: (sumMoeny > 0) ? logoGreen : logoGreen.withOpacity(0.5),
                height: 50,
                child: const Center(
                  child: Text(
                    "Tạo đơn",
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            )
          ],
        ));
  }

  // renderContentSell(context) {
  //   return Expanded(
  //     child: ListView(
  //       children: [
  //         for (ProductModel item in productListSell)
  //           if (item.quantityInStock > 0)
  //             Container(
  //               padding: const EdgeInsets.only(left: 16.0),
  //               color: Colors.white,
  //               child: Column(
  //                 children: [
  //                   CheckBoxWidget(
  //                     value: productSelect.keys.contains(item) &&
  //                         productSelect[item]! > 0,
  //                     content: renderProduct(context, item),
  //                     handleSelected: (bool? value) {
  //                       setState(() {
  //                         if (value!) {
  //                           // Nếu sản phẩm đã được chọn, thì kiểm tra nếu đã tồn tại trong selectedProducts thì tăng số lượng lên 1, ngược lại thêm sản phẩm vào selectedProducts với số lượng là 1
  //                           if (productSelect.containsKey(item)) {
  //                             productSelect[item] = productSelect[item]! + 1;
  //                           } else {
  //                             productSelect[item] = 1;
  //                           }
  //                         } else {
  //                           // Nếu sản phẩm đã bị bỏ chọn, thì giảm số lượng của sản phẩm trong productSelect xuống 1. Nếu số lượng là 0 thì xóa sản phẩm khỏi productSelect
  //                           if (productSelect.containsKey(item) &&
  //                               productSelect[item]! > 0) {
  //                             productSelect[item] = 0;
  //                             if (productSelect[item]! == 0) {
  //                               productSelect.remove(item);
  //                             }
  //                           }
  //                         }
  //                       });
  //                     },
  //                   ),
  //                   Padding(
  //                     padding: const EdgeInsets.only(right: 15.0),
  //                     child: renderOrderNumberProduct(item),
  //                   ),
  //                   (productListSell.indexOf(item) !=
  //                           productListSell.length - 1)
  //                       ? divider(context: context)
  //                       : Container(
  //                           width: double.infinity,
  //                           height: 10.0,
  //                           color: Colors.white,
  //                         ),
  //                 ],
  //               ),
  //             ),
  //       ],
  //     ),
  //   );
  // }

  renderProduct(context, ProductModel productModel) {
    return Container(
      padding: const EdgeInsets.only(top: 5, left: 5, right: 15, bottom: 0),
      color: Colors.white,
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        // Image(
        //   image: AssetImage(productModel.url),
        //   height: 50,
        // ),
        const SizedBox(width: 20),
        Expanded(
          child: SizedBox(
            height: 65,
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("productModel.nameProduct", style: const TextStyle(fontSize: 15)),
                    Text(
                      "SL kho:200",
                      style: const TextStyle(fontSize: 15),
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
                      "không",
                      style: TextStyle(color: logoGreen, fontSize: 15),
                    ),
                    Text(
                      "không",
                      style: const TextStyle(color: Colors.black54, fontSize: 14),
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

  renderOrderNumberProduct(ProductModel productModel) {
    int numberOrderProduct = productSelect[productModel] ?? 0;
    return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
      InkWell(
        onTap: numberOrderProduct > 0
            ? () {
                setState(() {
                  if (numberOrderProduct > 0) {
                    numberOrderProduct--;
                  }
                  productSelect[productModel] = numberOrderProduct;
                });
              }
            : null,
        child: Icon(
          Icons.remove,
          size: 20,
          color: numberOrderProduct > 0 ? logoGreen : Colors.black12,
        ),
      ),
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 5.0),
        decoration: const BoxDecoration(color: Colors.black12, borderRadius: BorderRadius.all(Radius.circular(5.0))),
        width: 40,
        height: 25,
        child: Center(
          child: Text(
            numberOrderProduct.toString(),
            style: const TextStyle(fontSize: 13),
          ),
        ),
      ),
      // InkWell(
      //   onTap: numberOrderProduct < productModel.quantityInStock
      //       ? () {
      //           setState(() {
      //             if (numberOrderProduct < productModel.quantityInStock) {
      //               numberOrderProduct++;
      //             }
      //             productSelect[productModel] = numberOrderProduct;
      //           });
      //         }
      //       : null,
      //   child: Icon(
      //     Icons.add,
      //     size: 20,
      //     color: numberOrderProduct < productModel.quantityInStock
      //         ? logoGreen
      //         : Colors.black26,
      //   ),
      // ),
    ]);
  }
}
