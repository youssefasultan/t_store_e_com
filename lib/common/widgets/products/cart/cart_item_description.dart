import 'package:flutter/material.dart';
import 'package:t_store_e_com/common/widgets/images/rounded_image.dart';
import 'package:t_store_e_com/common/widgets/texts/brand_title_text_with_verification_icon.dart';
import 'package:t_store_e_com/common/widgets/texts/product_title_text.dart';
import 'package:t_store_e_com/features/shop/models/cart_item_model.dart';
import 'package:t_store_e_com/utils/constants/colors.dart';
import 'package:t_store_e_com/utils/constants/sizes.dart';
import 'package:t_store_e_com/utils/helpers/helper_functions.dart';

class CartItemDescription extends StatelessWidget {
  const CartItemDescription({
    super.key,
    required this.cartItem,
  });

  final CartItemModel cartItem;
  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    return Row(
      children: [
        // image
        RoundedImage(
          width: 60,
          height: 60,
          padding: const EdgeInsets.all(TSizes.sm),
          backgroundColor: isDark ? TColors.darkerGrey : TColors.light,
          imageUrl: cartItem.image ?? '',
          isNetworkImage: true,
        ),
        const SizedBox(width: TSizes.spaceBtwItems),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            BrandTitleTextWithVerificationIcon(title: cartItem.brandName ?? ''),
            Flexible(
              child: ProductTitleText(title: cartItem.title, maxLines: 1),
            ),
            Text.rich(
              TextSpan(
                children: (cartItem.selectedVariation ?? {})
                    .entries
                    .map(
                      (e) => TextSpan(
                        children: [
                          TextSpan(
                            text: '${e.key} ',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          TextSpan(
                            text: '${e.value} ',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    )
                    .toList(),
              ),
            )
          ],
        )
      ],
    );
  }
}
