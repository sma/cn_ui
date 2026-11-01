import 'package:flutter/widgets.dart';

/// Role variants for [CnMenuAction].
enum CnMenuRole { standard, destructive }

/// An entry in a [CnDropdownMenu], [CnContextMenu] or [CnMenubar].
sealed class CnMenuEntry {
  const CnMenuEntry();
}

/// An action. A `null` [onSelected] disables it.
class const CnMenuAction({
  required final Widget label,
  final VoidCallback? onSelected,
  final Widget? leading,
  final Widget? trailing,
  final MenuSerializableShortcut? shortcut,
  final CnMenuRole role = .standard,
  final bool closeOnActivate = true,
}) extends CnMenuEntry;

/// A checkbox. A `null` [onChanged] disables it.
class const CnMenuCheckboxItem({
  required final Widget label,
  required final bool value,
  final ValueChanged<bool>? onChanged,
  final bool closeOnActivate = false,
}) extends CnMenuEntry;

/// A radio button. A `null` [onChanged] disables it.
class const CnMenuRadioItem<T>({
  required final Widget label,
  required final T value,
  required final T? groupValue,
  final ValueChanged<T>? onChanged,
  final bool closeOnActivate = false,
}) extends CnMenuEntry {
  bool get isSelected => value == groupValue;

  bool get isEnabled => onChanged != null;

  void select() => onChanged?.call(value);
}

/// A line between entries.
class const CnMenuSeparator() extends CnMenuEntry;

/// An entry that opens further [entries].
class const CnMenuSubmenu({
  required final Widget label,
  required final List<CnMenuEntry> entries,
  final Widget? leading,
  final Widget? trailing,
}) extends CnMenuEntry;
