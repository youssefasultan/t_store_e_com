import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:t_store_e_com/data/repos/auth/auth_repo.dart';
import 'package:t_store_e_com/data/repos/user/user_repo.dart';
import 'package:t_store_e_com/features/authentication/screens/login/login.dart';
import 'package:t_store_e_com/features/personalization/models/user_model.dart';
import 'package:t_store_e_com/features/personalization/screens/profile/widgets/re_auth_user_login_form.dart';
import 'package:t_store_e_com/utils/constants/image_strings.dart';
import 'package:t_store_e_com/utils/constants/sizes.dart';
import 'package:t_store_e_com/utils/helpers/network_manager.dart';
import 'package:t_store_e_com/utils/popups/full_screen_loader.dart';
import 'package:t_store_e_com/utils/popups/loaders.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final profileLoading = false.obs;
  final imageUploading = false.obs;
  final userRepo = Get.put(UserRepo());
  final authRepo = AuthRepo.instance;
  Rx<UserModel> user = UserModel.empty().obs;

  final hidePassword = false.obs;
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    fetchUserReord();
  }

  // save user record from any registraion provider
  Future<void> saveUserRecord(UserCredential? userCredential) async {
    try {
      // refresh user record
      await fetchUserReord();

      if (user.value.id.isEmpty) {
        if (userCredential != null) {
          // convert name to fiest and last name
          final nameParts =
              UserModel.nameParts(userCredential.user!.displayName ?? '');
          final username = UserModel.generateUsername(
              userCredential.user!.displayName ?? '');

          final user = UserModel(
            id: userCredential.user!.uid,
            firstName: nameParts[0],
            lastName:
                nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '',
            email: userCredential.user!.email ?? '',
            username: username,
            phoneNumber: userCredential.user!.phoneNumber ?? '',
            profilePic: userCredential.user!.photoURL ?? '',
          );

          await userRepo.saveUserRecord(user);
        }
      }
    } catch (e) {
      TLoaders.errorSnackBar(
        title: 'Data not Saved',
        message:
            'Something went wrong while saving your info. you can re-save your data in your profile settings',
      );
    }
  }

  Future<void> fetchUserReord() async {
    try {
      profileLoading.value = true;
      final user = await userRepo.fetchUserDetails();
      this.user(user);
    } catch (e) {
      user(UserModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  void deleteAccountWarningPopUp() {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(TSizes.sm),
      title: 'Delete Account',
      middleText:
          'Are you sure you want to delete your account? this action cannot be undone.',
      confirm: ElevatedButton(
        onPressed: () async => deleteUserAccount(),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          side: const BorderSide(color: Colors.red),
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: TSizes.lg),
          child: Text('Delete '),
        ),
      ),
      cancel: OutlinedButton(
        onPressed: () => Navigator.of(Get.overlayContext!).pop(),
        child: const Text('Cancel'),
      ),
    );
  }

  void deleteUserAccount() async {
    try {
      TFullScreenLoader.openLoadingDialog(
          'Processing..', TImages.docerAnimation);

      final provider =
          authRepo.authUser!.providerData.map((e) => e.providerId).first;
      if (provider.isNotEmpty) {
        if (provider == 'google.com') {
          await authRepo.siginInWithGoogle();
          await authRepo.deleteAccount();
          TFullScreenLoader.stopLoading();
          Get.offAll(() => const LoginScreen());
        } else if (provider == 'password') {
          TFullScreenLoader.stopLoading();
          Get.to(() => const ReAuthLoginForm());
        }
      }
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.warningSnackBar(title: 'OH SHIT', message: e.toString());
    }
  }

  Future<void> reAuthenticateWithEmailAndPassword() async {
    try {
      TFullScreenLoader.openLoadingDialog(
          'Processing..', TImages.docerAnimation);
      // check connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // form validation
      if (!reAuthFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      await authRepo.reAuthenticateWithEmailAndPassword(
        verifyEmail.text.trim(),
        verifyPassword.text.trim(),
      );
      await authRepo.deleteAccount();
      TFullScreenLoader.stopLoading();
      Get.offAll(() => const LoginScreen());
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.warningSnackBar(title: 'OH SHIT', message: e.toString());
    }
  }

  // upload profile img
  uploadUSerProfilePicture() async {
    try {
      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
        maxHeight: 512,
        maxWidth: 512,
      );

      if (image != null) {
        imageUploading.value = true;
        // upload image
        final imageUrl =
            await userRepo.uploadImage('Users/Images/Profile/', image);

        // update image
        Map<String, dynamic> json = {
          'ProfilePic': imageUrl,
        };

        await userRepo.updateSingleFeild(json);

        user.value.profilePic = imageUrl;

        user.refresh();

        TLoaders.successSnackBar(
            title: 'OH YEAH', message: 'Profile Image Updated');
      }
    } catch (e) {
      TLoaders.errorSnackBar(title: 'OH SHIT', message: e.toString());
    } finally {
      imageUploading.value = false;
    }
  }
}
