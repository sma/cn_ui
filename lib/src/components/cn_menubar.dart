import 'package:material_ui/material_ui.dart';

import 'cn_menu_entry.dart';
import 'cn_menu_styles.dart';

/// A horizontal menu bar like the one of a desktop application.
///
/// See also:
///
///  * [CnDropdownMenu], for standalone dropdown menus.
///  * [CnContextMenu], for context menus.
///  * [CnNavigationMenu], for navigation-focused menus.
class const CnMenubar({super.key, required final List<CnMenu> menus})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final menuStyle = cnMenuStyle(context);

    return cnMenuTheme(
      context,
      menuStyle: menuStyle,
      child: MenuBar(
        style: cnMenuStyle(context),
        children: [
          for (final menu in menus)
            SubmenuButton(
              style: cnMenuItemStyle(context, fontWeight: .w500),
              leadingIcon: menu.leading,
              menuStyle: menuStyle,
              menuChildren: buildCnMenuEntries(
                context,
                menu.entries,
                menuStyle: menuStyle,
              ),
              child: menu.label,
            ),
        ],
      ),
    );
  }
}

/// A top-level menu in a [CnMenubar].
class const CnMenu({
  required final Widget label,
  required final List<CnMenuEntry> entries,
  final Widget? leading,
});
