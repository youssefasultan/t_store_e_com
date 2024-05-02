// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class BrandModel {
  String id, name, image;
  bool? isFeatured;
  int? productsCount;
  BrandModel({
    required this.id,
    required this.image,
    required this.name,
    this.isFeatured,
    this.productsCount,
  });

  static BrandModel empty() => BrandModel(
      id: '', name: '', image: '', isFeatured: false, productsCount: 0);

  BrandModel copyWith({
    required String id,
    name,
    image,
    bool? isFeatured,
    int? productsCount,
  }) {
    return BrandModel(
      image: image ?? this.image,
      isFeatured: isFeatured ?? this.isFeatured,
      productsCount: productsCount ?? this.productsCount,
      id: id,
      name: name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Id': id,
      'Name': name,
      'Image': image,
      'IsFeatured': isFeatured,
      'ProductsCount': productsCount,
    };
  }

  factory BrandModel.fromMap(Map<String, dynamic> map) {
    return BrandModel(
      id: map['Id'] as String,
      name: map['Name'] as String,
      image: map['Image'] as String,
      isFeatured: map['IsFeatured'] != null ? map['IsFeatured'] as bool : null,
      productsCount:
          map['ProductsCount'] != null ? map['ProductsCount'] as int : null,
    );
  }

  factory BrandModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    if (snapshot.data() != null) {
      final json = snapshot.data()!;
      return BrandModel(
        id: snapshot.id,
        name: json['Name'] ?? '',
        image: json['Image'] ?? '',
        isFeatured: json['IsFeatured'] ?? false,
        productsCount: json['ProductsCount'] ?? 0,
      );
    }

    return BrandModel.empty();
  }

  String toJson() => json.encode(toMap());

  factory BrandModel.fromJson(String source) =>
      BrandModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'BrandModel(image: $image, isFeatured: $isFeatured, productsCount: $productsCount)';
}
