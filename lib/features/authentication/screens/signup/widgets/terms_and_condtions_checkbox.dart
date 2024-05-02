import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store_e_com/features/authentication/controllers/signup/signup_controller.dart';
import 'package:t_store_e_com/utils/constants/colors.dart';
import 'package:t_store_e_com/utils/constants/sizes.dart';
import 'package:t_store_e_com/utils/constants/text_strings.dart';
import 'package:t_store_e_com/utils/helpers/helper_functions.dart';

class TermsAndConditionsCheckbox extends StatelessWidget {
  const TermsAndConditionsCheckbox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    final controller = SignUpController.instance;
    return Row(
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: Obx(
            () => Checkbox(
              value: controller.privacyPolicy.value,
              onChanged: (value) => controller.privacyPolicy.value =
                  !controller.privacyPolicy.value,
            ),
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwItems),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: '${TTexts.iAgreeTo} ',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              TextSpan(
                text: TTexts.privacyPolicy,
                style: Theme.of(context).textTheme.bodyMedium!.apply(
                      color: isDark ? TColors.white : TColors.primary,
                      decoration: TextDecoration.underline,
                      decorationColor: isDark ? TColors.white : TColors.primary,
                    ),
              ),
              TextSpan(
                text: ' ${TTexts.and} ',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              TextSpan(
                text: TTexts.termsOfUse,
                style: Theme.of(context).textTheme.bodyMedium!.apply(
                      color: isDark ? TColors.white : TColors.primary,
                      decoration: TextDecoration.underline,
                      decorationColor: isDark ? TColors.white : TColors.primary,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
