import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store_e_com/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:t_store_e_com/common/widgets/images/rounded_image.dart';
import 'package:t_store_e_com/common/widgets/products/fav_icon/favorite_icon.dart';
import 'package:t_store_e_com/common/widgets/texts/brand_title_text_with_verification_icon.dart';
import 'package:t_store_e_com/common/widgets/texts/price_text.dart';
import 'package:t_store_e_com/common/widgets/texts/product_title_text.dart';
import 'package:t_store_e_com/features/shop/controllers/product/product_controller.dart';
import 'package:t_store_e_com/features/shop/models/product_model.dart';
import 'package:t_store_e_com/features/shop/screens/product_details/product_details.dart';
import 'package:t_store_e_com/utils/constants/colors.dart';
import 'package:t_store_e_com/utils/constants/enums.dart';
import 'package:t_store_e_com/utils/constants/sizes.dart';
import 'package:t_store_e_com/utils/helpers/helper_functions.dart';

import 'add_to_cart_button.dart';

class HorizontalProductCard extends StatelessWidget {
  const HorizontalProductCard({super.key, required this.product});
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    final controller = ProductController.instance;
    final saleTag =
        controller.calculateSalePercentage(product.price, product.salePrice);
    return GestureDetector(
      onTap: () => Get.to(() => ProductDetailsScreen(
            product: ProductModel.empty(),
          )),
      child: Container(
        width: 310,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(TSizes.productImageRadius),
          color: isDark ? TColors.darkerGrey : TColors.softGrey,
        ),
        child: Row(
          children: [
            // thumbnail, whishlist, discount tag
            RoundedContainer(
              height: 120,
              padding: const EdgeInsets.all(TSizes.sm),
              backgroundColor: isDark ? TColors.dark : TColors.light,
              child: Stack(
                children: [
                  // image
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: RoundedImage(
                      imageUrl: product.thumbnail,
                      applyImageRadius: true,
                      isNetworkImage: true,
                    ),
                  ),

                  // discount tag
                  if (saleTag != null)
                    Positioned(
                      top: 12,
                      child: RoundedContainer(
                        radius: TSizes.sm,
                        backgroundColor: TColors.secondary.withOpacity(0.8),
                        padding: const EdgeInsets.symmetric(
                            horizontal: TSizes.sm, vertical: TSizes.xs),
                        child: Text(
                          '$saleTag%',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .apply(color: TColors.black),
                        ),
                      ),
                    ),
                  // fav icon button
                  Positioned(
                    top: 0,
                    right: 0,
                    child: FavoriteIcon(productId: product.id),
                  ),
                ],
              ),
            ),

            // details
            SizedBox(
              width: 172,
              child: Padding(
                padding: const EdgeInsets.only(top: TSizes.sm, left: TSizes.sm),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ProductTitleText(
                          title: product.title,
                          smallSize: true,
                        ),
                        const SizedBox(height: TSizes.spaceBtwItems / 2),
                        BrandTitleTextWithVerificationIcon(
                          title: product.brand!.name,
                        ),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (product.productType ==
                                ProductType.single.toString() &&
                            product.salePrice > 0)
                          Flexible(
                            child: PriceText(
                              price: product.price.toString(),
                              lineThrough: true,
                            ),
                          ),
                        Padding(
                          padding: const EdgeInsets.only(left: TSizes.sm),
                          child: PriceText(
                            price: controller.getProductPrice(product),
                            isLarge: true,
                          ),
                        ),
                        ProductCardAddToCartButton(product: product),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
