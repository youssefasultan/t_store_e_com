import 'package:flutter/material.dart';
import 'package:t_store_e_com/common/widgets/brands/brand_showcase.dart';
import 'package:t_store_e_com/common/widgets/shimmers/boxes_shimmer.dart';
import 'package:t_store_e_com/common/widgets/shimmers/list_tile_shimmer.dart';
import 'package:t_store_e_com/features/shop/controllers/brand_controller.dart';
import 'package:t_store_e_com/features/shop/models/category_model.dart';
import 'package:t_store_e_com/utils/constants/sizes.dart';
import 'package:t_store_e_com/utils/helpers/cloud_helper_functions.dart';

class CategoryBrands extends StatelessWidget {
  const CategoryBrands({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    return FutureBuilder(
      future: controller.getBrandsForCategory(category.id),
      builder: (context, snapshot) {
        const loader = Column(
          children: [
            ListTileShimmer(),
            SizedBox(height: TSizes.spaceBtwItems),
            BoxesShimmer(),
            SizedBox(height: TSizes.spaceBtwItems),
          ],
        );

        final widget = TCloudHelperFunctions.checkMultiRecordState(
            snapshot: snapshot, loader: loader);
        if (widget != null) return widget;

        final brands = snapshot.data!;
        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: brands.length,
          itemBuilder: (_, index) {
            final brand = brands[index];

            return FutureBuilder(
              future: controller.getBrandProducts(id: brand.id, limit: 3),
              builder: (context, snapshot) {
                final widget = TCloudHelperFunctions.checkMultiRecordState(
                    snapshot: snapshot, loader: loader);
                if (widget != null) return widget;

                final products = snapshot.data!;

                return BrandShowCase(
                    images: products.map((e) => e.thumbnail).toList(),
                    brand: brand);
              },
            );
          },
        );
      },
    );
  }
}
