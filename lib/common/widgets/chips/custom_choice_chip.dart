import 'package:flutter/material.dart';
import 'package:t_store_e_com/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:t_store_e_com/utils/constants/colors.dart';
import 'package:t_store_e_com/utils/helpers/helper_functions.dart';

class CustomChoiceChip extends StatelessWidget {
  const CustomChoiceChip({
    super.key,
    required this.text,
    required this.selected,
    this.onSelected,
  });

  final String text;
  final bool selected;
  final void Function(bool)? onSelected;

  @override
  Widget build(BuildContext context) {
    final colorFound = THelperFunctions.getColor(text) != null;
    return Theme(
      data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
      child: ChoiceChip(
        label: colorFound ? const SizedBox() : Text(text),
        selected: selected,
        onSelected: onSelected,
        labelStyle: TextStyle(color: selected ? TColors.white : null),
        avatar: colorFound
            ? RoundedContainer(
                width: 50,
                height: 50,
                backgroundColor: THelperFunctions.getColor(text)!,
              )
            : null,
        shape: colorFound ? const CircleBorder() : null,
        backgroundColor: colorFound ? THelperFunctions.getColor(text) : null,
        selectedColor: colorFound ? THelperFunctions.getColor(text) : null,
        labelPadding: colorFound ? EdgeInsets.zero : null,
        padding: colorFound ? EdgeInsets.zero : null,
      ),
    );
  }
}
