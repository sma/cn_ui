import 'package:flutter/material.dart';

import '../theme/cn_theme.dart';

/// A linear progress indicator component.
///
/// Wraps Flutter's LinearProgressIndicator with themed styling and customizable height.
///
/// See also:
///
///  * [CnSpinner], for circular loading indicators.
class CnProgress extends StatelessWidget {
  final double? value;
  final double height;

  const CnProgress({super.key, this.value, this.height = 8});

  @override
  Widget build(BuildContext context) {
    final cnTheme = CnTheme.of(context);
    return ClipRRect(
      borderRadius: .circular(cnTheme.radius),
      child: LinearProgressIndicator(value: value, minHeight: height),
    );
  }
}
