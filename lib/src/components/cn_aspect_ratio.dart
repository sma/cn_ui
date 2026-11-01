import 'package:flutter/widgets.dart';

import '../theme/cn_theme.dart';

/// Keeps its child at a given aspect ratio, with rounded corners.
class const CnAspectRatio({
  super.key,
  required final double aspectRatio,
  required final Widget child,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: .circular(CnTheme.of(context).radius),
      child: AspectRatio(aspectRatio: aspectRatio, child: child),
    );
  }
}
