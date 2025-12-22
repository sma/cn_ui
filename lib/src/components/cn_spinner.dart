import 'package:flutter/material.dart';

import '../../cn_ui.dart';

/// A circular loading spinner component.
///
/// Wraps Flutter's CircularProgressIndicator with customizable size and stroke width.
///
/// See also:
///
///  * [CnProgress], for linear progress indicators.
class CnSpinner extends StatelessWidget {
  final double size;
  final double strokeWidth;
  final Color? color;

  const CnSpinner({
    super.key,
    this.size = 20,
    this.strokeWidth = 2.5,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = CnTheme.colorSchemeOf(context);
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        strokeWidth: strokeWidth,
        color: color ?? scheme.primary,
      ),
    );
  }
}
