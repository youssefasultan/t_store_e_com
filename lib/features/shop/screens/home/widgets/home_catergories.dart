import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:t_store_e_com/common/widgets/shimmers/category_shimmer.dart';
import 'package:t_store_e_com/common/widgets/texts/vertical_image_text_widget.dart';
import 'package:t_store_e_com/features/shop/controllers/category_controller.dart';
import 'package:t_store_e_com/features/shop/screens/sub_category/sub_category.dart';

class HomeCategories extends StatelessWidget {
  const HomeCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.put(CategoryController());
    return Obx(() {
      if (categoryController.isLoading.value) {
        return const CategoryShimmer();
      }

      if (categoryController.featuredCategories.isEmpty) {
        return Center(
          child: Text(
            'No data found',
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .apply(color: Colors.white),
          ),
        );
      }

      return SizedBox(
        height: 82,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: categoryController.featuredCategories.length,
          itemBuilder: (_, index) {
            final category = categoryController.featuredCategories[index];
            return VerticalImageText(
              image: category.image,
              title: category.name,
              onTap: () => Get.to(() => SubCategoryScreen(category: category)),
            );
          },
        ),
      );
    });
  }
}
