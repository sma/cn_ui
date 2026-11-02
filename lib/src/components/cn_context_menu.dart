import 'package:material_ui/material_ui.dart';

import 'cn_menu_entry.dart';
import 'cn_menu_styles.dart';

/// A menu that opens at the pointer on right-click or long-press.
///
/// See also:
///
///  * [CnDropdownMenu], for click-triggered dropdown menus.
///  * [CnMenubar], for horizontal menu bars.
class const CnContextMenu({
  super.key,
  required final Widget child,
  required final List<CnMenuEntry> entries,
  final double? width,
  final bool openOnTap = false,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final menuStyle = cnMenuStyle(context, width: width);

    return cnMenuTheme(
      context,
      menuStyle: menuStyle,
      child: MenuAnchor(
        style: menuStyle,
        menuChildren: buildCnMenuEntries(
          context,
          entries,
          menuStyle: menuStyle,
        ),
        builder: (context, controller, child) {
          void openAt(Offset position) {
            final box = context.findRenderObject() as RenderBox?;
            controller.open(position: box?.globalToLocal(position) ?? position);
          }

          return GestureDetector(
            behavior: .translucent,
            onTapDown: openOnTap
                ? (details) => openAt(details.globalPosition)
                : null,
            onSecondaryTapDown: (details) => openAt(details.globalPosition),
            onLongPressStart: (details) => openAt(details.globalPosition),
            child: child,
          );
        },
        child: child,
      ),
    );
  }
}
