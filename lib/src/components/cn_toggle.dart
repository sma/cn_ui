import 'package:material_ui/material_ui.dart';

import '../theme/cn_theme.dart';
import 'cn_button_group.dart';

/// Visual style variants for [CnToggle].
enum CnToggleVariant { standard, outline }

/// Size variants for [CnToggle].
enum CnToggleSize { sm, md, lg }

/// A button with an on and an off state.
///
/// A `null` [onChanged] disables it. Inside a [CnButtonGroup], it adapts its
/// corners to its position in the group.
///
/// See also:
///
///  * [CnToggleGroup], which groups multiple toggle buttons together.
///  * [CnSwitch], for a switch-style toggle.
///  * [CnCheckbox], for checkbox-style selection.
class const CnToggle({
  super.key,
  required final bool value,
  final ValueChanged<bool>? onChanged,
  required final Widget child,
  final Widget? leading,
  final Widget? trailing,
  final CnToggleVariant variant = .standard,
  final CnToggleSize size = .md,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = CnTheme.of(context);
    final colors = theme.colors;
    final enabled = onChanged != null;
    final states = {if (!enabled) WidgetState.disabled};
    final radius =
        (CnButtonGroup.of(context)?.borderRadius(theme.radii.md) ??
                BorderRadius.circular(theme.radii.md))
            .resolve(Directionality.of(context));
    final foreground = value ? colors.accentForeground : colors.foreground;
    final height = switch (size) {
      .sm => 32.0,
      .md => 36.0,
      .lg => 40.0,
    };

    return Material(
      type: .transparency,
      child: InkWell(
        borderRadius: radius,
        onTap: enabled ? () => onChanged!(!value) : null,
        child: Container(
          padding: const .symmetric(horizontal: 8),
          constraints: BoxConstraints(minHeight: height, minWidth: height),
          decoration: BoxDecoration(
            color: value ? colors.accent : null,
            borderRadius: radius,
            border: variant == .outline
                ? Border.all(color: colors.input.resolve(states))
                : null,
          ),
          child: DefaultTextStyle.merge(
            style: theme.text.sm.medium.copyWith(
              color: foreground.resolve(states),
            ),
            child: IconTheme.merge(
              data: IconThemeData(color: foreground.resolve(states), size: 16),
              child: Center(
                widthFactor: 1,
                child: Row(
                  mainAxisSize: .min,
                  spacing: 8,
                  children: [?leading, child, ?trailing],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
