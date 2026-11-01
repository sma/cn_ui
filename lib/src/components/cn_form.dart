import 'package:flutter/widgets.dart';

/// Validates the controls inside it, e.g. a [CnInput] with a `validator`.
///
/// Call `validate` on the state of [formKey] to run all validators.
///
/// See also:
///
///  * [CnField], for the label and description of a control.
class const CnForm({
  super.key,
  required final Widget child,
  final GlobalKey<FormState>? formKey,
  final AutovalidateMode? autovalidateMode,
  final VoidCallback? onChanged,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: autovalidateMode,
      onChanged: onChanged,
      child: child,
    );
  }
}
