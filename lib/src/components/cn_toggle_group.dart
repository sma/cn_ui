import 'package:material_ui/material_ui.dart';

import 'cn_button_group.dart';
import 'cn_toggle.dart';

/// A group of toggle buttons for single or multiple selection.
///
/// A [spacing] of zero connects the buttons to one control. With [required],
/// the last selected item cannot be deselected.
///
/// See also:
///
///  * [CnToggle], for individual toggle buttons.
///  * [CnRadioGroup], for single-selection radio buttons.
class const CnToggleGroup<T>({
  super.key,
  required final List<CnToggleGroupItem<T>> items,
  required final Set<T> value,
  final ValueChanged<Set<T>>? onChanged,
  final bool multiple = false,
  final bool required = false,
  final Axis direction = .horizontal,
  final CnToggleVariant variant = .standard,
  final CnToggleSize size = .md,
  final double spacing = 8,
}) extends StatelessWidget {
  void _handleChanged(T item, bool selected) {
    if (!selected && required && value.length <= 1) {
      return;
    }
    onChanged?.call(
      selected
          ? (multiple ? {...value, item} : {item})
          : ({...value}..remove(item)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final toggles = [
      for (final item in items)
        CnToggle(
          value: value.contains(item.value),
          onChanged: item.enabled && onChanged != null
              ? (selected) => _handleChanged(item.value, selected)
              : null,
          variant: variant,
          size: size,
          child: item.child,
        ),
    ];

    if (spacing == 0) {
      return CnButtonGroup(direction: direction, children: toggles);
    }
    return Wrap(
      direction: direction,
      spacing: spacing,
      runSpacing: spacing,
      children: toggles,
    );
  }
}

/// An item in a [CnToggleGroup], identified by its [value].
class const CnToggleGroupItem<T>({
  required final T value,
  required final Widget child,
  final bool enabled = true,
});
