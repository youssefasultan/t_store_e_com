import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
    required this.isFeatured,
    this.parentId = '',
  });

  String id, name, image, parentId;
  bool isFeatured;

  // empty helper functon
  static CategoryModel empty() =>
      CategoryModel(id: '', name: '', image: '', isFeatured: false);

  /// convert model to json
  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'Image': image,
      'IsFeatured': isFeatured,
      'ParentId': parentId
    };
  }

  // map json to model
  factory CategoryModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final json = document.data()!;
      return CategoryModel(
        id: document.id,
        name: json['name'] ?? '',
        image: json['image'] ?? '',
        isFeatured: json['isFeatured'] ?? false,
        parentId: json['parentId'] ?? '',
      );
    }

    return CategoryModel.empty();
  }
}
