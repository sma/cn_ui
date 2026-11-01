import 'package:material_ui/material_ui.dart';

import '../theme/cn_theme.dart';
import 'cn_field.dart';

/// Size variants for [CnSelect].
enum CnSelectSize { sm, md }

/// An entry in the list of a [CnSelect].
sealed class CnSelectEntry<T> {
  const CnSelectEntry();
}

/// A selectable option.
class const CnSelectItem<T>({
  required final T value,
  required final Widget child,
  final bool enabled = true,
}) extends CnSelectEntry<T>;

/// A labeled group of options.
class const CnSelectGroup<T>({
  required final Widget label,
  required final List<CnSelectItem<T>> items,
}) extends CnSelectEntry<T>;

/// A dropdown for choosing one value from a list.
///
/// A `null` [onChanged] disables it. With a [validator], it takes part in the
/// validation of an enclosing [CnForm].
///
/// See also:
///
///  * [CnCombobox], for a searchable select component.
class const CnSelect<T>({
  super.key,
  required final List<CnSelectEntry<T>> items,
  final T? value,
  final ValueChanged<T?>? onChanged,
  final String? placeholder,
  final FormFieldValidator<T>? validator,
  final bool expand = true,
  final CnSelectSize size = .md,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = CnTheme.of(context);
    final hasError = CnField.hasError(context);

    return DropdownButtonFormField<T>(
      key: ValueKey(value),
      initialValue: value,
      items: _buildItems(theme),
      onChanged: onChanged,
      validator: validator,
      isExpanded: expand,
      isDense: true,
      forceErrorText: hasError ? '' : null,
      style: theme.text.sm.copyWith(color: theme.colors.foreground),
      borderRadius: .circular(theme.radii.md),
      dropdownColor: theme.colors.popover,
      icon: Icon(
        Icons.expand_more,
        size: 16,
        color: theme.colors.mutedForeground,
      ),
      decoration: InputDecoration(
        hintText: placeholder,
        contentPadding: size == .sm
            ? const EdgeInsets.symmetric(horizontal: 12, vertical: 6)
            : null,
        // The field shows the message, so only the border changes here.
        errorStyle: hasError ? const TextStyle(fontSize: 0, height: 0) : null,
      ),
    );
  }

  List<DropdownMenuItem<T>> _buildItems(CnTheme theme) {
    DropdownMenuItem<T> option(CnSelectItem<T> item) {
      return DropdownMenuItem<T>(
        value: item.value,
        enabled: item.enabled,
        child: item.child,
      );
    }

    return [
      for (final entry in items)
        ...switch (entry) {
          CnSelectItem<T>() => [option(entry)],
          CnSelectGroup<T>() => [
            DropdownMenuItem<T>(
              enabled: false,
              child: DefaultTextStyle.merge(
                style: theme.text.xs.copyWith(
                  color: theme.colors.mutedForeground,
                ),
                child: entry.label,
              ),
            ),
            for (final item in entry.items) option(item),
          ],
        },
    ];
  }
}
