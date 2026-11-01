import 'package:flutter/services.dart';
import 'package:material_ui/material_ui.dart';

import '../theme/cn_theme.dart';
import 'cn_overlay.dart';

/// Shows a panel that slides in from a screen edge.
Future<T?> showCnSlideOverlay<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  required CnSide side,
  required bool barrierDismissible,
  required bool draggable,
  required double size,
}) {
  final isRtl = Directionality.of(context) == TextDirection.rtl;
  final begin = switch (side) {
    .top => const Offset(0, -1),
    .bottom => const Offset(0, 1),
    .start => Offset(isRtl ? 1 : -1, 0),
    .end => Offset(isRtl ? -1 : 1, 0),
  };

  return showGeneralDialog<T>(
    context: context,
    barrierLabel: 'Dismiss',
    barrierDismissible: barrierDismissible,
    barrierColor: const Color(0x80000000),
    transitionDuration: const Duration(milliseconds: 260),
    pageBuilder: (context, animation, secondaryAnimation) {
      final isVertical = side == .top || side == .bottom;
      final panel = SizedBox(
        width: isVertical ? null : size,
        child: Material(
          type: MaterialType.transparency,
          child: _CnOverlaySideScope(side: side, child: builder(context)),
        ),
      );
      return SafeArea(
        child: Align(
          alignment: switch (side) {
            .top => AlignmentDirectional.topCenter,
            .bottom => AlignmentDirectional.bottomCenter,
            .start => AlignmentDirectional.centerStart,
            .end => AlignmentDirectional.centerEnd,
          },
          child: draggable ? _DragToDismiss(side: side, child: panel) : panel,
        ),
      );
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: Tween(begin: begin, end: Offset.zero).animate(
          CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
        ),
        child: child,
      );
    },
  );
}

class _CnOverlaySideScope extends InheritedWidget {
  const _CnOverlaySideScope({required this.side, required super.child});
  final CnSide side;

  @override
  bool updateShouldNotify(_CnOverlaySideScope oldWidget) {
    return oldWidget.side != side;
  }
}

class _DragToDismiss extends StatefulWidget {
  const _DragToDismiss({required this.side, required this.child});
  final CnSide side;
  final Widget child;

  @override
  State<_DragToDismiss> createState() => _DragToDismissState();
}

class _DragToDismissState extends State<_DragToDismiss>
    with SingleTickerProviderStateMixin {
  late final _controller = AnimationController.unbounded(vsync: this);

  bool get _isVertical => widget.side == .top || widget.side == .bottom;

  /// The direction that moves the panel towards its screen edge.
  double get _dismissSign {
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    return switch (widget.side) {
      .top => -1,
      .bottom => 1,
      .start => isRtl ? 1 : -1,
      .end => isRtl ? -1 : 1,
    };
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleUpdate(double delta) {
    _controller.value = (_controller.value + delta * _dismissSign).clamp(
      0.0,
      double.infinity,
    );
  }

  void _handleEnd(double velocity) {
    final extent = _isVertical ? context.size?.height : context.size?.width;
    final isFling = velocity * _dismissSign > 700;
    if (isFling || _controller.value > (extent ?? 0) / 3) {
      Navigator.of(context).maybePop();
    } else {
      _controller.animateTo(
        0,
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: _isVertical
          ? (details) => _handleUpdate(details.delta.dy)
          : null,
      onVerticalDragEnd: _isVertical
          ? (details) => _handleEnd(details.velocity.pixelsPerSecond.dy)
          : null,
      onHorizontalDragUpdate: _isVertical
          ? null
          : (details) => _handleUpdate(details.delta.dx),
      onHorizontalDragEnd: _isVertical
          ? null
          : (details) => _handleEnd(details.velocity.pixelsPerSecond.dx),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final distance = _controller.value * _dismissSign;
          return Transform.translate(
            offset: _isVertical ? Offset(0, distance) : Offset(distance, 0),
            child: child,
          );
        },
        child: widget.child,
      ),
    );
  }
}

/// The visible surface of a sheet or drawer.
///
/// Rounds the corners that face away from the screen edge it is attached to.
class CnSlidePanel extends StatelessWidget {
  const CnSlidePanel({
    super.key,
    this.title,
    this.description,
    this.content,
    this.actions = const [],
    required this.showHandle,
    required this.showCloseButton,
  });
  final Widget? title;
  final Widget? description;
  final Widget? content;
  final List<Widget> actions;
  final bool showHandle;
  final bool showCloseButton;

  @override
  Widget build(BuildContext context) {
    final theme = CnTheme.of(context);
    final colors = theme.colors;
    final side =
        context
            .dependOnInheritedWidgetOfExactType<_CnOverlaySideScope>()
            ?.side ??
        CnSide.end;
    final radius = Radius.circular(theme.radii.xl);
    final isVertical = side == .top || side == .bottom;

    return Material(
      color: colors.background,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: colors.border),
        borderRadius: switch (side) {
          .top => BorderRadiusDirectional.vertical(bottom: radius),
          .bottom => BorderRadiusDirectional.vertical(top: radius),
          .start => BorderRadiusDirectional.horizontal(end: radius),
          .end => BorderRadiusDirectional.horizontal(start: radius),
        },
      ),
      child: SizedBox(
        height: isVertical ? null : double.infinity,
        child: Stack(
          children: [
            Padding(
              padding: const .all(24),
              child: Column(
                mainAxisSize: isVertical ? .min : .max,
                crossAxisAlignment: .start,
                spacing: 16,
                children: [
                  if (showHandle)
                    Align(
                      child: Container(
                        width: 48,
                        height: 4,
                        decoration: BoxDecoration(
                          color: colors.muted,
                          borderRadius: .circular(theme.radii.full),
                        ),
                      ),
                    ),
                  CnOverlayHeader(title: title, description: description),
                  if (content != null)
                    Flexible(child: SingleChildScrollView(child: content!)),
                  if (actions.isNotEmpty)
                    Row(mainAxisAlignment: .end, spacing: 8, children: actions),
                ],
              ),
            ),
            if (showCloseButton) const CnOverlayCloseButton(),
          ],
        ),
      ),
    );
  }
}

/// The title and description of an overlay.
class CnOverlayHeader extends StatelessWidget {
  const CnOverlayHeader({super.key, this.title, this.description});
  final Widget? title;
  final Widget? description;

  @override
  Widget build(BuildContext context) {
    if (title == null && description == null) {
      return const SizedBox.shrink();
    }
    final theme = CnTheme.of(context);
    return Column(
      crossAxisAlignment: .start,
      spacing: 6,
      children: [
        if (title != null)
          DefaultTextStyle.merge(
            style: theme.text.lg.semibold.copyWith(
              color: theme.colors.foreground,
            ),
            child: title!,
          ),
        if (description != null)
          DefaultTextStyle.merge(
            style: theme.text.sm.copyWith(color: theme.colors.mutedForeground),
            child: description!,
          ),
      ],
    );
  }
}

/// The close button in the top end corner of an overlay.
class CnOverlayCloseButton extends StatelessWidget {
  const CnOverlayCloseButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PositionedDirectional(
      top: 8,
      end: 8,
      child: IconButton(
        icon: Icon(
          Icons.close,
          size: 16,
          color: CnTheme.of(context).colors.mutedForeground,
        ),
        tooltip: 'Close',
        onPressed: () => Navigator.of(context).maybePop(),
      ),
    );
  }
}

/// Shows [overlay] next to [child] while [controller] says so.
///
/// The overlay closes on a tap outside and on the escape key.
class CnAnchoredOverlay extends StatefulWidget {
  const CnAnchoredOverlay({
    super.key,
    required this.controller,
    required this.side,
    required this.align,
    required this.overlay,
    required this.child,
    this.gap = 6,
  });
  final OverlayPortalController controller;
  final CnSide side;
  final CnAlign align;
  final Widget overlay;
  final Widget child;
  final double gap;

  @override
  State<CnAnchoredOverlay> createState() => _CnAnchoredOverlayState();
}

class _CnAnchoredOverlayState extends State<CnAnchoredOverlay> {
  final _link = LayerLink();

  void _hide() {
    if (widget.controller.isShowing) {
      widget.controller.hide();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    final startX = isRtl ? 1.0 : -1.0;
    final alongX = switch (widget.align) {
      .start => startX,
      .center => 0.0,
      .end => -startX,
    };
    final alongY = switch (widget.align) {
      .start => -1.0,
      .center => 0.0,
      .end => 1.0,
    };
    final (target, follower, offset) = switch (widget.side) {
      .bottom => (
        Alignment(alongX, 1),
        Alignment(alongX, -1),
        Offset(0, widget.gap),
      ),
      .top => (
        Alignment(alongX, -1),
        Alignment(alongX, 1),
        Offset(0, -widget.gap),
      ),
      .start => (
        Alignment(startX, alongY),
        Alignment(-startX, alongY),
        Offset(startX * widget.gap, 0),
      ),
      .end => (
        Alignment(-startX, alongY),
        Alignment(startX, alongY),
        Offset(-startX * widget.gap, 0),
      ),
    };

    return CompositedTransformTarget(
      link: _link,
      child: OverlayPortal(
        controller: widget.controller,
        overlayChildBuilder: (context) {
          return Align(
            alignment: Alignment.topLeft,
            child: CompositedTransformFollower(
              link: _link,
              targetAnchor: target,
              followerAnchor: follower,
              offset: offset,
              showWhenUnlinked: false,
              child: TapRegion(
                groupId: this,
                onTapOutside: (_) => _hide(),
                child: Focus(
                  autofocus: true,
                  onKeyEvent: (node, event) {
                    if (event is KeyDownEvent &&
                        event.logicalKey == LogicalKeyboardKey.escape) {
                      _hide();
                      return KeyEventResult.handled;
                    }
                    return KeyEventResult.ignored;
                  },
                  child: widget.overlay,
                ),
              ),
            ),
          );
        },
        child: TapRegion(groupId: this, child: widget.child),
      ),
    );
  }
}

/// The surface of an anchored overlay such as a popover.
class CnPopupSurface extends StatelessWidget {
  const CnPopupSurface({super.key, required this.child, this.width});
  final Widget child;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final theme = CnTheme.of(context);
    return SizedBox(
      width: width ?? 288,
      child: Material(
        color: theme.colors.popover,
        textStyle: theme.text.sm.copyWith(
          color: theme.colors.popoverForeground,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: .circular(theme.radii.md),
          side: BorderSide(color: theme.colors.border),
        ),
        child: Padding(padding: const .all(16), child: child),
      ),
    );
  }
}
