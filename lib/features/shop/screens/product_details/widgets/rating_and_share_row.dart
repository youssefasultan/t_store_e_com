import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store_e_com/utils/constants/sizes.dart';

class RatingAndShareRow extends StatelessWidget {
  const RatingAndShareRow({
    super.key,
    required this.rating,
    required this.count,
  });

  final String rating, count;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // rating
        Row(
          children: [
            const Icon(Iconsax.star5, color: Colors.amber, size: 24),
            const SizedBox(width: TSizes.spaceBtwItems / 2),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                      text: rating,
                      style: Theme.of(context).textTheme.bodyLarge),
                  TextSpan(text: '($count)'),
                ],
              ),
            ),
          ],
        ),
        // sharing button

        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.share,
            size: TSizes.iconMd,
          ),
        )
      ],
    );
  }
}
