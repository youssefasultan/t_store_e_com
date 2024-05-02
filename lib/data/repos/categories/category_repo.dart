import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:t_store_e_com/data/services/cloud_storage/firebase_storage_service.dart';
import 'package:t_store_e_com/features/shop/models/category_model.dart';
import 'package:t_store_e_com/utils/exceptions/firebase_exceptions.dart';
import 'package:t_store_e_com/utils/exceptions/platform_exceptions.dart';

class CategoryRepo extends GetxController {
  static CategoryRepo get instance => Get.find();

  // variables
  final _db = FirebaseFirestore.instance;

  // get all categories

  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final snapshot = await _db.collection('Categories').get();
      final list =
          snapshot.docs.map((e) => CategoryModel.fromSnapshot(e)).toList();
      return list;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. please try again';
    }
  }

  // get sub-categories

  // upload categories to cloud firestore
  Future<void> uploadDummyData(List<CategoryModel> categories) async {
    try {
      final storage = Get.put(FirebaseStorageService());

      for (var category in categories) {
        // get imagedata link from local assets
        final file = await storage.getImageDataFromAssets(category.image);

        // upload image and get url
        final url =
            await storage.uploadImageData('Categories', file, category.name);

        // assign url to category.image attribute
        category.image = url;

        // store category in firestore
        await _db
            .collection('Categories')
            .doc(category.id)
            .set(category.toJson());
      }
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. please try again';
    }
  }

  Future<List<CategoryModel>> getSubCategories(String categoryId) async {
    try {
      final snapshot = await _db
          .collection('Categories')
          .where('ParentId', isEqualTo: categoryId)
          .get();
      final result =
          snapshot.docs.map((e) => CategoryModel.fromSnapshot(e)).toList();
      return result;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. please try again';
    }
  }
}
