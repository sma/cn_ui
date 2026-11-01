import 'package:material_ui/material_ui.dart';

import '../theme/cn_theme.dart';

/// Two panels with a handle between them.
///
/// [value] is the share of the [primary] panel, from 0 to 1. A `null`
/// [onChanged] makes the handle inert.
class const CnResizable({
  super.key,
  required final Widget primary,
  required final Widget secondary,
  required final double value,
  final ValueChanged<double>? onChanged,
  final Axis direction = .horizontal,
  final double minValue = 0.2,
  final double maxValue = 0.8,
  final double handleSize = 12,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isHorizontal = direction == .horizontal;
    final ratio = value.clamp(minValue, maxValue);
    final scale = 1000;
    final primaryFlex = (ratio * scale).round().clamp(1, scale - 1);

    return LayoutBuilder(
      builder: (context, constraints) {
        final mainSize = isHorizontal
            ? constraints.maxWidth
            : constraints.maxHeight;
        final available = mainSize - handleSize;
        final isRtl =
            isHorizontal && Directionality.of(context) == TextDirection.rtl;

        void handleDrag(double delta) {
          if (onChanged == null || !available.isFinite || available <= 0) {
            return;
          }
          final signed = isRtl ? -delta : delta;
          final next = (ratio + signed / available).clamp(minValue, maxValue);
          if (next != ratio) {
            onChanged!(next);
          }
        }

        return Flex(
          direction: direction,
          children: [
            Expanded(flex: primaryFlex, child: primary),
            MouseRegion(
              cursor: isHorizontal
                  ? SystemMouseCursors.resizeColumn
                  : SystemMouseCursors.resizeRow,
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onHorizontalDragUpdate: isHorizontal
                    ? (details) => handleDrag(details.delta.dx)
                    : null,
                onVerticalDragUpdate: isHorizontal
                    ? null
                    : (details) => handleDrag(details.delta.dy),
                child: SizedBox(
                  width: isHorizontal ? handleSize : double.infinity,
                  height: isHorizontal ? double.infinity : handleSize,
                  child: Center(child: _Handle(isHorizontal: isHorizontal)),
                ),
              ),
            ),
            Expanded(flex: scale - primaryFlex, child: secondary),
          ],
        );
      },
    );
  }
}

class const _Handle({required final bool isHorizontal})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = CnTheme.of(context);
    return Container(
      width: isHorizontal ? 3 : 36,
      height: isHorizontal ? 36 : 3,
      decoration: BoxDecoration(
        color: theme.colors.border,
        borderRadius: .circular(theme.radii.full),
      ),
    );
  }
}
