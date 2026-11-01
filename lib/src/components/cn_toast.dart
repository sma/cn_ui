import 'package:material_ui/material_ui.dart';

import '../theme/cn_theme.dart';
import 'cn_spinner.dart';

/// Visual style variants for [CnToast].
enum CnToastVariant { standard, success, info, warning, error, loading }

/// Shows brief messages. They need a [ScaffoldMessenger] above them.
///
/// Every method returns a function that closes the toast.
///
/// See also:
///
///  * [CnAlert], for persistent messages.
abstract final class CnToast {
  static VoidCallback show(
    BuildContext context, {
    required Widget title,
    Widget? description,
    Widget? action,
    CnToastVariant variant = .standard,
    Duration duration = const Duration(seconds: 4),
    bool replace = true,
  }) {
    final messenger = ScaffoldMessenger.of(context);
    if (replace) {
      messenger.clearSnackBars();
    }
    final theme = CnTheme.of(context);
    final colors = theme.colors;
    final leading = switch (variant) {
      .standard => null,
      .success => Icon(Icons.check_circle_outline, color: colors.success),
      .info => Icon(Icons.info_outline, color: colors.info),
      .warning => Icon(Icons.warning_amber_outlined, color: colors.warning),
      .error => Icon(Icons.error_outline, color: colors.destructive),
      .loading => const CnSpinner(size: 16),
    };

    final controller = messenger.showSnackBar(
      SnackBar(
        duration: duration,
        backgroundColor: colors.popover,
        content: IconTheme.merge(
          data: const IconThemeData(size: 16),
          child: Row(
            spacing: 12,
            children: [
              ?leading,
              Expanded(
                child: Column(
                  mainAxisSize: .min,
                  crossAxisAlignment: .start,
                  spacing: 2,
                  children: [
                    DefaultTextStyle.merge(
                      style: theme.text.sm.medium.copyWith(
                        color: colors.popoverForeground,
                      ),
                      child: title,
                    ),
                    if (description != null)
                      DefaultTextStyle.merge(
                        style: theme.text.sm.copyWith(
                          color: colors.mutedForeground,
                        ),
                        child: description,
                      ),
                  ],
                ),
              ),
              ?action,
            ],
          ),
        ),
      ),
    );
    return controller.close;
  }

  static VoidCallback success(
    BuildContext context, {
    required Widget title,
    Widget? description,
    Widget? action,
  }) => show(
    context,
    title: title,
    description: description,
    action: action,
    variant: .success,
  );

  static VoidCallback info(
    BuildContext context, {
    required Widget title,
    Widget? description,
    Widget? action,
  }) => show(
    context,
    title: title,
    description: description,
    action: action,
    variant: .info,
  );

  static VoidCallback warning(
    BuildContext context, {
    required Widget title,
    Widget? description,
    Widget? action,
  }) => show(
    context,
    title: title,
    description: description,
    action: action,
    variant: .warning,
  );

  static VoidCallback error(
    BuildContext context, {
    required Widget title,
    Widget? description,
    Widget? action,
  }) => show(
    context,
    title: title,
    description: description,
    action: action,
    variant: .error,
  );

  /// Shows a toast that stays until the returned function closes it.
  static VoidCallback loading(
    BuildContext context, {
    required Widget title,
    Widget? description,
  }) => show(
    context,
    title: title,
    description: description,
    variant: .loading,
    duration: const Duration(days: 1),
  );
}
