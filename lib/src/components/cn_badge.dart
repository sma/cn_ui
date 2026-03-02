import 'dart:math' as math;

import 'package:cn_ui/previews.dart';
import 'package:flutter/material.dart';

import '../theme/cn_theme.dart';

/// Visual style variants for [CnBadge].
enum CnBadgeVariant { primary, secondary, outline, destructive }

/// A small label component for highlighting information or status.
///
/// Commonly used to display counts, status indicators, or categorical labels.
///
/// See also:
///
///  * [CnButton], for actionable elements with similar visual variants.
class CnBadge extends StatelessWidget {
  const CnBadge({super.key, this.variant = .primary, required this.child});
  final CnBadgeVariant variant;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final scheme = CnTheme.colorSchemeOf(context);
    final cnTheme = CnTheme.of(context);
    final visuals = _resolveVisuals(variant, scheme);

    return Container(
      padding: const .symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: visuals.background,
        borderRadius: .circular(math.max(0, cnTheme.radius - 4)),
        border: Border.all(color: visuals.border),
      ),
      child: DefaultTextStyle(
        style:
            CnTheme.textThemeOf(
              context,
            ).labelSmall?.copyWith(color: visuals.foreground) ??
            TextStyle(color: visuals.foreground),
        child: child,
      ),
    );
  }

  _CnBadgeVisuals _resolveVisuals(CnBadgeVariant variant, ColorScheme scheme) {
    return switch (variant) {
      .primary => _CnBadgeVisuals(
        background: scheme.primary,
        foreground: scheme.onPrimary,
        border: scheme.primary,
      ),
      .secondary => _CnBadgeVisuals(
        background: scheme.secondaryContainer,
        foreground: scheme.onSecondaryContainer,
        border: scheme.secondaryContainer,
      ),
      .outline => _CnBadgeVisuals(
        background: Colors.transparent,
        foreground: scheme.onSurface,
        border: scheme.outline,
      ),
      .destructive => _CnBadgeVisuals(
        background: scheme.error,
        foreground: scheme.onError,
        border: scheme.error,
      ),
    };
  }

  @Preview()
  static Widget preview() {
    return Column(
      spacing: 8,
      children: [
        for (final v in CnBadgeVariant.values)
          CnBadge(variant: v, child: Text('Badge')),
      ],
    );
  }
}

class _CnBadgeVisuals {
  const _CnBadgeVisuals({
    required this.background,
    required this.foreground,
    required this.border,
  });
  final Color background;
  final Color foreground;
  final Color border;
}
