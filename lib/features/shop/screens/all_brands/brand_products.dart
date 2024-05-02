import 'package:flutter/material.dart';
import 'package:t_store_e_com/common/widgets/appbar/custom_appbar.dart';
import 'package:t_store_e_com/common/widgets/brands/brand_card.dart';
import 'package:t_store_e_com/common/widgets/products/sortable/sortable_products.dart';
import 'package:t_store_e_com/common/widgets/shimmers/vertical_product_shimmer.dart';
import 'package:t_store_e_com/features/shop/controllers/brand_controller.dart';
import 'package:t_store_e_com/features/shop/models/brand_model.dart';
import 'package:t_store_e_com/utils/constants/sizes.dart';
import 'package:t_store_e_com/utils/helpers/cloud_helper_functions.dart';

class BrandProducts extends StatelessWidget {
  const BrandProducts({super.key, required this.brand});

  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(brand.name),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              BrandCard(
                showBoarder: true,
                brand: brand,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
              FutureBuilder(
                future: controller.getBrandProducts(id: brand.id),
                builder: (context, snapshot) {
                  const loader = VerticalProductShimmer();

                  final widget = TCloudHelperFunctions.checkMultiRecordState(
                      snapshot: snapshot, loader: loader);
                  if (widget != null) return widget;

                  final brandProducts = snapshot.data!;
                  return SortableListProducts(
                    products: brandProducts,
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
