import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/cn_theme.dart';

/// Visual style variants for [CnToggle].
enum CnToggleVariant { outline, ghost }

/// Size variants for [CnToggle].
enum CnToggleSize { sm, md, lg }

/// A toggle button component for binary on/off states.
///
/// Provides outline and ghost variants with multiple sizes for toggling boolean values.
///
/// See also:
///
///  * [CnToggleGroup], which groups multiple toggle buttons together.
///  * [CnSwitch], for a switch-style toggle.
///  * [CnCheckbox], for checkbox-style selection.
class CnToggle extends StatelessWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  final Widget child;
  final CnToggleVariant variant;
  final CnToggleSize size;
  final bool enabled;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  final bool showBorder;

  const CnToggle({
    super.key,
    required this.value,
    required this.child,
    this.onChanged,
    this.variant = .outline,
    this.size = .md,
    this.enabled = true,
    this.padding,
    this.borderRadius,
    this.showBorder = true,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = CnTheme.colorSchemeOf(context);
    final cnTheme = CnTheme.of(context);
    final isEnabled = enabled && onChanged != null;
    final visuals = _resolveVisuals(
      scheme,
      value,
      variant,
      isEnabled,
      showBorder,
    );
    final resolvedPadding = padding ?? _paddingFor(size);
    final minHeight = _minHeightFor(size);
    final resolvedRadius =
        borderRadius ?? .circular(math.max(0, cnTheme.radius - 4));

    return Opacity(
      opacity: isEnabled ? 1 : 0.6,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: resolvedRadius,
          onTap: isEnabled ? () => onChanged!(!value) : null,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOut,
            padding: resolvedPadding,
            constraints: BoxConstraints(minHeight: minHeight),
            decoration: BoxDecoration(
              color: visuals.background,
              borderRadius: resolvedRadius,
              border: Border.all(color: visuals.border),
            ),
            child: DefaultTextStyle(
              style:
                  CnTheme.textThemeOf(context).labelLarge?.copyWith(
                    color: visuals.foreground,
                    fontWeight: .w600,
                  ) ??
                  TextStyle(color: visuals.foreground),
              child: IconTheme(
                data: IconThemeData(color: visuals.foreground, size: 16),
                child: Center(child: child),
              ),
            ),
          ),
        ),
      ),
    );
  }

  EdgeInsets _paddingFor(CnToggleSize size) {
    return switch (size) {
      .sm => const .symmetric(horizontal: 8, vertical: 2),
      .md => const .symmetric(horizontal: 8, vertical: 6),
      .lg => const .symmetric(horizontal: 12, vertical: 12),
    };
  }

  double _minHeightFor(CnToggleSize size) {
    return switch (size) {
      .sm => 24,
      .md => 32,
      .lg => 48,
    };
  }

  _ToggleVisuals _resolveVisuals(
    ColorScheme scheme,
    bool selected,
    CnToggleVariant variant,
    bool enabled,
    bool showBorder,
  ) {
    final baseForeground = selected
        ? scheme.onSecondaryContainer
        : scheme.onSurface;
    final foreground = enabled
        ? baseForeground
        : scheme.onSurfaceVariant.withValues(alpha: 0.6);

    if (selected) {
      return _ToggleVisuals(
        background: scheme.secondaryContainer,
        border: showBorder ? scheme.secondary : Colors.transparent,
        foreground: foreground,
      );
    }

    return _ToggleVisuals(
      background: variant == .outline ? scheme.surface : Colors.transparent,
      border: showBorder && variant == .outline
          ? scheme.outlineVariant
          : Colors.transparent,
      foreground: foreground,
    );
  }
}

class _ToggleVisuals {
  final Color background;
  final Color border;
  final Color foreground;

  const _ToggleVisuals({
    required this.background,
    required this.border,
    required this.foreground,
  });
}
