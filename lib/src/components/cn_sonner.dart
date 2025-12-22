import 'package:flutter/material.dart';

import '../theme/cn_theme.dart';
import 'cn_spinner.dart';

/// Visual style variants for [CnSonner].
enum CnSonnerVariant { neutral, success, info, warning, error, loading }

/// A utility class for displaying rich toast notifications with icons and actions.
///
/// Provides a static method to show styled toast messages with variant-specific icons and colors.
///
/// See also:
///
///  * [CnToast], for simpler toast notifications.
///  * [CnAlert], for persistent alert messages.
class CnSonner {
  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> show(
    BuildContext context, {
    required String title,
    String? description,
    CnSonnerVariant variant = .neutral,
    Duration duration = const Duration(seconds: 4),
    String? actionLabel,
    VoidCallback? onAction,
    bool replace = true,
  }) {
    final messenger = ScaffoldMessenger.of(context);
    if (replace) {
      messenger.clearSnackBars();
    }

    final scheme = CnTheme.colorSchemeOf(context);
    final textTheme = CnTheme.textThemeOf(context);
    final cnTheme = CnTheme.of(context);
    final visuals = _resolveVisuals(variant, scheme);

    final snackBar = SnackBar(
      duration: duration,
      backgroundColor: visuals.background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(cnTheme.radius),
        side: BorderSide(color: visuals.border),
      ),
      action: actionLabel == null
          ? null
          : SnackBarAction(
              label: actionLabel,
              textColor: visuals.accent,
              onPressed: onAction ?? () {},
            ),
      content: Row(
        crossAxisAlignment: .start,
        spacing: 12,
        children: [
          _buildLeading(variant, visuals.accent),
          Expanded(
            child: Column(
              mainAxisSize: .min,
              crossAxisAlignment: .start,
              spacing: 4,
              children: [
                Text(
                  title,
                  style: textTheme.bodyMedium?.copyWith(
                    fontWeight: .w600,
                    color: visuals.foreground,
                  ),
                ),
                if (description != null)
                  Text(
                    description,
                    style: textTheme.bodySmall?.copyWith(color: visuals.muted),
                  ),
              ],
            ),
          ),
        ],
      ),
    );

    return messenger.showSnackBar(snackBar);
  }

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> success(
    BuildContext context, {
    required String title,
    String? description,
    Duration duration = const Duration(seconds: 4),
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    return show(
      context,
      title: title,
      description: description,
      duration: duration,
      actionLabel: actionLabel,
      onAction: onAction,
      variant: .success,
    );
  }

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> info(
    BuildContext context, {
    required String title,
    String? description,
    Duration duration = const Duration(seconds: 4),
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    return show(
      context,
      title: title,
      description: description,
      duration: duration,
      actionLabel: actionLabel,
      onAction: onAction,
      variant: .info,
    );
  }

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> warning(
    BuildContext context, {
    required String title,
    String? description,
    Duration duration = const Duration(seconds: 4),
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    return show(
      context,
      title: title,
      description: description,
      duration: duration,
      actionLabel: actionLabel,
      onAction: onAction,
      variant: .warning,
    );
  }

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> error(
    BuildContext context, {
    required String title,
    String? description,
    Duration duration = const Duration(seconds: 4),
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    return show(
      context,
      title: title,
      description: description,
      duration: duration,
      actionLabel: actionLabel,
      onAction: onAction,
      variant: .error,
    );
  }

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> loading(
    BuildContext context, {
    required String title,
    String? description,
    Duration duration = const Duration(seconds: 8),
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    return show(
      context,
      title: title,
      description: description,
      duration: duration,
      actionLabel: actionLabel,
      onAction: onAction,
      variant: .loading,
    );
  }

  static Widget _buildLeading(CnSonnerVariant variant, Color color) {
    return switch (variant) {
      .success => Icon(Icons.check_circle_outline, color: color),
      .info => Icon(Icons.info_outline, color: color),
      .warning => Icon(Icons.warning_amber_outlined, color: color),
      .error => Icon(Icons.error_outline, color: color),
      .loading => CnSpinner(size: 18, strokeWidth: 2, color: color),
      .neutral => Icon(Icons.notifications_none, color: color),
    };
  }

  static _CnSonnerVisuals _resolveVisuals(
    CnSonnerVariant variant,
    ColorScheme scheme,
  ) {
    final border = scheme.outlineVariant;

    return switch (variant) {
      .success => _CnSonnerVisuals(
        background: scheme.surface,
        foreground: scheme.onSurface,
        muted: scheme.onSurfaceVariant,
        accent: scheme.tertiary,
        border: border,
      ),
      .info => _CnSonnerVisuals(
        background: scheme.surface,
        foreground: scheme.onSurface,
        muted: scheme.onSurfaceVariant,
        accent: scheme.primary,
        border: border,
      ),
      .warning => _CnSonnerVisuals(
        background: scheme.surface,
        foreground: scheme.onSurface,
        muted: scheme.onSurfaceVariant,
        accent: scheme.secondary,
        border: border,
      ),
      .error => _CnSonnerVisuals(
        background: scheme.surface,
        foreground: scheme.onSurface,
        muted: scheme.onSurfaceVariant,
        accent: scheme.error,
        border: border,
      ),
      .loading => _CnSonnerVisuals(
        background: scheme.surface,
        foreground: scheme.onSurface,
        muted: scheme.onSurfaceVariant,
        accent: scheme.primary,
        border: border,
      ),
      .neutral => _CnSonnerVisuals(
        background: scheme.surface,
        foreground: scheme.onSurface,
        muted: scheme.onSurfaceVariant,
        accent: scheme.primary,
        border: border,
      ),
    };
  }
}

class _CnSonnerVisuals {
  final Color background;
  final Color foreground;
  final Color muted;
  final Color accent;
  final Color border;

  const _CnSonnerVisuals({
    required this.background,
    required this.foreground,
    required this.muted,
    required this.accent,
    required this.border,
  });
}
