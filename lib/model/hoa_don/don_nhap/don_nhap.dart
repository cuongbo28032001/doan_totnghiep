import 'chi_tiet_don_nhap.dart';

class DonNhap {
  int? id;
  String? maDonNhap;
  int? ngayNhap;
  String? nguoiNhap;
  int? tongTien;
  List<ChiTietDonNhap>? chitietdonnhaps;

  DonNhap(
      {this.id,
      this.maDonNhap,
      this.ngayNhap,
      this.nguoiNhap,
      this.tongTien,
      this.chitietdonnhaps});

  factory DonNhap.fromJson(Map<String, dynamic> json) {
    return DonNhap(
      id: json['id'],
      maDonNhap: json['maDonNhap'],
      ngayNhap: json['ngayNhap'],
      nguoiNhap: json['nguoiNhap'],
      tongTien: json['tongTien'].toInt(),
      chitietdonnhaps: json['chitietdonnhaps'] != null
          ? List<ChiTietDonNhap>.from(
              json['chitietdonnhaps'].map((x) => ChiTietDonNhap.fromJson(x)))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['maDonNhap'] = maDonNhap;
    data['ngayNhap'] = ngayNhap;
    data['nguoiNhap'] = nguoiNhap;
    data['tongTien'] = tongTien;
    data['chitietdonnhaps'] = chitietdonnhaps!.map((e) => e.toJson()).toList();
    return data;
  }
}
