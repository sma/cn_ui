import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/cn_theme.dart';

/// Orientation variants for [CnButtonGroup].
enum CnButtonGroupOrientation { horizontal, vertical }

/// A container for grouping buttons together with shared borders.
///
/// Arranges buttons horizontally or vertically with connected styling.
///
/// See also:
///
///  * [CnToggleGroup], for toggle button groups.
///  * [CnButton], for individual buttons.
class CnButtonGroup extends StatelessWidget {
  final List<Widget> children;
  final CnButtonGroupOrientation orientation;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;
  final Color? backgroundColor;
  final Color? borderColor;

  const CnButtonGroup({
    super.key,
    required this.children,
    this.orientation = .horizontal,
    this.padding,
    this.borderRadius,
    this.backgroundColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = CnTheme.colorSchemeOf(context);
    final cnTheme = CnTheme.of(context);
    final resolvedRadius =
        borderRadius ?? BorderRadius.circular(math.max(0, cnTheme.radius - 4));
    final resolvedBackground = backgroundColor ?? scheme.surface;
    final resolvedBorder = borderColor ?? scheme.outlineVariant;

    final content = orientation == .horizontal
        ? Row(mainAxisSize: .min, children: children)
        : Column(mainAxisSize: .min, children: children);

    return _CnButtonGroupScope(
      orientation: orientation,
      child: Material(
        color: resolvedBackground,
        shape: RoundedRectangleBorder(
          borderRadius: resolvedRadius,
          side: BorderSide(color: resolvedBorder),
        ),
        clipBehavior: Clip.antiAlias,
        child: Padding(padding: padding ?? .zero, child: content),
      ),
    );
  }
}

/// A divider for separating buttons in a [CnButtonGroup].
class CnButtonGroupSeparator extends StatelessWidget {
  final CnButtonGroupOrientation? orientation;
  final double thickness;
  final Color? color;

  const CnButtonGroupSeparator({
    super.key,
    this.orientation,
    this.thickness = 1,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = CnTheme.colorSchemeOf(context);
    final resolvedOrientation =
        orientation ??
        _CnButtonGroupScope.of(context)?.orientation ??
        .horizontal;
    final resolvedColor = color ?? scheme.outlineVariant;

    if (resolvedOrientation == .vertical) {
      return Divider(
        height: thickness,
        thickness: thickness,
        color: resolvedColor,
      );
    }

    return VerticalDivider(
      width: thickness,
      thickness: thickness,
      color: resolvedColor,
    );
  }
}

/// A text label within a [CnButtonGroup].
class CnButtonGroupText extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final TextStyle? style;

  const CnButtonGroupText({
    super.key,
    required this.child,
    this.padding,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = CnTheme.colorSchemeOf(context);
    final resolvedStyle =
        style ??
        CnTheme.textThemeOf(context).bodySmall?.copyWith(
          color: scheme.onSurfaceVariant,
          fontWeight: .w600,
        );

    return Padding(
      padding:
          padding ?? const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: DefaultTextStyle(
        style: resolvedStyle ?? TextStyle(color: scheme.onSurfaceVariant),
        child: child,
      ),
    );
  }
}

class _CnButtonGroupScope extends InheritedWidget {
  final CnButtonGroupOrientation orientation;

  const _CnButtonGroupScope({required this.orientation, required super.child});

  static _CnButtonGroupScope? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_CnButtonGroupScope>();
  }

  @override
  bool updateShouldNotify(_CnButtonGroupScope oldWidget) {
    return oldWidget.orientation != orientation;
  }
}
