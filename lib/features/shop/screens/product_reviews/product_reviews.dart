import 'package:flutter/material.dart';

import 'package:t_store_e_com/common/widgets/appbar/custom_appbar.dart';
import 'package:t_store_e_com/common/widgets/products/ratings/rating_bar_indicator.dart';
import 'package:t_store_e_com/features/shop/screens/product_reviews/widgets/user_review_card.dart';
import 'package:t_store_e_com/utils/constants/sizes.dart';

import 'widgets/overall_product_rating.dart';

class ProductReviewsScreen extends StatelessWidget {
  const ProductReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: Text('Reviews & Ratings'),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Ratings and reviews are verifed and are from people who used the product.',
              ),
              const SizedBox(height: TSizes.spaceBtwItems),

              // overall product rating
              const OverAllProductRating(),
              const CustomRatingBarIndicator(rating: 3.5),
              Text('12,611', style: Theme.of(context).textTheme.bodySmall),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Users reviews
              const UserReviewCard(),
              const UserReviewCard(),
              const UserReviewCard(),
              const UserReviewCard(),
            ],
          ),
        ),
      ),
    );
  }
}
