import 'package:material_ui/material_ui.dart';

import '../theme/cn_theme.dart';

/// Media display variants for [CnItemMedia].
enum CnItemMediaVariant { standard, icon, image }

/// A vertical list of [CnItem]s with optional dividers.
class const CnItemGroup({
  super.key,
  required final List<Widget> children,
  final bool showDividers = true,
  final double spacing = 0,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .stretch,
      spacing: spacing,
      children: [
        for (var index = 0; index < children.length; index++) ...[
          children[index],
          if (showDividers && index != children.length - 1)
            const Divider(height: 1),
        ],
      ],
    );
  }
}

/// A list item with a leading widget, title, description and trailing widget.
///
/// See also:
///
///  * [CnItemGroup], for grouping multiple items.
///  * [CnItemMedia], for a framed leading icon or image.
class const CnItem({
  super.key,
  final Widget? leading,
  final Widget? title,
  final Widget? description,
  final Widget? trailing,
  final VoidCallback? onTap,
  final bool selected = false,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = CnTheme.of(context);
    final colors = theme.colors;
    final radius = BorderRadius.circular(theme.radii.md);

    return Material(
      animationDuration: Duration.zero,
      color: selected ? colors.accent : Colors.transparent,
      borderRadius: radius,
      child: InkWell(
        borderRadius: radius,
        onTap: onTap,
        child: Padding(
          padding: const .symmetric(horizontal: 16, vertical: 12),
          child: Row(
            spacing: 16,
            children: [
              ?leading,
              Expanded(
                child: Column(
                  crossAxisAlignment: .start,
                  spacing: 4,
                  children: [
                    if (title != null)
                      DefaultTextStyle.merge(
                        style: theme.text.sm.medium,
                        child: title!,
                      ),
                    if (description != null)
                      DefaultTextStyle.merge(
                        style: theme.text.sm.copyWith(
                          color: colors.mutedForeground,
                        ),
                        child: description!,
                      ),
                  ],
                ),
              ),
              ?trailing,
            ],
          ),
        ),
      ),
    );
  }
}

/// A framed icon or image for the leading slot of a [CnItem].
class const CnItemMedia({
  super.key,
  required final Widget child,
  final CnItemMediaVariant variant = .standard,
  final double size = 40,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = CnTheme.of(context);
    final colors = theme.colors;
    final radius = BorderRadius.circular(theme.radii.md);

    if (variant == .image) {
      return ClipRRect(
        borderRadius: radius,
        child: SizedBox.square(dimension: size, child: child),
      );
    }

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: variant == .icon ? colors.muted : null,
        borderRadius: variant == .icon ? radius : null,
      ),
      child: IconTheme.merge(
        data: IconThemeData(color: colors.foreground, size: 16),
        child: Center(child: child),
      ),
    );
  }
}
