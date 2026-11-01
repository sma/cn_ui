import 'package:flutter/widget_previews.dart';
import 'package:material_ui/material_ui.dart';

import '../../cn_ui.dart';

/// A component for displaying multiple overlapping avatars.
///
/// Arranges avatars horizontally or vertically with configurable overlap and outline styling.
///
/// See also:
///
///  * [CnAvatar], for individual avatars.
class CnAvatarGroup extends StatelessWidget {
  const CnAvatarGroup({
    super.key,
    this.direction = .horizontal,
    this.color,
    this.overlap = 0.75,
    this.outlineWidth = 4,
    this.outlineShape,
    required this.children,
  }) : assert(overlap > 0 && overlap <= 1, 'overlap must be between 0 and 1.');

  @Preview()
  static Widget preview() {
    return Column(
      spacing: 16,
      children: [
        for (final v in Axis.values)
          for (var i = 1; i <= 3; i++)
            CnAvatarGroup(
              direction: v,
              children: [CnAvatar(), CnAvatar(), CnAvatar()].sublist(0, i),
            ),
      ],
    );
  }

  /// Displays children as a row (the default) or column.
  final Axis direction;

  /// Background color, defaults to `surface`.
  final Color? color;

  /// How much of the next avatar should remain visible.
  final double overlap;

  /// The outline width behind each avatar.
  final double outlineWidth;

  /// The shape used for the background outline.
  final ShapeBorder? outlineShape;

  /// The avatars.
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final bg = color ?? ColorScheme.of(context).surface;
    final resolvedShape = outlineShape ?? const CircleBorder();
    return ColoredBox(
      color: bg,
      child: Flex(
        direction: direction,
        mainAxisSize: .min,
        children: children.length < 2
            ? children
            : [
                for (var i = 0; i < children.length; i++)
                  _wrapChild(children[i], bg, resolvedShape, i),
              ],
      ),
    );
  }

  Widget _wrapChild(Widget child, Color bg, ShapeBorder shape, int index) {
    final isLast = index == children.length - 1;
    final wrapped = index == 0 ? child : _gap(child, bg, shape);
    final shouldShrink = index == 0 || !isLast;
    return shouldShrink ? _shrink(wrapped) : wrapped;
  }

  Widget _shrink(Widget child) {
    return switch (direction) {
      .horizontal => Align(
        alignment: .centerStart,
        widthFactor: overlap,
        child: child,
      ),
      .vertical => Align(
        alignment: .topCenter,
        heightFactor: overlap,
        child: child,
      ),
    };
  }

  Widget _gap(Widget child, Color bg, ShapeBorder shape) {
    return DecoratedBox(
      decoration: ShapeDecoration(color: bg, shape: shape),
      child: Padding(padding: EdgeInsets.all(outlineWidth), child: child),
    );
  }
}
