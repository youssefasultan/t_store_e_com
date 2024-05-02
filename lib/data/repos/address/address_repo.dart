import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:t_store_e_com/data/repos/auth/auth_repo.dart';
import 'package:t_store_e_com/features/personalization/models/address_model.dart';

class AddressRepo extends GetxController {
  static AddressRepo get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<List<AddressModel>> fetchUserAddress() async {
    try {
      final userId = AuthRepo.instance.authUser!.uid;
      if (userId.isEmpty) {
        throw 'Unable to find user information. try again in few minutes';
      }

      final result = await _db
          .collection('Users')
          .doc(userId)
          .collection('Addresses')
          .get();

      return result.docs.map((e) => AddressModel.fromSnapshot(e)).toList();
    } catch (e) {
      throw 'Unable to find user information. try again in few minutes';
    }
  }

  Future<void> updateSelectedFeild(String addressId, bool selected) async {
    try {
      final userId = AuthRepo.instance.authUser!.uid;

      await _db
          .collection('Users')
          .doc(userId)
          .collection('Addresses')
          .doc(addressId)
          .update({'SelectedAddress': selected});
    } catch (e) {
      throw 'Unable to update selected address. try again in few minutes';
    }
  }

  Future<String> addAddress(AddressModel address) async {
    try {
      final userId = AuthRepo.instance.authUser!.uid;
      final currentAddress = await _db
          .collection('Users')
          .doc(userId)
          .collection('Addresses')
          .add(address.toJson());
      return currentAddress.id;
    } catch (e) {
      throw 'Something went wrong while saving address. try again in few minutes';
    }
  }
}
