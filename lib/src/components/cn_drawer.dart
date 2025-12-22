import 'package:flutter/material.dart';

import '../theme/cn_theme.dart';

/// Side positioning for [CnDrawer].
enum CnDrawerSide { left, right }

/// A builder function for creating drawers.
typedef CnDrawerBuilder = Widget Function(BuildContext context);

/// Shows a drawer sliding from the left or right side of the screen.
Future<T?> showCnDrawer<T>({
  required BuildContext context,
  required CnDrawerBuilder builder,
  CnDrawerSide side = .left,
  double size = 360,
  bool barrierDismissible = true,
  Color barrierColor = const Color(0x99000000),
  Duration transitionDuration = const Duration(milliseconds: 260),
}) {
  final alignment = side == .left
      ? Alignment.centerLeft
      : Alignment.centerRight;
  final beginOffset = side == .left ? const Offset(-1, 0) : const Offset(1, 0);

  return showGeneralDialog<T>(
    context: context,
    barrierLabel: 'Drawer',
    barrierDismissible: barrierDismissible,
    barrierColor: barrierColor,
    transitionDuration: transitionDuration,
    pageBuilder: (context, animation, secondaryAnimation) {
      return SafeArea(
        child: Align(
          alignment: alignment,
          child: Material(
            color: Colors.transparent,
            child: SizedBox(width: size, child: builder(context)),
          ),
        ),
      );
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      final curved = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
      );
      return SlideTransition(
        position: Tween<Offset>(
          begin: beginOffset,
          end: Offset.zero,
        ).animate(curved),
        child: child,
      );
    },
  );
}

/// A side panel drawer component that slides from the screen edge.
///
/// Provides a modal overlay from the left or right side with optional title, description, content, and actions.
///
/// See also:
///
///  * [CnDialog], for centered modal dialogs.
///  * [CnSheet], for bottom sheet dialogs.
///  * [showCnDrawer], for showing drawers programmatically.
class CnDrawer extends StatelessWidget {
  final CnDrawerSide side;
  final Widget? title;
  final Widget? description;
  final Widget? content;
  final List<Widget> actions;
  final bool showCloseButton;
  final VoidCallback? onClose;
  final EdgeInsetsGeometry? padding;

  const CnDrawer({
    super.key,
    this.side = .left,
    this.title,
    this.description,
    this.content,
    this.actions = const [],
    this.showCloseButton = true,
    this.onClose,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final cnTheme = CnTheme.of(context);
    final scheme = CnTheme.colorSchemeOf(context);
    final close = onClose ?? () => Navigator.of(context).maybePop();
    final radius = cnTheme.radius;

    final borderRadius = side == .left
        ? BorderRadius.only(
            topRight: Radius.circular(radius),
            bottomRight: Radius.circular(radius),
          )
        : BorderRadius.only(
            topLeft: Radius.circular(radius),
            bottomLeft: Radius.circular(radius),
          );

    return Material(
      color: scheme.surface,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius,
        side: BorderSide(color: scheme.outlineVariant),
      ),
      child: Padding(
        padding: padding ?? const .all(20),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            if (showCloseButton)
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: close,
                  tooltip: 'Close',
                ),
              ),
            _DrawerBody(
              title: title,
              description: description,
              content: content,
              actions: actions,
            ),
          ],
        ),
      ),
    );
  }
}

class _DrawerBody extends StatelessWidget {
  final Widget? title;
  final Widget? description;
  final Widget? content;
  final List<Widget> actions;

  const _DrawerBody({
    required this.title,
    required this.description,
    required this.content,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = CnTheme.colorSchemeOf(context);
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
            fit: FlexFit.loose,
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

    if (bodyChildren.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      mainAxisSize: .min,
      crossAxisAlignment: .start,
      spacing: 16,
      children: bodyChildren,
    );
  }
}
