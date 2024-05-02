import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store_e_com/common/widgets/appbar/custom_appbar.dart';
import 'package:t_store_e_com/common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import 'package:t_store_e_com/common/widgets/images/rounded_image.dart';
import 'package:t_store_e_com/common/widgets/products/fav_icon/favorite_icon.dart';
import 'package:t_store_e_com/features/shop/controllers/product/images_controller.dart';
import 'package:t_store_e_com/features/shop/models/product_model.dart';
import 'package:t_store_e_com/utils/constants/colors.dart';
import 'package:t_store_e_com/utils/constants/sizes.dart';
import 'package:t_store_e_com/utils/helpers/helper_functions.dart';

class ImageSlider extends StatelessWidget {
  const ImageSlider({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(ImageController());
    final images = controller.getAllProductImages(product);
    return CurvedEdgesWidget(
      child: Container(
        color: isDark ? TColors.darkerGrey : TColors.light,
        child: Stack(
          children: [
            // main image
            SizedBox(
              height: 400,
              child: Padding(
                padding: const EdgeInsets.all(TSizes.productImageRadius * 2),
                child: Center(
                  child: Obx(() {
                    final image = controller.selectedImg.value;
                    return GestureDetector(
                      onTap: () => controller.showEnlaredImage(image),
                      child: CachedNetworkImage(
                        imageUrl: image,
                        progressIndicatorBuilder: (_, __, progress) => Center(
                          child: CircularProgressIndicator(
                            value: progress.progress,
                            color: TColors.primary,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),

            // image slider
            Positioned(
              right: 0,
              bottom: 30,
              left: TSizes.defaultSpace,
              child: SizedBox(
                height: 80,
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: images.length,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (_, index) => Obx(() {
                    final imgSelected =
                        controller.selectedImg.value == images[index];
                    return RoundedImage(
                      width: 80,
                      imageUrl: images[index],
                      border: Border.all(color:imgSelected ? TColors.primary : Colors.transparent),
                      padding: const EdgeInsets.all(TSizes.sm),
                      backgroundColor: isDark ? TColors.dark : TColors.white,
                      isNetworkImage: true,
                      onPressed: () => controller.selectedImg.value = images[index],
                    );
                  }),
                  separatorBuilder: (_, index) => const SizedBox(
                    width: TSizes.spaceBtwItems,
                  ),
                ),
              ),
            ),

            // appbar
             CustomAppBar(
              showBackArrow: true,
              actions: [
                FavoriteIcon(productId: product.id)
              ],
            )
          ],
        ),
      ),
    );
  }
}
