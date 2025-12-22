import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/cn_theme.dart';

/// A skeleton loader component for displaying loading placeholders.
///
/// Provides an animated shimmer effect for content placeholders with customizable shapes and sizes.
///
/// See also:
///
///  * [CnSpinner], for loading spinners.
///  * [CnProgress], for progress indicators.
class CnSkeleton extends StatefulWidget {
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final bool isCircle;
  final bool animate;
  final Duration duration;
  final Color? baseColor;
  final Color? highlightColor;

  const CnSkeleton({
    super.key,
    this.width,
    this.height,
    this.borderRadius,
    this.isCircle = false,
    this.animate = true,
    this.duration = const Duration(milliseconds: 1400),
    this.baseColor,
    this.highlightColor,
  });

  @override
  State<CnSkeleton> createState() => _CnSkeletonState();
}

class _CnSkeletonState extends State<CnSkeleton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    if (widget.animate) {
      _controller.repeat();
    }
  }

  @override
  void didUpdateWidget(covariant CnSkeleton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.animate != widget.animate ||
        oldWidget.duration != widget.duration) {
      _controller.duration = widget.duration;
      if (widget.animate) {
        _controller.repeat();
      } else {
        _controller.stop();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = CnTheme.colorSchemeOf(context);
    final cnTheme = CnTheme.of(context);
    final baseColor = widget.baseColor ?? scheme.surfaceContainerHighest;
    final highlightColor = widget.highlightColor ?? scheme.surfaceContainerLow;
    final radius =
        widget.borderRadius ?? .circular(math.max(4, cnTheme.radius - 6));

    final shape = widget.isCircle ? BoxShape.circle : BoxShape.rectangle;
    final decoration = BoxDecoration(
      color: baseColor,
      borderRadius: widget.isCircle ? null : radius,
      shape: shape,
    );

    final child = Container(
      width: widget.width,
      height: widget.height,
      decoration: decoration,
    );

    if (!widget.animate) {
      return child;
    }

    return AnimatedBuilder(
      animation: _controller,
      child: child,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (rect) {
            final shimmerPosition = (_controller.value * 2) - 1;
            return LinearGradient(
              begin: Alignment(-1.2 - shimmerPosition, 0),
              end: Alignment(1.2 + shimmerPosition, 0),
              colors: [baseColor, highlightColor, baseColor],
              stops: const [0.2, 0.5, 0.8],
            ).createShader(rect);
          },
          blendMode: BlendMode.srcATop,
          child: child,
        );
      },
    );
  }
}

class CnSkeletonLine extends StatelessWidget {
  final double? width;
  final double height;
  final bool animate;

  const CnSkeletonLine({
    super.key,
    this.width,
    this.height = 12,
    this.animate = true,
  });

  @override
  Widget build(BuildContext context) {
    return CnSkeleton(
      width: width,
      height: height,
      animate: animate,
      borderRadius: .circular(height / 2),
    );
  }
}

class CnSkeletonAvatar extends StatelessWidget {
  final double size;
  final bool animate;

  const CnSkeletonAvatar({super.key, this.size = 40, this.animate = true});

  @override
  Widget build(BuildContext context) {
    return CnSkeleton(
      width: size,
      height: size,
      animate: animate,
      isCircle: true,
    );
  }
}
