import 'package:flutter/material.dart';
import 'package:t_store_e_com/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:t_store_e_com/utils/constants/sizes.dart';
import 'package:t_store_e_com/utils/device/device_utility.dart';

class OnBoradingSkip extends StatelessWidget {
  const OnBoradingSkip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: TDeviceUtil.getAppBarHeight(),
      right: TSizes.defaultSpace,
      child: TextButton(
        onPressed: () => OnBoardingController.instance.skipPage(),
        child: const Text('Skip'),
      ),
    );
  }
}
