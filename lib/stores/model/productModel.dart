class ProductModel {
  int? id;
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

  ProductModel({
    this.id,
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
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
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
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
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
    return data;
  }
}










// class ProductModel {
//   final String url;
//   final String nameProduct;
//   final String codeProduct;
//   final int priceProduct;
//   final String weightProduct;
//   final int quantityInStock;
//   const ProductModel(
//       {required this.url,
//       required this.nameProduct,
//       required this.codeProduct,
//       required this.priceProduct,
//       required this.weightProduct,
//       required this.quantityInStock});

//   @override
//   String toString() {
//     return 'current list Product info: $url & $nameProduct & $codeProduct & $priceProduct & $weightProduct & $quantityInStock ';
//   }

//   Map toJson() => {
//         'url': url,
//         'nameProduct': nameProduct,
//         'codeProduct': codeProduct,
//         'priceProduct': priceProduct,
//         'weightProduct': weightProduct,
//         'quantityInStock': quantityInStock
//       };

//   static ProductModel fromJson(dynamic json) {
//     if (json == String) {
//       return const ProductModel(
//           url: 'assets/images/LogoApp.png',
//           nameProduct: '',
//           codeProduct: '',
//           priceProduct: 0,
//           weightProduct: '',
//           quantityInStock: 0);
//     }
//     return ProductModel(
//         url: json['url'] != String ? json['url'] as String : '',
//         nameProduct:
//             json['nameProduct'] != String ? json['nameProduct'] as String : '',
//         codeProduct:
//             json['codeProduct'] != String ? json['codeProduct'] as String : '',
//         priceProduct:
//             json['priceProduct'] != String ? json['priceProduct'] as int : 0,
//         weightProduct: json['weightProduct'] != String
//             ? json['weightProduct'] as String
//             : '',
//         quantityInStock: json['quantityInStock'] != String
//             ? json['quantityInStock'] as int
//             : 0);
//   }
// }

// List<ProductModel> items = [
//   const ProductModel(
//       url: 'assets/images/LogoApp.png',
//       nameProduct: 'Tylosin 98',
//       codeProduct: 'SP0001',
//       priceProduct: 2150000,
//       weightProduct: '100 g',
//       quantityInStock: 1),
//   const ProductModel(
//       url: 'assets/images/LogoApp.png',
//       nameProduct: 'Amoxycol 64',
//       codeProduct: 'SP0002',
//       priceProduct: 1150000,
//       weightProduct: '1 kg',
//       quantityInStock: 2),
//   const ProductModel(
//       url: 'assets/images/LogoApp.png',
//       nameProduct: 'IG one care',
//       codeProduct: 'SP0003',
//       priceProduct: 150000,
//       weightProduct: '1 lít',
//       quantityInStock: 0),
//   const ProductModel(
//       url: 'assets/images/LogoApp.png',
//       nameProduct: 'Para C',
//       codeProduct: 'SP0004',
//       priceProduct: 2550000,
//       weightProduct: '500 g',
//       quantityInStock: 0),
//   const ProductModel(
//       url: 'assets/images/LogoApp.png',
//       nameProduct: 'Paracetamol +C',
//       codeProduct: 'SP0005',
//       priceProduct: 1550000,
//       weightProduct: '1 kg',
//       quantityInStock: 0),
//   const ProductModel(
//       url: 'assets/images/LogoApp.png',
//       nameProduct: 'Melocam',
//       codeProduct: 'SP0006',
//       priceProduct: 350000,
//       weightProduct: '2 lít',
//       quantityInStock: 1),
//   const ProductModel(
//       url: 'assets/images/LogoApp.png',
//       nameProduct: 'Men cao tỏi',
//       codeProduct: 'SP0007',
//       priceProduct: 950000,
//       weightProduct: '4 kg',
//       quantityInStock: 1),
//   const ProductModel(
//       url: 'assets/images/LogoApp.png',
//       nameProduct: 'Tylosin 98',
//       codeProduct: 'SP0008',
//       priceProduct: 2150000,
//       weightProduct: '100 g',
//       quantityInStock: 1),
//   const ProductModel(
//       url: 'assets/images/LogoApp.png',
//       nameProduct: 'Tylosin 98',
//       codeProduct: 'SP0009',
//       priceProduct: 2150000,
//       weightProduct: '100 g',
//       quantityInStock: 1),
//   const ProductModel(
//       url: 'assets/images/LogoApp.png',
//       nameProduct: 'Tylosin 98',
//       codeProduct: 'SP0010',
//       priceProduct: 2150000,
//       weightProduct: '100 g',
//       quantityInStock: 1),
//   const ProductModel(
//       url: 'assets/images/LogoApp.png',
//       nameProduct: 'Tylosin 98',
//       codeProduct: 'SP0011',
//       priceProduct: 2150000,
//       weightProduct: '100 g',
//       quantityInStock: 1),
//   const ProductModel(
//       url: 'assets/images/LogoApp.png',
//       nameProduct: 'Tylosin 98',
//       codeProduct: 'SP0012',
//       priceProduct: 2150000,
//       weightProduct: '100 g',
//       quantityInStock: 1),
//   const ProductModel(
//       url: 'assets/images/LogoApp.png',
//       nameProduct: 'Tylosin 98',
//       codeProduct: 'SP0013',
//       priceProduct: 2150000,
//       weightProduct: '100 g',
//       quantityInStock: 1),
// ];
