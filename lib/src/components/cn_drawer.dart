import 'package:material_ui/material_ui.dart';

import 'cn_overlay.dart';
import 'cn_overlay_internal.dart';

/// Shows a [CnDrawer] on the given [side]. Close it with [Navigator.pop].
///
/// [size] is the width of a drawer on the start or end side.
Future<T?> showCnDrawer<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  CnSide side = .bottom,
  double size = 384,
  bool barrierDismissible = true,
}) {
  return showCnSlideOverlay<T>(
    context: context,
    builder: builder,
    side: side,
    size: size,
    barrierDismissible: barrierDismissible,
    draggable: true,
  );
}

/// A panel attached to a screen edge that the user can swipe away.
///
/// See also:
///
///  * [CnDialog], for centered modal dialogs.
///  * [CnSheet], for panels that stay until they are closed.
class const CnDrawer({
  super.key,
  final Widget? title,
  final Widget? description,
  final Widget? content,
  final List<Widget> actions = const [],
  final bool showHandle = true,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CnSlidePanel(
      title: title,
      description: description,
      content: content,
      actions: actions,
      showHandle: showHandle,
      showCloseButton: false,
    );
  }
}
