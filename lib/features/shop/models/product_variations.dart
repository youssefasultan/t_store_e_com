// ignore_for_file: public_member_api_docs, sort_constructors_first
class ProductVariationModel {
  final String id;
  String sku, image;
  String? description;
  double price;
  double salePrice;
  int stock;
  Map<String, dynamic> attibutesValues;

  ProductVariationModel({
    required this.id,
    this.image = '',
    this.description = '',
    this.sku = '',
    this.price = 0.0,
    this.salePrice = 0.0,
    this.stock = 0,
    required this.attibutesValues,
  });

  toJson() {
    return {
      'Id': id,
      'Image': image,
      'Description': description,
      'SKU': sku,
      'Price': price,
      'SalePrice': salePrice,
      'Stock': stock,
      'AttibutesValues': attibutesValues,
    };
  }

  static ProductVariationModel empty() {
    return ProductVariationModel(
      id: '',
      image: '',
      description: '',
      sku: '',
      price: 0.0,
      salePrice: 0.0,
      stock: 0,
      attibutesValues: {},
    );
  }

  factory ProductVariationModel.fromJson(Map<String, dynamic> snapshot) {
    if (snapshot.isEmpty) return ProductVariationModel.empty();

    return ProductVariationModel(
      id: snapshot['Id'] ?? '',
      image: snapshot['Image'] ?? '',
      description: snapshot['Description'],
      sku: snapshot['SKU'] ?? '',
      price: double.parse((snapshot['Price'] ?? 0.0).toString()),
      salePrice: double.parse((snapshot['SalePrice'] ?? 0.0).toString()),
      stock: snapshot['Stock'] ?? 0,
      attibutesValues: Map<String, String>.from(snapshot['AttibutesValues']),
    );
  }
}
