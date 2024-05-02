import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:t_store_e_com/data/repos/auth/auth_repo.dart';
import 'package:t_store_e_com/features/authentication/screens/password_config.dart/reset_password.dart';
import 'package:t_store_e_com/utils/constants/image_strings.dart';
import 'package:t_store_e_com/utils/helpers/network_manager.dart';
import 'package:t_store_e_com/utils/popups/full_screen_loader.dart';
import 'package:t_store_e_com/utils/popups/loaders.dart';

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();

  // variables
  final email = TextEditingController();
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  // send reset pass email
  sendPasswordResetEmail() async {
    try {
      // start loading
      TFullScreenLoader.openLoadingDialog(
          'We are Processing your request..', TImages.docerAnimation);

      // check connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // form validation
      if (!forgetPasswordFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      await AuthRepo.instance.sendPasswordResetEmail(email.text.trim());

      // remove loader
      TFullScreenLoader.stopLoading();

      // show Sucess Screen
      TLoaders.successSnackBar(
        title: 'Email Sent',
        message: 'Email link sent to reset your password',
      );

      Get.to(() => ResetPasswordScreen(email: email.text.trim()));
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'OH SHIT', message: e.toString());
    }
  }

  reSendPasswordResetEmail(String email) async {
    try {
      // start loading
      TFullScreenLoader.openLoadingDialog(
          'We are Processing your request..', TImages.docerAnimation);

      // check connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      

      await AuthRepo.instance.sendPasswordResetEmail(email);

      // remove loader
      TFullScreenLoader.stopLoading();

      // show Sucess Screen
      TLoaders.successSnackBar(
        title: 'Email Sent',
        message: 'Email link sent to reset your password'.tr,
      );

    
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'OH SHIT', message: e.toString());
    }
  }
}
