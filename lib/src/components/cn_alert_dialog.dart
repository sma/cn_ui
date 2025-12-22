import 'package:flutter/material.dart';

import '../theme/cn_theme.dart';

/// A builder function for creating dialogs with a [CnDialogController].
typedef CnDialogBuilder = Widget Function(CnDialogController dialog);

/// Shows a dialog using the provided builder function.
Future<T?> showCnDialog<T>({
  required BuildContext context,
  required CnDialogBuilder builder,
  bool barrierDismissible = true,
}) {
  return showDialog<T>(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (context) => builder(CnDialogController(context)),
  );
}

/// A controller for managing dialog interactions and results.
class CnDialogController {
  final BuildContext _context;

  CnDialogController(this._context);

  void cancel<T extends Object?>([T? result]) {
    Navigator.of(_context).pop(result);
  }

  void result<T extends Object?>([T? result]) {
    Navigator.of(_context).pop(result);
  }
}

/// A simple alert dialog component wrapping Flutter's AlertDialog.
///
/// Provides a basic alert interface with title, content, and action buttons.
///
/// See also:
///
///  * [CnDialog], for more customizable dialogs.
///  * [showCnDialog], for showing dialogs programmatically.
class CnAlertDialog extends StatelessWidget {
  final List<Widget> actions;
  final Widget? content;
  final Widget? title;

  const CnAlertDialog({
    super.key,
    this.actions = const [],
    this.content,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    final cnTheme = CnTheme.of(context);
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: .circular(cnTheme.radius)),
      title: title,
      content: content,
      actions: actions,
      actionsPadding: const .fromLTRB(24, 0, 24, 20),
      contentPadding: const .fromLTRB(24, 16, 24, 20),
      titlePadding: const .fromLTRB(24, 24, 24, 8),
    );
  }
}
