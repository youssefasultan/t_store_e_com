import 'package:flutter/widgets.dart';
import 'package:get/get.dart';


import 'package:t_store_e_com/data/repos/user/user_repo.dart';
import 'package:t_store_e_com/features/personalization/controllers/user_controller.dart';
import 'package:t_store_e_com/features/personalization/screens/profile/profile.dart';
import 'package:t_store_e_com/utils/constants/image_strings.dart';
import 'package:t_store_e_com/utils/helpers/network_manager.dart';
import 'package:t_store_e_com/utils/popups/full_screen_loader.dart';
import 'package:t_store_e_com/utils/popups/loaders.dart';

class UpdateNameController extends GetxController {
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final userController = UserController.instance;
  final userRepo = Get.put(UserRepo());

  GlobalKey<FormState> updateNameFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    initNames();
    super.onInit();
  }

  Future<void> initNames() async {
    firstName.text = userController.user.value.firstName;
    lastName.text = userController.user.value.lastName;
  }

  Future<void> updateUserName() async {
    try {
      // start loading
      TFullScreenLoader.openLoadingDialog(
          'We are Updating your info..', TImages.docerAnimation);

      // check connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // form validation
      if (!updateNameFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // update in firebase firestore
      Map<String, dynamic> name = {
        'FiretName': firstName.text.trim(),
        'LastName': lastName.text.trim(),
      };

      await userRepo.updateSingleFeild(name);

      // update rx user value
      userController.user.value.firstName = firstName.text.trim();
      userController.user.value.lastName = lastName.text.trim();

      TFullScreenLoader.stopLoading();

      TLoaders.successSnackBar(
        title: 'OH YAH!',
        message: 'Name Changed Successfully',
      );

      Get.off(() => const ProfileScreen());
    } catch (e) {
      TFullScreenLoader.stopLoading();

      TLoaders.errorSnackBar(
        title: 'OH SHIT!',
        message: e.toString(),
      );
    }
  }
}
