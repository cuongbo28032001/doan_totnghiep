import 'package:fltn_app/common/widgets/card_layout.dart';
import 'package:fltn_app/common/widgets/divider.dart';
import 'package:fltn_app/common/widgets/loading.dart';
import 'package:fltn_app/model/hoa_don/don_xuat/chi_tiet_don_xuat.dart';
import 'package:fltn_app/model/hoa_don/don_xuat/don_xuat.dart';
import 'package:flutter/material.dart';
import '../../api.dart';
import '../../consts/colorsTheme.dart';
import '../../model/hoa_don/don_nhap/chi_tiet_don_nhap.dart';
import '../../model/hoa_don/don_nhap/don_nhap.dart';

class ListBillScreen extends StatefulWidget {
  const ListBillScreen({super.key});

  @override
  State<ListBillScreen> createState() => _ListBillScreenState();
}

class _ListBillScreenState extends State<ListBillScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool loading = false;

  List<dynamic> listBillNhap = [];
  List<dynamic> listBillNhapAPI = [];
  List<dynamic> listBillXuat = [];
  List<dynamic> listBillXuatAPI = [];
  Map<String, dynamic> searchProduc = {};

  callApiListDonNhap() async {
    var search = {"pageNumber": 1, "pageSize": 100, "customize": searchProduc};
    try {
      var response = await httpPost('/api/donnhap/search', search, context);

      if (response.containsKey("body")) {
        var body = response["body"]["result"]['content'];
        print(body);
        if (response['body']['desc'].toString().compareTo('OK') == 0) {
          setState(() async {
            listBillNhapAPI = await body.map((e) {
              return DonNhap.fromJson(e);
            }).toList();

            for (DonNhap item in listBillNhapAPI) {
              if (item.tongTien! > 0) {
                listBillNhap.add(item);
              }
            }
          });
        }
      }
    } catch (e) {
      return listBillNhap;
    }
    return listBillNhap;
  }

  callApiListDonXuat() async {
    var search = {"pageNumber": 1, "pageSize": 100, "customize": searchProduc};
    try {
      var response = await httpPost('/api/don-xuat/search', search, context);

      if (response.containsKey("body")) {
        var body = response["body"]["result"]['content'];
        if (response['body']['desc'].toString().compareTo('OK') == 0) {
          setState(() {
            listBillXuatAPI = body.map((e) {
              return DonXuat.fromJson(e);
            }).toList();
          });
          for (DonXuat item in listBillXuatAPI) {
            if (item.chitietdonXuats!.isNotEmpty) {
              listBillXuat.add(item);
            }
          }
        }
      }
    } catch (e) {
      return listBillXuat;
    }
    return listBillXuat;
  }

  Future<void> callAllApi() async {
    await callApiListDonNhap();
    await callApiListDonXuat();
    if (listBillXuat.isNotEmpty) {
      loading = true;
    }
  }

  @override
  void initState() {
    callAllApi();
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: logoGreen,
          centerTitle: true,
          title: const Center(child: Text("Danh sách hóa đơn")),
        ),
        body: loading == true ? renderBodyListBill() : loadingCallAPi());
  }

  renderBodyListBill() {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 16.0, top: 10.0, right: 16.0),
          height: 45,
          decoration: BoxDecoration(
            color: logoGreen,
            borderRadius: BorderRadius.circular(
              5.0,
            ),
          ),
          child: TabBar(
            controller: _tabController,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(
                5.0,
              ),
              color: logoOrange,
            ),
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white,
            tabs: const [
              Tab(
                text: 'Hóa đơn nhập',
              ),
              Tab(
                text: 'Hóa đơn xuất',
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        // tab bar view here
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              renderListDonNhap(),
              renderListDonXuat(),
            ],
          ),
        ),
      ],
    );
  }

  renderListDonNhap() {
    return listBillNhap.isEmpty
        ? const Center(child: Text("Không có hóa đơn nhập"))
        : SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                for (DonNhap item in listBillNhap)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: CardLayoutWidget(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Mã hóa đơn",
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              Text(item.maDonNhap!)
                            ],
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                "Loại hóa đơn",
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              Text("Hóa đơn mua hàng")
                            ],
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Người tạo",
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              Text(item.nguoiNhap ?? '')
                            ],
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          for (ChiTietDonNhap items in item.chitietdonnhaps!)
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${items.loThuoc!.tenThuoc} - ${items.loThuoc!.soLo} x ${items.soLuong}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text('${items.giaNhap!.toString()} VND'),
                                  ],
                                ),
                                if (item.chitietdonnhaps!.indexOf(items) !=
                                    item.chitietdonnhaps!.length - 1)
                                  divider(context: context)
                              ],
                            ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Text(
                                "Tổng tiền:",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FontStyle.italic),
                              ),
                              const SizedBox(
                                width: 10.0,
                              ),
                              Text(
                                '${item.tongTien!.toString()} VND',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FontStyle.italic),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          );
  }

  renderListDonXuat() {
    return listBillXuat.isEmpty
        ? const Center(
            child: Text("Không có hóa đơn xuất"),
          )
        : SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                for (DonXuat item in listBillXuat)
                  if (item.chitietdonXuats!.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: CardLayoutWidget(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Mã hóa đơn",
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                                Text(item.maDonXuat!)
                              ],
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  "Loại hóa đơn",
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                                Text("Hóa đơn bán hàng")
                              ],
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Người tạo",
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                                Text(item.nguoiXuat ?? '')
                              ],
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            for (ChiTietDonXuat items in item.chitietdonXuats!)
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${items.loThuoc!.tenThuoc} - ${items.loThuoc!.soLo} x ${items.soLuong}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                          '${items.loThuoc!.giaBan.toString()} VND'),
                                    ],
                                  ),
                                  if (item.chitietdonXuats!.indexOf(items) !=
                                      item.chitietdonXuats!.length - 1)
                                    divider(context: context)
                                ],
                              ),
                            const SizedBox(
                              height: 16.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const Text(
                                  "Tổng tiền:",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FontStyle.italic),
                                ),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                Text(
                                  '${item.tongTien!.toString()} VND',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FontStyle.italic),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
              ],
            ),
          );
  }
}
