// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PaymentMethodModel {
  String name;
  String img;
  PaymentMethodModel({
    required this.name,
    required this.img,
  });

  static PaymentMethodModel empty() => PaymentMethodModel(
        name: '',
        img: '',
      );

  PaymentMethodModel copyWith({
    String? name,
    String? img,
  }) {
    return PaymentMethodModel(
      name: name ?? this.name,
      img: img ?? this.img,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'img': img,
    };
  }

  factory PaymentMethodModel.fromMap(Map<String, dynamic> map) {
    return PaymentMethodModel(
      name: map['name'] as String,
      img: map['img'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentMethodModel.fromJson(String source) =>
      PaymentMethodModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'PaymentMethod(name: $name, img: $img)';

  @override
  bool operator ==(covariant PaymentMethodModel other) {
    if (identical(this, other)) return true;

    return other.name == name && other.img == img;
  }

  @override
  int get hashCode => name.hashCode ^ img.hashCode;
}
