import 'package:flutter/material.dart';

/// A tooltip component for displaying brief help text on hover or long press.
///
/// Wraps Flutter's Tooltip widget with a consistent interface.
///
/// See also:
///
///  * [CnPopover], for more complex popover content.
///  * [CnHoverCard], for rich hover content.
class CnTooltip extends StatelessWidget {
  final String message;
  final Widget child;
  final EdgeInsetsGeometry? padding;

  const CnTooltip({
    super.key,
    required this.message,
    required this.child,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(message: message, padding: padding, child: child);
  }
}
