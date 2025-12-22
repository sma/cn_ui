import 'package:flutter/material.dart';

import '../../cn_ui.dart';

/// A circular avatar component for displaying user images or initials.
///
/// Wraps Flutter's CircleAvatar with consistent theming for profile pictures and user indicators.
///
/// See also:
///
///  * [CnAvatarGroup], for displaying multiple overlapping avatars.
class CnAvatar extends StatelessWidget {
  final ImageProvider? image;
  final String? initials;
  final double size;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Widget? child;

  const CnAvatar({
    super.key,
    this.image,
    this.initials,
    this.size = 40,
    this.backgroundColor,
    this.foregroundColor,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = CnTheme.colorSchemeOf(context);
    final resolvedBackground = backgroundColor ?? scheme.primaryContainer;
    final resolvedForeground = foregroundColor ?? scheme.onPrimaryContainer;

    return CircleAvatar(
      radius: size / 2,
      backgroundColor: resolvedBackground,
      foregroundColor: resolvedForeground,
      backgroundImage: image,
      child: image == null
          ? initials == null
                ? child
                : Text(
                    initials ?? '',
                    style: CnTheme.textThemeOf(
                      context,
                    ).labelLarge?.copyWith(color: resolvedForeground),
                  )
          : child,
    );
  }
}

class CnAvatarSize {
  static const sm = 16.0;
  static const lg = 48.0;
}
