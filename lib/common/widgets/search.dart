import 'package:fltn_app/common/widgets/showToast.dart';
import 'package:fltn_app/views/pages/sell/create_bill.dart';
import 'package:flutter/material.dart';

inPutSearch(
    {BuildContext? context,
    String? lable,
    IconData? addIcon,
    IconData? filterIcon}) {
  return Container(
    color: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 10.0),
    child: Row(children: [
      Expanded(
          child: TextFormField(
        decoration: InputDecoration(
            hintText: lable,
            icon: const Icon(
              Icons.search,
              color: Colors.black45,
              size: 25,
            ),
            border: InputBorder.none),
      )),
      const SizedBox(
        width: 10,
      ),
      if (addIcon != null)
        IconButton(
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          onPressed: () {
            toast("Tạo đơn hàng");
            Navigator.push(
              context!,
              MaterialPageRoute(
                builder: (context) => const CreateBillSellScreen(),
              ),
            );
          },
          icon: Icon(addIcon, color: Colors.black45),
        ),
      const SizedBox(
        width: 10,
      ),
      IconButton(
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
        onPressed: () {
          toast("Bộ lọc");
        },
        icon: Icon(filterIcon, color: Colors.black45),
      ),
    ]),
  );
}
