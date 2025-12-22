import 'package:flutter/material.dart';

import '../theme/cn_theme.dart';
import 'cn_label.dart';

/// A form container component for managing form state and validation.
///
/// Wraps Flutter's [Form] widget with consistent styling.
///
/// See also:
///
///  * [CnFormField], for individual form fields with labels and validation.
///  * [Form], the underlying Material widget.
class CnForm extends StatelessWidget {
  final Widget child;
  final GlobalKey<FormState>? formKey;
  final AutovalidateMode? autovalidateMode;
  final VoidCallback? onChanged;

  const CnForm({
    super.key,
    required this.child,
    this.formKey,
    this.autovalidateMode,
    this.onChanged,
  });

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

/// A form field wrapper that provides label, description, and error text.
///
/// Wraps form input components with consistent layout and validation display.
///
/// See also:
///
///  * [CnForm], for wrapping multiple form fields.
///  * [CnLabel], for standalone labels.
class CnFormField extends StatelessWidget {
  final Widget child;
  final Widget? label;
  final String? labelText;
  final bool required;
  final Widget? description;
  final String? descriptionText;
  final String? errorText;
  final EdgeInsetsGeometry? padding;

  const CnFormField({
    super.key,
    required this.child,
    this.label,
    this.labelText,
    this.required = false,
    this.description,
    this.descriptionText,
    this.errorText,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = CnTheme.colorSchemeOf(context);
    final cnTheme = CnTheme.of(context);

    final resolvedLabel =
        label ??
        (labelText == null
            ? null
            : CnLabel(required: required, child: Text(labelText!)));
    final resolvedDescription =
        description ??
        (descriptionText == null ? null : Text(descriptionText!));

    final resolvedPadding = (padding ?? .zero).add(
      EdgeInsets.only(bottom: cnTheme.radius / 2),
    );

    return Padding(
      padding: resolvedPadding,
      child: Column(
        crossAxisAlignment: .start,
        spacing: 6,
        children: [
          if (resolvedLabel != null) resolvedLabel,
          child,
          if (resolvedDescription != null)
            DefaultTextStyle(
              style:
                  CnTheme.textThemeOf(
                    context,
                  ).bodySmall?.copyWith(color: scheme.onSurfaceVariant) ??
                  TextStyle(color: scheme.onSurfaceVariant),
              child: resolvedDescription,
            ),
          if (errorText != null)
            DefaultTextStyle(
              style:
                  CnTheme.textThemeOf(context).bodySmall?.copyWith(
                    color: scheme.error,
                    fontWeight: .w600,
                  ) ??
                  TextStyle(color: scheme.error),
              child: Text(errorText!),
            ),
        ],
      ),
    );
  }
}
