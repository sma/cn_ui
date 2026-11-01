import 'package:cn_ui/cn_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  test('CnBreakpoint classifies widths', () {
    expect(CnBreakpoint.of(575), CnBreakpoint.small);
    expect(CnBreakpoint.of(576), CnBreakpoint.medium);
    expect(CnBreakpoint.of(1023), CnBreakpoint.medium);
    expect(CnBreakpoint.of(1024), CnBreakpoint.large);
    expect(CnBreakpoint.of(double.infinity), CnBreakpoint.large);
  });

  Future<void> pumpAt(WidgetTester tester, double width, Widget child) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: const CnTheme(font: '').toThemeData(),
        home: Scaffold(
          body: Align(
            alignment: Alignment.topLeft,
            child: SizedBox(width: width, child: child),
          ),
        ),
      ),
    );
  }

  testWidgets('CnResponsive falls back to the next smaller builder', (
    tester,
  ) async {
    final responsive = CnResponsive(
      small: (context, child) => const Text('small'),
      medium: (context, child) => child!,
      child: const Text('medium'),
    );

    await pumpAt(tester, 400, responsive);
    expect(find.text('small'), findsOneWidget);

    await pumpAt(tester, 700, responsive);
    expect(find.text('medium'), findsOneWidget);

    await pumpAt(tester, 780, responsive);
    expect(find.text('medium'), findsOneWidget);
  });

  testWidgets('CnDataTable fills the available width', (tester) async {
    await tester.binding.setSurfaceSize(const Size(1000, 600));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await pumpAt(
      tester,
      900,
      CnDataTable<String>(
        rows: const ['a', 'b'],
        columns: [
          CnDataTableColumn(
            id: 'name',
            label: const Text('Name'),
            cellBuilder: (context, row) => Text(row),
          ),
        ],
      ),
    );

    expect(tester.getSize(find.byType(Table)).width, closeTo(898, 2));
  });

  testWidgets('A wide CnDataTable scrolls instead of shrinking', (
    tester,
  ) async {
    await pumpAt(
      tester,
      300,
      CnDataTable<String>(
        rows: const ['a'],
        minTableWidth: 600,
        columns: [
          CnDataTableColumn(
            id: 'name',
            label: const Text('Name'),
            cellBuilder: (context, row) => Text(row),
          ),
        ],
      ),
    );

    expect(tester.getSize(find.byType(Table)).width, closeTo(598, 2));
    expect(tester.takeException(), isNull);
  });
}
