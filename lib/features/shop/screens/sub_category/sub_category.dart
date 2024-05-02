import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store_e_com/common/widgets/appbar/custom_appbar.dart';
import 'package:t_store_e_com/common/widgets/images/rounded_image.dart';
import 'package:t_store_e_com/common/widgets/products/product_cards/product_card_horizontal.dart';
import 'package:t_store_e_com/common/widgets/shimmers/horizontal_product_shimmer.dart';
import 'package:t_store_e_com/common/widgets/texts/seaction_header.dart';
import 'package:t_store_e_com/features/shop/controllers/category_controller.dart';
import 'package:t_store_e_com/features/shop/models/category_model.dart';
import 'package:t_store_e_com/features/shop/screens/all_products/all_products.dart';
import 'package:t_store_e_com/utils/constants/image_strings.dart';
import 'package:t_store_e_com/utils/constants/sizes.dart';
import 'package:t_store_e_com/utils/helpers/cloud_helper_functions.dart';

class SubCategoryScreen extends StatelessWidget {
  const SubCategoryScreen({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(category.name),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              const RoundedImage(
                width: double.infinity,
                applyImageRadius: true,
                imageUrl: TImages.promoBanner1,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              // sub-categor
              FutureBuilder(
                future: controller.getSubCategoryProducts(category.id),
                builder: (context, snapshot) {
                  const loader = HorizontalProductShimmer();
                  final widget = TCloudHelperFunctions.checkMultiRecordState(
                      snapshot: snapshot, loader: loader);
                  if (widget != null) return widget;

                  final subCategories = snapshot.data!;

                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: subCategories.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final subCategory = subCategories[index];
                      return FutureBuilder(
                          future: controller.getCategoryProducts(
                              categoryId: subCategory.id, limit: 4),
                          builder: (context, snapshot) {
                            final widget =
                                TCloudHelperFunctions.checkMultiRecordState(
                                    snapshot: snapshot, loader: loader);
                            if (widget != null) return widget;

                            final products = snapshot.data!;
                            return Column(
                              children: [
                                SectionHeader(
                                  title: subCategory.name,
                                  onActionButtonPressed: () => Get.to(
                                    () => AllProductsScreen(
                                      title: subCategory.name,
                                      futureMethod:
                                          controller.getCategoryProducts(
                                        categoryId: subCategory.id,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: TSizes.spaceBtwItems),
                                SizedBox(
                                  height: 120,
                                  child: ListView.separated(
                                    itemCount: products.length,
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemBuilder: (_, index) =>
                                        HorizontalProductCard(
                                      product: products[index],
                                    ),
                                    separatorBuilder: (_, __) => const SizedBox(
                                        width: TSizes.spaceBtwItems),
                                  ),
                                )
                              ],
                            );
                          });
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
