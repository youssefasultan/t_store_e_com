import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store_e_com/common/widgets/appbar/custom_appbar.dart';
import 'package:t_store_e_com/common/widgets/brands/brand_card.dart';
import 'package:t_store_e_com/common/widgets/layout/product_grid_layout.dart';
import 'package:t_store_e_com/common/widgets/shimmers/brands_shimmer.dart';

import 'package:t_store_e_com/common/widgets/texts/seaction_header.dart';
import 'package:t_store_e_com/features/shop/controllers/brand_controller.dart';
import 'package:t_store_e_com/features/shop/screens/all_brands/brand_products.dart';
import 'package:t_store_e_com/utils/constants/sizes.dart';

class AllBrandsScreen extends StatelessWidget {
  const AllBrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    return Scaffold(
      appBar: const CustomAppBar(
        title: Text('All Brands'),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              const SectionHeader(title: 'Brands'),
              const SizedBox(height: TSizes.spaceBtwItems),
              // brands

              Obx(() {
                if (controller.isLoading.value) {
                  return const BrandsShimmer();
                }

                if (controller.allBrands.isEmpty) {
                  return Center(
                    child: Text(
                      'No featured brands found',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  );
                }

                return ProductsGridLayout(
                  itemCount: controller.allBrands.length,
                  mainAxisExtent: 80,
                  itembuilder: (_, index) {
                    final brand = controller.allBrands[index];
                    return BrandCard(
                      showBoarder: true,
                      brand: brand,
                      onPressed: () => Get.to(() => BrandProducts(
                            brand: brand,
                          )),
                    );
                  },
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
