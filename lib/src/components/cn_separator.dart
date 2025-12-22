import 'package:flutter/material.dart';

/// A visual separator for dividing content horizontally or vertically.
///
/// Wraps Flutter's Divider and VerticalDivider with a consistent interface.
///
/// See also:
///
///  * [Divider], the underlying horizontal separator widget.
///  * [VerticalDivider], the underlying vertical separator widget.
class CnSeparator extends StatelessWidget {
  final Axis direction;
  final double thickness;
  final double? length;

  const CnSeparator({
    super.key,
    this.direction = .horizontal,
    this.thickness = 1,
    this.length,
  });

  @override
  Widget build(BuildContext context) {
    if (direction == .vertical) {
      return SizedBox(
        height: length,
        child: VerticalDivider(thickness: thickness),
      );
    }
    return SizedBox(
      width: length,
      child: Divider(thickness: thickness, height: thickness),
    );
  }
}
