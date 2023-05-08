import 'package:fltn_app/model/lo_thuoc.dart';

class ChiTietDonNhap {
  int? id;
  int? giaNhap;
  int? giaBan;
  int? soLuong;
  int? hsd;
  int? nsx;
  int? donNhap;
  LoThuoc? loThuoc;

  ChiTietDonNhap(
      {this.id,
      this.giaNhap,
      this.giaBan,
      this.soLuong,
      this.hsd,
      this.nsx,
      this.donNhap,
      this.loThuoc});

  factory ChiTietDonNhap.fromJson(Map<String, dynamic> json) {
    return ChiTietDonNhap(
        id: json['id'],
        giaNhap: json['giaNhap'].toInt(),
        giaBan: json['giaBan'].toInt(),
        soLuong: json['soLuong'],
        hsd: json['hsd'],
        nsx: json['nsx'],
        donNhap: json['donNhap'],
        loThuoc: LoThuoc.fromJson(json['loThuoc']));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['giaNhap'] = giaNhap;
    data['giaBan'] = giaBan;
    data['soLuong'] = soLuong;
    data['hsd'] = hsd;
    data['nsx'] = nsx;
    data['donNhap'] = donNhap;
    data['loThuoc'] = loThuoc!.toJson();
    return data;
  }
}
