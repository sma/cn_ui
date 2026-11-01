import 'package:material_ui/material_ui.dart';

/// A loading indicator in the color of the surrounding icons.
///
/// See also:
///
///  * [CnProgress], for linear progress indicators.
class const CnSpinner({
  super.key,
  final double size = 16,
  final double strokeWidth = 2,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: size,
      child: CircularProgressIndicator(
        strokeWidth: strokeWidth,
        color: IconTheme.of(context).color,
      ),
    );
  }
}
