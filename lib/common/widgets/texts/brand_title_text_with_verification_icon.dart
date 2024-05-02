import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store_e_com/common/widgets/texts/brand_title_text.dart';
import 'package:t_store_e_com/utils/constants/colors.dart';
import 'package:t_store_e_com/utils/constants/enums.dart';
import 'package:t_store_e_com/utils/constants/sizes.dart';

class BrandTitleTextWithVerificationIcon extends StatelessWidget {
  const BrandTitleTextWithVerificationIcon({
    super.key,
    required this.title,
    this.maxLines = 1,
    this.textColor,
    this.iconColor = TColors.primary,
    this.textAlign = TextAlign.left,
    this.textSize = TextSizes.small,
  });

  final String title;
  final int maxLines;
  final Color? textColor, iconColor;
  final TextAlign? textAlign;
  final TextSizes textSize;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: BrandTitleText(
            title: title,
            color: textColor,
            maxLines: maxLines,
            textAlign: textAlign,
            textSize: textSize,
          ),
        ),
        const SizedBox(height: TSizes.sm),
        Icon(Iconsax.verify5, color: iconColor, size: TSizes.iconSm)
      ],
    );
  }
}
