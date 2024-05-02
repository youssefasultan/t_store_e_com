import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:t_store_e_com/data/repos/auth/auth_repo.dart';
import 'package:t_store_e_com/features/personalization/controllers/user_controller.dart';
import 'package:t_store_e_com/utils/constants/image_strings.dart';
import 'package:t_store_e_com/utils/helpers/network_manager.dart';
import 'package:t_store_e_com/utils/popups/full_screen_loader.dart';
import 'package:t_store_e_com/utils/popups/loaders.dart';

class LoginController extends GetxController {
  // variables
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  final localStorage = GetStorage();
  final userController = Get.put(UserController());

  final rememberMe = false.obs;
  final hidePassword = true.obs;

  @override
  void onInit() {
    email.text = localStorage.read('REMEMBER_ME_EMAIL') ?? '';
    password.text = localStorage.read('REMEMBER_ME_PASSWORD') ?? '';
    super.onInit();
  }

  Future<void> emailAndPasswordSignIn() async {
    try {
      TFullScreenLoader.openLoadingDialog(
          'Loggin you in..', TImages.docerAnimation);

      // check connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // form validation
      if (!loginFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // save data if remember me is selected
      if (rememberMe.value) {
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }

      // login user
      await AuthRepo.instance
          .loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      // stop loader
      TFullScreenLoader.stopLoading();

      // redirect
      AuthRepo.instance.screenRedircet();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Shit', message: e.toString());
    }
  }

  // google sign in
  Future<void> googleSignIn() async {
    try {
      TFullScreenLoader.openLoadingDialog(
          'Loggin you in..', TImages.docerAnimation);

      // check connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      //goodle auth
      final userCredential = await AuthRepo.instance.siginInWithGoogle();

      // save user record
      await userController.saveUserRecord(userCredential);

      // stop loader
      TFullScreenLoader.stopLoading();

      AuthRepo.instance.screenRedircet();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Shit', message: e.toString());
    }
  }
}
