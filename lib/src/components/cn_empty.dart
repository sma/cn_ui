import 'package:material_ui/material_ui.dart';

import '../theme/cn_theme.dart';

/// Media display variants for [CnEmptyMedia].
enum CnEmptyMediaVariant { standard, icon, image }

/// An empty state, shown when there is no content yet.
///
/// See also:
///
///  * [CnEmptyMedia], for a framed icon or image.
class const CnEmpty({
  super.key,
  final Widget? media,
  final Widget? title,
  final Widget? description,
  final Widget? content,
  final Widget? actions,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = CnTheme.of(context);

    return Padding(
      padding: const .all(24),
      child: Column(
        mainAxisSize: .min,
        spacing: 16,
        children: [
          ?media,
          if (title != null || description != null)
            Column(
              spacing: 8,
              children: [
                if (title != null)
                  DefaultTextStyle.merge(
                    style: theme.heading.lg.medium,
                    textAlign: .center,
                    child: title!,
                  ),
                if (description != null)
                  DefaultTextStyle.merge(
                    style: theme.text.sm.copyWith(
                      color: theme.colors.mutedForeground,
                    ),
                    textAlign: .center,
                    child: description!,
                  ),
              ],
            ),
          ?content,
          ?actions,
        ],
      ),
    );
  }
}

/// A framed icon or image for the media slot of a [CnEmpty].
class const CnEmptyMedia({
  super.key,
  required final Widget child,
  final CnEmptyMediaVariant variant = .icon,
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
        data: IconThemeData(color: colors.foreground, size: 24),
        child: Center(child: child),
      ),
    );
  }
}
