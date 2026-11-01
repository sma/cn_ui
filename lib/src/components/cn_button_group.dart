import 'package:material_ui/material_ui.dart';

import '../theme/cn_theme.dart';

/// Where a child sits in a [CnButtonGroup].
@immutable
class const CnButtonGroupPosition({
  required final Axis direction,
  required final bool isFirst,
  required final bool isLast,
}) {
  /// Rounds only the corners on the outside of the group.
  BorderRadiusGeometry borderRadius(double radius) {
    final corner = Radius.circular(radius);
    if (direction == .horizontal) {
      return BorderRadiusDirectional.horizontal(
        start: isFirst ? corner : Radius.zero,
        end: isLast ? corner : Radius.zero,
      );
    }
    return BorderRadius.vertical(
      top: isFirst ? corner : Radius.zero,
      bottom: isLast ? corner : Radius.zero,
    );
  }
}

/// Arranges buttons as one connected control.
///
/// The group only lays out its children. Children such as [CnButton] ask
/// [CnButtonGroup.of] for their position and adapt their own corners.
///
/// See also:
///
///  * [CnToggleGroup], for toggle button groups.
///  * [CnButton], for individual buttons.
class const CnButtonGroup({
  super.key,
  required final List<Widget> children,
  final Axis direction = .horizontal,
}) extends StatelessWidget {
  /// Returns the position of the calling widget in the enclosing group.
  static CnButtonGroupPosition? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_CnButtonGroupScope>()
        ?.position;
  }

  @override
  Widget build(BuildContext context) {
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    // Neighbors overlap by one pixel so that they share their border.
    var overlap = 0;
    final items = <Widget>[];
    for (var i = 0; i < children.length; i++) {
      final child = children[i];
      final separated =
          child is CnButtonGroupSeparator ||
          (i > 0 && children[i - 1] is CnButtonGroupSeparator);
      if (i > 0 && !separated) {
        overlap++;
      }
      final shift = overlap.toDouble();
      items.add(
        Transform.translate(
          offset: direction == .horizontal
              ? Offset(isRtl ? shift : -shift, 0)
              : Offset(0, -shift),
          child: _CnButtonGroupScope(
            position: CnButtonGroupPosition(
              direction: direction,
              isFirst: i == 0,
              isLast: i == children.length - 1,
            ),
            child: child,
          ),
        ),
      );
    }

    return direction == .horizontal
        ? IntrinsicHeight(
            child: Row(
              mainAxisSize: .min,
              crossAxisAlignment: .stretch,
              children: items,
            ),
          )
        : IntrinsicWidth(
            child: Column(
              mainAxisSize: .min,
              crossAxisAlignment: .stretch,
              children: items,
            ),
          );
  }
}

/// A divider for separating buttons in a [CnButtonGroup].
class const CnButtonGroupSeparator({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final color = CnTheme.of(context).colors.border;
    if (CnButtonGroup.of(context)?.direction == .vertical) {
      return Divider(height: 1, thickness: 1, color: color);
    }
    return VerticalDivider(width: 1, thickness: 1, color: color);
  }
}

/// A text label within a [CnButtonGroup].
class const CnButtonGroupText({super.key, required final Widget child})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = CnTheme.of(context);
    final radius = theme.radii.md;

    return Container(
      alignment: .center,
      padding: const .symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: theme.colors.muted,
        borderRadius:
            CnButtonGroup.of(context)?.borderRadius(radius) ??
            BorderRadius.circular(radius),
        border: Border.all(color: theme.colors.input),
      ),
      child: DefaultTextStyle.merge(
        style: theme.text.sm.medium,
        textAlign: .center,
        child: child,
      ),
    );
  }
}

class const _CnButtonGroupScope({
  required final CnButtonGroupPosition position,
  required super.child,
}) extends InheritedWidget {
  @override
  bool updateShouldNotify(_CnButtonGroupScope oldWidget) {
    return oldWidget.position.direction != position.direction ||
        oldWidget.position.isFirst != position.isFirst ||
        oldWidget.position.isLast != position.isLast;
  }
}
