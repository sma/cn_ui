import 'package:material_ui/material_ui.dart';

import '../theme/cn_theme.dart';
import 'cn_button_group.dart';

/// Visual style variants for [CnButton].
enum CnButtonVariant { primary, secondary, outline, ghost, destructive, link }

/// Size variants for [CnButton].
enum CnButtonSize { xs, sm, md, lg }

/// A button with multiple variants and sizes.
///
/// A `null` [onPressed] disables the button. Inside a [CnButtonGroup], the
/// button adapts its corners to its position in the group.
///
/// See also:
///
///  * [CnButtonGroup], which groups multiple buttons together.
///  * [CnToggle], for toggle buttons.
class CnButton extends StatelessWidget {
  const CnButton({
    super.key,
    this.variant = .primary,
    this.size = .md,
    required this.onPressed,
    required this.child,
    this.leading,
    this.trailing,
    this.expand = false,
  }) : _square = false;

  /// Creates a square button that only shows an icon.
  const CnButton.icon({
    super.key,
    this.variant = .primary,
    this.size = .md,
    required this.onPressed,
    required Widget icon,
  }) : child = icon,
       leading = null,
       trailing = null,
       expand = false,
       _square = true;

  final CnButtonVariant variant;
  final CnButtonSize size;
  final VoidCallback? onPressed;
  final Widget child;
  final Widget? leading;
  final Widget? trailing;
  final bool expand;
  final bool _square;

  @override
  Widget build(BuildContext context) {
    final theme = CnTheme.of(context);
    final colors = theme.colors;
    final group = CnButtonGroup.of(context);
    final height = switch (size) {
      .xs => 24.0,
      .sm => 32.0,
      .md => 36.0,
      .lg => 40.0,
    };
    final padding = _square
        ? EdgeInsets.zero
        : switch (size) {
            .xs => const EdgeInsets.symmetric(horizontal: 8),
            .sm => const EdgeInsets.symmetric(horizontal: 12),
            .md => const EdgeInsets.symmetric(horizontal: 16),
            .lg => const EdgeInsets.symmetric(horizontal: 24),
          };
    final textStyle = (size == .xs ? theme.text.xs : theme.text.sm).medium;
    final radius = theme.radii.md;

    Widget button = TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        minimumSize: .all(_square ? Size.square(height) : Size(0, height)),
        maximumSize: _square ? .all(Size.square(height)) : null,
        padding: .all(padding),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: .standard,
        animationDuration: Duration.zero,
        backgroundColor: _background(colors),
        foregroundColor: _foreground(colors),
        iconColor: _foreground(colors),
        iconSize: .all(size == .xs ? 12 : 16),
        overlayColor: .all(Colors.transparent),
        shape: .resolveWith(
          (states) => RoundedRectangleBorder(
            borderRadius:
                group?.borderRadius(radius) ?? BorderRadius.circular(radius),
            side: variant == .outline
                ? BorderSide(color: colors.input.resolve(states))
                : BorderSide.none,
          ),
        ),
        textStyle: .resolveWith((states) {
          final underline =
              variant == .link && states.contains(WidgetState.hovered);
          return underline
              ? textStyle.copyWith(decoration: TextDecoration.underline)
              : textStyle;
        }),
      ),
      child: IconTheme.merge(
        data: IconThemeData(size: size == .xs ? 12 : 16),
        child: leading == null && trailing == null
            ? child
            : Row(
                mainAxisSize: expand ? .max : .min,
                mainAxisAlignment: .center,
                spacing: 8,
                children: [?leading, child, ?trailing],
              ),
      ),
    );

    if (expand) {
      button = SizedBox(width: double.infinity, child: button);
    }
    return button;
  }

  WidgetStateProperty<Color> _background(CnColors colors) {
    return switch (variant) {
      .primary => colors.primary,
      .secondary => colors.secondary,
      .outline || .ghost => WidgetStateColor.fromMap({
        WidgetState.disabled: Colors.transparent,
        WidgetState.pressed | WidgetState.hovered | WidgetState.focused:
            colors.accent,
        WidgetState.any: Colors.transparent,
      }),
      .destructive => WidgetStateColor.fromMap({
        WidgetState.disabled: colors.destructive.withValues(alpha: 0.05),
        WidgetState.pressed | WidgetState.hovered: colors.destructive
            .withValues(alpha: 0.2),
        WidgetState.any: colors.destructive.withValues(alpha: 0.1),
      }),
      .link => const WidgetStatePropertyAll(Colors.transparent),
    };
  }

  WidgetStateProperty<Color> _foreground(CnColors colors) {
    return switch (variant) {
      .primary => colors.primaryForeground,
      .secondary => colors.secondaryForeground,
      .outline || .ghost => WidgetStateColor.fromMap({
        WidgetState.disabled: colors.foreground.resolve(const {.disabled}),
        WidgetState.pressed | WidgetState.hovered | WidgetState.focused:
            colors.accentForeground,
        WidgetState.any: colors.foreground,
      }),
      .destructive => colors.destructive,
      .link => colors.primary,
    };
  }
}
