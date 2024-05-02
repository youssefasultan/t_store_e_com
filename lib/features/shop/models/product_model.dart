// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:t_store_e_com/features/shop/models/brand_model.dart';

import 'product_attributes.dart';
import 'product_variations.dart';

class ProductModel {
  ProductModel({
    required this.id,
    required this.title,
    required this.stock,
    required this.price,
    required this.thumbnail,
    required this.productType,
    this.categoryId,
    this.salePrice = 0.0,
    this.date,
    this.isFeatured,
    this.images,
    this.brand,
    this.productAttributes,
    this.productVariations,
    this.sku,
    this.description,
  });

  String id, title, thumbnail, productType;
  String? sku, description, categoryId;
  double price, salePrice;
  int stock;
  DateTime? date;
  bool? isFeatured;
  List<String>? images;
  BrandModel? brand;
  List<ProductAttributeModel>? productAttributes;
  List<ProductVariationModel>? productVariations;

  toJson() {
    return {
      'Id': id,
      'Title': title,
      'Thumbnail': thumbnail,
      'ProductType': productType,
      'Price': price,
      'SalePrice': salePrice,
      'Stock': stock,
      'Date': date,
      'CategoryId': categoryId,
      'Description': description,
      'SKU': sku,
      'IsFeatured': isFeatured,
      'Images': images ?? [],
      'Brand': brand!.toJson(),
      'ProductAttributes': productAttributes != null
          ? productAttributes!.map((e) => e.toJson()).toList()
          : [],
      'ProductVariations': productVariations != null
          ? productVariations!.map((e) => e.toJson()).toList()
          : [],
    };
  }

  static ProductModel empty() {
    return ProductModel(
      id: '',
      title: '',
      thumbnail: '',
      productType: '',
      price: 0.0,
      salePrice: 0.0,
      stock: 0,
      date: DateTime.now(),
      categoryId: '',
      description: '',
      sku: '',
      isFeatured: false,
      images: [],
      brand: BrandModel.empty(),
      productAttributes: [],
      productVariations: [],
    );
  }

  factory ProductModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    if(doc.data() == null) return ProductModel.empty();


    final data = doc.data()!;
    return ProductModel(
      id: doc.id,
      title: data['Title'] ?? '',
      thumbnail: data['Thumbnail'] ?? '',
      productType: data['ProductType'] ?? '',
      price: double.parse((data['Price'] ?? 0.0).toString()),
      salePrice: double.parse((data['SalePrice'] ?? 0.0).toString()),
      stock: data['Stock'] ?? 0,
      date: data['Date'],
      categoryId: data['CategoryId'] ?? '',
      description: data['Description'] ?? '',
      sku: data['SKU'] ?? '',
      isFeatured: data['IsFeatured'] ?? false,
      brand: BrandModel.fromJson(data['Brand']),
      images: data['Images'] != null ? List<String>.from(data['Images']) : [],
      productAttributes: (data['ProductAttributes'] as List<dynamic>)
          .map((e) => ProductAttributeModel.fromJson(e))
          .toList(),
      productVariations: (data['ProductVariations'] as List<dynamic>)
          .map((e) => ProductVariationModel.fromJson(e))
          .toList(),
    );
  }

  factory ProductModel.fromQuerySnapshot(QueryDocumentSnapshot<Object?> doc) {
    final data = doc.data() as Map<String, dynamic>;

     return ProductModel(
      id: doc.id,
      title: data['Title'] ?? '',
      thumbnail: data['Thumbnail'] ?? '',
      productType: data['ProductType'] ?? '',
      price: double.parse((data['Price'] ?? 0.0).toString()),
      salePrice: double.parse((data['SalePrice'] ?? 0.0).toString()),
      stock: data['Stock'] ?? 0,
      date: data['Date'],
      categoryId: data['CategoryId'] ?? '',
      description: data['Description'] ?? '',
      sku: data['SKU'] ?? '',
      isFeatured: data['IsFeatured'] ?? false,
      brand: BrandModel.fromJson(data['Brand']),
      images: data['Images'] != null ? List<String>.from(data['Images']) : [],
      productAttributes: (data['ProductAttributes'] as List<dynamic>)
          .map((e) => ProductAttributeModel.fromJson(e))
          .toList(),
      productVariations: (data['ProductVariations'] as List<dynamic>)
          .map((e) => ProductVariationModel.fromJson(e))
          .toList(),
    );

  }
}
