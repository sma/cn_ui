import '../../cn_ui.dart';

/// A text label component for form fields with optional required indicator.
///
/// Displays an asterisk when the [required] parameter is true.
///
/// See also:
///
///  * [CnFormField], which automatically includes labels.
class CnLabel extends StatelessWidget {
  final Widget child;
  final bool required;
  final Color? requiredColor;
  final TextStyle? style;

  const CnLabel({
    super.key,
    required this.child,
    this.required = false,
    this.requiredColor,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = CnTheme.colorSchemeOf(context);
    final resolvedStyle = style ?? CnTheme.textThemeOf(context).labelLarge;

    return Row(
      mainAxisSize: .min,
      spacing: 4,
      children: [
        DefaultTextStyle(
          style: resolvedStyle ?? const TextStyle(),
          child: child,
        ),
        if (required) ...[
          Text(
            '*',
            style:
                resolvedStyle?.copyWith(
                  color: requiredColor ?? scheme.error,
                  fontWeight: .w700,
                ) ??
                TextStyle(color: requiredColor ?? scheme.error),
          ),
        ],
      ],
    );
  }
}
