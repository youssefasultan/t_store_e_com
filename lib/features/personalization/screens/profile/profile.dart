import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store_e_com/common/widgets/appbar/custom_appbar.dart';
import 'package:t_store_e_com/common/widgets/images/circular_image.dart';
import 'package:t_store_e_com/common/widgets/shimmers/shimmer.dart';
import 'package:t_store_e_com/common/widgets/texts/seaction_header.dart';
import 'package:t_store_e_com/features/personalization/controllers/user_controller.dart';
import 'package:t_store_e_com/features/personalization/screens/profile/widgets/change_name.dart';
import 'package:t_store_e_com/utils/constants/image_strings.dart';
import 'package:t_store_e_com/utils/constants/sizes.dart';

import 'widgets/profile_menu_item.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: const CustomAppBar(
        showBackArrow: true,
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              //profile pic
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Obx(() {
                      final networkImg = controller.user.value.profilePic;
                      final image =
                          networkImg.isNotEmpty ? networkImg : TImages.user;
                      return controller.imageUploading.value
                          ? const TShimmerEffect(
                              width: 80,
                              height: 80,
                              radius: 80,
                            )
                          : CircularImage(
                              image: image,
                              width: 80,
                              height: 80,
                              isNetworkImage: networkImg.isNotEmpty,
                            );
                    }),
                    TextButton(
                      onPressed: () => controller.uploadUSerProfilePicture(),
                      child: const Text('Change Profile Picture'),
                    )
                  ],
                ),
              ),

              // details
              const SizedBox(height: TSizes.spaceBtwItems / 2),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),

              // heading profile info
              const SectionHeader(
                  title: 'Profile Info', showActionButton: false),
              const SizedBox(height: TSizes.spaceBtwItems),

              ProfileMenuItem(
                ontap: () => Get.to(() => const ChangeName()),
                title: 'Name',
                value: controller.user.value.fullName,
              ),
              ProfileMenuItem(
                ontap: () {},
                title: 'username',
                value: controller.user.value.username,
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),

              // heading personal info
              const SectionHeader(
                title: 'Personal Info',
                showActionButton: false,
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              ProfileMenuItem(
                ontap: () {},
                title: 'UserId',
                value: controller.user.value.id,
                icon: Iconsax.copy,
              ),
              ProfileMenuItem(
                ontap: () {},
                title: 'E-mail',
                value: controller.user.value.email,
              ),
              ProfileMenuItem(
                ontap: () {},
                title: 'Phone Number',
                value: controller.user.value.phoneNumber,
              ),
              ProfileMenuItem(
                ontap: () {},
                title: 'Gender',
                value: 'Male',
              ),
              ProfileMenuItem(
                ontap: () {},
                title: 'Date of Birth',
                value: '18 Aug, 1995',
              ),

              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),

              Center(
                child: TextButton(
                  onPressed: () => controller.deleteAccountWarningPopUp(),
                  child: const Text(
                    'Delete Account',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
