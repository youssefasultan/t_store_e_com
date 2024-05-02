import 'package:flutter/material.dart';
import 'package:t_store_e_com/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:t_store_e_com/common/widgets/images/circular_image.dart';
import 'package:t_store_e_com/common/widgets/texts/brand_title_text_with_verification_icon.dart';
import 'package:t_store_e_com/features/shop/models/brand_model.dart';
import 'package:t_store_e_com/utils/constants/colors.dart';
import 'package:t_store_e_com/utils/constants/enums.dart';
import 'package:t_store_e_com/utils/constants/sizes.dart';
import 'package:t_store_e_com/utils/helpers/helper_functions.dart';

class BrandCard extends StatelessWidget {
  const BrandCard({
    super.key,
    required this.showBoarder,
    this.onPressed,
    required this.brand,
  });

  final bool showBoarder;
  final void Function()? onPressed;
  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: onPressed,
      child: RoundedContainer(
        padding: const EdgeInsets.all(TSizes.sm),
        showBorder: showBoarder,
        backgroundColor: Colors.transparent,
        child: Row(
          children: [
            // icon
            Flexible(
              child: CircularImage(
                image: brand.image,
                backgroundColor: Colors.transparent,
                overlayColor: isDark ? TColors.white : TColors.dark,
                isNetworkImage: true,
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwItems / 2),

            //text
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BrandTitleTextWithVerificationIcon(
                    title: brand.name,
                    textSize: TextSizes.large,
                  ),
                  Text(
                    '${brand.productsCount ?? 0} Products',
                    style: Theme.of(context).textTheme.labelMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
