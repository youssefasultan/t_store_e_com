import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store_e_com/common/widgets/login_signup/form_divider.dart';
import 'package:t_store_e_com/common/widgets/login_signup/social_buttons.dart';
import 'package:t_store_e_com/features/authentication/screens/signup/widgets/signup_form.dart';
import 'package:t_store_e_com/utils/constants/sizes.dart';
import 'package:t_store_e_com/utils/constants/text_strings.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tile
              Text(
                TTexts.signupTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              // form
              const SignUpForm(),
              const SizedBox(height: TSizes.spaceBtwSections),

              //Divider
              FormDivider(title: TTexts.orSignUpWith.capitalize!),
              const SizedBox(height: TSizes.spaceBtwSections),

              // social buttons
              const SocialButtons()
            ],
          ),
        ),
      ),
    );
  }
}
