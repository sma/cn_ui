import 'package:flutter/widget_previews.dart';
import 'package:material_ui/material_ui.dart';

import '../theme/cn_theme.dart';

/// A checkbox with an optional label. A `null` [onChanged] disables it.
class const CnCheckbox({
  super.key,
  required final bool value,
  final ValueChanged<bool>? onChanged,
  final Widget? label,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = CnTheme.of(context);
    final states = {if (onChanged == null) WidgetState.disabled};

    return Row(
      mainAxisSize: .min,
      spacing: 8,
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged == null
              ? null
              : (next) => onChanged!(next ?? false),
        ),
        if (label != null)
          Flexible(
            child: DefaultTextStyle.merge(
              style: theme.text.sm.medium.copyWith(
                color: theme.colors.foreground.resolve(states),
              ),
              child: label!,
            ),
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
