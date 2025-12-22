import 'package:flutter/material.dart';

/// A toggle switch component with optional label.
///
/// Wraps Flutter's [Switch] widget with label support and consistent spacing.
///
/// See also:
///
///  * [CnCheckbox], for checkbox selections.
///  * [CnToggle], for toggle buttons.
///  * [Switch], the underlying Material widget.
class CnSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  final Widget? label;

  const CnSwitch({super.key, required this.value, this.onChanged, this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: .min,
      spacing: 8,
      children: [
        Switch(value: value, onChanged: onChanged),
        if (label != null) Flexible(child: label!),
      ],
    );
  }
}
