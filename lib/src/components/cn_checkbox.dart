import 'package:flutter/material.dart';

class CnCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?>? onChanged;
  final Widget? label;

  const CnCheckbox({
    super.key,
    required this.value,
    this.onChanged,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: .min,
      spacing: 8,
      children: [
        Checkbox(value: value, onChanged: onChanged),
        if (label != null) Flexible(child: label!),
      ],
    );
  }
}
