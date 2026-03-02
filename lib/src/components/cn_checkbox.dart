import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

class CnCheckbox extends StatelessWidget {
  const CnCheckbox({
    super.key,
    required this.value,
    this.onChanged,
    this.label,
  });
  final bool value;
  final ValueChanged<bool?>? onChanged;
  final Widget? label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: .min,
      spacing: 8,
      children: [
        Checkbox(value: value, onChanged: onChanged),
        if (label != null)
          DefaultTextStyle.merge(
            style: TextStyle(
              color: onChanged != null ? null : Theme.of(context).disabledColor,
            ),
            child: Flexible(child: label!),
          ),
      ],
    );
  }

  @Preview()
  static Widget preview() {
    return Column(
      children: [
        CnCheckbox(value: true, onChanged: (_) {}, label: Text('Label')),
        CnCheckbox(value: false, onChanged: (_) {}, label: Text('Label')),
        CnCheckbox(value: true, label: Text('Label')),
        CnCheckbox(value: false, label: Text('Label')),
      ],
    );
  }
}
