import 'package:flutter/material.dart';
import 'package:t_store_e_com/common/widgets/shimmers/shimmer.dart';
import 'package:t_store_e_com/utils/constants/sizes.dart';

class CategoryShimmer extends StatelessWidget {
  const CategoryShimmer({super.key, this.itemCount = 6});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 82,
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: itemCount,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (_, __) =>
            const SizedBox(width: TSizes.spaceBtwItems),
        itemBuilder: (_, __) => const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TShimmerEffect(
              width: 55,
              height: 55,
              radius: 55,
            ),
            SizedBox(height: TSizes.spaceBtwItems / 2),
            TShimmerEffect(
              width: 55,
              height: 8,
            ),
          ],
        ),
      ),
    );
  }
}
