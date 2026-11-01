import 'package:flutter/widget_previews.dart';
import 'package:material_ui/material_ui.dart';

import '../theme/cn_theme.dart';

/// Visual style variants for [CnBadge].
enum CnBadgeVariant { primary, secondary, outline, ghost, destructive, link }

/// A small label component for highlighting information or status.
///
/// Commonly used to display counts, status indicators, or categorical labels.
///
/// See also:
///
///  * [CnButton], for actionable elements with similar visual variants.
class const CnBadge({
  super.key,
  final CnBadgeVariant variant = .primary,
  final Widget? leading,
  final Widget? trailing,
  required final Widget child,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = CnTheme.of(context);
    final colors = theme.colors;
    final (background, foreground, border) = switch (variant) {
      .primary => (colors.primary, colors.primaryForeground, null),
      .secondary => (colors.secondary, colors.secondaryForeground, null),
      .outline => (null, colors.foreground, colors.border),
      .ghost => (null, colors.foreground, null),
      .destructive => (
        colors.destructive.withValues(alpha: 0.1),
        colors.destructive,
        null,
      ),
      .link => (null, colors.primary, null),
    };

    return Container(
      padding: const .symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: background,
        borderRadius: .circular(theme.radii.full),
        border: border == null ? null : .all(color: border),
      ),
      child: IconTheme.merge(
        data: IconThemeData(color: foreground, size: 12),
        child: DefaultTextStyle.merge(
          style: theme.text.xs.medium.copyWith(
            color: foreground,
            decoration: variant == .link ? TextDecoration.underline : null,
          ),
          child: leading == null && trailing == null
              ? child
              : Row(
                  mainAxisSize: .min,
                  spacing: 4,
                  children: [?leading, child, ?trailing],
                ),
        ),
      ),
    );
  }

  @Preview()
  static Widget preview() {
    return Column(
      spacing: 16,
      children: [
        for (final v in CnBadgeVariant.values)
          CnBadge(variant: v, child: Text('Badge')),
        for (final v in CnBadgeVariant.values)
          CnBadge(variant: v, leading: Icon(Icons.hail), child: Text('Badge')),
      ],
    );
  }
}
