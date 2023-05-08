import 'chi_tiet_don_xuat.dart';

class DonXuat {
  int? id;
  String? maDonXuat;
  int? ngayXuat;
  String? nguoiXuat;
  int? tongTien;
  List<ChiTietDonXuat>? chitietdonXuats;

  DonXuat(
      {this.id,
      this.maDonXuat,
      this.ngayXuat,
      this.nguoiXuat,
      this.tongTien,
      this.chitietdonXuats});

  factory DonXuat.fromJson(Map<String, dynamic> json) {
    return DonXuat(
      id: json['id'],
      maDonXuat: json['maDonXuat'],
      ngayXuat: json['ngayXuat'],
      nguoiXuat: json['nguoiXuat'],
      tongTien: json['tongTien'].toInt(),
      chitietdonXuats: json['chitietdonxuats'] != null
          ? List<ChiTietDonXuat>.from(
              json['chitietdonxuats'].map((x) => ChiTietDonXuat.fromJson(x)))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['maDonXuat'] = maDonXuat;
    data['ngayXuat'] = ngayXuat;
    data['nguoiXuat'] = nguoiXuat;
    data['tongTien'] = tongTien;
    data['chitietdonxuats'] = chitietdonXuats!.map((e) => e.toJson()).toList();
    return data;
  }
}
