import 'package:flutter/material.dart';

import '../theme/cn_theme.dart';

/// A builder function for creating bottom sheets.
typedef CnSheetBuilder = Widget Function(BuildContext context);

/// Shows a bottom sheet using the provided builder function.
Future<T?> showCnSheet<T>({
  required BuildContext context,
  required CnSheetBuilder builder,
  bool isDismissible = true,
  bool enableDrag = true,
  bool useSafeArea = true,
  Color? barrierColor,
}) {
  return showModalBottomSheet<T>(
    context: context,
    isDismissible: isDismissible,
    enableDrag: enableDrag,
    useSafeArea: useSafeArea,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    barrierColor: barrierColor,
    builder: builder,
  );
}

/// A bottom sheet component that slides up from the bottom of the screen.
///
/// Provides a modal overlay with optional handle, title, description, content, and actions.
///
/// See also:
///
///  * [CnDialog], for centered modal dialogs.
///  * [CnDrawer], for side panel drawers.
///  * [showCnSheet], for showing sheets programmatically.
class CnSheet extends StatelessWidget {
  final Widget? title;
  final Widget? description;
  final Widget? content;
  final List<Widget> actions;
  final double heightFactor;
  final bool showHandle;
  final bool showCloseButton;
  final VoidCallback? onClose;

  const CnSheet({
    super.key,
    this.title,
    this.description,
    this.content,
    this.actions = const [],
    this.heightFactor = 0.6,
    this.showHandle = true,
    this.showCloseButton = true,
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final cnTheme = CnTheme.of(context);
    final scheme = CnTheme.colorSchemeOf(context);
    final close = onClose ?? () => Navigator.of(context).maybePop();
    final maxHeight = MediaQuery.sizeOf(context).height * heightFactor;
    final hasHeader = title != null || description != null;
    final hasContent = content != null;
    final hasActions = actions.isNotEmpty;

    final header = hasHeader
        ? Column(
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
          )
        : null;

    final contentWidget = content == null
        ? null
        : Flexible(
            child: Padding(
              padding: EdgeInsets.only(top: hasHeader ? 0 : 16),
              child: SingleChildScrollView(child: content!),
            ),
          );
    final actionsWidget = hasActions
        ? Padding(
            padding: EdgeInsets.only(top: (hasHeader || hasContent) ? 0 : 16),
            child: Row(mainAxisAlignment: .end, spacing: 12, children: actions),
          )
        : null;

    final bodyChildren = <Widget>[
      if (header != null) header,
      if (contentWidget != null) contentWidget,
      if (actionsWidget != null) actionsWidget,
    ];
    final body = bodyChildren.isEmpty
        ? null
        : Column(
            mainAxisSize: .min,
            crossAxisAlignment: .start,
            spacing: 16,
            children: bodyChildren,
          );
    final topStack = [
      if (showHandle)
        Align(
          alignment: Alignment.center,
          child: Container(
            width: 44,
            height: 4,
            decoration: BoxDecoration(
              color: scheme.outlineVariant,
              borderRadius: .circular(999),
            ),
          ),
        ),
      if (showCloseButton)
        Align(
          alignment: Alignment.centerRight,
          child: IconButton(
            icon: const Icon(Icons.close),
            onPressed: close,
            tooltip: 'Close',
          ),
        ),
    ];
    final top = topStack.isEmpty
        ? null
        : Column(mainAxisSize: .min, spacing: 12, children: topStack);
    final bodyTopPadding = showHandle && !showCloseButton ? 12.0 : 0.0;

    return Align(
      alignment: Alignment.bottomCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: maxHeight),
        child: Container(
          decoration: BoxDecoration(
            color: scheme.surface,
            borderRadius: .vertical(top: Radius.circular(cnTheme.radius + 4)),
            border: Border.all(color: scheme.outlineVariant),
          ),
          child: Padding(
            padding: const .fromLTRB(20, 12, 20, 20),
            child: Column(
              mainAxisSize: .min,
              crossAxisAlignment: .start,
              children: [
                if (top != null) top,
                if (body != null)
                  Padding(
                    padding: EdgeInsets.only(top: bodyTopPadding),
                    child: body,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
