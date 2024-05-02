import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store_e_com/common/widgets/appbar/custom_appbar.dart';
import 'package:t_store_e_com/common/widgets/appbar/tabbar.dart';
import 'package:t_store_e_com/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:t_store_e_com/common/widgets/layout/product_grid_layout.dart';
import 'package:t_store_e_com/common/widgets/products/cart/cart_counter_icon_button.dart';
import 'package:t_store_e_com/common/widgets/brands/brand_card.dart';
import 'package:t_store_e_com/common/widgets/shimmers/brands_shimmer.dart';
import 'package:t_store_e_com/common/widgets/texts/seaction_header.dart';
import 'package:t_store_e_com/features/shop/controllers/brand_controller.dart';
import 'package:t_store_e_com/features/shop/controllers/category_controller.dart';
import 'package:t_store_e_com/features/shop/screens/all_brands/all_brands.dart';
import 'package:t_store_e_com/features/shop/screens/all_brands/brand_products.dart';
import 'package:t_store_e_com/features/shop/screens/store/widgets/catergory_tab.dart';
import 'package:t_store_e_com/utils/constants/colors.dart';
import 'package:t_store_e_com/utils/constants/sizes.dart';
import 'package:t_store_e_com/utils/helpers/helper_functions.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    final categories = CategoryController.instance.featuredCategories;
    final brandController = Get.put(BrandController());

    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        appBar: CustomAppBar(
          title: Text(
            'Store',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          actions: const [
            CartCounterIconButton(),
          ],
        ),
        body: NestedScrollView(
          headerSliverBuilder: (_, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                pinned: true,
                floating: true,
                backgroundColor: isDark ? TColors.black : TColors.white,
                expandedHeight: 440,
                automaticallyImplyLeading: false,
                flexibleSpace: Padding(
                  padding: const EdgeInsets.all(TSizes.defaultSpace),
                  child: ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: [
                      // search bar
                      const SizedBox(height: TSizes.spaceBtwItems),
                      const SearchContainer(
                        title: 'Search in Store',
                        showBorder: true,
                        showBackground: false,
                        padding: EdgeInsets.zero,
                      ),
                      const SizedBox(height: TSizes.spaceBtwSections),

                      // featured brands
                      SectionHeader(
                        title: 'Featured Brands',
                        showActionButton: true,
                        onActionButtonPressed: () =>
                            Get.to(() => const AllBrandsScreen()),
                      ),
                      const SizedBox(height: TSizes.spaceBtwItems / 1.5),

                      Obx(() {
                        if (brandController.isLoading.value) {
                          return const BrandsShimmer();
                        }

                        if (brandController.featuredBrands.isEmpty) {
                          return Center(
                            child: Text(
                              'No featured brands found',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          );
                        }

                        return ProductsGridLayout(
                          itemCount: brandController.featuredBrands.length,
                          mainAxisExtent: 80,
                          itembuilder: (_, index) {
                            final brand = brandController.featuredBrands[index];
                            return BrandCard(
                              showBoarder: true,
                              brand: brand,
                              onPressed: () => Get.to(() => BrandProducts(
                                    brand: brand,
                                  )),
                            );
                          },
                        );
                      }),
                    ],
                  ),
                ),
                //tabs
                bottom: CustomTabBar(
                  tabs: categories
                      .map((category) => Tab(child: Text(category.name)))
                      .toList(),
                ),
              ),
            ];
          },
          body: TabBarView(
            children: categories
                .map((category) => CategoryTab(category: category))
                .toList(),
          ),
        ),
      ),
    );
  }
}
