import 'package:flutter/material.dart';

import '../theme/cn_theme.dart';

/// A container that maintains a specific aspect ratio with rounded corners.
///
/// Wraps Flutter's AspectRatio with ClipRRect for themed border radius.
///
/// See also:
///
///  * [AspectRatio], the underlying aspect ratio widget.
class CnAspectRatio extends StatelessWidget {
  const CnAspectRatio({
    super.key,
    required this.aspectRatio,
    required this.child,
    this.radius,
  });
  final double aspectRatio;
  final Widget child;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    final resolvedRadius = radius ?? CnTheme.of(context).radius;
    return ClipRRect(
      borderRadius: .circular(resolvedRadius),
      child: AspectRatio(aspectRatio: aspectRatio, child: child),
    );
  }
}
