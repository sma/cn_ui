import 'package:material_ui/material_ui.dart';

import '../theme/cn_theme.dart';

/// Visual style variants for [CnTabs].
enum CnTabsVariant { standard, line }

/// Shows one of several panels, selected through a list of triggers.
///
/// [value] is the [CnTab.value] of the selected tab.
///
/// See also:
///
///  * [CnToggleGroup], for selection without panels.
class const CnTabs<T>({
  super.key,
  required final List<CnTab<T>> tabs,
  required final T value,
  final ValueChanged<T>? onChanged,
  final CnTabsVariant variant = .standard,
  final Axis direction = .horizontal,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = CnTheme.of(context);
    final triggers = Flex(
      direction: direction,
      mainAxisSize: .min,
      crossAxisAlignment: direction == .horizontal ? .center : .stretch,
      spacing: variant == .line ? 8 : 0,
      children: [
        for (final tab in tabs)
          _CnTabTrigger(
            selected: tab.value == value,
            variant: variant,
            onTap: tab.enabled && onChanged != null
                ? () => onChanged!(tab.value)
                : null,
            child: tab.label,
          ),
      ],
    );
    final list = variant == .standard
        ? Container(
            padding: const .all(3),
            decoration: BoxDecoration(
              color: theme.colors.muted,
              borderRadius: .circular(theme.radii.lg),
            ),
            child: triggers,
          )
        : triggers;
    final content = DefaultTextStyle.merge(
      style: theme.text.sm,
      child: tabs.firstWhere((tab) => tab.value == value).content,
    );

    if (direction == .vertical) {
      return Row(
        crossAxisAlignment: .start,
        spacing: 16,
        children: [
          list,
          Expanded(child: content),
        ],
      );
    }
    return Column(
      crossAxisAlignment: .start,
      spacing: 8,
      children: [list, content],
    );
  }
}

/// A tab in [CnTabs], identified by its [value].
class const CnTab<T>({
  required final T value,
  required final Widget label,
  required final Widget content,
  final bool enabled = true,
});

class const _CnTabTrigger({
  required final bool selected,
  required final CnTabsVariant variant,
  required final VoidCallback? onTap,
  required final Widget child,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = CnTheme.of(context);
    final colors = theme.colors;
    final states = {if (onTap == null) WidgetState.disabled};
    final foreground = selected ? colors.foreground : colors.mutedForeground;
    final isStandard = variant == .standard;

    return Semantics(
      selected: selected,
      button: true,
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: onTap,
          hoverColor: Colors.transparent,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            alignment: .center,
            padding: const .symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: isStandard && selected ? colors.background : null,
              borderRadius: isStandard ? .circular(theme.radii.md) : null,
              border: isStandard
                  ? null
                  : Border(
                      bottom: BorderSide(
                        width: 2,
                        color: selected
                            ? colors.foreground
                            : Colors.transparent,
                      ),
                    ),
            ),
            child: DefaultTextStyle.merge(
              style: theme.text.sm.medium.copyWith(
                color: foreground.resolve(states),
              ),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
