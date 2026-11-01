import 'package:material_ui/material_ui.dart';

import '../theme/cn_theme.dart';

/// A pulsing placeholder for content that is still loading.
///
/// See also:
///
///  * [CnSpinner], for loading spinners.
///  * [CnProgress], for progress indicators.
class CnSkeleton extends StatefulWidget {
  const CnSkeleton({
    super.key,
    this.width,
    this.height,
    this.circle = false,
    this.animate = true,
  });
  final double? width;
  final double? height;
  final bool circle;
  final bool animate;

  @override
  State<CnSkeleton> createState() => _CnSkeletonState();
}

class _CnSkeletonState extends State<CnSkeleton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
      lowerBound: 0.5,
      upperBound: 1,
    );
    _sync();
  }

  @override
  void didUpdateWidget(covariant CnSkeleton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.animate != widget.animate) {
      _sync();
    }
  }

  void _sync() {
    if (widget.animate) {
      _controller.repeat(reverse: true);
    } else {
      _controller.value = _controller.upperBound;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = CnTheme.of(context);

    return FadeTransition(
      opacity: _controller,
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: theme.colors.muted,
          borderRadius: widget.circle ? null : .circular(theme.radii.md),
          shape: widget.circle ? BoxShape.circle : BoxShape.rectangle,
        ),
      ),
    );
  }
}

/// A [CnSkeleton] in the shape of a line of text.
class const CnSkeletonLine({
  super.key,
  final double? width,
  final double height = 16,
  final bool animate = true,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CnSkeleton(width: width, height: height, animate: animate);
  }
}

/// A [CnSkeleton] in the shape of an avatar.
class const CnSkeletonAvatar({
  super.key,
  final double size = 32,
  final bool animate = true,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CnSkeleton(
      width: size,
      height: size,
      animate: animate,
      circle: true,
    );
  }
}
