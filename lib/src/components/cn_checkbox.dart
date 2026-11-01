import 'package:flutter/widget_previews.dart';
import 'package:material_ui/material_ui.dart';

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
      spacing: 16,
      crossAxisAlignment: .start,
      children: [
        CnCheckbox(value: true, onChanged: (_) {}, label: Text('Label (on)')),
        CnCheckbox(value: false, onChanged: (_) {}, label: Text('Label (off)')),
        CnCheckbox(value: true, label: Text('Label (disabled on)')),
        CnCheckbox(value: false, label: Text('Label (disabled off)')),
      ],
    );
  }
}
