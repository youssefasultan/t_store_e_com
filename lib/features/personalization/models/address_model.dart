// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:t_store_e_com/utils/formatters/formatter.dart';

class AddressModel {
  final String phoneNumber, street, city, state, postalCode, country, name;
  final DateTime? dateTime;
  bool selectedAddress;
  String id;
  AddressModel({
    required this.name,
    required this.id,
    required this.phoneNumber,
    required this.street,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
    this.dateTime,
    this.selectedAddress = false,
  });

  String get formattedPhoneNo => TFormatter.formatPhoneNumber(phoneNumber);

  static AddressModel empty() => AddressModel(
        id: '',
        phoneNumber: '',
        street: '',
        city: '',
        state: '',
        postalCode: '',
        country: '',
        name: '',
      );

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Name': name,
      'PhoneNumber': phoneNumber,
      'Street': street,
      'City': city,
      'State': state,
      'PostalCode': postalCode,
      'Country': country,
      'Date': DateTime.now(),
      'SelectedAddress': selectedAddress,
    };
  }

  factory AddressModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

    return AddressModel(
      name: data['Name'] ?? '',
      id: data['Id'] ?? '',
      phoneNumber: data['PhoneNumber'] ?? '',
      street: data['Street'] ?? '',
      city: data['City'] ?? '',
      state: data['State'] ?? '',
      postalCode: data['PostalCode'] ?? '',
      country: data['Country'] ?? '',
      selectedAddress: data['SelectedAddress'] ?? false,
      dateTime: data['Date'] ?? DateTime.now(),
    );
  }


  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      name: json['Name'],
      id: json['Id'],
      phoneNumber: json['PhoneNumber'],
      street: json['Street'],
      city: json['City'],
      state: json['State'],
      postalCode: json['PostalCode'],
      country: json['Country'],
      selectedAddress: json['SelectedAddress'],
      dateTime: json['Date'],
    );
  }

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      name: map['Name'] ?? '',
      id: map['Id'] ?? '',
      phoneNumber: map['PhoneNumber'] ?? '',
      street: map['Street'] ?? '',
      city: map['City'] ?? '',
      state: map['State'] ?? '',
      postalCode: map['PostalCode'] ?? '',
      country: map['Country'] ?? '',
      selectedAddress: map['SelectedAddress'] ?? false,
      dateTime: map['Date'] ?? DateTime.now(),
    );
  }

  @override
  String toString() {
    return '$street, $city, $state, $postalCode, $country';
  }
}
