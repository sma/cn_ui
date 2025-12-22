import 'package:flutter/material.dart';

import '../theme/cn_theme.dart';
import 'cn_menu_styles.dart';

/// Role variants for [CnDropdownMenuAction].
enum CnDropdownMenuRole { standard, destructive }

/// A dropdown menu component triggered by a button or custom trigger.
///
/// Provides a menu overlay with actions, checkboxes, radio items, separators, and submenus.
///
/// See also:
///
///  * [CnContextMenu], for right-click context menus.
///  * [CnMenubar], for horizontal menu bars.
///  * [CnPopover], for simpler popover content.
class CnDropdownMenu extends StatelessWidget {
  final List<CnDropdownMenuEntry> entries;
  final Widget? trigger;
  final Widget Function(BuildContext context, MenuController controller)?
  triggerBuilder;
  final MenuStyle? style;
  final Offset? alignmentOffset;
  final double? menuWidth;

  const CnDropdownMenu({
    super.key,
    required this.entries,
    this.trigger,
    this.triggerBuilder,
    this.style,
    this.alignmentOffset,
    this.menuWidth,
  }) : assert(
         trigger != null || triggerBuilder != null,
         'Provide a trigger or triggerBuilder.',
       );

  @override
  Widget build(BuildContext context) {
    final resolvedStyle = style ?? cnMenuStyle(context, width: menuWidth);
    final menuItemStyle = cnMenuItemStyle(context);
    final submenuIcon = cnSubmenuIcon(context);

    return MenuTheme(
      data: MenuThemeData(style: resolvedStyle, submenuIcon: submenuIcon),
      child: MenuButtonTheme(
        data: MenuButtonThemeData(style: menuItemStyle),
        child: MenuAnchor(
          alignmentOffset: alignmentOffset ?? const Offset(0, 6),
          style: resolvedStyle,
          menuChildren: buildCnDropdownMenuEntries(
            context,
            entries,
            menuStyle: resolvedStyle,
            menuItemStyle: menuItemStyle,
          ),
          builder: (context, controller, child) {
            if (triggerBuilder != null) {
              return triggerBuilder!(context, controller);
            }
            return GestureDetector(
              onTap: () {
                if (controller.isOpen) {
                  controller.close();
                } else {
                  controller.open();
                }
              },
              child: AbsorbPointer(child: child),
            );
          },
          child: trigger,
        ),
      ),
    );
  }
}

List<Widget> buildCnDropdownMenuEntries(
  BuildContext context,
  List<CnDropdownMenuEntry> entries, {
  required MenuStyle menuStyle,
  required ButtonStyle menuItemStyle,
}) {
  return [
    for (final entry in entries)
      _buildCnDropdownMenuEntry(
        context,
        entry,
        menuStyle: menuStyle,
        menuItemStyle: menuItemStyle,
      ),
  ];
}

Widget _buildCnDropdownMenuEntry(
  BuildContext context,
  CnDropdownMenuEntry entry, {
  required MenuStyle menuStyle,
  required ButtonStyle menuItemStyle,
}) {
  final scheme = CnTheme.colorSchemeOf(context);

  return switch (entry) {
    CnDropdownMenuAction() => MenuItemButton(
      leadingIcon: entry.leading,
      trailingIcon: entry.trailing,
      shortcut: entry.shortcut,
      closeOnActivate: entry.closeOnActivate,
      onPressed: entry.onSelected,
      style: entry.role == .destructive
          ? ButtonStyle(
              foregroundColor: WidgetStateProperty.all(scheme.error),
            ).merge(menuItemStyle)
          : menuItemStyle,
      child: entry.label != null ? Text(entry.label!) : entry.child,
    ),
    CnDropdownMenuCheckboxItem() => MenuItemButton(
      leadingIcon: entry.leading ?? _buildCheckboxIcon(context, entry.checked),
      closeOnActivate: entry.closeOnActivate,
      onPressed: entry.onChanged == null
          ? null
          : () => entry.onChanged!(!entry.checked),
      style: menuItemStyle,
      child: Text(entry.label),
    ),
    CnDropdownMenuRadioItem() => MenuItemButton(
      leadingIcon: entry.leading ?? _buildRadioIcon(context, entry.isSelected),
      closeOnActivate: entry.closeOnActivate,
      onPressed: entry.onSelected == null
          ? null
          : () => entry.onSelected!(entry.value),
      style: menuItemStyle,
      child: Text(entry.label),
    ),
    CnDropdownMenuSeparator() => const _DropdownDivider(),
    CnDropdownMenuSubmenu() => SubmenuButton(
      leadingIcon: entry.leading,
      trailingIcon: entry.trailing,
      menuStyle: menuStyle,
      style: menuItemStyle,
      menuChildren: buildCnDropdownMenuEntries(
        context,
        entry.entries,
        menuStyle: menuStyle,
        menuItemStyle: menuItemStyle,
      ),
      child: Text(entry.label),
    ),
  };
}

Widget _buildCheckboxIcon(BuildContext context, bool checked) {
  final scheme = CnTheme.colorSchemeOf(context);
  if (!checked) {
    return const SizedBox(width: 18, height: 18);
  }
  return Icon(Icons.check, size: 18, color: scheme.primary);
}

Widget _buildRadioIcon(BuildContext context, bool selected) {
  final scheme = CnTheme.colorSchemeOf(context);
  if (!selected) {
    return const SizedBox(width: 18, height: 18);
  }
  return Icon(Icons.radio_button_checked, size: 18, color: scheme.primary);
}

/// Base class for dropdown menu entries.
sealed class CnDropdownMenuEntry {
  const CnDropdownMenuEntry();
}

/// An action entry in a dropdown menu.
class CnDropdownMenuAction extends CnDropdownMenuEntry {
  final String? label;
  final VoidCallback? onSelected;
  final Widget? leading;
  final Widget? trailing;
  final MenuSerializableShortcut? shortcut;
  final CnDropdownMenuRole role;
  final bool closeOnActivate;
  final Widget? child;

  const CnDropdownMenuAction({
    this.label,
    this.onSelected,
    this.leading,
    this.trailing,
    this.shortcut,
    this.role = .standard,
    this.closeOnActivate = true,
    this.child,
  }) : assert(label != null || child != null);
}

/// A checkbox entry in a dropdown menu.
class CnDropdownMenuCheckboxItem extends CnDropdownMenuEntry {
  final String label;
  final bool checked;
  final ValueChanged<bool>? onChanged;
  final Widget? leading;
  final bool closeOnActivate;

  const CnDropdownMenuCheckboxItem({
    required this.label,
    required this.checked,
    this.onChanged,
    this.leading,
    this.closeOnActivate = false,
  });
}

/// A radio button entry in a dropdown menu.
class CnDropdownMenuRadioItem extends CnDropdownMenuEntry {
  final String label;
  final Object? value;
  final Object? groupValue;
  final ValueChanged<Object?>? onSelected;
  final Widget? leading;
  final bool closeOnActivate;

  const CnDropdownMenuRadioItem({
    required this.label,
    required this.value,
    required this.groupValue,
    this.onSelected,
    this.leading,
    this.closeOnActivate = false,
  });

  bool get isSelected => value == groupValue;
}

/// A separator entry in a dropdown menu.
class CnDropdownMenuSeparator extends CnDropdownMenuEntry {
  const CnDropdownMenuSeparator();
}

/// A submenu entry in a dropdown menu.
class CnDropdownMenuSubmenu extends CnDropdownMenuEntry {
  final String label;
  final List<CnDropdownMenuEntry> entries;
  final Widget? leading;
  final Widget? trailing;

  const CnDropdownMenuSubmenu({
    required this.label,
    required this.entries,
    this.leading,
    this.trailing,
  });
}

class _DropdownDivider extends StatelessWidget {
  const _DropdownDivider();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const .symmetric(vertical: 6),
      child: Divider(color: CnTheme.colorSchemeOf(context).outlineVariant),
    );
  }
}
