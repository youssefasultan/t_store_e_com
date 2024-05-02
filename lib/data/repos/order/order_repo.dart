import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:t_store_e_com/data/repos/auth/auth_repo.dart';
import 'package:t_store_e_com/features/shop/models/order_model.dart';
import 'package:t_store_e_com/utils/exceptions/firebase_exceptions.dart';

import '../../../utils/exceptions/platform_exceptions.dart';

class OrderRepo extends GetxController {
  static OrderRepo get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<List<OrderModel>> fetchUserOrders() async {
    try {
      final userId = AuthRepo.instance.authUser!.uid;
      if (userId.isEmpty) throw 'unable to find user info.';

      final result =
          await _db.collection('Users').doc(userId).collection('Orders').get();

      return result.docs.map((e) => OrderModel.fromSnapshot(e)).toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. please try again';
    }
  }

  Future<void> saveOrder(OrderModel order, String userId) async {
    try {
      await _db
          .collection('Users')
          .doc(userId)
          .collection('Orders')
          .add(order.toJson());
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. please try again';
    }
  }
}
