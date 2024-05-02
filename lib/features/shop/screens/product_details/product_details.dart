import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';
import 'package:t_store_e_com/common/widgets/texts/seaction_header.dart';
import 'package:t_store_e_com/features/shop/models/product_model.dart';
import 'package:t_store_e_com/features/shop/screens/product_details/widgets/bottom_add_to_cart.dart';
import 'package:t_store_e_com/features/shop/screens/product_details/widgets/product_attributes.dart';

import 'package:t_store_e_com/features/shop/screens/product_details/widgets/product_detail_image_slider.dart';
import 'package:t_store_e_com/features/shop/screens/product_details/widgets/product_meta_data.dart';
import 'package:t_store_e_com/features/shop/screens/product_details/widgets/rating_and_share_row.dart';
import 'package:t_store_e_com/features/shop/screens/product_reviews/product_reviews.dart';
import 'package:t_store_e_com/utils/constants/enums.dart';
import 'package:t_store_e_com/utils/constants/sizes.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAddToCart(product: product),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // product slider
            ImageSlider(
              product: product,
            ),

            // product details
            Padding(
              padding: const EdgeInsets.only(
                right: TSizes.defaultSpace,
                left: TSizes.defaultSpace,
                bottom: TSizes.defaultSpace,
              ),
              child: Column(
                children: [
                  /// rating and share
                  const RatingAndShareRow(
                    rating: '5.0',
                    count: '199',
                  ),

                  // product metadata
                  ProductMetaData(product: product),

                  // attributes
                  if (product.productType ==
                      ProductType.variable.toString()) ...{
                    ProductAttributes(
                      product: product,
                    ),
                    const SizedBox(height: TSizes.spaceBtwSections),
                  },

                  // checkout buttoon
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text('Checkout'),
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  // description
                  const SectionHeader(
                      title: 'Description', showActionButton: false),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  ReadMoreText(
                    product.description ?? '',
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: 'Show more',
                    trimExpandedText: 'Show less',
                    moreStyle: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w800),
                    lessStyle: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w800),
                  ),

                  // reviews
                  const Divider(),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SectionHeader(
                          title: 'Reviews(199)', showActionButton: false),
                      IconButton(
                        onPressed: () {
                          Get.to(() => const ProductReviewsScreen());
                        },
                        icon: const Icon(Iconsax.arrow_right_3),
                      ),
                    ],
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
