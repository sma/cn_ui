import 'package:flutter/material.dart';

import '../theme/cn_theme.dart';
import 'cn_button.dart';

/// A horizontal navigation menu component with optional dropdown links.
///
/// Provides a navigation bar with items that can contain dropdown menus with titled links and descriptions.
///
/// See also:
///
///  * [CnMenubar], for application menu bars.
///  * [CnSidebar], for sidebar navigation.
///  * [CnTabs], for tab navigation.
class CnNavigationMenu extends StatelessWidget {
  final List<CnNavigationMenuItem> items;
  final double spacing;
  final EdgeInsetsGeometry? padding;
  final double menuWidth;

  const CnNavigationMenu({
    super.key,
    required this.items,
    this.spacing = 12,
    this.padding,
    this.menuWidth = 320,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? .zero,
      child: Wrap(
        spacing: spacing,
        runSpacing: spacing,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          for (final item in items)
            _NavigationMenuItem(item: item, menuWidth: menuWidth),
        ],
      ),
    );
  }
}

/// A menu item in a [CnNavigationMenu].
class CnNavigationMenuItem {
  final String label;
  final VoidCallback? onTap;
  final Widget? leading;
  final List<CnNavigationMenuLink> links;

  const CnNavigationMenuItem({
    required this.label,
    this.onTap,
    this.leading,
    this.links = const [],
  });
}

/// A link within a [CnNavigationMenuItem] dropdown menu.
class CnNavigationMenuLink {
  final String title;
  final String? description;
  final VoidCallback? onTap;
  final Widget? leading;

  const CnNavigationMenuLink({
    required this.title,
    this.description,
    this.onTap,
    this.leading,
  });
}

class _NavigationMenuItem extends StatelessWidget {
  final CnNavigationMenuItem item;
  final double menuWidth;

  const _NavigationMenuItem({required this.item, required this.menuWidth});

  @override
  Widget build(BuildContext context) {
    if (item.links.isEmpty) {
      return CnButton(
        variant: .ghost,
        size: .sm,
        onPressed: item.onTap,
        leading: item.leading,
        child: Text(item.label),
      );
    }

    final menuStyle = _menuStyle(context, menuWidth);

    return MenuAnchor(
      style: menuStyle,
      menuChildren: [
        for (final link in item.links) _buildMenuLink(context, link),
      ],
      builder: (context, controller, child) {
        return CnButton(
          variant: .ghost,
          size: .sm,
          onPressed: () {
            if (controller.isOpen) {
              controller.close();
            } else {
              controller.open();
            }
          },
          leading: item.leading,
          trailing: Icon(
            controller.isOpen ? Icons.expand_less : Icons.expand_more,
            size: 16,
          ),
          child: Text(item.label),
        );
      },
    );
  }

  MenuStyle _menuStyle(BuildContext context, double width) {
    final cnTheme = CnTheme.of(context);
    final scheme = CnTheme.colorSchemeOf(context);

    return MenuStyle(
      backgroundColor: WidgetStateProperty.all(cnTheme.menuColor),
      surfaceTintColor: WidgetStateProperty.all(Colors.transparent),
      elevation: WidgetStateProperty.all(0),
      side: WidgetStateProperty.all(BorderSide(color: scheme.outlineVariant)),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: .circular(cnTheme.radius)),
      ),
      fixedSize: WidgetStateProperty.all(Size.fromWidth(width)),
      padding: WidgetStateProperty.all(
        const .symmetric(horizontal: 12, vertical: 8),
      ),
    );
  }

  Widget _buildMenuLink(BuildContext context, CnNavigationMenuLink link) {
    final scheme = CnTheme.colorSchemeOf(context);
    final titleStyle = CnTheme.textThemeOf(
      context,
    ).bodyMedium?.copyWith(fontWeight: .w600, color: scheme.onSurface);
    final descriptionStyle = CnTheme.textThemeOf(
      context,
    ).bodySmall?.copyWith(color: scheme.onSurfaceVariant);

    return MenuItemButton(
      onPressed: link.onTap,
      leadingIcon: link.leading,
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Text(link.title, style: titleStyle),
          if (link.description != null)
            Padding(
              padding: const .only(top: 4),
              child: Text(link.description!, style: descriptionStyle),
            ),
        ],
      ),
    );
  }
}
