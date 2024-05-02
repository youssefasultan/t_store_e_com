import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:iconsax/iconsax.dart';
import 'package:t_store_e_com/common/widgets/layout/product_grid_layout.dart';
import 'package:t_store_e_com/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:t_store_e_com/features/shop/controllers/product/all_products_controller.dart';
import 'package:t_store_e_com/features/shop/models/product_model.dart';
import 'package:t_store_e_com/utils/constants/sizes.dart';

class SortableListProducts extends StatelessWidget {
  const SortableListProducts({
    super.key,
    required this.products,
  });

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllProductsController());
    controller.assignProducts(products);
    return Column(
      children: [
        //dropdown
        DropdownButtonFormField(
          decoration: const InputDecoration(prefixIcon: Icon(Iconsax.sort)),
          value: controller.selectedSortOption.value,
          items: ['Name', 'Higher Price', 'Lower Price', 'Newest', 'Sale']
              .map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(e),
                  ))
              .toList(),
          onChanged: (value) => controller.sortProducts(value!),
        ),
        const SizedBox(height: TSizes.spaceBtwSections),
        // products

        Obx(
          () => ProductsGridLayout(
            itemCount: controller.products.length,
            itembuilder: (_, index) => VerticalProductCard(
              product: controller.products[index],
            ),
          ),
        )
      ],
    );
  }
}
