import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/cn_theme.dart';

/// A keyboard key component for displaying keyboard shortcuts.
///
/// Renders keyboard keys with styled borders and backgrounds for documentation and UI hints.
///
/// See also:
///
///  * [CnKbdGroup], for grouping multiple keyboard keys.
class CnKbd extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final Color? borderColor;

  const CnKbd({
    super.key,
    required this.child,
    this.padding,
    this.backgroundColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = CnTheme.colorSchemeOf(context);
    final cnTheme = CnTheme.of(context);

    return Container(
      padding:
          padding ?? const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor ?? scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(math.max(0, cnTheme.radius - 6)),
        border: Border.all(color: borderColor ?? scheme.outlineVariant),
      ),
      child: DefaultTextStyle(
        style:
            CnTheme.textThemeOf(
              context,
            ).labelSmall?.copyWith(fontWeight: .w600) ??
            const TextStyle(fontWeight: FontWeight.w600),
        child: child,
      ),
    );
  }
}

/// A group of keyboard keys for [CnKbd].
class CnKbdGroup extends StatelessWidget {
  final List<Widget> children;
  final double spacing;

  const CnKbdGroup({super.key, required this.children, this.spacing = 6});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisSize: .min, spacing: spacing, children: children);
  }
}
