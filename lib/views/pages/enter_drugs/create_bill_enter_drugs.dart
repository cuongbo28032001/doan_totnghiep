import 'package:fltn_app/common/date_form_field.dart';
import 'package:fltn_app/common/widgets/card_layout.dart';
import 'package:fltn_app/common/widgets/input_layout.dart';
import 'package:fltn_app/common/widgets/showToast.dart';
import 'package:fltn_app/model/lo_thuoc.dart';
import 'package:fltn_app/model/user.dart';
import 'package:fltn_app/views/App.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../api.dart';
import '../../../consts/colorsTheme.dart';
import '../../../model/securityModel.dart';

// ignore: unused_import, depend_on_referenced_packages
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class CreatBillEnterDrugs extends StatefulWidget {
  List<dynamic> productSelect;
  CreatBillEnterDrugs({super.key, required this.productSelect});

  @override
  State<CreatBillEnterDrugs> createState() => _CreatBillEnterDrugsState();
}

class _CreatBillEnterDrugsState extends State<CreatBillEnterDrugs> {
  late TextEditingController searchController;
  late TextEditingController controllerLotNumber;
  late TextEditingController controllerNumber;
  late TextEditingController controllerDate;
  late TextEditingController controllerGiaNhap;
  late TextEditingController controllerGiaBan;
  String controllerGiaNhapValue = '';
  String controllerGiaBanValue = '';

  String? error;
  int? idHoaDon;
  int? idLo;
  List<dynamic> listProduct = [];
  List<dynamic> listPost = [];
  List<dynamic> list = [];
  bool loading = false;

  Future<void> processing() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  callApiDonNhap(object) async {
    try {
      var response = await httpPost('/api/donnhap/create', object, context);
      if (response.containsKey("body")) {
        var body = response["body"];
        setState(() {
          error = body["desc"];
        });
        if (error!.compareTo("THÊM MỚI THÀNH CÔNG") == 0) {
          setState(() {
            idHoaDon = body['result'];
          });
        }
      }
    } catch (e) {
      return e;
    }
  }

  callApiChiTietDonNhap(List<dynamic> list) async {
    try {
      var response =
          await httpPost('/api/chi-tiet-don-nhap/create', list, context);
      if (response.containsKey("body")) {
        var body = response["body"];
        setState(() {
          error = body["desc"];
        });
      }
      if (error!.compareTo('THÊM MỚI THÀNH CÔNG') == 0) {
        toast(error!);
        Future.delayed(const Duration(seconds: 2), () {
          globalAppContent.currentState!.selectSellTab();
        });
      } else {
        toast(error!);
      }
    } catch (e) {
      return e;
    }
  }

  String convertToDate(int value) {
    DateTime dateTime;
    dateTime = DateTime.fromMillisecondsSinceEpoch(value);
    var date = DateFormat('yyyy-MM-dd').format(dateTime);
    return date;
  }

  @override
  void initState() {
    super.initState();
    controllerLotNumber = TextEditingController();
    controllerNumber = TextEditingController();
    controllerDate = TextEditingController();
    searchController = TextEditingController();
    controllerGiaNhap = TextEditingController();
    controllerGiaBan = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchController.dispose();
    controllerLotNumber.dispose();
    controllerNumber.dispose();
    controllerDate.dispose();
    controllerGiaNhap.dispose();
    controllerGiaBan.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: logoGreen,
          centerTitle: true,
          title: const Text("Tạo đơn nhập"),
        ),
        body: SingleChildScrollView(
          child: renderBill(),
        ));
  }

  renderBill() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
          child: CardLayoutWidget(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Người tạo:",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text(User().userName!),
                  ],
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Thời gian:",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text(DateFormat("yyyy-MM-dd").format(DateTime.now())),
                  ],
                ),
                const SizedBox(
                  height: 16.0,
                ),
                const Text(
                  'Danh sách thuốc',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                for (LoThuoc items in widget.productSelect)
                  renderProductSelected(context, items),
                const SizedBox(
                  height: 32.0,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 32.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: InkWell(
            onTap: () async {
              var securityModel =
                  Provider.of<SecurityModel>(context, listen: false);
              await callApiDonNhap({
                "nguoiNhap": User().userName,
                "ngayNhap": DateFormat("yyyy-MM-dd").format(DateTime.now())
              });
              if (idHoaDon != null) {
                for (LoThuoc items in widget.productSelect) {
                  var data = {
                    "donNhap": idHoaDon,
                    "loThuoc": items.id,
                    "soLuong": items.soLuong,
                    "giaNhap": items.giaNhap,
                    "giaBan": items.giaBan,
                    "hsd": convertToDate(items.hsd!),
                  };

                  bool isExist =
                      false; // Biến để kiểm tra sự tồn tại của data trong listPost
                  for (var post in listPost) {
                    if (post['loThuoc'] == data['loThuoc']) {
                      // So sánh thuộc tính 'thuoc' của post với 'thuoc' của data
                      isExist = true; // Nếu tồn tại thì gán isExist = true
                      break; // Thoát khỏi vòng lặp khi tìm thấy
                    }
                  }
                  if (!isExist) {
                    // Kiểm tra isExist để thêm data vào listPost
                    listPost.add(data);
                  }
                }
              } else {
                toast(error!);
              }
              await callApiChiTietDonNhap(listPost);
            },
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(5.0),
                  ),
                  color: logoOrange),
              child: const Text(
                "Tiếp tục",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        )
      ],
    );
  }

  renderProductSelected(context, LoThuoc productModel) {
    TextEditingController soloController =
        TextEditingController(text: productModel.soLo);
    setState(() {
      controllerLotNumber = soloController;
    });
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10.0,
          ),
          Text(
            productModel.tenThuoc ?? '',
            style: TextStyle(color: logoGreen, fontWeight: FontWeight.w600),
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: InputFormWidget(
                  controller: controllerLotNumber,
                  label: 'Số lô',
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
              Expanded(
                flex: 1,
                child: InputFormWidget(
                  controller: TextEditingController(
                      text: productModel.soLuong != null
                          ? productModel.soLuong.toString()
                          : ''),
                  label: 'Số lượng',
                  callback: (value) {
                    productModel.soLuong = int.parse(value);
                  },
                ),
              )
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                flex: 1,
                child: InputFormWidget(
                  controller: TextEditingController(
                      text: productModel.giaNhap != null
                          ? productModel.giaNhap.toString()
                          : ''),
                  label: 'Giá nhập',
                  suffix: 'VND',
                  callback: (value) {
                    productModel.giaNhap = int.parse(value);
                  },
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
              Expanded(
                flex: 1,
                child: InputFormWidget(
                  controller: TextEditingController(
                      text: productModel.giaBan != null
                          ? productModel.giaBan.toString()
                          : ''),
                  label: 'Giá bán',
                  suffix: 'VND',
                  callback: (value) {
                    productModel.giaBan = int.parse(value);
                  },
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: renderDate(
                    controller: TextEditingController(
                        text: productModel.hsd != null
                            ? convertToDate(productModel.hsd!)
                            : ''),
                    label: 'Hạn sử dụng',
                    onChanged: (value) {
                      DateTime dateTime = DateTime.parse(value);
                      int timestamp = dateTime.millisecondsSinceEpoch;
                      productModel.hsd = timestamp;
                    }),
              ),
              const SizedBox(
                width: 10.0,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    widget.productSelect.remove(productModel);
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 4.0),
                  decoration: BoxDecoration(
                      color: logoOrange,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(4.0))),
                  child: const Text(
                    "Xóa",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
