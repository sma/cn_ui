import 'package:flutter/material.dart';

import '../theme/cn_theme.dart';

/// A modal dialog component for displaying content over the main interface.
///
/// Provides a centered overlay with optional title, description, content, and action buttons.
///
/// See also:
///
///  * [CnAlertDialog], for simpler alert-style dialogs.
///  * [CnSheet], for bottom sheet dialogs.
///  * [CnDrawer], for side panel dialogs.
class CnDialog extends StatelessWidget {
  final Widget? title;
  final Widget? description;
  final Widget? content;
  final List<Widget> actions;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? actionsPadding;
  final double maxWidth;
  final bool showCloseButton;
  final VoidCallback? onClose;

  const CnDialog({
    super.key,
    this.title,
    this.description,
    this.content,
    this.actions = const [],
    this.padding,
    this.actionsPadding,
    this.maxWidth = 440,
    this.showCloseButton = true,
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final cnTheme = CnTheme.of(context);
    final scheme = CnTheme.colorSchemeOf(context);
    final close = onClose ?? () => Navigator.of(context).maybePop();

    final header = (title == null && description == null)
        ? null
        : Column(
            crossAxisAlignment: .start,
            spacing: 6,
            children: [
              if (title != null)
                DefaultTextStyle(
                  style:
                      CnTheme.textThemeOf(context).titleLarge ??
                      const TextStyle(),
                  child: title!,
                ),
              if (description != null)
                DefaultTextStyle(
                  style:
                      CnTheme.textThemeOf(
                        context,
                      ).bodyMedium?.copyWith(color: scheme.onSurfaceVariant) ??
                      TextStyle(color: scheme.onSurfaceVariant),
                  child: description!,
                ),
            ],
          );
    final hasBodyContent = header != null || content != null;
    final actionsTopPadding = hasBodyContent ? 4.0 : 20.0;

    return Dialog(
      backgroundColor: scheme.surface,
      surfaceTintColor: Colors.transparent,
      insetPadding: const .symmetric(horizontal: 24, vertical: 24),
      shape: RoundedRectangleBorder(
        borderRadius: .circular(cnTheme.radius),
        side: BorderSide(color: scheme.outlineVariant),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Padding(
          padding: padding ?? const .fromLTRB(24, 20, 24, 20),
          child: Column(
            mainAxisSize: .min,
            crossAxisAlignment: .start,
            children: [
              if (showCloseButton)
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: const Icon(Icons.close),
                    tooltip: 'Close',
                    onPressed: close,
                  ),
                ),
              if (header != null || content != null || actions.isNotEmpty)
                Column(
                  crossAxisAlignment: .start,
                  spacing: 16,
                  children: [
                    if (header != null) header,
                    if (content != null) content!,
                    if (actions.isNotEmpty)
                      Padding(
                        padding: (actionsPadding ?? .zero).add(
                          EdgeInsets.only(top: actionsTopPadding),
                        ),
                        child: Row(
                          mainAxisAlignment: .end,
                          spacing: 12,
                          children: actions,
                        ),
                      ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
