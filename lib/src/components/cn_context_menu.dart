import 'package:flutter/material.dart';

import 'cn_dropdown_menu.dart';
import 'cn_menu_styles.dart';

/// A context menu component triggered by right-click or long-press.
///
/// Provides a menu overlay with actions, checkboxes, radio items, and submenus at the cursor position.
///
/// See also:
///
///  * [CnDropdownMenu], for click-triggered dropdown menus.
///  * [CnMenubar], for horizontal menu bars.
class CnContextMenu extends StatelessWidget {
  final Widget child;
  final List<CnDropdownMenuEntry> entries;
  final MenuStyle? style;
  final Offset? alignmentOffset;
  final double? menuWidth;
  final bool openOnTap;

  const CnContextMenu({
    super.key,
    required this.child,
    required this.entries,
    this.style,
    this.alignmentOffset,
    this.menuWidth,
    this.openOnTap = false,
  });

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
          style: resolvedStyle,
          alignmentOffset: alignmentOffset,
          menuChildren: buildCnDropdownMenuEntries(
            context,
            entries,
            menuStyle: resolvedStyle,
            menuItemStyle: menuItemStyle,
          ),
          builder: (context, controller, child) {
            return GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTapDown: openOnTap
                  ? (details) {
                      _openAt(context, controller, details.globalPosition);
                    }
                  : null,
              onSecondaryTapDown: (details) {
                _openAt(context, controller, details.globalPosition);
              },
              onLongPressStart: (details) {
                _openAt(context, controller, details.globalPosition);
              },
              child: child,
            );
          },
          child: child,
        ),
      ),
    );
  }

  void _openAt(
    BuildContext context,
    MenuController controller,
    Offset position,
  ) {
    final box = context.findRenderObject() as RenderBox?;
    final local = box?.globalToLocal(position) ?? position;
    controller.open(position: local);
  }
}
