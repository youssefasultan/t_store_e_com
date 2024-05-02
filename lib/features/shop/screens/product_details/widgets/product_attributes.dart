import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store_e_com/common/widgets/chips/custom_choice_chip.dart';
import 'package:t_store_e_com/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:t_store_e_com/common/widgets/texts/price_text.dart';
import 'package:t_store_e_com/common/widgets/texts/product_title_text.dart';
import 'package:t_store_e_com/common/widgets/texts/seaction_header.dart';
import 'package:t_store_e_com/features/shop/controllers/product/variation_controller.dart';
import 'package:t_store_e_com/features/shop/models/product_model.dart';
import 'package:t_store_e_com/utils/constants/colors.dart';
import 'package:t_store_e_com/utils/constants/sizes.dart';
import 'package:t_store_e_com/utils/helpers/helper_functions.dart';

class ProductAttributes extends StatelessWidget {
  const ProductAttributes({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(VariationController());
    return Obx(
      () => Column(
        children: [
          // selected Attributes
          if (controller.selectedVariation.value.id.isNotEmpty)
            RoundedContainer(
              backgroundColor: isDark ? TColors.darkerGrey : TColors.grey,
              padding: const EdgeInsets.all(TSizes.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const SectionHeader(
                          title: 'Variation', showActionButton: false),
                      const SizedBox(width: TSizes.spaceBtwItems),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //price
                          Row(
                            children: [
                              const ProductTitleText(
                                  title: 'Price', smallSize: true),
                              const SizedBox(width: TSizes.spaceBtwItems * 1.5),
                              // actual price
                              if (controller.selectedVariation.value.salePrice >
                                  0) ...{
                                PriceText(
                                    price: controller
                                        .selectedVariation.value.price
                                        .toString(),
                                    lineThrough: true),
                                const SizedBox(width: TSizes.spaceBtwItems),
                              },

                              // sale price
                              PriceText(price: controller.getVariationPrice()),
                            ],
                          ),

                          // stock
                          Row(
                            children: [
                              const ProductTitleText(
                                  title: 'Stock', smallSize: true),
                              const SizedBox(width: TSizes.spaceBtwItems),
                              Text(controller.variableStockStatus.value,
                                  style:
                                      Theme.of(context).textTheme.titleMedium),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                   ProductTitleText(
                    title:
                        controller.selectedVariation.value.description ?? '',
                    smallSize: true,
                    maxLines: 4,
                  ),
                ],
              ),
            ),
          const SizedBox(height: TSizes.spaceBtwItems),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: product.productAttributes!
                .map(
                  (attribute) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SectionHeader(
                          title: attribute.name ?? '', showActionButton: false),
                      const SizedBox(height: TSizes.spaceBtwItems / 2),
                      Wrap(
                        spacing: 8,
                        children: attribute.values!.map((value) {
                          final isSelected =
                              controller.selectedAttributes[attribute.name] ==
                                  value;
                          final isAvailable = controller
                              .getAttributesAvailabilityInVariation(
                                  product.productVariations!, attribute.name!)
                              .contains(value);
                          return CustomChoiceChip(
                            text: value,
                            selected: isSelected,
                            onSelected: isAvailable
                                ? (selected) {
                                    if (selected && isAvailable) {
                                      controller.onAttributeSelected(
                                          product, attribute.name ?? '', value);
                                    }
                                  }
                                : null,
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
