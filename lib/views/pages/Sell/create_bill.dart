import 'dart:math';

import 'package:fltn_app/common/widgets/card_layout.dart';
import 'package:fltn_app/common/widgets/showToast.dart';
import 'package:fltn_app/url.dart';
import 'package:fltn_app/views/pages/sell/show_bill_confirm.dart';
import 'package:flutter/material.dart';
import '../../../common/widgets/check_box.dart';
import '../../../common/widgets/divider.dart';
import '../../../common/widgets/search.dart';
import '../../../consts/colorsTheme.dart';
import '../../../model/lo_thuoc.dart';
import '../../../model/productModel.dart';

// ignore: unused_import, depend_on_referenced_packages
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class CreateBillSellScreen extends StatefulWidget {
  List<dynamic>? listProducts;
  CreateBillSellScreen({super.key, this.listProducts});

  @override
  State<CreateBillSellScreen> createState() => _CreateBillSellScreenState();
}

class _CreateBillSellScreenState extends State<CreateBillSellScreen> {
  Map<dynamic, int> productSelect = {};
  List<dynamic> productListSell = [];
  int sumMoeny = 0;
  late TextEditingController searchController;

  @override
  void initState() {
    // TODO: implement initState
    if (widget.listProducts!.isNotEmpty) {
      for (ProductModel items in widget.listProducts!) {
        if (items.loThuoc!.isNotEmpty) {
          int sum = 0;
          for (LoThuoc itemLo in items.loThuoc!) {
            sum += itemLo.soLuong!;
          }
          if (sum > 0) {
            productListSell.add(items);
          }
        }
      }
    }
    super.initState();
    searchController = TextEditingController();
    // for (ProductModel item in items) {
    //   if (item.quantityInStock > 0) {
    //     productListSell.add(item);
    //   }
    // }
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

  int calculateTotalPrice() {
    int totalPrice = 0;
    // Lấy số lượng mua của từng sản phẩm từ map orderQuantities
    productSelect.forEach((product, quantity) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: logoGreen,
        centerTitle: true,
        title: const Text("Tạo đơn bán"),
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
                    // productSelect.forEach((product, count) {
                    //   if (count > 0) {
                    //     // print(
                    //     //     'Sản phẩm: ${product.nameProduct}, Số lượng: $count');
                    //   }
                    // });
                  },
                  child: Text("Thành tiền: $sumMoeny")),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
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
                filterIcon: Icons.filter_alt_rounded,
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ShowBillConfirmScreen(
                            productSelect: productSelect)));
                toast("Tạo đơn");
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                color: (productSelect.length > 0)
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
    int count = 0;
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                item.tenThuoc!,
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(
                                height: 18,
                              ),
                              Text(
                                item.maThuoc!,
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
    List<dynamic> listLo = [];
    for (LoThuoc loThuoc in productModel.loThuoc!) {
      if (loThuoc.soLuong! > 0) {
        listLo.add(loThuoc);
      }
    }
    return Column(
      children: [
        for (LoThuoc loThuoc in listLo)
          Column(
            children: [
              CheckBoxWidget(
                value: productSelect.keys.contains(loThuoc) &&
                    productSelect[loThuoc]! > 0,
                content: renderProduct(context, loThuoc),
                handleSelected: (bool? value) {
                  setState(() {
                    if (value!) {
                      // Nếu sản phẩm đã được chọn, thì kiểm tra nếu đã tồn tại trong selectedProducts thì tăng số lượng lên 1, ngược lại thêm sản phẩm vào selectedProducts với số lượng là 1
                      if (productSelect.containsKey(loThuoc)) {
                        productSelect[loThuoc] = productSelect[loThuoc]! + 1;
                      } else {
                        productSelect[loThuoc] = 1;
                      }
                    } else {
                      // Nếu sản phẩm đã bị bỏ chọn, thì giảm số lượng của sản phẩm trong productSelect xuống 1. Nếu số lượng là 0 thì xóa sản phẩm khỏi productSelect
                      if (productSelect.containsKey(loThuoc) &&
                          productSelect[loThuoc]! > 0) {
                        productSelect[loThuoc] = 0;
                        if (productSelect[loThuoc]! == 0) {
                          productSelect.remove(loThuoc);
                        }
                      }
                    }
                  });
                },
              ),
              if (listLo.length - 1 != listLo.indexOf(loThuoc))
                divider(context: context)
            ],
          ),
      ],
    );
  }

  renderProduct(context, LoThuoc loThuoc) {
    return Container(
      padding: const EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 0),
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
                    Text('${loThuoc.soLo!} - ${loThuoc.giaBan} VND',
                        style: TextStyle(
                            fontSize: 15,
                            color: logoGreen,
                            fontStyle: FontStyle.italic)),
                    Text(
                      loThuoc.hsd.toString().compareTo('null') == 0
                          ? ''
                          : 'HSD: ${convertToDate(loThuoc.hsd!)}',
                      style: const TextStyle(
                          fontSize: 15,
                          fontStyle: FontStyle.italic,
                          color: Colors.black45),
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
                      'SL: ${loThuoc.soLuong!.toString()}',
                      style: const TextStyle(fontSize: 15),
                    ),
                    renderOrderNumberProduct(loThuoc),
                  ],
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }

  renderOrderNumberProduct(LoThuoc loThuoc) {
    int numberOrderProduct = productSelect[loThuoc] ?? 0;
    return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
      InkWell(
        onTap: numberOrderProduct > 0
            ? () {
                setState(() {
                  if (numberOrderProduct > 0) {
                    numberOrderProduct--;
                  }
                  productSelect[loThuoc] = numberOrderProduct;
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
        decoration: const BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.all(Radius.circular(5.0))),
        width: 40,
        height: 25,
        child: Center(
          child: Text(
            numberOrderProduct.toString(),
            style: const TextStyle(fontSize: 13),
          ),
        ),
      ),

      //
      //
      // Bổ sung trường số lượng trong kho để cộng sản phẩm
      //
      //
      InkWell(
        onTap: numberOrderProduct < loThuoc.soLuong!
            ? () {
                setState(() {
                  if (numberOrderProduct < 200) {
                    numberOrderProduct++;
                  }
                  productSelect[loThuoc] = numberOrderProduct;
                });
              }
            : null,
        child: Icon(
          Icons.add,
          size: 20,
          color: numberOrderProduct < loThuoc.soLuong!
              ? logoGreen
              : Colors.black26,
        ),
      ),
    ]);
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
