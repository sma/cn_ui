import 'package:material_ui/material_ui.dart';

import 'cn_menu_entry.dart';
import 'cn_menu_styles.dart';

/// A menu that opens from a trigger.
///
/// See also:
///
///  * [CnContextMenu], for right-click context menus.
///  * [CnMenubar], for horizontal menu bars.
///  * [CnPopover], for free-form content.
class CnDropdownMenu extends StatelessWidget {
  /// Creates a menu that opens when [trigger] is tapped.
  const CnDropdownMenu({
    super.key,
    required this.entries,
    required Widget this.trigger,
    this.width,
  }) : builder = null;

  /// Creates a menu whose trigger calls `toggle` itself.
  const CnDropdownMenu.builder({
    super.key,
    required this.entries,
    required Widget Function(BuildContext context, VoidCallback toggle)
    this.builder,
    this.width,
  }) : trigger = null;

  final List<CnMenuEntry> entries;
  final Widget? trigger;
  final Widget Function(BuildContext context, VoidCallback toggle)? builder;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final menuStyle = cnMenuStyle(context, width: width);

    return cnMenuTheme(
      context,
      menuStyle: menuStyle,
      child: MenuAnchor(
        alignmentOffset: const Offset(0, 4),
        style: menuStyle,
        menuChildren: buildCnMenuEntries(
          context,
          entries,
          menuStyle: menuStyle,
        ),
        builder: (context, controller, child) {
          void toggle() {
            controller.isOpen ? controller.close() : controller.open();
          }

          if (builder != null) {
            return builder!(context, toggle);
          }
          return GestureDetector(
            onTap: toggle,
            child: AbsorbPointer(child: child),
          );
        },
        child: trigger,
      ),
    );
  }
}
