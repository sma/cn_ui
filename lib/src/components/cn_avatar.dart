import 'package:material_ui/material_ui.dart';

import '../theme/cn_theme.dart';

/// Size variants for [CnAvatar].
enum CnAvatarSize { sm, md, lg }

/// A circular user image.
///
/// [child] is the fallback, e.g. initials, shown while there is no [image].
///
/// See also:
///
///  * [CnAvatarGroup], for displaying multiple overlapping avatars.
class const CnAvatar({
  super.key,
  final ImageProvider? image,
  final CnAvatarSize size = .md,
  final Widget? child,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = CnTheme.of(context);
    final colors = theme.colors;
    final diameter = switch (size) {
      .sm => 24.0,
      .md => 32.0,
      .lg => 40.0,
    };

    return CircleAvatar(
      radius: diameter / 2,
      backgroundColor: colors.muted,
      foregroundColor: colors.mutedForeground,
      backgroundImage: image,
      child: image != null || child == null
          ? null
          : DefaultTextStyle.merge(
              style: (size == .sm ? theme.text.xs : theme.text.sm).copyWith(
                color: colors.mutedForeground,
              ),
              child: child!,
            ),
    );
  }
}
