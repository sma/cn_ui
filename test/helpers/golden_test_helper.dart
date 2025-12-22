import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cn_ui/src/theme/cn_theme.dart';

/// Configuration for a theme variant in golden tests
class ThemeVariantConfig {
  final String name;
  final CnTheme cnTheme;
  final Brightness brightness;

  const ThemeVariantConfig({
    required this.name,
    required this.cnTheme,
    required this.brightness,
  });
}

/// The three theme variants used in golden tests
class GoldenThemeVariants {
  // Theme 1: Default classic theme
  static const classic = ThemeVariantConfig(
    name: 'Classic',
    cnTheme: CnTheme(
      style: CnStyle.classic,
      baseColor: Color(0xFFF7F4EF),
      themeColor: Color(0xFF1D4ED8),
      fontFamily:
          '', // Use default font for testing to avoid Google Fonts HTTP requests
      radius: 12,
    ),
    brightness: Brightness.light,
  );

  // Theme 2: White on black with pink primary + max border radius
  static const darkPink = ThemeVariantConfig(
    name: 'Dark Pink',
    cnTheme: CnTheme(
      style: CnStyle.classic,
      baseColor: Color(0xFF000000),
      themeColor: Color(0xFFEC4899), // Pink
      fontFamily: '', // Use default font for testing
      radius: 99,
    ),
    brightness: Brightness.dark,
  );

  // Theme 3: Black on white with purple primary + no border radius
  static const lightPurple = ThemeVariantConfig(
    name: 'Light Purple',
    cnTheme: CnTheme(
      style: CnStyle.classic,
      baseColor: Color(0xFFFFFFFF),
      themeColor: Color(0xFF9333EA), // Purple
      fontFamily: '', // Use default font for testing
      radius: 0,
    ),
    brightness: Brightness.light,
  );

  static const all = [classic, darkPink, lightPurple];
}

/// Wraps a widget with a specific theme variant for golden testing
Widget _wrapWithTheme(Widget child, ThemeVariantConfig config) {
  final themeData = config.cnTheme.toThemeData(brightness: config.brightness);

  return Theme(
    data: themeData,
    child: Builder(
      builder: (context) => Material(
        color: themeData.colorScheme.surface,
        child: Padding(
          padding: .all(20),
          child: Center(child: child),
        ),
      ),
    ),
  );
}

/// Creates a 3-column layout showing a widget in all theme variants
Widget createGoldenTestWidget(Widget child) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Directionality(
      textDirection: TextDirection.ltr,
      child: Row(
        children: [
          for (final variant in GoldenThemeVariants.all)
            Expanded(child: _wrapWithTheme(child, variant)),
        ],
      ),
    ),
  );
}

/// Pumps a golden test widget with proper text rendering configuration
Future<void> pumpGoldenTest(
  WidgetTester tester,
  Widget child, {
  double? width,
  double? height,
}) async {
  await tester.binding.setSurfaceSize(Size(width ?? 1280, height ?? 1080));
  await tester.pumpWidget(createGoldenTestWidget(child));
}

/// Standard golden test comparison with proper configuration
Future<void> expectGoldenMatches(WidgetTester tester, String goldenPath) async {
  await expectLater(find.byType(MaterialApp), matchesGoldenFile(goldenPath));
}

/// Complete golden test helper that pumps widget and compares to golden
Future<void> goldenTest(
  WidgetTester tester,
  Widget child,
  String goldenPath, {
  double? width,
  double? height,
  Duration? pumpDuration,
}) async {
  await pumpGoldenTest(tester, child, width: width, height: height);

  // Allow animations to settle if duration provided
  if (pumpDuration != null) {
    await tester.pump(pumpDuration);
  }

  // Ensure all frames are rendered
  await tester.pumpAndSettle();

  await expectGoldenMatches(tester, goldenPath);
}

/// Creates a wrapper with specific dimensions for testing
Widget withDimensions(Widget child, {double? width, double? height}) {
  return SizedBox(width: width, height: height, child: child);
}

/// Creates a column layout for multiple widgets in the same golden
Widget goldenColumn({required List<Widget> children, double spacing = 24}) {
  return Padding(
    padding: .all(spacing),
    child: Column(
      spacing: spacing,
      mainAxisSize: .min,
      crossAxisAlignment: .start,
      children: children,
    ),
  );
}

/// Creates a row layout for multiple widgets in the same golden
Widget goldenRow({required List<Widget> children, double spacing = 24}) {
  return Padding(
    padding: .all(spacing),
    child: Row(
      spacing: spacing,
      mainAxisSize: .min,
      crossAxisAlignment: .start,
      children: children,
    ),
  );
}
