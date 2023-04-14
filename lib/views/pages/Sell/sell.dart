import 'package:fltn_app/views/pages/infomation_drugs.dart';
import 'package:flutter/material.dart';
import '../../../common/widgets/divider.dart';
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
        renderContentSell(context),
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
          filterIcon: Icons.filter_alt_rounded,
        ));
  }

  // renderSelectMenu(context) {
  //   return Container(
  //       padding: const EdgeInsets.all(10),
  //       height: 50,
  //       decoration: BoxDecoration(
  //           color: Colors.white,
  //           border: Border(
  //               bottom:
  //                   BorderSide(width: 0.1, color: logoGreen.withOpacity(0.5)))),
  //       child: Row(
  //         children: [
  //           selectIconAndText(
  //               context, Icons.menu, "Tất cả", Colors.black45, 25.0, null),
  //           const Expanded(
  //             child: SizedBox(),
  //           ),
  //           selectIconAndText(
  //               context, Icons.check, "Chọn nhiều", Colors.black45, 20.0, null)
  //         ],
  //       ));
  // }

  // selectIconAndText(context, icons, titles, colors, sizes, widGet) {
  //   return InkWell(
  //     onTap: () {
  //       showModalBottomSheet(
  //         context: context,
  //         isScrollControlled: true,
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(16.0),
  //         ),
  //         builder: (BuildContext context) {
  //           return FractionallySizedBox(
  //             heightFactor: 0.8,
  //             child: widGet,
  //           );
  //         },
  //       );
  //     },
  //     child: Row(children: [
  //       Icon(
  //         icons,
  //         color: colors,
  //         size: sizes,
  //       ),
  //       const SizedBox(
  //         width: 10,
  //       ),
  //       Text(titles, style: TextStyle(color: colors))
  //     ]),
  //   );
  // }

  renderContentSell(context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            for (ProductModel item in items) renderProduct(context, item)
          ],
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
              Image(
                image: AssetImage(productModel.url),
                height: 50,
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
                          Text(productModel.nameProduct,
                              style: const TextStyle(fontSize: 15)),
                          Text(
                            productModel.codeProduct,
                            style: TextStyle(color: logoGreen, fontSize: 15),
                          ),
                          Text(
                            "SL kho: ${productModel.quantityInStock}",
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
                            productModel.priceProduct.toString(),
                            style: TextStyle(color: logoGreen, fontSize: 15),
                          ),
                          Text(
                            productModel.weightProduct,
                            style: const TextStyle(
                                color: Colors.black54, fontSize: 14),
                          ),
                          const Text(
                            "HSD: 11/12/2024",
                            style: TextStyle(
                                fontSize: 12, fontStyle: FontStyle.italic),
                            textAlign: TextAlign.end,
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
