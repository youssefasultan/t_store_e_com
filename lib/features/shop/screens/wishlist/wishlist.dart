import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store_e_com/common/widgets/appbar/custom_appbar.dart';
import 'package:t_store_e_com/common/widgets/icons/circular_icon.dart';
import 'package:t_store_e_com/common/widgets/layout/product_grid_layout.dart';
import 'package:t_store_e_com/common/widgets/loaders/animation_loader.dart';
import 'package:t_store_e_com/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:t_store_e_com/common/widgets/shimmers/vertical_product_shimmer.dart';
import 'package:t_store_e_com/features/shop/controllers/product/favorites_controller.dart';
import 'package:t_store_e_com/features/shop/screens/home/home.dart';
import 'package:t_store_e_com/navigation_menu.dart';
import 'package:t_store_e_com/utils/constants/image_strings.dart';
import 'package:t_store_e_com/utils/constants/sizes.dart';
import 'package:t_store_e_com/utils/helpers/cloud_helper_functions.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = FavoritesController.instance;
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(
          'Wishlist',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          CircularIcon(
            icon: Iconsax.add,
            onPressed: () => Get.to(const HomeScreen()),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Obx(
            () => FutureBuilder(
                future: controller.favoriteProducts(),
                builder: (context, snapshot) {
                  const loader = VerticalProductShimmer(itemCount: 6);
                  final widget = TCloudHelperFunctions.checkMultiRecordState(
                    snapshot: snapshot,
                    loader: loader,
                    nothingFound: TAnimationLoaderWidget(
                      text: 'Whoops!! Whishlist is empty',
                      animation: TImages.pencilAnimation,
                      showAction: true,
                      actionText: 'Let\'s add some products',
                      onActionPressed: () =>
                          Get.off(() => const NavigationMenu()),
                    ),
                  );
                  if (widget != null) return widget;

                  final products = snapshot.data!;
                  return ProductsGridLayout(
                    itemCount: products.length,
                    itembuilder: (_, index) => VerticalProductCard(
                      product: products[index],
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }
}
