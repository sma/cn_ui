import 'package:material_ui/material_ui.dart';

import '../theme/cn_theme.dart';

/// Holds the selected [value] for the [CnRadio]s inside [child].
class const CnRadioGroup<T>({
  super.key,
  required final T? value,
  required final ValueChanged<T?> onChanged,
  required final Widget child,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RadioGroup<T>(groupValue: value, onChanged: onChanged, child: child);
  }
}

/// A radio button in a [CnRadioGroup].
class const CnRadio<T>({
  super.key,
  required final T value,
  final bool enabled = true,
  final Widget? label,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = CnTheme.of(context);
    final states = {if (!enabled) WidgetState.disabled};

    return Row(
      mainAxisSize: .min,
      spacing: 8,
      children: [
        Radio<T>(value: value, enabled: enabled),
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
}
