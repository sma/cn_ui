import 'package:material_ui/material_ui.dart';

import '../theme/cn_theme.dart';
import 'cn_field.dart';

/// A single-line text input.
///
/// With a [validator], it takes part in the validation of an enclosing
/// [CnForm]. Inside a [CnField] with an error, it shows its error state.
///
/// See also:
///
///  * [CnField], for a label and a description.
///  * [CnTextarea], for multi-line text.
class const CnInput({
  super.key,
  final TextEditingController? controller,
  final FocusNode? focusNode,
  final String? placeholder,
  final bool enabled = true,
  final bool readOnly = false,
  final bool autofocus = false,
  final bool obscureText = false,
  final TextInputType? keyboardType,
  final ValueChanged<String>? onChanged,
  final ValueChanged<String>? onSubmitted,
  final FormFieldValidator<String>? validator,
  final Widget? leading,
  final Widget? trailing,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final hasError = CnField.hasError(context);
    final theme = CnTheme.of(context);

    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      enabled: enabled,
      readOnly: readOnly,
      autofocus: autofocus,
      obscureText: obscureText,
      keyboardType: keyboardType,
      onChanged: onChanged,
      onFieldSubmitted: onSubmitted,
      validator: validator,
      forceErrorText: hasError ? '' : null,
      style: theme.text.sm,
      decoration: InputDecoration(
        hintText: placeholder,
        prefixIcon: leading,
        suffixIcon: trailing,
        prefixIconConstraints: const BoxConstraints(
          minWidth: 36,
          minHeight: 36,
        ),
        suffixIconConstraints: const BoxConstraints(
          minWidth: 36,
          minHeight: 36,
        ),
        // The field shows the message, so only the border changes here.
        errorStyle: hasError ? const TextStyle(fontSize: 0, height: 0) : null,
      ),
    );
  }
}
