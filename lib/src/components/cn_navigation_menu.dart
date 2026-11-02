import 'package:material_ui/material_ui.dart';

import '../theme/cn_theme.dart';
import 'cn_button.dart';
import 'cn_menu_styles.dart';

/// A horizontal navigation bar whose items can open a list of links.
///
/// See also:
///
///  * [CnMenubar], for application menu bars.
///  * [CnSidebar], for sidebar navigation.
///  * [CnTabs], for tab navigation.
class const CnNavigationMenu({
  super.key,
  required final List<CnNavigationMenuItem> items,
  final double spacing = 4,
  final double menuWidth = 320,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: spacing,
      runSpacing: spacing,
      crossAxisAlignment: .center,
      children: [
        for (final item in items)
          _NavigationMenuItem(item: item, menuWidth: menuWidth),
      ],
    );
  }
}

/// An item in a [CnNavigationMenu], either a link or a list of [links].
class const CnNavigationMenuItem({
  required final Widget label,
  final VoidCallback? onTap,
  final Widget? leading,
  final List<CnNavigationMenuLink> links = const [],
});

/// A link in the list of a [CnNavigationMenuItem].
class const CnNavigationMenuLink({
  required final Widget title,
  final Widget? description,
  final VoidCallback? onTap,
  final Widget? leading,
});

class _NavigationMenuItem extends StatelessWidget {
  const _NavigationMenuItem({required this.item, required this.menuWidth});
  final CnNavigationMenuItem item;
  final double menuWidth;

  @override
  Widget build(BuildContext context) {
    if (item.links.isEmpty) {
      return CnButton(
        variant: .ghost,
        onPressed: item.onTap,
        leading: item.leading,
        child: item.label,
      );
    }

    return MenuAnchor(
      alignmentOffset: const Offset(0, 4),
      style: cnMenuStyle(context, width: menuWidth),
      menuChildren: [for (final link in item.links) _buildLink(context, link)],
      builder: (context, controller, child) {
        return CnButton(
          variant: .ghost,
          onPressed: () {
            controller.isOpen ? controller.close() : controller.open();
          },
          leading: item.leading,
          trailing: Icon(
            controller.isOpen ? Icons.expand_less : Icons.expand_more,
          ),
          child: item.label,
        );
      },
    );
  }

  Widget _buildLink(BuildContext context, CnNavigationMenuLink link) {
    final theme = CnTheme.of(context);

    return MenuItemButton(
      onPressed: link.onTap,
      leadingIcon: link.leading,
      style: cnMenuItemStyle(context),
      child: Column(
        crossAxisAlignment: .start,
        spacing: 4,
        children: [
          DefaultTextStyle.merge(
            style: theme.text.sm.medium,
            child: link.title,
          ),
          if (link.description != null)
            DefaultTextStyle.merge(
              style: theme.text.sm.copyWith(
                color: theme.colors.mutedForeground,
              ),
              child: link.description!,
            ),
        ],
      ),
    );
  }
}
