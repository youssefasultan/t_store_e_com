import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:t_store_e_com/utils/exceptions/firebase_exceptions.dart';
import 'package:t_store_e_com/utils/exceptions/platform_exceptions.dart';

class FirebaseStorageService extends GetxController {
  static FirebaseStorageService get instance => Get.find();

  final _firebaseStrorage = FirebaseStorage.instance;

  /// upload local asset from ide
  /// returns a Init8list containing img data
  Future<Uint8List> getImageDataFromAssets(String path) async {
    try {
      final byteData = await rootBundle.load(path);
      final imageData = byteData.buffer
          .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes);
      return imageData;
    } catch (e) {
      throw 'Error Loading image data $e';
    }
  }

  /// upload image uisng imageData on cloud
  /// returns download url
  Future<String> uploadImageData(
      String path, Uint8List image, String name) async {
    try {
      final ref = _firebaseStrorage.ref(path).child(name);
      await ref.putData(image);
      final url = await ref.getDownloadURL();
      return url;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } on SocketException catch (e) {
      throw 'Network error : ${e.message}';
    } catch (e) {
      throw 'Something went wrong. please try again';
    }
  }


  /// upload image  on cloud
  /// returns download url of uploaded img
  Future<String> uploadImageFile(
      String path, XFile image) async {
    try {
      final ref = _firebaseStrorage.ref(path).child(image.name);
      await ref.putFile(File(image.path));
      final url = await ref.getDownloadURL();
      return url;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } on SocketException catch (e) {
      throw 'Network error : ${e.message}';
    } catch (e) {
      throw 'Something went wrong. please try again';
    }
  }
}
