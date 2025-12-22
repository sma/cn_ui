import 'package:flutter/material.dart';

import '../../cn_ui.dart';

/// Base class for entries in a [CnNativeSelect].
sealed class CnNativeSelectEntry<T> {
  const CnNativeSelectEntry();
}

/// A single selectable option in a [CnNativeSelect].
class CnNativeSelectOption<T> extends CnNativeSelectEntry<T> {
  final T value;
  final String label;
  final bool enabled;

  const CnNativeSelectOption({
    required this.value,
    required this.label,
    this.enabled = true,
  });
}

/// A group of options in a [CnNativeSelect].
class CnNativeSelectOptGroup<T> extends CnNativeSelectEntry<T> {
  final String label;
  final List<CnNativeSelectOption<T>> options;

  const CnNativeSelectOptGroup({required this.label, required this.options});
}

/// Size variants for [CnNativeSelect].
enum CnNativeSelectSize { sm, md }

/// A dropdown select component with support for option groups and sizing.
///
/// Provides a more feature-rich select than [CnSelect] with option groups and size variants.
///
/// See also:
///
///  * [CnSelect], for a simpler select component.
///  * [CnCombobox], for a searchable select component.
class CnNativeSelect<T extends Object?> extends StatelessWidget {
  final List<CnNativeSelectEntry<T>> entries;
  final T? value;
  final ValueChanged<T?>? onChanged;
  final String? placeholder;
  final bool isExpanded;
  final CnNativeSelectSize size;

  const CnNativeSelect({
    super.key,
    required this.entries,
    this.value,
    this.onChanged,
    this.placeholder,
    this.isExpanded = true,
    this.size = .md,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      key: ValueKey(value),
      initialValue: value,
      items: _buildItems(context),
      onChanged: onChanged,
      isExpanded: isExpanded,
      decoration: InputDecoration(
        hintText: placeholder,
        contentPadding: _paddingFor(size),
      ),
    );
  }

  List<DropdownMenuItem<T>> _buildItems(BuildContext context) {
    final items = <DropdownMenuItem<T>>[];
    for (final entry in entries) {
      if (entry is CnNativeSelectOption<T>) {
        items.add(
          DropdownMenuItem<T>(
            value: entry.value,
            enabled: entry.enabled,
            child: Text(entry.label),
          ),
        );
      } else if (entry is CnNativeSelectOptGroup<T>) {
        items.add(
          DropdownMenuItem<T>(
            value: null,
            enabled: false,
            child: Text(
              entry.label,
              style: CnTheme.textThemeOf(context).bodySmall?.copyWith(
                fontWeight: .w600,
                color: CnTheme.colorSchemeOf(context).onSurfaceVariant,
              ),
            ),
          ),
        );
        for (final option in entry.options) {
          items.add(
            DropdownMenuItem<T>(
              value: option.value,
              enabled: option.enabled,
              child: Text(option.label),
            ),
          );
        }
      }
    }
    return items;
  }

  EdgeInsets _paddingFor(CnNativeSelectSize size) {
    return switch (size) {
      .sm => const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      .md => const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    };
  }
}
