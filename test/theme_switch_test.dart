import 'package:cn_ui/cn_ui.dart';
import 'package:cn_ui/demo/cn_demo_app.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  test('every palette combines base, theme and chart colors', () {
    for (final brightness in Brightness.values) {
      for (final base in CnBaseColor.values) {
        for (final theme in CnAccentColor.values) {
          final colors = CnColors.palette(
            base: base,
            theme: theme,
            brightness: brightness,
          );
          expect(colors.brightness, brightness);
        }
      }
    }
    final blue = CnColors.palette(theme: .blue);
    expect(blue.primary, isNot(CnColors.light.primary));
    expect(blue.background, CnColors.light.background);
    expect(blue.chart1, isNot(CnColors.light.chart1));
    expect(
      CnColors.palette(theme: .blue, chart: .base).chart1,
      CnColors.light.chart1,
    );
    expect(CnColors.palette().primary, CnColors.light.primary);
  });

  test('all fonts of the playground exist in google_fonts', () {
    const fonts = [
      'Geist',
      'Inter',
      'Noto Sans',
      'Nunito Sans',
      'Figtree',
      'Roboto',
      'Raleway',
      'DM Sans',
      'Public Sans',
      'Outfit',
      'Oxanium',
      'Manrope',
      'Space Grotesk',
      'Montserrat',
      'IBM Plex Sans',
      'Source Sans 3',
      'Instrument Sans',
      'Geist Mono',
      'JetBrains Mono',
      'Noto Serif',
      'Roboto Slab',
      'Merriweather',
      'Lora',
      'Playfair Display',
      'EB Garamond',
      'Instrument Serif',
      'Courier Prime',
      'IBM Plex Mono',
    ];
    final known = GoogleFonts.asMap();
    expect(fonts.where((font) => !known.containsKey(font)), isEmpty);

    for (final font in fonts) {
      final style = CnTheme(font: font).text.sm.semibold;
      expect(style.fontWeight, FontWeight.w600, reason: font);
      expect(style.fontFamily, startsWith(font.replaceAll(' ', '')));
    }
  });

  test('text stays readable in every step between light and dark', () {
    double luminance(Color c) => c.computeLuminance();
    for (var t = 0.0; t <= 1.0; t += 0.05) {
      final colors = CnColors.light.lerp(CnColors.dark, t);
      final contrast =
          (luminance(colors.foreground) - luminance(colors.background)).abs();
      expect(contrast, greaterThan(0.1), reason: 't=$t');
    }
  });

  testWidgets('the theme animation has no lagging text', (tester) async {
    await tester.binding.setSurfaceSize(const Size(1800, 2400));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(const CnDemoApp());
    await tester.pump();
    await tester.tap(find.text('Theme').first);
    await tester.pump(const Duration(milliseconds: 300));
    await tester.tap(find.text('Dark'));

    final title = find.text('Theme Playground');
    for (var i = 0; i < 12; i++) {
      await tester.pump(const Duration(milliseconds: 25));
      expect(tester.takeException(), isNull);
      final element = tester.element(title);
      expect(
        DefaultTextStyle.of(element).style.color,
        CnTheme.of(element).colors.foreground,
        reason: 'frame $i',
      );
    }
    expect(
      CnTheme.of(tester.element(title)).colors.brightness,
      Brightness.dark,
    );
  });
}
