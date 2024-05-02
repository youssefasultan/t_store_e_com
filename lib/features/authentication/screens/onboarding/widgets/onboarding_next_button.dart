import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store_e_com/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:t_store_e_com/utils/constants/colors.dart';
import 'package:t_store_e_com/utils/constants/sizes.dart';
import 'package:t_store_e_com/utils/device/device_utility.dart';
import 'package:t_store_e_com/utils/helpers/helper_functions.dart';

class OnBoardingNextButton extends StatelessWidget {
  const OnBoardingNextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    return Positioned(
      right: TSizes.defaultSpace,
      bottom: TDeviceUtil.getBottomNavigationBarHeight(),
      child: ElevatedButton(
        onPressed: () => OnBoardingController.instance.nextPage(),
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          backgroundColor: isDark ? TColors.primary : TColors.black,
        ),
        child: const Icon(Iconsax.arrow_right_3),
      ),
    );
  }
}
