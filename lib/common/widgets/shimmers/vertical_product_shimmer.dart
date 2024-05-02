import 'package:flutter/material.dart';
import 'package:t_store_e_com/common/widgets/layout/product_grid_layout.dart';
import 'package:t_store_e_com/common/widgets/shimmers/shimmer.dart';
import 'package:t_store_e_com/utils/constants/sizes.dart';

class VerticalProductShimmer extends StatelessWidget {
  const VerticalProductShimmer({super.key, this.itemCount = 6});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return ProductsGridLayout(
      itemCount: itemCount,
      itembuilder: (context, index) => const SizedBox(
        width: 180,
        child: Column(
          children: [
            TShimmerEffect(width: 180, height: 180),
            SizedBox(height: TSizes.spaceBtwItems),
            TShimmerEffect(width: 180, height: 15),
            SizedBox(height: TSizes.spaceBtwItems / 2),
            TShimmerEffect(width: 180, height: 15),
          ],
        ),
      ),
    );
  }
}
