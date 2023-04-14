import 'package:flutter/material.dart';
import '../../../consts/colorsTheme.dart';

class InventoryManagementScreen extends StatefulWidget {
  const InventoryManagementScreen({super.key});

  @override
  State<InventoryManagementScreen> createState() =>
      _InventoryManagementScreenState();
}

class _InventoryManagementScreenState extends State<InventoryManagementScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: logoGreen,
        title: const Center(child: Text("Quản lý kho")),
      ),
      body: const Center(
        child: SingleChildScrollView(
          child: Text("Chức năng đang được cập nhật"),
        ),
      ),
    );
  }
}
