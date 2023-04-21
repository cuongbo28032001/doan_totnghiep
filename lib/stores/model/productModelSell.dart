// import 'package:fltn_app/stores/model/productModel.dart';

// class ProductModelSell {
//   final ProductModel productModelSell;
//   late final int count;

//   const ProductModelSell({required this.productModelSell, required this.count});

//   Map toJson() => {'productModelSell': productModelSell, 'count': count};

//   static ProductModelSell fromJson(dynamic json) {
//     if (json == null) {
//       return const ProductModelSell(
//           productModelSell: ProductModel(
//               url: '',
//               codeProduct: '',
//               priceProduct: 0,
//               nameProduct: '',
//               quantityInStock: 0,
//               weightProduct: ''),
//           count: 0);
//     }
//     return ProductModelSell(
//       productModelSell: json['productModelSell'] != null
//           ? json['productModelSell'] as ProductModel
//           : const ProductModel(
//               url: 'url',
//               nameProduct: 'nameProduct',
//               codeProduct: 'codeProduct',
//               priceProduct: 0,
//               weightProduct: 'weightProduct',
//               quantityInStock: 0),
//       count: json['count'] != null ? json['count'] as int : 0,
//     );
//   }
// }
