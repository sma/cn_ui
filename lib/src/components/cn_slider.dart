import 'package:flutter/material.dart';

/// A slider component for selecting numeric values from a range.
///
/// Wraps Flutter's Slider widget with a simple interface for value selection.
///
/// See also:
///
///  * [CnInput], for text-based numeric input.
class CnSlider extends StatelessWidget {
  final double value;
  final ValueChanged<double>? onChanged;
  final double min;
  final double max;
  final int? divisions;

  const CnSlider({
    super.key,
    required this.value,
    this.onChanged,
    this.min = 0,
    this.max = 100,
    this.divisions,
  });

  @override
  Widget build(BuildContext context) {
    return Slider(
      value: value,
      onChanged: onChanged,
      min: min,
      max: max,
      divisions: divisions,
    );
  }
}
