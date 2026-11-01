import 'package:material_ui/material_ui.dart';

import 'cn_overlay.dart';
import 'cn_overlay_internal.dart';

/// Shows a [CnSheet] on the given [side]. Close it with [Navigator.pop].
///
/// [size] is the width of a sheet on the start or end side.
Future<T?> showCnSheet<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  CnSide side = .end,
  double size = 384,
  bool barrierDismissible = true,
}) {
  return showCnSlideOverlay<T>(
    context: context,
    builder: builder,
    side: side,
    size: size,
    barrierDismissible: barrierDismissible,
    draggable: false,
  );
}

/// A panel attached to a screen edge that complements the main content.
///
/// See also:
///
///  * [CnDialog], for centered modal dialogs.
///  * [CnDrawer], for panels that can be swiped away.
class const CnSheet({
  super.key,
  final Widget? title,
  final Widget? description,
  final Widget? content,
  final List<Widget> actions = const [],
  final bool showCloseButton = true,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CnSlidePanel(
      title: title,
      description: description,
      content: content,
      actions: actions,
      showHandle: false,
      showCloseButton: showCloseButton,
    );
  }
}
