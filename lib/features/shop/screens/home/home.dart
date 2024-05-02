import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:t_store_e_com/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:t_store_e_com/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:t_store_e_com/common/widgets/layout/product_grid_layout.dart';
import 'package:t_store_e_com/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:t_store_e_com/common/widgets/shimmers/vertical_product_shimmer.dart';
import 'package:t_store_e_com/common/widgets/texts/seaction_header.dart';
import 'package:t_store_e_com/features/shop/controllers/product/product_controller.dart';
import 'package:t_store_e_com/features/shop/screens/all_products/all_products.dart';
import 'package:t_store_e_com/features/shop/screens/home/widgets/home_promo_slider.dart';
import 'package:t_store_e_com/utils/constants/colors.dart';
import 'package:t_store_e_com/utils/constants/sizes.dart';

import 'widgets/home_app_bar.dart';
import 'widgets/home_catergories.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // header
            const PrimaryHeaderContainer(
              child: Column(
                children: [
                  // appbar
                  HomeAppBar(),
                  SizedBox(height: TSizes.spaceBtwSections),

                  //search bar
                  SearchContainer(
                    title: 'Search in Store',
                  ),
                  SizedBox(height: TSizes.spaceBtwSections),

                  //catergories

                  Padding(
                    padding: EdgeInsets.only(left: TSizes.defaultSpace),
                    child: Column(
                      children: [
                        // seaction header
                        SectionHeader(
                          title: 'PopularCategories',
                          showActionButton: false,
                          textColor: TColors.white,
                        ),
                        SizedBox(height: TSizes.spaceBtwItems),
                        // categories listview
                        HomeCategories(),
                      ],
                    ),
                  ),

                  SizedBox(height: TSizes.spaceBtwSections),
                ],
              ),
            ),

            // body
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  // promo slider
                  const PromoSlider(),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  SectionHeader(
                    title: 'Popular Products',
                    onActionButtonPressed: () => Get.to(
                      () => AllProductsScreen(
                        title: 'Popular Products',
                        futureMethod: controller.fetchAllFeaturedProducts(),
                      ),
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  // popular products
                  Obx(
                    () {
                      if (controller.isLoading.value) {
                        return const VerticalProductShimmer(itemCount: 4);
                      }

                      if (controller.featuredProducts.isEmpty) {
                        return Center(
                          child: Text(
                            'No Products Found',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        );
                      }
                      return ProductsGridLayout(
                        itemCount: controller.featuredProducts.length,
                        itembuilder: (_, index) => VerticalProductCard(
                          product: controller.featuredProducts[index],
                        ),
                      );
                    },
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
