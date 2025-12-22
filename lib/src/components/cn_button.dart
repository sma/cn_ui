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
class CnButton extends StatelessWidget {
  final CnButtonVariant variant;
  final CnButtonSize size;
  final VoidCallback? onPressed;
  final Widget child;
  final Widget? leading;
  final Widget? trailing;
  final bool fullWidth;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;

  const CnButton({
    super.key,
    this.variant = .primary,
    this.size = .md,
    this.onPressed,
    required this.child,
    this.leading,
    this.trailing,
    this.fullWidth = false,
    this.padding,
    this.borderRadius,
  });

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
      minimumSize: WidgetStateProperty.all(Size(0, minHeight)),
      padding: WidgetStateProperty.all(padding),
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return scheme.surfaceContainerHighest.withValues(alpha: 0.4);
        }
        return visuals.background;
      }),
      foregroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return scheme.onSurfaceVariant.withValues(alpha: 0.6);
        }
        return visuals.foreground;
      }),
      overlayColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.pressed)) {
          return visuals.foreground.withValues(alpha: 0.12);
        }
        if (states.contains(WidgetState.hovered)) {
          return visuals.foreground.withValues(alpha: 0.06);
        }
        return null;
      }),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: resolvedRadius,
          side: BorderSide(color: visuals.border),
        ),
      ),
      textStyle: WidgetStateProperty.all(textStyle),
    );

    final content = _ButtonContent(
      leading: leading,
      trailing: trailing,
      child: child,
    );

    return SizedBox(
      width: fullWidth ? double.infinity : null,
      child: TextButton(onPressed: onPressed, style: style, child: content),
    );
  }

  EdgeInsets _paddingFor(CnButtonSize size) {
    return switch (size) {
      .sm => const .symmetric(horizontal: 12, vertical: 8),
      .md => const .symmetric(horizontal: 16, vertical: 12),
      .lg => const .symmetric(horizontal: 20, vertical: 14),
      .icon => const .all(12),
    };
  }

  double _minHeightFor(CnButtonSize size) {
    return switch (size) {
      .sm => 32,
      .md => 40,
      .lg => 48,
      .icon => 40,
    };
  }

  TextStyle? _textStyleFor(CnButtonVariant variant, TextStyle? base) {
    if (base == null) {
      return null;
    }
    if (variant == .link) {
      return base.copyWith(
        fontWeight: .w600,
        decoration: TextDecoration.underline,
      );
    }
    return base.copyWith(fontWeight: .w600);
  }

  _CnButtonVisuals _resolveVisuals(
    CnButtonVariant variant,
    ColorScheme scheme,
  ) {
    return switch (variant) {
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
}

class _ButtonContent extends StatelessWidget {
  final Widget? leading;
  final Widget? trailing;
  final Widget child;

  const _ButtonContent({required this.child, this.leading, this.trailing});

  @override
  Widget build(BuildContext context) {
    if (leading == null && trailing == null) {
      return child;
    }
    return Row(
      mainAxisSize: .min,
      spacing: 8,
      children: [
        if (leading != null) leading!,
        child,
        if (trailing != null) trailing!,
      ],
    );
  }
}

class _CnButtonVisuals {
  final Color background;
  final Color foreground;
  final Color border;

  const _CnButtonVisuals({
    required this.background,
    required this.foreground,
    required this.border,
  });
}
