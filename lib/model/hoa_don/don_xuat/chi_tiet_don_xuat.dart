import 'package:fltn_app/model/lo_thuoc.dart';

class ChiTietDonXuat {
  int? id;
  int? soLuong;
  int? donXuat;
  LoThuoc? loThuoc;

  ChiTietDonXuat({this.id, this.soLuong, this.donXuat, this.loThuoc});

  factory ChiTietDonXuat.fromJson(Map<String, dynamic> json) {
    return ChiTietDonXuat(
      id: json['id'],
      soLuong: json['soLuong'],
      donXuat: json['donXuat'],
      loThuoc: LoThuoc.fromJson(json['loThuoc']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['soLuong'] = soLuong;
    data['donXuat'] = donXuat;
    data['loThuoc'] = loThuoc!.toJson();
    return data;
  }
}
