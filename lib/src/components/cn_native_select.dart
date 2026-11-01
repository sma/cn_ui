import 'package:flutter/widgets.dart';

import 'cn_select.dart';

/// The counterpart of the shadcn/ui native select.
///
/// Flutter has no native select widget, so this is a [CnSelect].
class const CnNativeSelect<T>({
  super.key,
  required final List<CnSelectEntry<T>> items,
  final T? value,
  final ValueChanged<T?>? onChanged,
  final String? placeholder,
  final FormFieldValidator<T>? validator,
  final bool expand = true,
  final CnSelectSize size = .md,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CnSelect<T>(
      items: items,
      value: value,
      onChanged: onChanged,
      placeholder: placeholder,
      validator: validator,
      expand: expand,
      size: size,
    );
  }
}
