import 'package:flutter/widgets.dart';

import 'cn_overlay.dart';
import 'cn_overlay_internal.dart';

/// A floating panel attached to a trigger.
///
/// It closes on a tap outside and on the escape key.
///
/// See also:
///
///  * [CnTooltip], for simple text tooltips.
///  * [CnHoverCard], for hover-triggered panels.
///  * [CnDropdownMenu], for menus.
class CnPopover extends StatefulWidget {
  /// Creates a popover that opens when [trigger] is tapped.
  const CnPopover({
    super.key,
    required this.content,
    required Widget this.trigger,
    this.side = .bottom,
    this.align = .center,
    this.width,
  }) : builder = null;

  /// Creates a popover whose trigger calls `toggle` itself.
  const CnPopover.builder({
    super.key,
    required this.content,
    required Widget Function(BuildContext context, VoidCallback toggle)
    this.builder,
    this.side = .bottom,
    this.align = .center,
    this.width,
  }) : trigger = null;

  final Widget content;
  final Widget? trigger;
  final Widget Function(BuildContext context, VoidCallback toggle)? builder;
  final CnSide side;
  final CnAlign align;
  final double? width;

  @override
  State<CnPopover> createState() => _CnPopoverState();
}

class _CnPopoverState extends State<CnPopover> {
  final _controller = OverlayPortalController();

  @override
  Widget build(BuildContext context) {
    return CnAnchoredOverlay(
      controller: _controller,
      side: widget.side,
      align: widget.align,
      overlay: CnPopupSurface(width: widget.width, child: widget.content),
      child: Builder(
        builder: (context) {
          if (widget.builder != null) {
            return widget.builder!(context, _controller.toggle);
          }
          return GestureDetector(
            onTap: _controller.toggle,
            child: AbsorbPointer(child: widget.trigger),
          );
        },
      ),
    );
  }
}
