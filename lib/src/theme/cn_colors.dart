import 'package:flutter/widgets.dart';

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
  /// The shadcn/ui neutral theme in light mode.
  static const light = CnColors(
    brightness: Brightness.light,
    background: CnColor(0xFFFFFFFF),
    foreground: CnColor.flat(0xFF0A0A0A),
    card: CnColor(0xFFFFFFFF),
    cardForeground: CnColor.flat(0xFF0A0A0A),
    popover: CnColor(0xFFFFFFFF),
    popoverForeground: CnColor.flat(0xFF0A0A0A),
    primary: CnColor(0xFF171717),
    primaryForeground: CnColor.flat(0xFFFAFAFA),
    secondary: CnColor(0xFFF5F5F5),
    secondaryForeground: CnColor.flat(0xFF171717),
    muted: CnColor(0xFFF5F5F5),
    mutedForeground: CnColor.flat(0xFF737373),
    accent: CnColor(0xFFF5F5F5),
    accentForeground: CnColor.flat(0xFF171717),
    destructive: CnColor(0xFFE7000B),
    destructiveForeground: CnColor.flat(0xFFFFFFFF),
    success: CnColor(0xFF00A63E),
    warning: CnColor(0xFFD08700),
    info: CnColor(0xFF155DFC),
    border: CnColor.flat(0xFFE5E5E5),
    input: CnColor.flat(0xFFE5E5E5),
    ring: CnColor.flat(0xFFA1A1A1),
    chart1: CnColor(0xFFF54900),
    chart2: CnColor(0xFF009689),
    chart3: CnColor(0xFF104E64),
    chart4: CnColor(0xFFFFB900),
    chart5: CnColor(0xFFFE9A00),
    sidebar: CnColor(0xFFFAFAFA),
    sidebarForeground: CnColor.flat(0xFF0A0A0A),
    sidebarPrimary: CnColor(0xFF171717),
    sidebarPrimaryForeground: CnColor.flat(0xFFFAFAFA),
    sidebarAccent: CnColor(0xFFF5F5F5),
    sidebarAccentForeground: CnColor.flat(0xFF171717),
    sidebarBorder: CnColor.flat(0xFFE5E5E5),
    sidebarRing: CnColor.flat(0xFFA1A1A1),
  );

  /// The shadcn/ui neutral theme in dark mode.
  static const dark = CnColors(
    brightness: Brightness.dark,
    background: CnColor(0xFF0A0A0A),
    foreground: CnColor.flat(0xFFFAFAFA),
    card: CnColor(0xFF171717),
    cardForeground: CnColor.flat(0xFFFAFAFA),
    popover: CnColor(0xFF171717),
    popoverForeground: CnColor.flat(0xFFFAFAFA),
    primary: CnColor(0xFFE5E5E5),
    primaryForeground: CnColor.flat(0xFF171717),
    secondary: CnColor(0xFF262626),
    secondaryForeground: CnColor.flat(0xFFFAFAFA),
    muted: CnColor(0xFF262626),
    mutedForeground: CnColor.flat(0xFFA1A1A1),
    accent: CnColor(0xFF262626),
    accentForeground: CnColor.flat(0xFFFAFAFA),
    destructive: CnColor(0xFFFF6467),
    destructiveForeground: CnColor.flat(0xFF0A0A0A),
    success: CnColor(0xFF05DF72),
    warning: CnColor(0xFFFDC700),
    info: CnColor(0xFF51A2FF),
    border: CnColor.flat(0x1AFFFFFF),
    input: CnColor.flat(0x26FFFFFF),
    ring: CnColor.flat(0xFF737373),
    chart1: CnColor(0xFF1447E6),
    chart2: CnColor(0xFF00BC7D),
    chart3: CnColor(0xFFFE9A00),
    chart4: CnColor(0xFFAD46FF),
    chart5: CnColor(0xFFFF2056),
    sidebar: CnColor(0xFF171717),
    sidebarForeground: CnColor.flat(0xFFFAFAFA),
    sidebarPrimary: CnColor(0xFF1447E6),
    sidebarPrimaryForeground: CnColor.flat(0xFFFAFAFA),
    sidebarAccent: CnColor(0xFF262626),
    sidebarAccentForeground: CnColor.flat(0xFFFAFAFA),
    sidebarBorder: CnColor.flat(0x1AFFFFFF),
    sidebarRing: CnColor.flat(0xFF737373),
  );

  /// The chart colors in order.
  List<CnColor> get charts => [chart1, chart2, chart3, chart4, chart5];

  /// Returns a copy with the given tokens replaced.
  CnColors copyWith({
    Color? background,
    Color? foreground,
    Color? primary,
    Color? primaryForeground,
    Color? accent,
    Color? accentForeground,
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
      secondary: secondary,
      secondaryForeground: secondaryForeground,
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
      chart1: chart1,
      chart2: chart2,
      chart3: chart3,
      chart4: chart4,
      chart5: chart5,
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
  CnColors lerp(CnColors other, double t) {
    return CnColors(
      brightness: t < 0.5 ? brightness : other.brightness,
      background: background.lerpTo(other.background, t),
      foreground: foreground.lerpTo(other.foreground, t),
      card: card.lerpTo(other.card, t),
      cardForeground: cardForeground.lerpTo(other.cardForeground, t),
      popover: popover.lerpTo(other.popover, t),
      popoverForeground: popoverForeground.lerpTo(other.popoverForeground, t),
      primary: primary.lerpTo(other.primary, t),
      primaryForeground: primaryForeground.lerpTo(other.primaryForeground, t),
      secondary: secondary.lerpTo(other.secondary, t),
      secondaryForeground: secondaryForeground.lerpTo(
        other.secondaryForeground,
        t,
      ),
      muted: muted.lerpTo(other.muted, t),
      mutedForeground: mutedForeground.lerpTo(other.mutedForeground, t),
      accent: accent.lerpTo(other.accent, t),
      accentForeground: accentForeground.lerpTo(other.accentForeground, t),
      destructive: destructive.lerpTo(other.destructive, t),
      destructiveForeground: destructiveForeground.lerpTo(
        other.destructiveForeground,
        t,
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
      sidebarForeground: sidebarForeground.lerpTo(other.sidebarForeground, t),
      sidebarPrimary: sidebarPrimary.lerpTo(other.sidebarPrimary, t),
      sidebarPrimaryForeground: sidebarPrimaryForeground.lerpTo(
        other.sidebarPrimaryForeground,
        t,
      ),
      sidebarAccent: sidebarAccent.lerpTo(other.sidebarAccent, t),
      sidebarAccentForeground: sidebarAccentForeground.lerpTo(
        other.sidebarAccentForeground,
        t,
      ),
      sidebarBorder: sidebarBorder.lerpTo(other.sidebarBorder, t),
      sidebarRing: sidebarRing.lerpTo(other.sidebarRing, t),
    );
  }
}
