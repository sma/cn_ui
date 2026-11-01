import 'package:material_ui/material_ui.dart';

import '../theme/cn_theme.dart';
import 'cn_menu_entry.dart';

MenuStyle cnMenuStyle(
  BuildContext context, {
  double? width,
  EdgeInsetsGeometry padding = const EdgeInsets.all(4),
}) {
  final theme = CnTheme.of(context);

  return MenuStyle(
    backgroundColor: .all(theme.colors.popover),
    surfaceTintColor: .all(Colors.transparent),
    elevation: .all(0),
    side: .all(BorderSide(color: theme.colors.border)),
    shape: .all(
      RoundedRectangleBorder(borderRadius: .circular(theme.radii.md)),
    ),
    fixedSize: width == null ? null : .all(Size.fromWidth(width)),
    padding: .all(padding),
  );
}

ButtonStyle cnMenuItemStyle(
  BuildContext context, {
  EdgeInsetsGeometry padding = const EdgeInsets.symmetric(
    horizontal: 8,
    vertical: 6,
  ),
  FontWeight fontWeight = .w400,
  Color? foreground,
}) {
  final theme = CnTheme.of(context);
  final colors = theme.colors;

  return ButtonStyle(
    padding: .all(padding),
    minimumSize: .all(const Size(0, 32)),
    shape: .all(
      RoundedRectangleBorder(borderRadius: .circular(theme.radii.sm)),
    ),
    backgroundColor: WidgetStateColor.fromMap({
      WidgetState.disabled: Colors.transparent,
      WidgetState.pressed | WidgetState.hovered | WidgetState.focused:
          colors.accent,
      WidgetState.any: Colors.transparent,
    }),
    foregroundColor: foreground != null
        ? .all(foreground)
        : WidgetStateColor.fromMap({
            WidgetState.disabled: colors.popoverForeground.resolve(const {
              .disabled,
            }),
            WidgetState.pressed | WidgetState.hovered | WidgetState.focused:
                colors.accentForeground,
            WidgetState.any: colors.popoverForeground,
          }),
    iconColor: foreground != null ? .all(foreground) : colors.mutedForeground,
    iconSize: .all(16),
    overlayColor: .all(Colors.transparent),
    textStyle: .all(theme.text.sm.weight(fontWeight)),
  );
}

WidgetStateProperty<Widget?> cnSubmenuIcon(BuildContext context) {
  final color = CnTheme.of(context).colors.mutedForeground;
  return .resolveWith((states) {
    return Icon(
      Icons.chevron_right,
      size: 16,
      color: states.contains(WidgetState.disabled)
          ? color.resolve(states)
          : color,
    );
  });
}

/// Wraps [child] in the themes every menu uses.
Widget cnMenuTheme(
  BuildContext context, {
  required MenuStyle menuStyle,
  required Widget child,
}) {
  return MenuTheme(
    data: MenuThemeData(style: menuStyle, submenuIcon: cnSubmenuIcon(context)),
    child: MenuButtonTheme(
      data: MenuButtonThemeData(style: cnMenuItemStyle(context)),
      child: child,
    ),
  );
}

/// Turns menu entries into Material menu widgets.
List<Widget> buildCnMenuEntries(
  BuildContext context,
  List<CnMenuEntry> entries, {
  required MenuStyle menuStyle,
}) {
  return [
    for (final entry in entries)
      _buildEntry(context, entry, menuStyle: menuStyle),
  ];
}

Widget _buildEntry(
  BuildContext context,
  CnMenuEntry entry, {
  required MenuStyle menuStyle,
}) {
  final colors = CnTheme.of(context).colors;

  Widget mark(bool visible, IconData icon) {
    return SizedBox.square(
      dimension: 16,
      child: visible ? Icon(icon, size: 16, color: colors.foreground) : null,
    );
  }

  return switch (entry) {
    CnMenuAction() => MenuItemButton(
      leadingIcon: entry.leading,
      trailingIcon: entry.trailing,
      shortcut: entry.shortcut,
      closeOnActivate: entry.closeOnActivate,
      onPressed: entry.onSelected,
      style: entry.role == .destructive
          ? cnMenuItemStyle(context, foreground: colors.destructive)
          : null,
      child: entry.label,
    ),
    CnMenuCheckboxItem() => MenuItemButton(
      leadingIcon: mark(entry.value, Icons.check),
      closeOnActivate: entry.closeOnActivate,
      onPressed: entry.onChanged == null
          ? null
          : () => entry.onChanged!(!entry.value),
      child: entry.label,
    ),
    CnMenuRadioItem() => MenuItemButton(
      leadingIcon: mark(entry.isSelected, Icons.circle),
      closeOnActivate: entry.closeOnActivate,
      onPressed: entry.isEnabled ? entry.select : null,
      child: entry.label,
    ),
    CnMenuSeparator() => const Padding(
      padding: .symmetric(vertical: 4),
      child: Divider(height: 1, thickness: 1),
    ),
    CnMenuSubmenu() => SubmenuButton(
      leadingIcon: entry.leading,
      trailingIcon: entry.trailing,
      menuStyle: menuStyle,
      menuChildren: buildCnMenuEntries(
        context,
        entry.entries,
        menuStyle: menuStyle,
      ),
      child: entry.label,
    ),
  };
}
