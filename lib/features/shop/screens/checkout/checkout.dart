import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:t_store_e_com/common/widgets/appbar/custom_appbar.dart';
import 'package:t_store_e_com/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:t_store_e_com/common/widgets/products/cart/coupon_code.dart';
import 'package:t_store_e_com/features/shop/controllers/cart_controller.dart';
import 'package:t_store_e_com/features/shop/controllers/product/order_controller.dart';
import 'package:t_store_e_com/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:t_store_e_com/features/shop/screens/checkout/widgets/billing_address.dart';
import 'package:t_store_e_com/features/shop/screens/checkout/widgets/billing_amount.dart';
import 'package:t_store_e_com/features/shop/screens/checkout/widgets/billing_payment.dart';
import 'package:t_store_e_com/utils/constants/colors.dart';
import 'package:t_store_e_com/utils/constants/sizes.dart';
import 'package:t_store_e_com/utils/helpers/helper_functions.dart';
import 'package:t_store_e_com/utils/helpers/pricing_calculator.dart';
import 'package:t_store_e_com/utils/popups/loaders.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    final cartController = CartController.instance;
    final orderController = Get.put(OrderController());
    final subTotal = cartController.totalCartPrice.value;
    final totalAmount = TPricingCalculator.calculateTotalPrice(subTotal, 'US');
    return Scaffold(
      appBar: CustomAppBar(
        showBackArrow: true,
        title: Text(
          'Order Review',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              // items in cart
              const CartItems(showAddRemoveButton: false),
              const SizedBox(height: TSizes.spaceBtwSections),

              // counpon
              const CouponCode(),
              const SizedBox(height: TSizes.spaceBtwSections),

              // billing
              RoundedContainer(
                showBorder: true,
                padding: const EdgeInsets.all(TSizes.md),
                backgroundColor: isDark ? TColors.black : TColors.white,
                child: const Column(
                  children: [
                    //pricig
                    BillingAmountSection(),
                    SizedBox(height: TSizes.spaceBtwItems),
                    // divider
                    Divider(),
                    SizedBox(height: TSizes.spaceBtwItems),
                    //payment method
                    BillingPaymentSection(),
                    SizedBox(height: TSizes.spaceBtwItems),
                    // address
                    BillingAddressSection(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: ElevatedButton(
          onPressed: subTotal > 0
              ? () => orderController.processOrder(totalAmount)
              : () => TLoaders.warningSnackBar(title: 'Empty Cart', message: 'Added Items to Cart'),
          child: Text('Checkout \$$totalAmount'),
        ),
      ),
    );
  }
}
