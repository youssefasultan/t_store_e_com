import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store_e_com/common/widgets/icons/circular_icon.dart';
import 'package:t_store_e_com/utils/constants/colors.dart';
import 'package:t_store_e_com/utils/constants/sizes.dart';
import 'package:t_store_e_com/utils/helpers/helper_functions.dart';

class ProductQuantitiyAddRemove extends StatelessWidget {
  const ProductQuantitiyAddRemove({
    super.key,
    required this.qty,
    this.add,
    this.remove,
  });
  final int qty;
  final VoidCallback? add, remove;

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    return Row(
      children: [
        CircularIcon(
          icon: Iconsax.minus,
          width: 32,
          height: 32,
          size: TSizes.md,
          color: isDark ? TColors.white : TColors.black,
          backgroundColor: isDark ? TColors.darkerGrey : TColors.light,
          onPressed: remove,
        ),
        const SizedBox(width: TSizes.spaceBtwItems),
        Text(
          qty.toString(),
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(width: TSizes.spaceBtwItems),
        CircularIcon(
          icon: Iconsax.add,
          width: 32,
          height: 32,
          size: TSizes.md,
          color: TColors.white,
          backgroundColor: TColors.primary,
          onPressed: add,
        ),
      ],
    );
  }
}
