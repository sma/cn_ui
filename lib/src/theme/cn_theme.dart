import 'dart:ui';

import 'package:google_fonts/google_fonts.dart';
import 'package:material_ui/material_ui.dart';

import 'cn_colors.dart';

export 'cn_colors.dart';

/// The radius scale, derived from a base radius like the shadcn/ui variables.
@immutable
class const CnRadii(final double base) {
  double get sm => base * 0.6;
  double get md => base * 0.8;
  double get lg => base;
  double get xl => base * 1.4;

  /// A radius for fully rounded shapes such as pills.
  double get full => 999;
}

/// The type scale, named like the Tailwind sizes shadcn/ui uses.
///
/// The styles carry no color, so they inherit the color of their surroundings.
@immutable
class CnTextStyles {
  CnTextStyles._(String fontFamily)
    : xs = _style(fontFamily, 12, 16),
      sm = _style(fontFamily, 14, 20),
      base = _style(fontFamily, 16, 24),
      lg = _style(fontFamily, 18, 28),
      xl = _style(fontFamily, 20, 28),
      xl2 = _style(fontFamily, 24, 32),
      xl3 = _style(fontFamily, 30, 36),
      xl4 = _style(fontFamily, 36, 40),
      mono = fontFamily.trim().isEmpty
          ? const TextStyle(
              fontFamily: 'monospace',
              fontSize: 14,
              height: 20 / 14,
            )
          : _style('IBM Plex Mono', 14, 20);

  final TextStyle xs;
  final TextStyle sm;
  final TextStyle base;
  final TextStyle lg;
  final TextStyle xl;
  final TextStyle xl2;
  final TextStyle xl3;
  final TextStyle xl4;
  final TextStyle mono;

  static final _cache = <String, CnTextStyles>{};

  static CnTextStyles _of(String fontFamily) {
    return _cache.putIfAbsent(fontFamily, () => CnTextStyles._(fontFamily));
  }

  static TextStyle _style(String fontFamily, double size, double lineHeight) {
    final style = TextStyle(fontSize: size, height: lineHeight / size);
    if (fontFamily.trim().isEmpty) {
      return style;
    }
    try {
      return GoogleFonts.getFont(fontFamily, textStyle: style);
    } catch (_) {
      return style.copyWith(fontFamily: fontFamily);
    }
  }
}

/// Font weight shortcuts for the styles in [CnTextStyles].
extension CnTextStyleWeights on TextStyle {
  TextStyle get medium => copyWith(fontWeight: FontWeight.w500);
  TextStyle get semibold => copyWith(fontWeight: FontWeight.w600);
}

/// The design tokens of the component library.
///
/// Components read their colors, text styles and radii from here. Use
/// [toThemeData] to configure Material widgets from the same tokens.
@immutable
class const CnTheme({
  final CnColors colors = CnColors.light,
  final String fontFamily = 'Geist',
  final double radius = 10,
}) extends ThemeExtension<CnTheme> {
  /// Returns the current [CnTheme].
  static CnTheme of(BuildContext context) {
    return Theme.of(context).extension<CnTheme>() ??
        const CnTheme(fontFamily: '');
  }

  /// The radius scale derived from [radius].
  CnRadii get radii => CnRadii(radius);

  /// The type scale in [fontFamily].
  CnTextStyles get text => CnTextStyles._of(fontFamily);

  /// Converts this theme into a Material theme.
  ThemeData toThemeData() {
    final text = this.text;
    final radii = this.radii;
    final colorScheme = ColorScheme(
      brightness: colors.brightness,
      primary: colors.primary,
      onPrimary: colors.primaryForeground,
      secondary: colors.secondary,
      onSecondary: colors.secondaryForeground,
      secondaryContainer: colors.secondary,
      onSecondaryContainer: colors.secondaryForeground,
      tertiary: colors.accent,
      onTertiary: colors.accentForeground,
      error: colors.destructive,
      onError: colors.destructiveForeground,
      surface: colors.background,
      onSurface: colors.foreground,
      onSurfaceVariant: colors.mutedForeground,
      surfaceContainerLowest: colors.background,
      surfaceContainerLow: colors.card,
      surfaceContainer: colors.popover,
      surfaceContainerHigh: colors.popover,
      surfaceContainerHighest: colors.muted,
      surfaceTint: Colors.transparent,
      outline: colors.input,
      outlineVariant: colors.border,
      inverseSurface: colors.foreground,
      onInverseSurface: colors.background,
      inversePrimary: colors.primaryForeground,
    );
    final textTheme = TextTheme(
      displayLarge: text.xl4.semibold,
      displayMedium: text.xl4.semibold,
      displaySmall: text.xl3.semibold,
      headlineLarge: text.xl3.semibold,
      headlineMedium: text.xl2.semibold,
      headlineSmall: text.xl.semibold,
      titleLarge: text.lg.semibold,
      titleMedium: text.base.semibold,
      titleSmall: text.sm.semibold,
      bodyLarge: text.base,
      bodyMedium: text.sm,
      bodySmall: text.xs,
      labelLarge: text.sm.medium,
      labelMedium: text.xs.medium,
      labelSmall: text.xs.medium,
    ).apply(bodyColor: colors.foreground, displayColor: colors.foreground);
    final divider = BorderSide(color: colors.border);
    OutlineInputBorder inputBorder(Color color, [double width = 1]) {
      return OutlineInputBorder(
        borderRadius: .circular(radii.md),
        borderSide: BorderSide(color: color, width: width),
      );
    }

    final surface = RoundedRectangleBorder(
      borderRadius: .circular(radius),
      side: divider,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: colors.brightness,
      visualDensity: .standard,
      colorScheme: colorScheme,
      textTheme: textTheme,
      scaffoldBackgroundColor: colors.background,
      canvasColor: colors.background,
      dividerColor: colors.border,
      hoverColor: colors.accent,
      focusColor: colors.accent,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      splashFactory: NoSplash.splashFactory,
      iconTheme: IconThemeData(color: colors.foreground, size: 16),
      dividerTheme: DividerThemeData(
        color: colors.border,
        space: 1,
        thickness: 1,
      ),
      cardTheme: CardThemeData(
        color: colors.card,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        margin: .zero,
        shape: surface,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: colors.background,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        shape: surface,
        titleTextStyle: text.lg.semibold.copyWith(color: colors.foreground),
        contentTextStyle: text.sm.copyWith(color: colors.mutedForeground),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: false,
        isDense: true,
        contentPadding: const .symmetric(horizontal: 12, vertical: 10),
        hintStyle: text.sm.copyWith(color: colors.mutedForeground),
        errorStyle: text.xs.copyWith(color: colors.destructive),
        border: inputBorder(colors.input),
        enabledBorder: inputBorder(colors.input),
        disabledBorder: inputBorder(colors.input.resolve(const {.disabled})),
        focusedBorder: inputBorder(colors.ring, 2),
        errorBorder: inputBorder(colors.destructive),
        focusedErrorBorder: inputBorder(colors.destructive, 2),
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: colors.foreground,
        selectionColor: colors.primary.withValues(alpha: 0.2),
        selectionHandleColor: colors.primary,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: colors.popover,
        contentTextStyle: text.sm.copyWith(color: colors.popoverForeground),
        actionTextColor: colors.foreground,
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        shape: surface,
      ),
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: colors.foreground,
          borderRadius: .circular(radii.md),
        ),
        padding: const .symmetric(horizontal: 12, vertical: 6),
        textStyle: text.xs.copyWith(color: colors.background),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: colors.background,
        foregroundColor: colors.foreground,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        iconTheme: IconThemeData(color: colors.foreground),
        titleTextStyle: text.lg.semibold.copyWith(color: colors.foreground),
      ),
      drawerTheme: DrawerThemeData(
        backgroundColor: colors.sidebar,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: .circular(radius)),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: .resolveWith((states) {
          if (!states.contains(WidgetState.selected)) {
            return Colors.transparent;
          }
          return colors.primary.resolve(states);
        }),
        checkColor: colors.primaryForeground,
        overlayColor: .all(Colors.transparent),
        side: WidgetStateBorderSide.fromMap({
          WidgetState.selected: BorderSide(color: colors.primary),
          WidgetState.any: BorderSide(color: colors.input),
        }),
        shape: RoundedRectangleBorder(borderRadius: .circular(radii.sm)),
      ),
      radioTheme: RadioThemeData(
        fillColor: .resolveWith((states) {
          if (!states.contains(WidgetState.selected)) {
            return colors.input;
          }
          return colors.primary.resolve(states);
        }),
        overlayColor: .all(Colors.transparent),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: .resolveWith((states) {
          return states.contains(WidgetState.selected)
              ? colors.primaryForeground
              : colors.background;
        }),
        trackColor: .resolveWith((states) {
          return states.contains(WidgetState.selected)
              ? colors.primary.resolve(states)
              : colors.input;
        }),
        trackOutlineColor: .all(Colors.transparent),
        overlayColor: .all(Colors.transparent),
      ),
      sliderTheme: SliderThemeData(
        activeTrackColor: colors.primary,
        inactiveTrackColor: colors.muted,
        thumbColor: colors.background,
        overlayColor: Colors.transparent,
        trackHeight: 4,
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: colors.primary,
        linearTrackColor: colors.primary.withValues(alpha: 0.2),
      ),
      scrollbarTheme: ScrollbarThemeData(
        thumbColor: .all(colors.border),
        radius: .circular(radii.full),
      ),
      menuTheme: MenuThemeData(
        style: MenuStyle(
          backgroundColor: .all(colors.popover),
          surfaceTintColor: .all(Colors.transparent),
          elevation: .all(0),
          side: .all(divider),
          shape: .all(
            RoundedRectangleBorder(borderRadius: .circular(radii.md)),
          ),
        ),
      ),
      extensions: [this],
    );
  }

  @override
  CnTheme copyWith({CnColors? colors, String? fontFamily, double? radius}) {
    return CnTheme(
      colors: colors ?? this.colors,
      fontFamily: fontFamily ?? this.fontFamily,
      radius: radius ?? this.radius,
    );
  }

  @override
  CnTheme lerp(ThemeExtension<CnTheme>? other, double t) {
    if (other is! CnTheme) {
      return this;
    }
    return CnTheme(
      colors: colors.lerp(other.colors, t),
      fontFamily: t < 0.5 ? fontFamily : other.fontFamily,
      radius: lerpDouble(radius, other.radius, t) ?? radius,
    );
  }
}
