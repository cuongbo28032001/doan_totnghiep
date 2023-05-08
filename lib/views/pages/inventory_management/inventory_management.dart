import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import '../../../consts/colorsTheme.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class InventoryManagementScreen extends StatefulWidget {
  const InventoryManagementScreen({super.key});

  @override
  State<InventoryManagementScreen> createState() =>
      _InventoryManagementScreenState();
}

class _InventoryManagementScreenState extends State<InventoryManagementScreen> {
  final birdDayController = TextEditingController();
  int timestamp = 1672531200000;
  late DateTime dateTime;
  late DateFormat format = DateFormat("yyyy-MM-dd");

  String _birdDate = '';
  _onInputDate(text) {
    setState(() {
      _birdDate = text;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    var d12 = DateFormat('yyyy-MM-dd').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: logoGreen,
        title: const Center(
          child: Text("Quản lý kho"),
        ),
      ),
      body: const Center(
        child: SingleChildScrollView(
          child: Text("Chức năng đang được cập nhật"),
        ),
      ),
    );
  }
}
