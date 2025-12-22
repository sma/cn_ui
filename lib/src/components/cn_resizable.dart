import 'package:flutter/material.dart';

import '../theme/cn_theme.dart';

/// A container with a draggable handle for resizing two panels.
///
/// Allows users to adjust the relative sizes of primary and secondary panels with ratio constraints.
///
/// See also:
///
///  * [CnResizeHandle], the visual handle for dragging.
class CnResizable extends StatefulWidget {
  final Axis direction;
  final Widget primary;
  final Widget secondary;
  final double initialRatio;
  final double minRatio;
  final double maxRatio;
  final double handleSize;
  final ValueChanged<double>? onChanged;
  final Widget? handle;

  const CnResizable({
    super.key,
    required this.primary,
    required this.secondary,
    this.direction = .horizontal,
    this.initialRatio = 0.5,
    this.minRatio = 0.2,
    this.maxRatio = 0.8,
    this.handleSize = 12,
    this.onChanged,
    this.handle,
  });

  @override
  State<CnResizable> createState() => _CnResizableState();
}

class _CnResizableState extends State<CnResizable> {
  late double _ratio;

  @override
  void initState() {
    super.initState();
    _ratio = _clampRatio(widget.initialRatio);
  }

  double _clampRatio(double value) {
    return value.clamp(widget.minRatio, widget.maxRatio);
  }

  void _updateRatio(double delta, double available) {
    if (available <= 0) {
      return;
    }
    final nextRatio = _clampRatio(_ratio + delta / available);
    if (nextRatio == _ratio) {
      return;
    }
    setState(() => _ratio = nextRatio);
    widget.onChanged?.call(_ratio);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isHorizontal = widget.direction == .horizontal;
        final mainSize = isHorizontal
            ? constraints.maxWidth
            : constraints.maxHeight;

        if (!mainSize.isFinite) {
          return _buildFlexWithRatio(context, 1000);
        }

        final available = (mainSize - widget.handleSize).clamp(0.0, mainSize);
        final firstSize = available * _ratio;
        final secondSize = (available - firstSize).clamp(0.0, available);

        return Flex(
          direction: widget.direction,
          children: [
            SizedBox(
              width: isHorizontal ? firstSize : null,
              height: isHorizontal ? null : firstSize,
              child: widget.primary,
            ),
            _ResizeHandleArea(
              direction: widget.direction,
              size: widget.handleSize,
              handle: widget.handle,
              onDrag: (delta) => _updateRatio(delta, available),
            ),
            SizedBox(
              width: isHorizontal ? secondSize : null,
              height: isHorizontal ? null : secondSize,
              child: widget.secondary,
            ),
          ],
        );
      },
    );
  }

  Widget _buildFlexWithRatio(BuildContext context, int scale) {
    final flex = (_ratio * scale).round().clamp(1, scale - 1);

    return Flex(
      direction: widget.direction,
      children: [
        Expanded(flex: flex, child: widget.primary),
        _ResizeHandleArea(
          direction: widget.direction,
          size: widget.handleSize,
          handle: widget.handle,
          onDrag: (_) {},
        ),
        Expanded(flex: scale - flex, child: widget.secondary),
      ],
    );
  }
}

class _ResizeHandleArea extends StatelessWidget {
  final Axis direction;
  final double size;
  final Widget? handle;
  final ValueChanged<double> onDrag;

  const _ResizeHandleArea({
    required this.direction,
    required this.size,
    required this.handle,
    required this.onDrag,
  });

  @override
  Widget build(BuildContext context) {
    final isHorizontal = direction == .horizontal;
    final cursor = isHorizontal
        ? SystemMouseCursors.resizeColumn
        : SystemMouseCursors.resizeRow;

    return MouseRegion(
      cursor: cursor,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onHorizontalDragUpdate: isHorizontal
            ? (details) => onDrag(details.delta.dx)
            : null,
        onVerticalDragUpdate: isHorizontal
            ? null
            : (details) => onDrag(details.delta.dy),
        child: SizedBox(
          width: isHorizontal ? size : double.infinity,
          height: isHorizontal ? double.infinity : size,
          child: Center(child: handle ?? CnResizeHandle(direction: direction)),
        ),
      ),
    );
  }
}

/// A visual handle for resizing panels in a [CnResizable].
class CnResizeHandle extends StatelessWidget {
  final Axis direction;
  final double thickness;
  final double length;
  final Color? color;

  const CnResizeHandle({
    super.key,
    this.direction = .horizontal,
    this.thickness = 3,
    this.length = 36,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = CnTheme.colorSchemeOf(context);
    final cnTheme = CnTheme.of(context);
    final isHorizontal = direction == .horizontal;

    return Container(
      width: isHorizontal ? thickness : length,
      height: isHorizontal ? length : thickness,
      decoration: BoxDecoration(
        color: color ?? scheme.outlineVariant,
        borderRadius: .circular(cnTheme.radius),
      ),
    );
  }
}
