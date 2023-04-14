import 'package:fltn_app/views/App.dart';
import 'package:flutter/material.dart';

class NoOder extends StatefulWidget {
  const NoOder({super.key});

  @override
  State<NoOder> createState() => _NoOderState();
}

class _NoOderState extends State<NoOder> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text("Không có sản phẩm"),
        InkWell(
          child: Text("Tạo hóa đơn mới"),
          onTap: () {
            globalAppContent.currentState?.selectSellTab();
          },
        )
      ]),
    );
  }
}
