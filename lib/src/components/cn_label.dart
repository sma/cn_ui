import 'package:flutter/widgets.dart';

import '../theme/cn_theme.dart';

/// A label for a form control. With [required], it shows an asterisk.
///
/// See also:
///
///  * [CnField], which includes a label.
class const CnLabel({
  super.key,
  required final Widget child,
  final bool required = false,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = CnTheme.of(context);
    final style = theme.text.sm.medium;

    return Row(
      mainAxisSize: .min,
      spacing: 4,
      children: [
        Flexible(
          child: DefaultTextStyle.merge(style: style, child: child),
        ),
        if (required)
          Text('*', style: style.copyWith(color: theme.colors.destructive)),
      ],
    );
  }
}
