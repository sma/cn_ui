import 'package:flutter/widget_previews.dart';

import '../../cn_ui.dart';

/// A component for displaying multiple overlapping avatars.
///
/// See also:
///
///  * [CnAvatar], for individual avatars.
class CnAvatarGroup extends StatelessWidget {
  const CnAvatarGroup({
    super.key,
    this.direction = .horizontal,
    this.overlap = 0.75,
    this.outlineWidth = 2,
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

  /// How much of the next avatar should remain visible.
  final double overlap;

  /// The outline width behind each avatar.
  final double outlineWidth;

  /// The avatars.
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final background = CnTheme.of(context).colors.background;
    return Flex(
      direction: direction,
      mainAxisSize: .min,
      children: children.length < 2
          ? children
          : [
              for (var i = 0; i < children.length; i++)
                _wrapChild(children[i], background, i),
            ],
    );
  }

  Widget _wrapChild(Widget child, Color background, int index) {
    final isLast = index == children.length - 1;
    final wrapped = index == 0 ? child : _gap(child, background);
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

  Widget _gap(Widget child, Color background) {
    return DecoratedBox(
      decoration: ShapeDecoration(
        color: background,
        shape: const CircleBorder(),
      ),
      child: Padding(padding: EdgeInsets.all(outlineWidth), child: child),
    );
  }
}
