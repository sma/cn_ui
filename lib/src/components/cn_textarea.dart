import 'package:flutter/material.dart';

/// A multi-line text input component.
///
/// Wraps Flutter's [TextField] configured for multi-line text entry.
///
/// See also:
///
///  * [CnInput], for single-line text input.
///  * [TextField], the underlying Material widget.
class CnTextarea extends StatelessWidget {
  final TextEditingController? controller;
  final String? placeholder;
  final bool enabled;
  final int minLines;
  final int maxLines;
  final ValueChanged<String>? onChanged;

  const CnTextarea({
    super.key,
    this.controller,
    this.placeholder,
    this.enabled = true,
    this.minLines = 4,
    this.maxLines = 8,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      enabled: enabled,
      minLines: minLines,
      maxLines: maxLines,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: placeholder,
        alignLabelWithHint: true,
      ),
    );
  }
}
