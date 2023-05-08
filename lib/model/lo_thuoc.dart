class LoThuoc {
  int? giaNhap;
  int? giaBan;
  String? soLo;
  int? soLuong;
  int? hsd;
  int? nsx;
  int? id;
  String? tenThuoc;

  LoThuoc(
      {this.giaNhap,
      this.giaBan,
      this.soLo,
      this.soLuong,
      this.hsd,
      this.nsx,
      this.tenThuoc,
      this.id});

  @override
  String toString() {
    // TODO: implement toString
    return 'LoThuoc: $id &  & $tenThuoc & $soLo & $soLuong & $giaBan & $hsd & $giaNhap & $nsx';
  }

  LoThuoc.fromJson(Map<String, dynamic> json) {
    giaNhap = json['giaNhap'].toInt();
    giaBan = json['giaBan'].toInt();
    soLo = json['soLo'];
    soLuong = json['soLuong'];
    hsd = json['hsd'];
    nsx = json['nsx'];
    id = json['id'];
    tenThuoc = json['tenThuoc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['giaNhap'] = giaNhap;
    data['giaBan'] = giaBan;
    data['soLo'] = soLo;
    data['soLuong'] = soLuong;
    data['nsx'] = nsx;
    data['hsd'] = hsd;
    data['id'] = id;
    data['tenThuoc'] = tenThuoc;
    return data;
  }
}
