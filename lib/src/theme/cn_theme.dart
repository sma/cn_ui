import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Visual style presets for [CnTheme].
enum CnStyle { classic, newYork }

/// A theme extension for customizing the CN UI component library.
///
/// Provides control over visual style, colors, fonts, border radius, and menu styling.
/// Use [CnTheme.of] to access the theme from any BuildContext.
///
/// See also:
///
///  * [ThemeExtension], the Flutter base class for theme extensions.
///  * [ColorScheme], for Material 3 color configuration.
@immutable
class CnTheme extends ThemeExtension<CnTheme> {
  final CnStyle style;
  final Color baseColor;
  final Color themeColor;
  final String fontFamily;
  final double radius;
  final Color menuColor;
  final Color menuAccent;

  const CnTheme({
    this.style = .classic,
    this.baseColor = const Color(0xFFF7F4EF),
    this.themeColor = const Color(0xFF1D4ED8),
    this.fontFamily = 'Space Grotesk',
    this.radius = 12,
    this.menuColor = const Color(0xFFFDFBF7),
    this.menuAccent = const Color(0xFF1D4ED8),
  });

  static CnTheme of(BuildContext context) {
    final theme = Theme.of(context);
    return theme.extension<CnTheme>() ?? const CnTheme();
  }

  static TextTheme textThemeOf(BuildContext context) {
    return TextTheme.of(context);
  }

  static ColorScheme colorSchemeOf(BuildContext context) {
    return ColorScheme.of(context);
  }

  ThemeData toThemeData({Brightness brightness = Brightness.light}) {
    final baseScheme = ColorScheme.fromSeed(
      seedColor: themeColor,
      brightness: brightness,
    );
    final colorScheme = baseScheme.copyWith(surface: baseColor);

    final baseTextTheme = ThemeData(brightness: brightness).textTheme;
    TextTheme textTheme;
    if (fontFamily.trim().isEmpty) {
      textTheme = baseTextTheme;
    } else {
      try {
        textTheme = GoogleFonts.getTextTheme(fontFamily, baseTextTheme);
      } catch (_) {
        textTheme = baseTextTheme.apply(fontFamily: fontFamily);
      }
    }

    textTheme = _applyStyle(textTheme);

    final shape = RoundedRectangleBorder(
      borderRadius: .circular(radius),
      side: BorderSide(color: colorScheme.outlineVariant),
    );

    return ThemeData(
      useMaterial3: true,
      visualDensity: .compact,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.surface,
      textTheme: textTheme,
      dividerTheme: DividerThemeData(color: colorScheme.outlineVariant),
      cardTheme: CardThemeData(
        shape: shape,
        surfaceTintColor: Colors.transparent,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surface,
        border: OutlineInputBorder(
          borderRadius: .circular(radius),
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: .circular(radius),
          borderSide: BorderSide(color: colorScheme.outlineVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: .circular(radius),
          borderSide: BorderSide(color: colorScheme.primary, width: 1.5),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: colorScheme.inverseSurface,
        contentTextStyle: textTheme.bodyMedium?.copyWith(
          color: colorScheme.onInverseSurface,
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: .circular(radius)),
      ),
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: colorScheme.inverseSurface,
          borderRadius: .circular(math.max(0, radius - 2)),
        ),
        textStyle: textTheme.bodySmall?.copyWith(
          color: colorScheme.onInverseSurface,
        ),
      ),
      tabBarTheme: TabBarThemeData(
        dividerColor: colorScheme.outlineVariant,
        labelColor: colorScheme.onSurface,
        unselectedLabelColor: colorScheme.onSurfaceVariant,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: colorScheme.onSurface),
        titleTextStyle: textTheme.titleLarge?.copyWith(
          color: colorScheme.onSurface,
        ),
      ),
      drawerTheme: DrawerThemeData(
        backgroundColor: menuColor,
        shape: RoundedRectangleBorder(borderRadius: .circular(radius)),
      ),
      extensions: [this],
    );
  }

  TextTheme _applyStyle(TextTheme base) {
    if (style == .newYork) {
      return base.copyWith(
        displaySmall: base.displaySmall?.copyWith(
          fontWeight: .w600,
          letterSpacing: -0.5,
        ),
        headlineMedium: base.headlineMedium?.copyWith(
          fontWeight: .w600,
          letterSpacing: -0.4,
        ),
        titleLarge: base.titleLarge?.copyWith(fontWeight: .w600),
        titleMedium: base.titleMedium?.copyWith(fontWeight: .w600),
      );
    }
    return base;
  }

  @override
  CnTheme copyWith({
    CnStyle? style,
    Color? baseColor,
    Color? themeColor,
    String? fontFamily,
    double? radius,
    Color? menuColor,
    Color? menuAccent,
  }) {
    return CnTheme(
      style: style ?? this.style,
      baseColor: baseColor ?? this.baseColor,
      themeColor: themeColor ?? this.themeColor,
      fontFamily: fontFamily ?? this.fontFamily,
      radius: radius ?? this.radius,
      menuColor: menuColor ?? this.menuColor,
      menuAccent: menuAccent ?? this.menuAccent,
    );
  }

  @override
  CnTheme lerp(ThemeExtension<CnTheme>? other, double t) {
    if (other is! CnTheme) {
      return this;
    }
    return CnTheme(
      style: t < 0.5 ? style : other.style,
      baseColor: Color.lerp(baseColor, other.baseColor, t) ?? baseColor,
      themeColor: Color.lerp(themeColor, other.themeColor, t) ?? themeColor,
      fontFamily: t < 0.5 ? fontFamily : other.fontFamily,
      radius: lerpDouble(radius, other.radius, t) ?? radius,
      menuColor: Color.lerp(menuColor, other.menuColor, t) ?? menuColor,
      menuAccent: Color.lerp(menuAccent, other.menuAccent, t) ?? menuAccent,
    );
  }
}
