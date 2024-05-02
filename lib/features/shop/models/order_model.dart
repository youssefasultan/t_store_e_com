import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:t_store_e_com/features/personalization/models/address_model.dart';
import 'package:t_store_e_com/features/shop/models/cart_item_model.dart';
import 'package:t_store_e_com/utils/constants/enums.dart';
import 'package:t_store_e_com/utils/helpers/helper_functions.dart';

class OrderModel {
  final String id, userId, paymentMethod;
  final OrderStatus status;
  final double totalAmount;
  final DateTime orderDate;
  final AddressModel? address;
  final DateTime? deliveryDate;
  final List<CartItemModel> items;

  OrderModel({
    required this.id,
    this.userId = '',
    this.paymentMethod = 'paypal',
    required this.status,
    required this.totalAmount,
    required this.orderDate,
    this.address,
    this.deliveryDate,
    required this.items,
  });

  String get formattedOrderDate => THelperFunctions.getFormattedDate(orderDate);
  String get formattedDeliveryDate => deliveryDate != null
      ? THelperFunctions.getFormattedDate(deliveryDate!)
      : '';

  String get orderStatusText => status == OrderStatus.delivered
      ? 'Delivered'
      : status == OrderStatus.shipped
          ? 'Shipment on the way'
          : 'Pending';

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'UserId': userId,
      'PaymentMethod': paymentMethod,
      'Status': status.toString(),
      'TotalAmount': totalAmount,
      'OrderDate': orderDate.toIso8601String(),
      'Address': address?.toJson(),
      'DeliveryDate': deliveryDate,
      'Items': items.map((item) => item.toJson()).toList(),
    };
  }

  factory OrderModel.fromSnapshot(DocumentSnapshot data) {
    final doc = data.data() as Map<String, dynamic>;
    return OrderModel(
      id: doc['Id'] as String,
      userId: doc['UserId'] as String,
      paymentMethod: doc['PaymentMethod'] as String,
      status: OrderStatus.values
          .firstWhere((element) => element.toString() == doc['Status']),
      totalAmount: doc['TotalAmount'] as double,
      orderDate: DateTime.parse(doc['OrderDate']),
      address: AddressModel.fromJson(doc['Address'] as Map<String, dynamic>),
      deliveryDate: doc['DeliveryDate'] == null
          ? null
          : DateTime.parse(doc['DeliveryDate']),
      items: (doc['Items'] as List<dynamic>)
          .map((item) => CartItemModel.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}
