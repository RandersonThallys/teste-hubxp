// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:teste_hub/src/core/theme/colors.dart';

class TimeFilterWidget extends StatelessWidget {
  const TimeFilterWidget({
    Key? key,
    required this.label,
    required this.onPressed,
    required this.selected,
  }) : super(key: key);
  final String label;
  final Function(bool) onPressed;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(label,
          style: TextStyle(color: selected ? Colors.white : AppColors().grey2)),
      selectedColor: AppColors().darkIndigo,
      showCheckmark: false,
      padding: EdgeInsets.zero,
      selected: selected,
      onSelected: onPressed,
    );
  }
}
