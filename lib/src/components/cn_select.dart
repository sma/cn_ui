import 'package:flutter/material.dart';

/// A dropdown select component that wraps Flutter's DropdownButtonFormField.
///
/// Provides a simple interface for selecting a single value from a list of options.
///
/// See also:
///
///  * [CnNativeSelect], which provides a more feature-rich select with option groups.
///  * [CnCombobox], for a searchable select component.
class CnSelect<T> extends StatelessWidget {
  final List<DropdownMenuItem<T>> items;
  final T? value;
  final ValueChanged<T?>? onChanged;
  final String? placeholder;
  final bool isExpanded;

  const CnSelect({
    super.key,
    required this.items,
    this.value,
    this.onChanged,
    this.placeholder,
    this.isExpanded = true,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      key: ValueKey(value),
      initialValue: value,
      items: items,
      onChanged: onChanged,
      isExpanded: isExpanded,
      decoration: InputDecoration(hintText: placeholder),
    );
  }
}
