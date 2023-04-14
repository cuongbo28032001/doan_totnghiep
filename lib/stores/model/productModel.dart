class ProductModel {
  final String url;
  final String nameProduct;
  final String codeProduct;
  final int priceProduct;
  final String weightProduct;
  final int quantityInStock;
  const ProductModel(
      {required this.url,
      required this.nameProduct,
      required this.codeProduct,
      required this.priceProduct,
      required this.weightProduct,
      required this.quantityInStock});

  @override
  String toString() {
    return 'current list Product info: $url & $nameProduct & $codeProduct & $priceProduct & $weightProduct & $quantityInStock ';
  }

  Map toJson() => {
        'url': url,
        'nameProduct': nameProduct,
        'codeProduct': codeProduct,
        'priceProduct': priceProduct,
        'weightProduct': weightProduct,
        'quantityInStock': quantityInStock
      };

  static ProductModel fromJson(dynamic json) {
    if (json == null) {
      return const ProductModel(
          url: 'assets/images/LogoApp.png',
          nameProduct: '',
          codeProduct: '',
          priceProduct: 0,
          weightProduct: '',
          quantityInStock: 0);
    }
    return ProductModel(
        url: json['url'] != null ? json['url'] as String : '',
        nameProduct:
            json['nameProduct'] != null ? json['nameProduct'] as String : '',
        codeProduct:
            json['codeProduct'] != null ? json['codeProduct'] as String : '',
        priceProduct:
            json['priceProduct'] != null ? json['priceProduct'] as int : 0,
        weightProduct: json['weightProduct'] != null
            ? json['weightProduct'] as String
            : '',
        quantityInStock: json['quantityInStock'] != null
            ? json['quantityInStock'] as int
            : 0);
  }
}

List<ProductModel> items = [
  const ProductModel(
      url: 'assets/images/LogoApp.png',
      nameProduct: 'Tylosin 98',
      codeProduct: 'SP0001',
      priceProduct: 2150000,
      weightProduct: '100 g',
      quantityInStock: 1),
  const ProductModel(
      url: 'assets/images/LogoApp.png',
      nameProduct: 'Amoxycol 64',
      codeProduct: 'SP0002',
      priceProduct: 1150000,
      weightProduct: '1 kg',
      quantityInStock: 2),
  const ProductModel(
      url: 'assets/images/LogoApp.png',
      nameProduct: 'IG one care',
      codeProduct: 'SP0003',
      priceProduct: 150000,
      weightProduct: '1 lít',
      quantityInStock: 0),
  const ProductModel(
      url: 'assets/images/LogoApp.png',
      nameProduct: 'Para C',
      codeProduct: 'SP0004',
      priceProduct: 2550000,
      weightProduct: '500 g',
      quantityInStock: 0),
  const ProductModel(
      url: 'assets/images/LogoApp.png',
      nameProduct: 'Paracetamol +C',
      codeProduct: 'SP0005',
      priceProduct: 1550000,
      weightProduct: '1 kg',
      quantityInStock: 0),
  const ProductModel(
      url: 'assets/images/LogoApp.png',
      nameProduct: 'Melocam',
      codeProduct: 'SP0006',
      priceProduct: 350000,
      weightProduct: '2 lít',
      quantityInStock: 1),
  const ProductModel(
      url: 'assets/images/LogoApp.png',
      nameProduct: 'Men cao tỏi',
      codeProduct: 'SP0007',
      priceProduct: 950000,
      weightProduct: '4 kg',
      quantityInStock: 1),
  const ProductModel(
      url: 'assets/images/LogoApp.png',
      nameProduct: 'Tylosin 98',
      codeProduct: 'SP0008',
      priceProduct: 2150000,
      weightProduct: '100 g',
      quantityInStock: 1),
  const ProductModel(
      url: 'assets/images/LogoApp.png',
      nameProduct: 'Tylosin 98',
      codeProduct: 'SP0009',
      priceProduct: 2150000,
      weightProduct: '100 g',
      quantityInStock: 1),
  const ProductModel(
      url: 'assets/images/LogoApp.png',
      nameProduct: 'Tylosin 98',
      codeProduct: 'SP0010',
      priceProduct: 2150000,
      weightProduct: '100 g',
      quantityInStock: 1),
  const ProductModel(
      url: 'assets/images/LogoApp.png',
      nameProduct: 'Tylosin 98',
      codeProduct: 'SP0011',
      priceProduct: 2150000,
      weightProduct: '100 g',
      quantityInStock: 1),
  const ProductModel(
      url: 'assets/images/LogoApp.png',
      nameProduct: 'Tylosin 98',
      codeProduct: 'SP0012',
      priceProduct: 2150000,
      weightProduct: '100 g',
      quantityInStock: 1),
  const ProductModel(
      url: 'assets/images/LogoApp.png',
      nameProduct: 'Tylosin 98',
      codeProduct: 'SP0013',
      priceProduct: 2150000,
      weightProduct: '100 g',
      quantityInStock: 1),
];
