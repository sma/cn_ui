import 'package:material_ui/material_ui.dart';

/// Brief help text shown on hover or long press.
///
/// See also:
///
///  * [CnPopover], for more complex popover content.
///  * [CnHoverCard], for rich hover content.
class const CnTooltip({
  super.key,
  required final String message,
  required final Widget child,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Tooltip(message: message, child: child);
  }
}
