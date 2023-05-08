import 'package:fltn_app/model/lo_thuoc.dart';

class ProductModel {
  int? id;
  String? image;
  String? baoQuan;
  String? chongChiDinh;
  String? congDung;
  String? dangBaoChe;
  String? doiTuongSuDung;
  String? donViTinh;
  String? nhaSanXuat;
  String? hoatTinhThuoc;
  String? huongDanSuDung;
  String? lieuLuong;
  String? maThuoc;
  String? tacDungPhu;
  String? tenThuoc;
  String? thanhPhan;
  String? loaiThuoc;
  String? tinhTrangKhongNenSuDung;
  String? tuongTacThuoc;
  String? createdAt;
  String? createdBy;
  String? updatedAt;
  String? updatedBy;
  List<LoThuoc>? loThuoc;

  ProductModel({
    this.id,
    this.image,
    this.baoQuan,
    this.chongChiDinh,
    this.congDung,
    this.dangBaoChe,
    this.doiTuongSuDung,
    this.donViTinh,
    this.nhaSanXuat,
    this.hoatTinhThuoc,
    this.huongDanSuDung,
    this.lieuLuong,
    this.maThuoc,
    this.tacDungPhu,
    this.tenThuoc,
    this.thanhPhan,
    this.loaiThuoc,
    this.tinhTrangKhongNenSuDung,
    this.tuongTacThuoc,
    this.createdAt,
    this.createdBy,
    this.updatedAt,
    this.updatedBy,
    this.loThuoc,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      image: json['image'],
      baoQuan: json['baoQuan'],
      chongChiDinh: json['chongChiDinh'],
      congDung: json['congDung'],
      dangBaoChe: json['dangBaoChe'],
      doiTuongSuDung: json['doiTuongSuDung'],
      donViTinh: json['donViTinh'],
      nhaSanXuat: json['nhaSanXuat'],
      hoatTinhThuoc: json['hoatTinhThuoc'],
      huongDanSuDung: json['huongDanSuDung'],
      lieuLuong: json['lieuLuong'],
      maThuoc: json['maThuoc'],
      tacDungPhu: json['tacDungPhu'],
      tenThuoc: json['tenThuoc'],
      thanhPhan: json['thanhPhan'],
      loaiThuoc: json['loaiThuoc'],
      tinhTrangKhongNenSuDung: json['tinhTrangKhongNenSuDung'],
      tuongTacThuoc: json['tuongTacThuoc'],
      createdAt: json['createdAt'],
      createdBy: json['createdBy'],
      updatedAt: json['updatedAt'],
      updatedBy: json['updatedBy'],
      loThuoc: json['loThuoc'] != null
          ? List<LoThuoc>.from(json['loThuoc']
              .map((x) => LoThuoc.fromJson(x))) // Chuyển đổi list kho từ JSON
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['image'] = image;
    data['baoQuan'] = baoQuan;
    data['chongChiDinh'] = chongChiDinh;
    data['congDung'] = congDung;
    data['dangBaoChe'] = dangBaoChe;
    data['doiTuongSuDung'] = doiTuongSuDung;
    data['donViTinh'] = donViTinh;
    data['nhaSanXuat'] = nhaSanXuat;
    data['hoatTinhThuoc'] = hoatTinhThuoc;
    data['huongDanSuDung'] = huongDanSuDung;
    data['lieuLuong'] = lieuLuong;
    data['maThuoc'] = maThuoc;
    data['tacDungPhu'] = tacDungPhu;
    data['tenThuoc'] = tenThuoc;
    data['thanhPhan'] = thanhPhan;
    data['loaiThuoc'] = loaiThuoc;
    data['tinhTrangKhongNenSuDung'] = tinhTrangKhongNenSuDung;
    data['tuongTacThuoc'] = tuongTacThuoc;
    data['createdAt'] = createdAt;
    data['createdBy'] = createdBy;
    data['updatedAt'] = updatedAt;
    data['updatedBy'] = updatedBy;
    data['loThuoc'] = loThuoc!.map((e) => e.toJson()).toList();
    return data;
  }
}
