import 'package:flutter/material.dart';
import 'package:t_store_e_com/utils/constants/sizes.dart';

class ProductsGridLayout extends StatelessWidget {
  const ProductsGridLayout({
    super.key,
    required this.itemCount,
    this.mainAxisExtent = 288,
    required this.itembuilder,
  });

  final int itemCount;
  final double? mainAxisExtent;
  final Widget? Function(BuildContext context, int index) itembuilder;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: itemCount,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: TSizes.gridViewSpacing,
        crossAxisSpacing: TSizes.gridViewSpacing,
        mainAxisExtent: mainAxisExtent,
      ),
      itemBuilder: itembuilder,
    );
  }
}
