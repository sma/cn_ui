import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

import 'cn_overlay.dart';
import 'cn_overlay_internal.dart';

/// A floating panel that opens while the pointer rests on [child].
///
/// See also:
///
///  * [CnTooltip], for simple text tooltips.
///  * [CnPopover], for click-triggered panels.
class CnHoverCard extends StatefulWidget {
  const CnHoverCard({
    super.key,
    required this.child,
    required this.content,
    this.side = .bottom,
    this.align = .center,
    this.openDelay = const Duration(milliseconds: 120),
    this.closeDelay = const Duration(milliseconds: 180),
    this.width,
  });
  final Widget child;
  final Widget content;
  final CnSide side;
  final CnAlign align;
  final Duration openDelay;
  final Duration closeDelay;
  final double? width;

  @override
  State<CnHoverCard> createState() => _CnHoverCardState();
}

class _CnHoverCardState extends State<CnHoverCard> {
  final _controller = OverlayPortalController();
  Timer? _timer;

  void _schedule(Duration delay, VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(delay, action);
  }

  void _handleEnter(PointerEnterEvent event) {
    _schedule(widget.openDelay, _controller.show);
  }

  void _handleExit(PointerExitEvent event) {
    _schedule(widget.closeDelay, _controller.hide);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CnAnchoredOverlay(
      controller: _controller,
      side: widget.side,
      align: widget.align,
      overlay: MouseRegion(
        onEnter: _handleEnter,
        onExit: _handleExit,
        child: CnPopupSurface(width: widget.width, child: widget.content),
      ),
      child: MouseRegion(
        onEnter: _handleEnter,
        onExit: _handleExit,
        child: widget.child,
      ),
    );
  }
}
