import 'package:flutter/material.dart';
import 'package:t_store_e_com/utils/constants/colors.dart';

class TShadowStyle {
  static final verticalShadowStyle = BoxShadow(
    color: TColors.darkGrey.withOpacity(0.1),
    blurRadius: 50,
    spreadRadius: 7,
    offset: const Offset(0, 2),
  );

  static final horizontalShadowStyle = BoxShadow(
    color: TColors.darkGrey.withOpacity(0.1),
    blurRadius: 50,
    spreadRadius: 7,
    offset: const Offset(0, 2),
  );
}
