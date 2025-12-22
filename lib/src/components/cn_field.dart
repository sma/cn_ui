import 'package:flutter/material.dart';

import '../theme/cn_theme.dart';
import 'cn_label.dart';

/// Layout options for [CnField].
enum CnFieldLayout { vertical, horizontal, responsive }

/// A container for grouping related form fields with optional border.
///
/// See also:
///
///  * [CnFieldGroup], for vertical stacking of fields without borders.
///  * [CnField], for individual form fields.
class CnFieldSet extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final bool showBorder;
  final BorderRadiusGeometry? borderRadius;
  final Color? backgroundColor;
  final Color? borderColor;

  const CnFieldSet({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(20),
    this.showBorder = true,
    this.borderRadius,
    this.backgroundColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = CnTheme.colorSchemeOf(context);
    final cnTheme = CnTheme.of(context);

    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor ?? scheme.surface,
        borderRadius: borderRadius ?? BorderRadius.circular(cnTheme.radius),
        border: showBorder
            ? Border.all(color: borderColor ?? scheme.outlineVariant)
            : null,
      ),
      child: child,
    );
  }
}

/// A title component for [CnFieldSet].
///
/// See also:
///
///  * [CnFieldSet], which uses this for its title.
class CnFieldLegend extends StatelessWidget {
  final Widget child;

  const CnFieldLegend({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style:
          CnTheme.textThemeOf(
            context,
          ).titleMedium?.copyWith(fontWeight: .w600) ??
          const TextStyle(fontWeight: FontWeight.w600),
      child: child,
    );
  }
}

/// A container for vertically stacking form fields with consistent spacing.
///
/// See also:
///
///  * [CnFieldSet], for grouped fields with a border.
///  * [CnField], for individual form fields.
class CnFieldGroup extends StatelessWidget {
  final List<Widget> children;
  final double spacing;

  const CnFieldGroup({super.key, required this.children, this.spacing = 16});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      spacing: spacing,
      children: children,
    );
  }
}

/// A form field component with label, description, and error text support.
///
/// Supports vertical, horizontal, and responsive layouts.
///
/// See also:
///
///  * [CnFormField], an alternative field wrapper.
///  * [CnFieldGroup], for grouping multiple fields.
class CnField extends StatelessWidget {
  final Widget child;
  final Widget? label;
  final String? labelText;
  final bool required;
  final Widget? description;
  final String? descriptionText;
  final String? errorText;
  final CnFieldLayout layout;
  final double labelWidth;
  final EdgeInsetsGeometry? padding;

  const CnField({
    super.key,
    required this.child,
    this.label,
    this.labelText,
    this.required = false,
    this.description,
    this.descriptionText,
    this.errorText,
    this.layout = .vertical,
    this.labelWidth = 180,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final resolvedLabel =
        label ??
        (labelText == null
            ? null
            : CnFieldLabel(
                child: CnLabel(required: required, child: Text(labelText!)),
              ));
    final resolvedDescription =
        description ??
        (descriptionText == null
            ? null
            : CnFieldDescription(child: Text(descriptionText!)));

    final content = Column(
      crossAxisAlignment: .start,
      spacing: 6,
      children: [
        child,
        if (resolvedDescription != null) resolvedDescription,
        if (errorText != null) CnFieldError(child: Text(errorText!)),
      ],
    );

    final resolvedLayout = _resolveLayout(context);
    final resolvedPadding = padding ?? EdgeInsets.zero;

    if (resolvedLayout == .horizontal) {
      return Padding(
        padding: resolvedPadding,
        child: Row(
          crossAxisAlignment: .start,
          spacing: 16,
          children: [
            if (resolvedLabel != null)
              SizedBox(
                width: labelWidth,
                child: DefaultTextStyle(
                  style:
                      CnTheme.textThemeOf(context).labelLarge ??
                      const TextStyle(),
                  child: resolvedLabel,
                ),
              ),
            Expanded(child: content),
          ],
        ),
      );
    }

    return Padding(
      padding: resolvedPadding,
      child: Column(
        crossAxisAlignment: .start,
        spacing: 6,
        children: [
          if (resolvedLabel != null)
            DefaultTextStyle(
              style:
                  CnTheme.textThemeOf(context).labelLarge ?? const TextStyle(),
              child: resolvedLabel,
            ),
          content,
        ],
      ),
    );
  }

  CnFieldLayout _resolveLayout(BuildContext context) {
    if (layout != .responsive) {
      return layout;
    }
    final width = MediaQuery.sizeOf(context).width;
    return width >= 720 ? .horizontal : .vertical;
  }
}

/// A wrapper for field content in custom field layouts.
class CnFieldContent extends StatelessWidget {
  final Widget child;

  const CnFieldContent({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return child;
  }
}

/// A styled label component for form fields.
class CnFieldLabel extends StatelessWidget {
  final Widget child;

  const CnFieldLabel({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style:
          CnTheme.textThemeOf(
            context,
          ).labelLarge?.copyWith(fontWeight: .w600) ??
          const TextStyle(fontWeight: FontWeight.w600),
      child: child,
    );
  }
}

/// A title component for field sections.
class CnFieldTitle extends StatelessWidget {
  final Widget child;

  const CnFieldTitle({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style:
          CnTheme.textThemeOf(
            context,
          ).titleSmall?.copyWith(fontWeight: .w600) ??
          const TextStyle(fontWeight: FontWeight.w600),
      child: child,
    );
  }
}

/// A description text component for providing field help text.
class CnFieldDescription extends StatelessWidget {
  final Widget child;

  const CnFieldDescription({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final scheme = CnTheme.colorSchemeOf(context);
    return DefaultTextStyle(
      style:
          CnTheme.textThemeOf(
            context,
          ).bodySmall?.copyWith(color: scheme.onSurfaceVariant) ??
          TextStyle(color: scheme.onSurfaceVariant),
      child: child,
    );
  }
}

/// A horizontal divider for separating field sections.
class CnFieldSeparator extends StatelessWidget {
  const CnFieldSeparator({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(color: CnTheme.colorSchemeOf(context).outlineVariant);
  }
}

/// An error message component for displaying field validation errors.
class CnFieldError extends StatelessWidget {
  final Widget child;

  const CnFieldError({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final scheme = CnTheme.colorSchemeOf(context);
    return DefaultTextStyle(
      style:
          CnTheme.textThemeOf(
            context,
          ).bodySmall?.copyWith(color: scheme.error, fontWeight: .w600) ??
          TextStyle(color: scheme.error),
      child: child,
    );
  }
}
