import 'package:flutter/widget_previews.dart';
import 'package:material_ui/material_ui.dart';

import '../theme/cn_theme.dart';

/// Visual style variants for [CnAlert].
enum CnAlertVariant { standard, info, success, warning, destructive }

/// A persistent message with a title, description and optional action.
///
/// See also:
///
///  * [CnToast], for temporary notification messages.
class const CnAlert({
  super.key,
  final CnAlertVariant variant = .standard,
  final Widget? title,
  final Widget? description,
  final Widget? leading,
  final Widget? trailing,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = CnTheme.of(context);
    final colors = theme.colors;
    final (accent, icon) = switch (variant) {
      .standard => (colors.foreground, null),
      .info => (colors.info, Icons.info_outline),
      .success => (colors.success, Icons.check_circle_outline),
      .warning => (colors.warning, Icons.warning_amber_outlined),
      .destructive => (colors.destructive, Icons.error_outline),
    };
    final resolvedLeading = leading ?? (icon == null ? null : Icon(icon));

    return Container(
      padding: const .symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: colors.card,
        borderRadius: .circular(theme.radius),
        border: Border.all(color: colors.border),
      ),
      child: Row(
        crossAxisAlignment: .start,
        spacing: 12,
        children: [
          if (resolvedLeading != null)
            IconTheme.merge(
              data: IconThemeData(color: accent, size: 16),
              child: resolvedLeading,
            ),
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              spacing: 4,
              children: [
                if (title != null)
                  DefaultTextStyle.merge(
                    style: theme.text.sm.medium.copyWith(
                      color: variant == .destructive
                          ? colors.destructive
                          : colors.cardForeground,
                    ),
                    child: title!,
                  ),
                if (description != null)
                  DefaultTextStyle.merge(
                    style: theme.text.sm.copyWith(
                      color: variant == .destructive
                          ? colors.destructive
                          : colors.mutedForeground,
                    ),
                    child: description!,
                  ),
              ],
            ),
          ),
          ?trailing,
        ],
      ),
    );
  }

  @Preview(size: Size(260, 450))
  static Widget preview() {
    return Column(
      spacing: 8,
      children: [
        for (final v in CnAlertVariant.values)
          CnAlert(
            variant: v,
            leading: Icon(Icons.hail),
            title: Text('Title'),
            description: Text(
              'Description in multiple lines. Description in multiple lines.',
            ),
          ),
      ],
    );
  }
}
