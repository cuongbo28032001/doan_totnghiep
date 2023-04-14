
import 'package:flutter/material.dart';
import '../../../common/no_oder/no_oder.dart';
import '../../../consts/colorsTheme.dart';

class EnterdrugsScreen extends StatefulWidget {
  const EnterdrugsScreen({super.key});

  @override
  State<EnterdrugsScreen> createState() => _EnterdrugsState();
}

class _EnterdrugsState extends State<EnterdrugsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: logoGreen,
        title: const Center(child: Text("Nhập thuốc")),
      ),
      body: const Center(
        child: SingleChildScrollView(
          child: Text("Chức năng đang được cập nhật"),
        ),
      ),
    );
  }
}
