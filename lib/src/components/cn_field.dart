import 'package:material_ui/material_ui.dart';

import '../theme/cn_theme.dart';
import 'cn_label.dart';

/// Layout options for [CnField].
enum CnFieldLayout { vertical, horizontal, responsive }

/// A titled group of fields.
///
/// See also:
///
///  * [CnFieldGroup], for vertical stacking of fields.
///  * [CnField], for individual form fields.
class const CnFieldSet({
  super.key,
  final Widget? legend,
  final Widget? description,
  required final Widget child,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = CnTheme.of(context);
    return Column(
      crossAxisAlignment: .stretch,
      spacing: 16,
      children: [
        if (legend != null || description != null)
          Column(
            crossAxisAlignment: .start,
            spacing: 4,
            children: [
              if (legend != null)
                DefaultTextStyle.merge(
                  style: theme.text.base.medium,
                  child: legend!,
                ),
              if (description != null)
                DefaultTextStyle.merge(
                  style: theme.text.sm.copyWith(
                    color: theme.colors.mutedForeground,
                  ),
                  child: description!,
                ),
            ],
          ),
        child,
      ],
    );
  }
}

/// A container for vertically stacking fields with consistent spacing.
class const CnFieldGroup({
  super.key,
  required final List<Widget> children,
  final double spacing = 16,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .stretch,
      spacing: spacing,
      children: children,
    );
  }
}

/// A horizontal line between fields.
class const CnFieldSeparator({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) => const Divider(height: 1);
}

/// A form control with a label, a description and an error message.
///
/// While [errorText] is set, controls inside the field such as [CnInput] show
/// their error state. They ask [CnField.of] for it.
class const CnField({
  super.key,
  required final Widget child,
  final Widget? label,
  final bool required = false,
  final Widget? description,
  final String? errorText,
  final CnFieldLayout layout = .vertical,
  final double labelWidth = 180,
}) extends StatelessWidget {
  /// Whether the enclosing field currently shows an error.
  static bool hasError(BuildContext context) {
    return context
            .dependOnInheritedWidgetOfExactType<_CnFieldScope>()
            ?.hasError ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    final theme = CnTheme.of(context);
    final resolvedLabel = label == null
        ? null
        : CnLabel(required: required, child: label!);

    final control = Column(
      crossAxisAlignment: .stretch,
      spacing: 6,
      children: [
        _CnFieldScope(hasError: errorText != null, child: child),
        if (description != null)
          DefaultTextStyle.merge(
            style: theme.text.sm.copyWith(color: theme.colors.mutedForeground),
            child: description!,
          ),
        if (errorText != null)
          Text(
            errorText!,
            style: theme.text.sm.copyWith(color: theme.colors.destructive),
          ),
      ],
    );

    final horizontal =
        layout == .horizontal ||
        (layout == .responsive && MediaQuery.sizeOf(context).width >= 720);

    if (horizontal) {
      return Row(
        crossAxisAlignment: .start,
        spacing: 16,
        children: [
          if (resolvedLabel != null)
            SizedBox(width: labelWidth, child: resolvedLabel),
          Expanded(child: control),
        ],
      );
    }

    return Column(
      crossAxisAlignment: .stretch,
      spacing: 6,
      children: [
        if (resolvedLabel != null)
          Align(alignment: .centerStart, child: resolvedLabel),
        control,
      ],
    );
  }
}

class const _CnFieldScope({required final bool hasError, required super.child})
    extends InheritedWidget {
  @override
  bool updateShouldNotify(_CnFieldScope oldWidget) {
    return oldWidget.hasError != hasError;
  }
}
