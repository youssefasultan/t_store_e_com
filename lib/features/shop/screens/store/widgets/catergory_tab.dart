import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:t_store_e_com/common/widgets/layout/product_grid_layout.dart';
import 'package:t_store_e_com/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:t_store_e_com/common/widgets/shimmers/vertical_product_shimmer.dart';
import 'package:t_store_e_com/common/widgets/texts/seaction_header.dart';
import 'package:t_store_e_com/features/shop/controllers/category_controller.dart';
import 'package:t_store_e_com/features/shop/models/category_model.dart';
import 'package:t_store_e_com/features/shop/screens/all_products/all_products.dart';
import 'package:t_store_e_com/features/shop/screens/store/widgets/category_brands.dart';
import 'package:t_store_e_com/utils/constants/sizes.dart';
import 'package:t_store_e_com/utils/helpers/cloud_helper_functions.dart';

class CategoryTab extends StatelessWidget {
  const CategoryTab({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              // brands
              CategoryBrands(category: category),
              const SizedBox(height: TSizes.spaceBtwItems),

              // prducts
              FutureBuilder(
                  future: controller.getCategoryProducts(
                      categoryId: category.id, limit: 4),
                  builder: (context, snapshot) {
                    final widget = TCloudHelperFunctions.checkMultiRecordState(
                        snapshot: snapshot,
                        loader: const VerticalProductShimmer());
                    if (widget != null) return widget;

                    final products = snapshot.data!;

                    return Column(
                      children: [
                        SectionHeader(
                          title: 'You might like',
                          onActionButtonPressed: () => Get.to(AllProductsScreen(
                            title: category.name,
                            futureMethod: controller.getCategoryProducts(
                              categoryId: category.id,
                            ),
                          )),
                        ),
                        const SizedBox(height: TSizes.spaceBtwItems),
                        ProductsGridLayout(
                          itemCount: products.length,
                          itembuilder: (_, index) => VerticalProductCard(
                            product: products[index],
                          ),
                        ),
                      ],
                    );
                  }),

              const SizedBox(height: TSizes.spaceBtwSections),
            ],
          ),
        ),
      ],
    );
  }
}
