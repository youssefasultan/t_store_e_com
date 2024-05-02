// ignore_for_file: public_member_api_docs, sort_constructors_first
class ProductAttributeModel {
  ProductAttributeModel({
    this.name,
    this.values,
  });

  String? name;
  final List<String>? values;

  toJson() {
    return {
      'Name': name,
      'Values': values,
    };
  }

  factory ProductAttributeModel.fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) return ProductAttributeModel();

    return ProductAttributeModel(
      name: json.containsKey('Name') ? json['Name'] : null,
      values:
          json.containsKey('Values') ? List<String>.from(json['Values']) : null,
    );
  }
}
