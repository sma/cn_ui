import 'package:flutter/material.dart';

/// A text input component with consistent theming.
///
/// Wraps Flutter's [TextField] widget with pre-configured styling.
///
/// See also:
///
///  * [CnFormField], for wrapping inputs with labels and validation messages.
///  * [CnInputGroup], for composing multiple inputs together.
///  * [TextField], the underlying Material widget.
class CnInput extends StatelessWidget {
  final TextEditingController? controller;
  final String? placeholder;
  final bool enabled;
  final bool obscureText;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  const CnInput({
    super.key,
    this.controller,
    this.placeholder,
    this.enabled = true,
    this.obscureText = false,
    this.keyboardType,
    this.onChanged,
    this.prefixIcon,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      enabled: enabled,
      obscureText: obscureText,
      keyboardType: keyboardType,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: placeholder,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
    );
  }
}
