import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store_e_com/common/styles/spacing_styles.dart';
import 'package:t_store_e_com/common/widgets/login_signup/form_divider.dart';
import 'package:t_store_e_com/common/widgets/login_signup/social_buttons.dart';
import 'package:t_store_e_com/utils/constants/sizes.dart';
import 'package:t_store_e_com/utils/constants/text_strings.dart';

import 'widgets/login_form.dart';
import 'widgets/login_header.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            children: [
              //logo, title, subtitle
              const LoginHeader(),
              // form
              const LoginForm(),

              // Divider
              FormDivider(title: TTexts.orSignUpWith.capitalize!),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Footer
              const SocialButtons()
            ],
          ),
        ),
      ),
    );
  }
}
