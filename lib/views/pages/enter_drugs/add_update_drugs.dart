import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:fltn_app/common/widgets/card_layout.dart';
import 'package:fltn_app/common/widgets/input_layout.dart';
import 'package:fltn_app/views/pages/Sell/sell.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as dev;
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../../api.dart';
import '../../../common/widgets/showToast.dart';
import '../../../consts/colorsTheme.dart';
import '../../../model/productModel.dart';
import '../../../model/securityModel.dart';
import '../../../url.dart';
import '../../App.dart';
import 'dart:developer' as dev;

// ignore: must_be_immutable
class AddUpdateInfoDrugsSCreen extends StatefulWidget {
  ProductModel? productModel;
  String title;
  AddUpdateInfoDrugsSCreen({super.key, this.productModel, required this.title});

  @override
  State<AddUpdateInfoDrugsSCreen> createState() =>
      _AddUpdateInfoDrugsSCreenState();
}

class _AddUpdateInfoDrugsSCreenState extends State<AddUpdateInfoDrugsSCreen> {
  final formKey = GlobalKey<FormState>();
  String idImage = '';
  dynamic _image;
  String error = '';
  late int resultID = 0;

  TextEditingController controllerMaThuoc = TextEditingController();
  TextEditingController controllerTenThuoc = TextEditingController();
  TextEditingController controllerDangBaoChe = TextEditingController();
  TextEditingController controllerNhaSanXuat = TextEditingController();
  TextEditingController controllerThanhPhan = TextEditingController();
  TextEditingController controllerChiDinh = TextEditingController();
  TextEditingController controllerLieuDung = TextEditingController();
  TextEditingController controllerChongChiDinh = TextEditingController();
  TextEditingController controllerCachBaoQuan = TextEditingController();
  TextEditingController controllerDonViTinh = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    if (widget.productModel != null) {
      controllerMaThuoc.text = widget.productModel!.maThuoc ?? '';
      controllerTenThuoc.text = widget.productModel!.tenThuoc ?? '';
      controllerDangBaoChe.text = widget.productModel!.dangBaoChe ?? '';
      controllerNhaSanXuat.text = widget.productModel!.nhaSanXuat ?? '';
      controllerThanhPhan.text = widget.productModel!.thanhPhan ?? '';
      controllerChiDinh.text = widget.productModel!.huongDanSuDung ?? '';
      controllerLieuDung.text = widget.productModel!.lieuLuong ?? '';
      controllerChongChiDinh.text = widget.productModel!.chongChiDinh ?? '';
      controllerCachBaoQuan.text = widget.productModel!.baoQuan ?? '';
      controllerDonViTinh.text = widget.productModel!.donViTinh ?? '';
    }
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controllerMaThuoc.dispose();
    controllerTenThuoc.dispose();
    // controllerLoaiThuoc.dispose();
    controllerDangBaoChe.dispose();
    controllerNhaSanXuat.dispose();
    controllerThanhPhan.dispose();
    controllerChiDinh.dispose();
    controllerLieuDung.dispose();
    controllerChongChiDinh.dispose();
    controllerCachBaoQuan.dispose();
    controllerDonViTinh.dispose();
  }

  Future<ImageSource?> showImageSource(BuildContext context) async {
    if (Platform.isIOS) {
      return showCupertinoModalPopup<ImageSource>(
          context: context,
          builder: (context) => CupertinoActionSheet(
                actions: [
                  CupertinoActionSheetAction(
                      onPressed: () =>
                          Navigator.of(context).pop(ImageSource.camera),
                      child: const Text('Máy ảnh')),
                  CupertinoActionSheetAction(
                      onPressed: () =>
                          Navigator.of(context).pop(ImageSource.gallery),
                      child: const Text('Thư viện'))
                ],
              ));
    } else {
      return showModalBottomSheet(
          context: context,
          builder: (context) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                      leading: const Icon(Icons.camera_alt),
                      title: const Text('Máy ảnh'),
                      onTap: () async {
                        Navigator.of(context).pop(ImageSource.camera);
                      }),
                  ListTile(
                      leading: const Icon(Icons.photo_library),
                      title: const Text('Thư viện'),
                      onTap: () async {
                        Navigator.of(context).pop(ImageSource.gallery);
                      }),
                ],
              ));
    }
  }

  uploadFile(file, {context}) async {
    var securityModel = Provider.of<SecurityModel>(context, listen: false);
    if (file != null) {
      if (file!.lengthSync() / (1024 * 1024) > 30) {
        toast(
          'File tải lên dung lượng không được quá lớn',
        );
      } else {
        final request = http.MultipartRequest(
          "POST",
          Uri.parse("$baseUrl/api/thuoc/upload"),
        );

        //-----add selected file with request
        request.files.add(http.MultipartFile(
            "file", file!.readAsBytes().asStream(), file.lengthSync(),
            filename: dev.basename(file.path)));
        // Add product_id to form data
        (widget.title.compareTo("Chỉnh sửa") == 0)
            ? request.fields['id'] = widget.productModel!.id.toString()
            : request.fields['id'] = resultID.toString();

        request.headers['Authorization'] =
            'Bearer ${securityModel.authorization!}';
        //-------Send request
        var resp = await request.send();

        //------Read response
        String result = await resp.stream.bytesToString();
        var body = json.decode(result);
        if (body.containsKey("1")) {
          return body['1'];
        }
        return "Chưa có báo cáo, nhấn vào để tải lên.";
      }
    } else {
      return null;
    }
  }

  addProduct(object) async {
    //  var search = {"pageNumber": 1, "pageSize": 5, "customize": searchProduc};
    try {
      var response = await httpPost('/api/thuoc/create', object, context);

      if (response.containsKey("body")) {
        var body = response["body"];
        setState(() {
          error = body["desc"];
          if (error.compareTo('THÊM MỚI THÀNH CÔNG') == 0) {
            resultID = body['result']['id'];
          }
        });
      }
    } catch (e) {
      dev.log('create: $e');
    }
  }

  updateProduct(object) async {
    try {
      var response = await httpPut('/api/thuoc/update', object, context);
      if (response.containsKey("body")) {
        var body = response["body"];
        setState(() {
          error = body["desc"];
        });
      }
    } catch (e) {
      dev.log('udate: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: logoGreen,
          centerTitle: true,
          title: Text(widget.title),
        ),
        body: renderBodyAddDrugs(context));
  }

  renderBodyAddDrugs(context) {
    return Padding(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom * 0.5),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        child: Column(
          children: [
            CardLayoutWidget(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InputFormWidget(
                      label: 'Mã thuốc',
                      controller: controllerMaThuoc,
                      note: true,
                      valid: (value) {
                        if (value.toString().isEmpty) {
                          return "Mã thuốc không được để trống";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    InputFormWidget(
                      controller: controllerTenThuoc,
                      label: 'Tên thuốc',
                      note: true,
                      valid: (value) {
                        if (value.toString().isEmpty) {
                          return "Tên thuốc không được để trống";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    InputFormWidget(
                      controller: controllerDangBaoChe,
                      label: 'Dạng bào chế',
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    InputFormWidget(
                      controller: controllerDonViTinh,
                      label: 'Đơn vị tính',
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    InputFormWidget(
                      controller: controllerNhaSanXuat,
                      label: 'Nhà sản xuất',
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    const Text(
                      "Thành phần",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    InputFormWidget(
                      controller: controllerThanhPhan,
                      maxLines: 4,
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    const Text(
                      "Chỉ định",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    InputFormWidget(
                      controller: controllerChiDinh,
                      maxLines: 4,
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    const Text(
                      "Liều dùng và cách sử dụng",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    InputFormWidget(
                      controller: controllerLieuDung,
                      maxLines: 4,
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    const Text(
                      "Chống chỉ định",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    InputFormWidget(
                      controller: controllerChongChiDinh,
                      maxLines: 4,
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    const Text(
                      "Cách bảo quản",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    InputFormWidget(
                      controller: controllerCachBaoQuan,
                      maxLines: 4,
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    _renderImageCard()
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 32.0,
            ),
            if (widget.title.compareTo('Nhập thuốc') == 0)
              InkWell(
                onTap: () async {
                  var data = {
                    "maThuoc": controllerMaThuoc.text,
                    "tenThuoc": controllerTenThuoc.text,
                    "dangBaoChe": controllerDangBaoChe.text,
                    "donViTinh": controllerDonViTinh.text,
                    "nhaSanXuat": controllerNhaSanXuat.text,
                    "thanhPhan": controllerThanhPhan.text,
                    "huongDanSuDung": controllerChiDinh.text,
                    "chongChiDinh": controllerChongChiDinh.text,
                    "lieuLuong": controllerLieuDung.text,
                    "baoQuan": controllerCachBaoQuan.text
                  };

                  if (formKey.currentState!.validate()) {
                    await addProduct(data);
                    if (error.compareTo('THÊM MỚI THÀNH CÔNG') == 0) {
                      // ignore: use_build_context_synchronously
                      if (_image != null) {
                        await uploadFile(_image, context: context);
                      }

                      globalAppContent.currentState?.selectSellTab();
                    }

                    toast(error);
                  } else {
                    toast('Nhập lại');
                  }
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
            if (widget.title.compareTo('Chỉnh sửa') == 0)
              InkWell(
                onTap: () async {
                  var data = {
                    "id": widget.productModel?.id,
                    'image': widget.productModel?.image,
                    "maThuoc": controllerMaThuoc.text,
                    "tenThuoc": controllerTenThuoc.text,
                    "dangBaoChe": controllerDangBaoChe.text,
                    "donViTinh": controllerDonViTinh.text,
                    "nhaSanXuat": controllerNhaSanXuat.text,
                    "thanhPhan": controllerThanhPhan.text,
                    "huongDanSuDung": controllerChiDinh.text,
                    "chongChiDinh": controllerChongChiDinh.text,
                    "lieuLuong": controllerLieuDung.text,
                    "baoQuan": controllerCachBaoQuan.text
                  };

                  if (formKey.currentState!.validate()) {
                    await updateProduct(data);
                    if (error.compareTo('CẬP NHẬT THÀNH CÔNG') == 0) {
                      // ignore: use_build_context_synchronously
                      print(widget.productModel!.id);
                      if (_image != null) {
                        await uploadFile(_image, context: context);
                      }
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SellScreen()));
                    }

                    toast(error);
                  } else {
                    toast('Nhập lại');
                  }
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
                    "Cập nhật",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  _imageSelect(imageTemp, imageCard) {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        border: Border.all(color: logoGreen, width: 1),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        image: widget.productModel?.image == null
            ? (imageTemp != null && imageTemp != "")
                ? DecorationImage(
                    image: FileImage(imageTemp),
                  )
                : const DecorationImage(
                    image: AssetImage('assets/images/LogoApp.png'),
                  )
            : (imageTemp != null && imageTemp != "")
                ? DecorationImage(
                    image: FileImage(imageTemp),
                  )
                : DecorationImage(
                    image: NetworkImage(
                        '$baseUrl/api/thuoc/image/${widget.productModel!.id}?timestamp=${Random().nextInt(10000)}'),
                  ),
      ),
    );
  }

  _renderImageCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          InkWell(
            onTap: () async {
              final source = await showImageSource(context);
              final imageTemp = await ImagePicker().pickImage(source: source!);
              setState(() {
                _image = File(imageTemp!.path);
              });
            },
            child: Ink(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Hình ảnh",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 10,
                ),
                _imageSelect(_image, idImage),
              ],
            )),
          ),
        ],
      ),
    );
  }
}
