import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store_e_com/data/repos/auth/auth_repo.dart';
import 'package:t_store_e_com/data/repos/user/user_repo.dart';
import 'package:t_store_e_com/features/authentication/screens/signup/verify_email.dart';
import 'package:t_store_e_com/features/personalization/models/user_model.dart';
import 'package:t_store_e_com/utils/constants/image_strings.dart';
import 'package:t_store_e_com/utils/helpers/network_manager.dart';
import 'package:t_store_e_com/utils/popups/full_screen_loader.dart';
import 'package:t_store_e_com/utils/popups/loaders.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  final hidePassword = true.obs;
  final privacyPolicy = false.obs;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  void signUp() async {
    try {
      // start loading
      TFullScreenLoader.openLoadingDialog(
          'We are Processing your info..', TImages.docerAnimation);

      // check connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // form validation
      if (!signupFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // privacy Policy
      if (!privacyPolicy.value) {
        TFullScreenLoader.stopLoading();
        TLoaders.warningSnackBar(
            title: 'Accept Pricacy Policy',
            message:
                'In order to create an account, youe must read and accept our Privacy Policy');
        return;
      }

      // regitser user in the firebase Auth & save user in the firebase
      final userCredential = await AuthRepo.instance
          .registerWithEmailAndPassword(
              emailController.text, passwordController.text);

      //save authenticated user data in the firestore
      final userModel = UserModel(
        id: userCredential.user!.uid,
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        username: usernameController.text.trim(),
        email: emailController.text.trim(),
        phoneNumber: phoneNumberController.text.trim(),
        profilePic: '',
      );

      final userRepo = Get.put(UserRepo());
      await userRepo.saveUserRecord(userModel);

      // show success message
      TFullScreenLoader.stopLoading();
      TLoaders.successSnackBar(
        title: 'OH YEAH!',
        message: 'Your account has been created! Verify email to continue.',
      );

      // move to verify email screen
      Get.to(() => VerifyEmailScreen(email: emailController.text.trim()));
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Shit', message: e.toString());
    }
  }
}
