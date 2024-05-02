import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store_e_com/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:t_store_e_com/features/shop/controllers/product/checkout_controller.dart';
import 'package:t_store_e_com/features/shop/models/payment_method_model.dart';
import 'package:t_store_e_com/utils/constants/colors.dart';
import 'package:t_store_e_com/utils/constants/sizes.dart';
import 'package:t_store_e_com/utils/helpers/helper_functions.dart';

class PAymentMethodTile extends StatelessWidget {
  const PAymentMethodTile({
    super.key,
    required this.payment,
  });

  final PaymentMethodModel payment;

  @override
  Widget build(BuildContext context) {
    final controller = CheckoutController.instance;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      onTap: () {
        controller.selectedPaymentMethod.value = payment;
        Get.back();

      },
      leading: RoundedContainer(
        width: 60,
        height: 40,
        backgroundColor: THelperFunctions.isDarkMode(context)
            ? TColors.light
            : TColors.white,
        padding: const EdgeInsets.all(TSizes.sm),
        child: Image(image: AssetImage(payment.img), fit: BoxFit.contain),
      ),
      title: Text(payment.name),
      trailing: const Icon(Iconsax.arrow_right_34),
    );
  }
}
