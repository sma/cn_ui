import 'package:flutter/material.dart';

import '../theme/cn_theme.dart';
import 'cn_menu_styles.dart';

/// Role variants for [CnMenuAction].
enum CnMenuRole { standard, destructive }

/// A horizontal menu bar component with dropdown submenus.
///
/// Provides a traditional application menu bar with hierarchical menu items.
///
/// See also:
///
///  * [CnDropdownMenu], for standalone dropdown menus.
///  * [CnContextMenu], for context menus.
///  * [CnNavigationMenu], for navigation-focused menus.
class CnMenubar extends StatelessWidget {
  final List<CnMenu> menus;
  final MenuStyle? style;
  final MenuStyle? menuStyle;

  const CnMenubar({super.key, required this.menus, this.style, this.menuStyle});

  @override
  Widget build(BuildContext context) {
    final resolvedMenuStyle = menuStyle ?? cnMenuStyle(context);
    final menuItemStyle = cnMenuItemStyle(context);
    final menubarItemStyle = cnMenuItemStyle(
      context,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      fontWeight: .w600,
    );
    final submenuIcon = cnSubmenuIcon(context);

    return MenuTheme(
      data: MenuThemeData(style: resolvedMenuStyle, submenuIcon: submenuIcon),
      child: MenuButtonTheme(
        data: MenuButtonThemeData(style: menuItemStyle),
        child: MenuBar(
          style:
              style ??
              cnMenuStyle(
                context,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              ),
          children: [
            for (final menu in menus)
              SubmenuButton(
                style: menubarItemStyle,
                leadingIcon: menu.leading,
                menuStyle: resolvedMenuStyle,
                menuChildren: _buildEntries(
                  context,
                  menu.entries,
                  resolvedMenuStyle,
                  menuItemStyle,
                ),
                child: Text(menu.label),
              ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildEntries(
    BuildContext context,
    List<CnMenuEntry> entries,
    MenuStyle menuStyle,
    ButtonStyle menuItemStyle,
  ) {
    return [
      for (final entry in entries)
        _buildEntry(context, entry, menuStyle, menuItemStyle),
    ];
  }

  Widget _buildEntry(
    BuildContext context,
    CnMenuEntry entry,
    MenuStyle menuStyle,
    ButtonStyle menuItemStyle,
  ) {
    final scheme = CnTheme.colorSchemeOf(context);

    return switch (entry) {
      CnMenuAction() => MenuItemButton(
        leadingIcon: entry.leading,
        trailingIcon: entry.trailing,
        shortcut: entry.shortcut,
        onPressed: entry.onSelected,
        closeOnActivate: entry.closeOnActivate,
        style: entry.role == .destructive
            ? ButtonStyle(
                foregroundColor: WidgetStateProperty.all(scheme.error),
              ).merge(menuItemStyle)
            : menuItemStyle,
        child: Text(entry.label),
      ),
      CnMenuSeparator() => const _MenuDivider(),
      CnMenuSubmenu() => SubmenuButton(
        leadingIcon: entry.leading,
        trailingIcon: entry.trailing,
        menuStyle: menuStyle,
        style: menuItemStyle,
        menuChildren: _buildEntries(
          context,
          entry.entries,
          menuStyle,
          menuItemStyle,
        ),
        child: Text(entry.label),
      ),
    };
  }
}

/// A top-level menu in a [CnMenubar].
class CnMenu {
  final String label;
  final List<CnMenuEntry> entries;
  final Widget? leading;

  const CnMenu({required this.label, required this.entries, this.leading});
}

/// Base class for menu entries in a [CnMenubar].
sealed class CnMenuEntry {
  const CnMenuEntry();
}

/// An action entry in a menu.
class CnMenuAction extends CnMenuEntry {
  final String label;
  final VoidCallback? onSelected;
  final Widget? leading;
  final Widget? trailing;
  final MenuSerializableShortcut? shortcut;
  final CnMenuRole role;
  final bool closeOnActivate;

  const CnMenuAction({
    required this.label,
    this.onSelected,
    this.leading,
    this.trailing,
    this.shortcut,
    this.role = .standard,
    this.closeOnActivate = true,
  });
}

/// A separator entry in a menu.
class CnMenuSeparator extends CnMenuEntry {
  const CnMenuSeparator();
}

/// A submenu entry in a menu.
class CnMenuSubmenu extends CnMenuEntry {
  final String label;
  final List<CnMenuEntry> entries;
  final Widget? leading;
  final Widget? trailing;

  const CnMenuSubmenu({
    required this.label,
    required this.entries,
    this.leading,
    this.trailing,
  });
}

class _MenuDivider extends StatelessWidget {
  const _MenuDivider();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const .symmetric(vertical: 6),
      child: Divider(color: CnTheme.colorSchemeOf(context).outlineVariant),
    );
  }
}
