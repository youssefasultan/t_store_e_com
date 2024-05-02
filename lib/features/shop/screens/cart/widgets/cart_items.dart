import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store_e_com/common/widgets/products/cart/add_remove_btton.dart';
import 'package:t_store_e_com/common/widgets/products/cart/cart_item_description.dart';
import 'package:t_store_e_com/common/widgets/texts/price_text.dart';
import 'package:t_store_e_com/features/shop/controllers/cart_controller.dart';
import 'package:t_store_e_com/utils/constants/sizes.dart';

class CartItems extends StatelessWidget {
  const CartItems({
    super.key,
    this.showAddRemoveButton = true,
  });

  final bool showAddRemoveButton;

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    return Obx(
      () => ListView.separated(
        shrinkWrap: true,
        itemBuilder: (context, index) => Obx(() {
          final item = cartController.cartItems[index];
          return Column(
            children: [
              CartItemDescription(cartItem: item),
              if (showAddRemoveButton)
                const SizedBox(height: TSizes.spaceBtwItems),
              if (showAddRemoveButton)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const SizedBox(width: 70),
                        ProductQuantitiyAddRemove(
                          qty: item.quantity,
                          add: () => cartController.addOneToCart(item),
                          remove: () => cartController.removeOneFromCart(item),
                        ),
                      ],
                    ),
                    PriceText(
                      price: (item.price * item.quantity).toStringAsFixed(1),
                    ),
                  ],
                )
            ],
          );
        }),
        separatorBuilder: (_, __) =>
            const SizedBox(height: TSizes.spaceBtwItems),
        itemCount: cartController.cartItems.length,
      ),
    );
  }
}
