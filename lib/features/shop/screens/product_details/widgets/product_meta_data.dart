import 'package:flutter/material.dart';
import 'package:t_store_e_com/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:t_store_e_com/common/widgets/images/circular_image.dart';
import 'package:t_store_e_com/common/widgets/texts/brand_title_text_with_verification_icon.dart';
import 'package:t_store_e_com/common/widgets/texts/price_text.dart';
import 'package:t_store_e_com/common/widgets/texts/product_title_text.dart';
import 'package:t_store_e_com/features/shop/controllers/product/product_controller.dart';
import 'package:t_store_e_com/features/shop/models/product_model.dart';
import 'package:t_store_e_com/utils/constants/colors.dart';
import 'package:t_store_e_com/utils/constants/enums.dart';
import 'package:t_store_e_com/utils/constants/sizes.dart';
import 'package:t_store_e_com/utils/helpers/helper_functions.dart';

class ProductMetaData extends StatelessWidget {
  const ProductMetaData({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    final controller = ProductController.instance;
    final salePercentage =
        controller.calculateSalePercentage(product.price, product.salePrice);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // price and sale price
        Row(
          children: [
            // sale tag
            RoundedContainer(
              radius: TSizes.sm,
              backgroundColor: TColors.secondary.withOpacity(0.8),
              padding: const EdgeInsets.symmetric(
                  horizontal: TSizes.sm, vertical: TSizes.xs),
              child: Text(
                '$salePercentage%',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .apply(color: TColors.black),
              ),
            ),
            const SizedBox(width: TSizes.spaceBtwItems),

            // price
            if (product.productType == ProductType.values.toString() &&
                product.salePrice > 0.0) ...{
              PriceText(
                price: product.price.toString(),
                lineThrough: true,
              ),
              const SizedBox(width: TSizes.spaceBtwItems),
            },

            PriceText(
                price: controller.getProductPrice(product), isLarge: true),
          ],
        ),
        const SizedBox(width: TSizes.spaceBtwItems / 1.5),

        // title
         ProductTitleText(title: product.title),
        const SizedBox(width: TSizes.spaceBtwItems / 1.5),

        // status
        Row(
          children: [
            const ProductTitleText(title: 'Status'),
            const SizedBox(width: TSizes.spaceBtwItems),
            Text(controller.getProductStockStatus(product.stock), style: Theme.of(context).textTheme.titleMedium),
          ],
        ),

        const SizedBox(width: TSizes.spaceBtwItems / 1.5),

        // brand
        Row(
          children: [
            CircularImage(
              width: 32,
              height: 32,
              overlayColor: isDark ? TColors.white : TColors.dark,
              image:product.brand != null ? product.brand!.image : '',
              isNetworkImage: true,
            ),
             BrandTitleTextWithVerificationIcon(
              title: product.brand != null ? product.brand!.name : '',
              textSize: TextSizes.medium,
            ),
          ],
        ),
      ],
    );
  }
}
