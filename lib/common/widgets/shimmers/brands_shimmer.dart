// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:t_store_e_com/common/widgets/layout/product_grid_layout.dart';
import 'package:t_store_e_com/common/widgets/shimmers/shimmer.dart';

class BrandsShimmer extends StatelessWidget {
  const BrandsShimmer({
    super.key,
    this.itemCount = 4,
  });

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return ProductsGridLayout(
      mainAxisExtent: 80,
      itemCount: itemCount,
      itembuilder: (context, index) =>
          const TShimmerEffect(width: 300, height: 80),
    );
  }
}
