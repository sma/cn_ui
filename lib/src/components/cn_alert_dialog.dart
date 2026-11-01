import 'package:material_ui/material_ui.dart';

import 'cn_dialog.dart';

/// A dialog asking the user to confirm an action.
///
/// Show it with [showCnDialog]. Unlike [CnDialog], it has no close button, so
/// the user has to pick one of the [actions].
class const CnAlertDialog({
  super.key,
  final Widget? title,
  final Widget? description,
  final Widget? content,
  final List<Widget> actions = const [],
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CnDialog(
      title: title,
      description: description,
      content: content,
      actions: actions,
      showCloseButton: false,
    );
  }
}
