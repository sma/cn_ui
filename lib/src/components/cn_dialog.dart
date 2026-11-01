import 'package:material_ui/material_ui.dart';

import '../theme/cn_theme.dart';
import 'cn_overlay_internal.dart';

/// Shows a modal dialog. Close it with [Navigator.pop].
Future<T?> showCnDialog<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  bool barrierDismissible = true,
}) {
  return showDialog<T>(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: builder,
  );
}

/// A centered modal surface with a title, description, content and actions.
///
/// See also:
///
///  * [CnAlertDialog], for confirmations.
///  * [CnSheet], for panels attached to a screen edge.
///  * [CnDrawer], for panels that can be swiped away.
class const CnDialog({
  super.key,
  final Widget? title,
  final Widget? description,
  final Widget? content,
  final List<Widget> actions = const [],
  final double maxWidth = 440,
  final bool showCloseButton = true,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = CnTheme.of(context);

    return Dialog(
      backgroundColor: theme.colors.background,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      insetPadding: const .all(24),
      shape: RoundedRectangleBorder(
        borderRadius: .circular(theme.radius),
        side: BorderSide(color: theme.colors.border),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Stack(
          children: [
            Padding(
              padding: const .all(24),
              child: Column(
                mainAxisSize: .min,
                crossAxisAlignment: .stretch,
                spacing: 16,
                children: [
                  CnOverlayHeader(title: title, description: description),
                  if (content != null)
                    Flexible(child: SingleChildScrollView(child: content!)),
                  if (actions.isNotEmpty)
                    Row(mainAxisAlignment: .end, spacing: 8, children: actions),
                ],
              ),
            ),
            if (showCloseButton) const CnOverlayCloseButton(),
          ],
        ),
      ),
    );
  }
}
