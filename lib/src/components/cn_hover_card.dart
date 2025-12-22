import 'dart:async';

import 'package:flutter/material.dart';

import '../theme/cn_theme.dart';

/// A hover-triggered card component that displays content on mouse hover.
///
/// Provides a delayed overlay with rich content that appears when hovering over the child widget.
///
/// See also:
///
///  * [CnTooltip], for simple text tooltips.
///  * [CnPopover], for click-triggered popovers.
class CnHoverCard extends StatefulWidget {
  final Widget child;
  final Widget content;
  final Offset offset;
  final Duration openDelay;
  final Duration closeDelay;
  final EdgeInsetsGeometry? padding;
  final double? width;

  const CnHoverCard({
    super.key,
    required this.child,
    required this.content,
    this.offset = const Offset(0, 8),
    this.openDelay = const Duration(milliseconds: 120),
    this.closeDelay = const Duration(milliseconds: 180),
    this.padding,
    this.width,
  });

  @override
  State<CnHoverCard> createState() => _CnHoverCardState();
}

class _CnHoverCardState extends State<CnHoverCard> {
  final LayerLink _link = LayerLink();
  OverlayEntry? _entry;
  Timer? _openTimer;
  Timer? _closeTimer;
  bool _hoveringChild = false;
  bool _hoveringOverlay = false;

  void _scheduleOpen() {
    _openTimer?.cancel();
    _openTimer = Timer(widget.openDelay, _show);
  }

  void _scheduleClose() {
    _closeTimer?.cancel();
    _closeTimer = Timer(widget.closeDelay, _hideIfNeeded);
  }

  void _show() {
    if (_entry != null || !mounted) {
      return;
    }
    _entry = OverlayEntry(
      builder: (context) {
        return Positioned.fill(
          child: Stack(
            children: [
              CompositedTransformFollower(
                link: _link,
                offset: widget.offset,
                showWhenUnlinked: false,
                child: MouseRegion(
                  onEnter: (_) {
                    _hoveringOverlay = true;
                  },
                  onExit: (_) {
                    _hoveringOverlay = false;
                    _scheduleClose();
                  },
                  child: _HoverCardSurface(
                    width: widget.width,
                    padding: widget.padding,
                    child: widget.content,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
    Overlay.of(context).insert(_entry!);
  }

  void _hideIfNeeded() {
    if (!_hoveringChild && !_hoveringOverlay) {
      _removeEntry();
    }
  }

  void _removeEntry() {
    _openTimer?.cancel();
    _closeTimer?.cancel();
    _entry?.remove();
    _entry = null;
  }

  @override
  void dispose() {
    _removeEntry();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _link,
      child: MouseRegion(
        onEnter: (_) {
          _hoveringChild = true;
          _scheduleOpen();
        },
        onExit: (_) {
          _hoveringChild = false;
          _scheduleClose();
        },
        child: widget.child,
      ),
    );
  }
}

class _HoverCardSurface extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double? width;

  const _HoverCardSurface({required this.child, this.padding, this.width});

  @override
  Widget build(BuildContext context) {
    final cnTheme = CnTheme.of(context);
    final scheme = CnTheme.colorSchemeOf(context);

    return Material(
      color: scheme.surface,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: .circular(cnTheme.radius),
        side: BorderSide(color: scheme.outlineVariant),
      ),
      child: IntrinsicHeight(
        child: ConstrainedBox(
          constraints: BoxConstraints(minWidth: 200, maxWidth: width ?? 320),
          child: Padding(padding: padding ?? const .all(16), child: child),
        ),
      ),
    );
  }
}
