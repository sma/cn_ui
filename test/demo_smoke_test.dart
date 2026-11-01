import 'package:cn_ui/demo/component_catalog.dart';
import 'package:cn_ui/demo/component_page.dart';
import 'package:cn_ui/demo/dashboard_page.dart';
import 'package:cn_ui/src/theme/cn_theme.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

/// Renders every example of the catalog, which catches layout errors.
void main() {
  testWidgets('Dashboard', (tester) async {
    // Wide, because the test font is much wider than a real one.
    await tester.binding.setSurfaceSize(const Size(1800, 2000));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      MaterialApp(
        theme: const CnTheme(font: '').toThemeData(),
        home: const Scaffold(body: DashboardPage()),
      ),
    );
    await tester.pump(const Duration(milliseconds: 500));
  });

  for (final colors in [CnColors.light, CnColors.dark]) {
    for (final entry in componentCatalog) {
      testWidgets('${entry.name} in ${colors.brightness.name} mode', (
        tester,
      ) async {
        await tester.binding.setSurfaceSize(const Size(1280, 4000));
        addTearDown(() => tester.binding.setSurfaceSize(null));
        await tester.pumpWidget(
          MaterialApp(
            theme: CnTheme(colors: colors, font: '').toThemeData(),
            home: Scaffold(body: ComponentPage(entry: entry)),
          ),
        );
        await tester.pump(const Duration(milliseconds: 500));
      });
    }
  }
}
