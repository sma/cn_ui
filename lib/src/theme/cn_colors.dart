import 'package:flutter/widgets.dart';

part 'cn_palettes.dart';

/// The base colors of shadcn/ui. They tint the neutral surfaces and text.
enum CnBaseColor { neutral, stone, zinc, mauve, olive, mist, taupe }

/// The theme colors of shadcn/ui. [base] uses the colors of the base color.
enum CnAccentColor {
  base,
  amber,
  blue,
  cyan,
  emerald,
  fuchsia,
  green,
  indigo,
  lime,
  orange,
  pink,
  purple,
  red,
  rose,
  sky,
  teal,
  violet,
  yellow,
}

/// A color token that also knows how it looks in each widget state.
///
/// It can be used as a plain [Color], which is its rest value, or as a
/// [WidgetStateProperty], e.g. `ButtonStyle(backgroundColor: colors.primary)`.
class CnColor extends WidgetStateColor {
  /// A fill color: lighter on hover and press, half transparent when disabled.
  const CnColor(super.defaultValue) : _flat = false;

  /// A text or line color: only changes when disabled.
  const CnColor.flat(super.defaultValue) : _flat = true;

  CnColor._from(Color color, this._flat) : super(color.toARGB32());

  final bool _flat;

  @override
  Color resolve(Set<WidgetState> states) {
    if (states.contains(WidgetState.disabled)) {
      return _scaleAlpha(0.5);
    }
    if (_flat) {
      return this;
    }
    if (states.contains(WidgetState.pressed)) {
      return _scaleAlpha(0.8);
    }
    if (states.contains(WidgetState.hovered) ||
        states.contains(WidgetState.focused)) {
      return _scaleAlpha(0.9);
    }
    return this;
  }

  Color _scaleAlpha(double factor) => withValues(alpha: a * factor);

  /// Returns a token with the same state behavior as this one.
  CnColor withColor(Color color) => CnColor._from(color, _flat);

  /// Interpolates between two tokens, keeping the state behavior of this one.
  CnColor lerpTo(CnColor other, double t) {
    return withColor(Color.lerp(this, other, t) ?? this);
  }
}

/// The color tokens of a theme, named like the shadcn/ui CSS variables.
///
/// `destructiveForeground`, `success`, `warning` and `info` have no shadcn
/// counterpart. They exist for the status variants of alerts and toasts.
@immutable
class const CnColors({
  required final Brightness brightness,
  required final CnColor background,
  required final CnColor foreground,
  required final CnColor card,
  required final CnColor cardForeground,
  required final CnColor popover,
  required final CnColor popoverForeground,
  required final CnColor primary,
  required final CnColor primaryForeground,
  required final CnColor secondary,
  required final CnColor secondaryForeground,
  required final CnColor muted,
  required final CnColor mutedForeground,
  required final CnColor accent,
  required final CnColor accentForeground,
  required final CnColor destructive,
  required final CnColor destructiveForeground,
  required final CnColor success,
  required final CnColor warning,
  required final CnColor info,
  required final CnColor border,
  required final CnColor input,
  required final CnColor ring,
  required final CnColor chart1,
  required final CnColor chart2,
  required final CnColor chart3,
  required final CnColor chart4,
  required final CnColor chart5,
  required final CnColor sidebar,
  required final CnColor sidebarForeground,
  required final CnColor sidebarPrimary,
  required final CnColor sidebarPrimaryForeground,
  required final CnColor sidebarAccent,
  required final CnColor sidebarAccentForeground,
  required final CnColor sidebarBorder,
  required final CnColor sidebarRing,
}) {
  /// Combines the choices of https://ui.shadcn.com/create.
  ///
  /// [theme] sets the primary colors. [chart] sets the chart colors and
  /// defaults to [theme].
  factory CnColors.palette({
    CnBaseColor base = .neutral,
    CnAccentColor theme = .base,
    CnAccentColor? chart,
    Brightness brightness = .light,
  }) {
    final isDark = brightness == .dark;
    final palette = _baseColors[base]!;

    _Accent? accentOf(CnAccentColor color) {
      final accents = _accents[color];
      return isDark ? accents?.dark : accents?.light;
    }

    final neutral = isDark ? palette.dark : palette.light;
    final colors = accentOf(theme)?.applyTo(neutral) ?? neutral;
    final charts = accentOf(chart ?? theme);
    return colors.copyWith(
      chart1: charts?.chart1 ?? neutral.chart1,
      chart2: charts?.chart2 ?? neutral.chart2,
      chart3: charts?.chart3 ?? neutral.chart3,
      chart4: charts?.chart4 ?? neutral.chart4,
      chart5: charts?.chart5 ?? neutral.chart5,
    );
  }

  /// The shadcn/ui neutral theme in light mode.
  static const light = _neutralLight;

  /// The shadcn/ui neutral theme in dark mode.
  static const dark = _neutralDark;

  /// The chart colors in order.
  List<CnColor> get charts => [chart1, chart2, chart3, chart4, chart5];

  /// Returns a copy with the given tokens replaced.
  CnColors copyWith({
    Color? background,
    Color? foreground,
    Color? primary,
    Color? primaryForeground,
    Color? secondary,
    Color? secondaryForeground,
    Color? accent,
    Color? accentForeground,
    Color? chart1,
    Color? chart2,
    Color? chart3,
    Color? chart4,
    Color? chart5,
    Color? sidebar,
    Color? sidebarPrimary,
    Color? sidebarPrimaryForeground,
    Color? sidebarAccent,
    Color? sidebarAccentForeground,
  }) {
    CnColor pick(Color? color, CnColor current) {
      return color == null ? current : current.withColor(color);
    }

    return CnColors(
      brightness: brightness,
      background: pick(background, this.background),
      foreground: pick(foreground, this.foreground),
      card: card,
      cardForeground: cardForeground,
      popover: popover,
      popoverForeground: popoverForeground,
      primary: pick(primary, this.primary),
      primaryForeground: pick(primaryForeground, this.primaryForeground),
      secondary: pick(secondary, this.secondary),
      secondaryForeground: pick(secondaryForeground, this.secondaryForeground),
      muted: muted,
      mutedForeground: mutedForeground,
      accent: pick(accent, this.accent),
      accentForeground: pick(accentForeground, this.accentForeground),
      destructive: destructive,
      destructiveForeground: destructiveForeground,
      success: success,
      warning: warning,
      info: info,
      border: border,
      input: input,
      ring: ring,
      chart1: pick(chart1, this.chart1),
      chart2: pick(chart2, this.chart2),
      chart3: pick(chart3, this.chart3),
      chart4: pick(chart4, this.chart4),
      chart5: pick(chart5, this.chart5),
      sidebar: pick(sidebar, this.sidebar),
      sidebarForeground: sidebarForeground,
      sidebarPrimary: pick(sidebarPrimary, this.sidebarPrimary),
      sidebarPrimaryForeground: pick(
        sidebarPrimaryForeground,
        this.sidebarPrimaryForeground,
      ),
      sidebarAccent: pick(sidebarAccent, this.sidebarAccent),
      sidebarAccentForeground: pick(
        sidebarAccentForeground,
        this.sidebarAccentForeground,
      ),
      sidebarBorder: sidebarBorder,
      sidebarRing: sidebarRing,
    );
  }

  /// Interpolates between two sets of tokens.
  ///
  /// Between light and dark, a surface and its text would meet at the same
  /// gray halfway. So the text flips in the middle instead of fading and stays
  /// readable while the surfaces fade.
  CnColors lerp(CnColors other, double t) {
    final textT = t < 0.5 ? 0.0 : 1.0;
    return CnColors(
      brightness: t < 0.5 ? brightness : other.brightness,
      background: background.lerpTo(other.background, t),
      foreground: foreground.lerpTo(other.foreground, textT),
      card: card.lerpTo(other.card, t),
      cardForeground: cardForeground.lerpTo(other.cardForeground, textT),
      popover: popover.lerpTo(other.popover, t),
      popoverForeground: popoverForeground.lerpTo(
        other.popoverForeground,
        textT,
      ),
      primary: primary.lerpTo(other.primary, t),
      primaryForeground: primaryForeground.lerpTo(
        other.primaryForeground,
        textT,
      ),
      secondary: secondary.lerpTo(other.secondary, t),
      secondaryForeground: secondaryForeground.lerpTo(
        other.secondaryForeground,
        textT,
      ),
      muted: muted.lerpTo(other.muted, t),
      mutedForeground: mutedForeground.lerpTo(other.mutedForeground, textT),
      accent: accent.lerpTo(other.accent, t),
      accentForeground: accentForeground.lerpTo(other.accentForeground, textT),
      destructive: destructive.lerpTo(other.destructive, t),
      destructiveForeground: destructiveForeground.lerpTo(
        other.destructiveForeground,
        textT,
      ),
      success: success.lerpTo(other.success, t),
      warning: warning.lerpTo(other.warning, t),
      info: info.lerpTo(other.info, t),
      border: border.lerpTo(other.border, t),
      input: input.lerpTo(other.input, t),
      ring: ring.lerpTo(other.ring, t),
      chart1: chart1.lerpTo(other.chart1, t),
      chart2: chart2.lerpTo(other.chart2, t),
      chart3: chart3.lerpTo(other.chart3, t),
      chart4: chart4.lerpTo(other.chart4, t),
      chart5: chart5.lerpTo(other.chart5, t),
      sidebar: sidebar.lerpTo(other.sidebar, t),
      sidebarForeground: sidebarForeground.lerpTo(
        other.sidebarForeground,
        textT,
      ),
      sidebarPrimary: sidebarPrimary.lerpTo(other.sidebarPrimary, t),
      sidebarPrimaryForeground: sidebarPrimaryForeground.lerpTo(
        other.sidebarPrimaryForeground,
        textT,
      ),
      sidebarAccent: sidebarAccent.lerpTo(other.sidebarAccent, t),
      sidebarAccentForeground: sidebarAccentForeground.lerpTo(
        other.sidebarAccentForeground,
        textT,
      ),
      sidebarBorder: sidebarBorder.lerpTo(other.sidebarBorder, t),
      sidebarRing: sidebarRing.lerpTo(other.sidebarRing, t),
    );
  }
}

/// The tokens a theme color overrides.
class const _Accent({
  required final Color primary,
  required final Color primaryForeground,
  required final Color secondary,
  required final Color secondaryForeground,
  required final Color chart1,
  required final Color chart2,
  required final Color chart3,
  required final Color chart4,
  required final Color chart5,
  final Color? sidebar,
  required final Color sidebarPrimary,
  required final Color sidebarPrimaryForeground,
}) {
  CnColors applyTo(CnColors colors) {
    return colors.copyWith(
      primary: primary,
      primaryForeground: primaryForeground,
      secondary: secondary,
      secondaryForeground: secondaryForeground,
      sidebar: sidebar,
      sidebarPrimary: sidebarPrimary,
      sidebarPrimaryForeground: sidebarPrimaryForeground,
    );
  }
}
