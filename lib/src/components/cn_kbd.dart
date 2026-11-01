import 'package:flutter/widgets.dart';

import '../theme/cn_theme.dart';

/// A keyboard key, for displaying shortcuts.
///
/// See also:
///
///  * [CnKbdGroup], for grouping multiple keyboard keys.
class const CnKbd({super.key, required final Widget child})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = CnTheme.of(context);

    return Container(
      padding: const .symmetric(horizontal: 4),
      constraints: const BoxConstraints(minWidth: 20, minHeight: 20),
      alignment: .center,
      decoration: BoxDecoration(
        color: theme.colors.muted,
        borderRadius: .circular(theme.radii.sm),
      ),
      child: DefaultTextStyle.merge(
        style: theme.text.xs.medium.copyWith(
          color: theme.colors.mutedForeground,
        ),
        child: child,
      ),
    );
  }
}

/// A group of keyboard keys for [CnKbd].
class const CnKbdGroup({
  super.key,
  required final List<Widget> children,
  final double spacing = 4,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(mainAxisSize: .min, spacing: spacing, children: children);
  }
}
