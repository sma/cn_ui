import 'package:material_ui/material_ui.dart';

import '../theme/cn_theme.dart';
import 'cn_field.dart';

/// A multi-line text input.
///
/// With a [validator], it takes part in the validation of an enclosing
/// [CnForm]. Inside a [CnField] with an error, it shows its error state.
///
/// See also:
///
///  * [CnInput], for single-line text input.
class const CnTextarea({
  super.key,
  final TextEditingController? controller,
  final FocusNode? focusNode,
  final String? placeholder,
  final bool enabled = true,
  final bool readOnly = false,
  final int minLines = 4,
  final int maxLines = 8,
  final ValueChanged<String>? onChanged,
  final FormFieldValidator<String>? validator,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final hasError = CnField.hasError(context);

    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      enabled: enabled,
      readOnly: readOnly,
      minLines: minLines,
      maxLines: maxLines,
      onChanged: onChanged,
      validator: validator,
      forceErrorText: hasError ? '' : null,
      style: CnTheme.of(context).text.sm,
      decoration: InputDecoration(
        hintText: placeholder,
        alignLabelWithHint: true,
        // The field shows the message, so only the border changes here.
        errorStyle: hasError ? const TextStyle(fontSize: 0, height: 0) : null,
      ),
    );
  }
}
