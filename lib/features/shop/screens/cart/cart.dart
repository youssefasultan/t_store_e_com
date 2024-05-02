import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:t_store_e_com/common/widgets/appbar/custom_appbar.dart';
import 'package:t_store_e_com/common/widgets/loaders/animation_loader.dart';
import 'package:t_store_e_com/features/shop/controllers/cart_controller.dart';
import 'package:t_store_e_com/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:t_store_e_com/features/shop/screens/checkout/checkout.dart';
import 'package:t_store_e_com/navigation_menu.dart';
import 'package:t_store_e_com/utils/constants/image_strings.dart';
import 'package:t_store_e_com/utils/constants/sizes.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    return Scaffold(
      appBar: CustomAppBar(
        showBackArrow: true,
        title: Text(
          'Cart',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: Obx(() {
        final emptyWidget = TAnimationLoaderWidget(
          text: 'Whoops! cart is Empty',
          animation: TImages.cartAnimation,
          showAction: true,
          actionText: 'Let\'s add some items',
          onActionPressed: () => Get.off(() => const NavigationMenu()),
        );

        if (controller.cartItems.isEmpty) {
          return emptyWidget;
        } else {
          return const SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(TSizes.defaultSpace),
              child: CartItems(),
            ),
          );
        }
      }),
      bottomNavigationBar: controller.cartItems.isEmpty
          ? const SizedBox()
          : Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: ElevatedButton(
                onPressed: () => Get.to(() => const CheckoutScreen()),
                child:
                    Obx(() => Text('Checkout \$${controller.totalCartPrice}')),
              ),
            ),
    );
  }
}
