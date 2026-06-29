import 'package:flutter/material.dart';

import '../theme/cn_theme.dart';

/// Visual style variants for [CnButton].
enum CnButtonVariant { primary, secondary, outline, ghost, destructive, link }

/// Size variants for [CnButton].
enum CnButtonSize { sm, md, lg, icon }

/// A customizable button component with multiple variants and sizes.
///
/// Provides primary, secondary, outline, ghost, destructive, and link button
/// styles with consistent theming.
///
/// See also:
///
///  * [CnButtonGroup], which groups multiple buttons together.
///  * [CnToggle], for toggle buttons.
class const CnButton({
  super.key,
  final CnButtonVariant variant = .primary,
  final CnButtonSize size = .md,
  required final VoidCallback? onPressed,
  required final Widget child,
  final Widget? leading,
  final Widget? trailing,
  final bool fullWidth = false,
  final EdgeInsetsGeometry? padding,
  final BorderRadiusGeometry? borderRadius,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final scheme = CnTheme.colorSchemeOf(context);
    final cnTheme = CnTheme.of(context);
    final visuals = _resolveVisuals(variant, scheme);
    final padding = this.padding ?? _paddingFor(size);
    final minHeight = _minHeightFor(size);
    final textStyle = _textStyleFor(
      variant,
      CnTheme.textThemeOf(context).labelLarge,
    );
    final resolvedRadius = borderRadius ?? .circular(cnTheme.radius);

    final style = ButtonStyle(
      minimumSize: .all(Size(0, minHeight)),
      padding: .all(padding),
      backgroundColor: .resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return scheme.surfaceContainerHighest.withValues(alpha: 0.4);
        }
        return visuals.background;
      }),
      foregroundColor: .resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return scheme.onSurfaceVariant.withValues(alpha: 0.6);
        }
        return visuals.foreground;
      }),
      overlayColor: .resolveWith((states) {
        if (states.contains(WidgetState.pressed)) {
          return visuals.foreground.withValues(alpha: 0.12);
        }
        if (states.contains(WidgetState.hovered)) {
          return visuals.foreground.withValues(alpha: 0.06);
        }
        return null;
      }),
      shape: .all(
        RoundedRectangleBorder(
          borderRadius: resolvedRadius,
          side: BorderSide(color: visuals.border),
        ),
      ),
      textStyle: .all(textStyle),
    );

    return SizedBox(
      width: fullWidth ? .infinity : null,
      child: TextButton(
        onPressed: onPressed,
        style: style,
        child: _ButtonContent(
          leading: leading,
          trailing: trailing,
          child: child,
        ),
      ),
    );
  }

  EdgeInsets _paddingFor(CnButtonSize size) => switch (size) {
    .sm => const .symmetric(horizontal: 12, vertical: 8),
    .md => const .symmetric(horizontal: 16, vertical: 12),
    .lg => const .symmetric(horizontal: 20, vertical: 14),
    .icon => const .all(12),
  };

  double _minHeightFor(CnButtonSize size) => switch (size) {
    .sm => 32,
    .md => 40,
    .lg => 48,
    .icon => 40,
  };

  TextStyle? _textStyleFor(CnButtonVariant variant, TextStyle? base) {
    if (base == null) {
      return null;
    }
    if (variant == .link) {
      return base.copyWith(fontWeight: .w600, decoration: .underline);
    }
    return base.copyWith(fontWeight: .w600);
  }

  _CnButtonVisuals _resolveVisuals(
    CnButtonVariant variant,
    ColorScheme scheme,
  ) => switch (variant) {
    .primary => _CnButtonVisuals(
      background: scheme.primary,
      foreground: scheme.onPrimary,
      border: scheme.primary,
    ),
    .secondary => _CnButtonVisuals(
      background: scheme.secondaryContainer,
      foreground: scheme.onSecondaryContainer,
      border: scheme.secondaryContainer,
    ),
    .outline => _CnButtonVisuals(
      background: Colors.transparent,
      foreground: scheme.onSurface,
      border: scheme.outline,
    ),
    .ghost => _CnButtonVisuals(
      background: Colors.transparent,
      foreground: scheme.onSurfaceVariant,
      border: Colors.transparent,
    ),
    .destructive => _CnButtonVisuals(
      background: scheme.error,
      foreground: scheme.onError,
      border: scheme.error,
    ),
    .link => _CnButtonVisuals(
      background: Colors.transparent,
      foreground: scheme.primary,
      border: Colors.transparent,
    ),
  };
}

class const _ButtonContent({
  required final Widget child,
  final Widget? leading,
  final Widget? trailing,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (leading == null && trailing == null) {
      return child;
    }
    return Row(
      mainAxisSize: .min,
      spacing: 8,
      children: [?leading, child, ?trailing],
    );
  }
}

class const _CnButtonVisuals({
  required final Color background,
  required final Color foreground,
  required final Color border,
});
