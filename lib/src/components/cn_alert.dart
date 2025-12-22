import 'package:flutter/material.dart';

import '../theme/cn_theme.dart';

/// Visual style variants for [CnAlert].
enum CnAlertVariant { neutral, info, success, warning, destructive }

/// An alert component for displaying important messages with contextual styling.
///
/// Provides visual feedback with title, description, icon, and variant-specific colors.
///
/// See also:
///
///  * [CnToast], for temporary notification messages.
///  * [CnSonner], for toast-style notifications.
class CnAlert extends StatelessWidget {
  final CnAlertVariant variant;
  final Widget? title;
  final Widget? description;
  final Widget? leading;
  final Widget? trailing;
  final EdgeInsetsGeometry? padding;

  const CnAlert({
    super.key,
    this.variant = .neutral,
    this.title,
    this.description,
    this.leading,
    this.trailing,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = CnTheme.colorSchemeOf(context);
    final cnTheme = CnTheme.of(context);
    final visuals = _resolveVisuals(scheme);
    final resolvedLeading = leading ?? visuals.icon;

    return Container(
      padding: padding ?? const .all(16),
      decoration: BoxDecoration(
        color: visuals.background,
        borderRadius: .circular(cnTheme.radius),
        border: Border.all(color: visuals.border),
      ),
      child: Row(
        crossAxisAlignment: .start,
        spacing: 12,
        children: [
          if (resolvedLeading != null) ...[
            IconTheme(
              data: IconThemeData(color: visuals.accent, size: 20),
              child: resolvedLeading,
            ),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              spacing: 6,
              children: [
                if (title != null)
                  DefaultTextStyle(
                    style:
                        CnTheme.textThemeOf(context).titleSmall?.copyWith(
                          color: visuals.foreground,
                          fontWeight: .w600,
                        ) ??
                        TextStyle(color: visuals.foreground),
                    child: title!,
                  ),
                if (description != null)
                  DefaultTextStyle(
                    style:
                        CnTheme.textThemeOf(
                          context,
                        ).bodySmall?.copyWith(color: visuals.foreground) ??
                        TextStyle(color: visuals.foreground),
                    child: description!,
                  ),
              ],
            ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }

  _AlertVisuals _resolveVisuals(ColorScheme scheme) {
    return switch (variant) {
      .neutral => _AlertVisuals(
        background: scheme.surfaceContainerHighest,
        border: scheme.outlineVariant,
        foreground: scheme.onSurface,
        accent: scheme.onSurfaceVariant,
        icon: const Icon(Icons.info_outline),
      ),
      .info => _AlertVisuals(
        background: scheme.primaryContainer,
        border: scheme.primary,
        foreground: scheme.onPrimaryContainer,
        accent: scheme.primary,
        icon: const Icon(Icons.auto_awesome),
      ),
      .success => _AlertVisuals(
        background: scheme.secondaryContainer,
        border: scheme.secondary,
        foreground: scheme.onSecondaryContainer,
        accent: scheme.secondary,
        icon: const Icon(Icons.check_circle_outline),
      ),
      .warning => _AlertVisuals(
        background: scheme.tertiaryContainer,
        border: scheme.tertiary,
        foreground: scheme.onTertiaryContainer,
        accent: scheme.tertiary,
        icon: const Icon(Icons.warning_amber_outlined),
      ),
      .destructive => _AlertVisuals(
        background: scheme.errorContainer,
        border: scheme.error,
        foreground: scheme.onErrorContainer,
        accent: scheme.error,
        icon: const Icon(Icons.error_outline),
      ),
    };
  }
}

class _AlertVisuals {
  final Color background;
  final Color border;
  final Color foreground;
  final Color accent;
  final Widget? icon;

  const _AlertVisuals({
    required this.background,
    required this.border,
    required this.foreground,
    required this.accent,
    required this.icon,
  });
}
