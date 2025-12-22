import 'package:flutter/material.dart';

class CnRadioGroup<T> extends StatelessWidget {
  final T? groupValue;
  final ValueChanged<T?> onChanged;
  final Widget child;

  const CnRadioGroup({
    super.key,
    required this.groupValue,
    required this.onChanged,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return RadioGroup<T>(
      groupValue: groupValue,
      onChanged: onChanged,
      child: child,
    );
  }
}

class CnRadio<T> extends StatelessWidget {
  final T value;
  final bool? enabled;
  final Widget? label;

  const CnRadio({super.key, required this.value, this.enabled, this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: .min,
      spacing: 8,
      children: [
        Radio<T>(value: value, enabled: enabled),
        if (label != null) Flexible(child: label!),
      ],
    );
  }
}
