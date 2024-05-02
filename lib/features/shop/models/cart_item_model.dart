import 'package:cloud_firestore/cloud_firestore.dart';

class CartItemModel {
  String productId, title, variationId;
  double price;
  int quantity;
  String? image, brandName;
  Map<String, dynamic>? selectedVariation;

  CartItemModel({
    this.variationId = '',
    this.price = 0.0,
    required this.quantity,
    this.brandName = '',
    this.image = '',
    this.selectedVariation,
    required this.productId,
    this.title = '',
  });

  static CartItemModel empty() => CartItemModel(quantity: 0, productId: '');

  Map<String, dynamic> toJson() {
    return {
      'ProductId': productId,
      'Title': title,
      'VariationId': variationId,
      'Price': price,
      'Image': image,
      'BrandName': brandName,
      'Quantity': quantity,
      'SelectedVariation': selectedVariation,
    };
  }

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      productId: json['ProductId'],
      title: json['Title'],
      variationId: json['VariationId'],
      price: json['Price'],
      image: json['Image'],
      brandName: json['BrandName'],
      quantity: json['Quantity'],
      selectedVariation: json['SelectedVariation'],
    );
  }

  factory CartItemModel.fromSnapshot(DocumentSnapshot doc) {
    final data = doc.data()! as Map<String, dynamic>;

    return CartItemModel(
      quantity: data['Quantity'] ?? '',
      productId: data['ProductId'] ?? 0,
      brandName: data['BrandName'] ?? '',
      price: data['Price'] ?? 0.0,
      selectedVariation: data['SelectedVariation'] ?? {},
      title: data['Title'] ?? '',
      variationId: data['VariationId'] ?? '',
    );
  }
}
