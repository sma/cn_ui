import 'package:cn_ui/cn_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

Widget _app(Widget child) {
  return MaterialApp(
    theme: const CnTheme(font: '').toThemeData(),
    home: Scaffold(body: Center(child: child)),
  );
}

void main() {
  testWidgets('CnPopover opens on tap and closes on a tap outside', (
    tester,
  ) async {
    await tester.pumpWidget(
      _app(const CnPopover(trigger: Text('Trigger'), content: Text('Content'))),
    );
    expect(find.text('Content'), findsNothing);

    await tester.tap(find.text('Trigger'));
    await tester.pump();
    expect(find.text('Content'), findsOneWidget);

    await tester.tapAt(.zero);
    await tester.pump();
    expect(find.text('Content'), findsNothing);
  });

  testWidgets('CnPopover sits on the requested side of its trigger', (
    tester,
  ) async {
    await tester.pumpWidget(
      _app(
        const CnPopover(
          trigger: Text('Trigger'),
          content: Text('Content'),
          side: .top,
        ),
      ),
    );
    await tester.tap(find.text('Trigger'));
    await tester.pump();

    final trigger = tester.getRect(find.text('Trigger'));
    final content = tester.getRect(find.text('Content'));
    expect(content.bottom, lessThan(trigger.top));
  });

  testWidgets('showCnSheet slides in and closes with Navigator.pop', (
    tester,
  ) async {
    await tester.pumpWidget(
      _app(
        Builder(
          builder: (context) => CnButton(
            onPressed: () => showCnSheet<void>(
              context: context,
              builder: (context) => CnSheet(
                title: const Text('Sheet'),
                actions: [
                  CnButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Done'),
                  ),
                ],
              ),
            ),
            child: const Text('Open'),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();
    expect(find.text('Sheet'), findsOneWidget);

    await tester.tap(find.text('Done'));
    await tester.pumpAndSettle();
    expect(find.text('Sheet'), findsNothing);
  });

  testWidgets('A CnDrawer closes when it is swiped away', (tester) async {
    await tester.pumpWidget(
      _app(
        Builder(
          builder: (context) => CnButton(
            onPressed: () => showCnDrawer<void>(
              context: context,
              builder: (context) => const CnDrawer(title: Text('Drawer')),
            ),
            child: const Text('Open'),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();
    expect(find.text('Drawer'), findsOneWidget);

    await tester.fling(find.text('Drawer'), const Offset(0, 300), 1000);
    await tester.pumpAndSettle();
    expect(find.text('Drawer'), findsNothing);
  });

  testWidgets('CnButtonGroup tells its children their position', (
    tester,
  ) async {
    final positions = <CnButtonGroupPosition?>[];
    Widget probe() => Builder(
      builder: (context) {
        positions.add(CnButtonGroup.of(context));
        return const SizedBox(width: 10, height: 10);
      },
    );

    await tester.pumpWidget(
      _app(CnButtonGroup(children: [probe(), probe(), probe()])),
    );

    expect(positions.map((p) => p?.isFirst), [true, false, false]);
    expect(positions.map((p) => p?.isLast), [false, false, true]);
  });

  testWidgets('CnForm validates a CnInput', (tester) async {
    final formKey = GlobalKey<FormState>();
    await tester.pumpWidget(
      _app(
        CnForm(
          formKey: formKey,
          child: CnInput(
            validator: (value) => value!.isEmpty ? 'Required' : null,
          ),
        ),
      ),
    );

    expect(formKey.currentState!.validate(), isFalse);
    await tester.pump();
    expect(find.text('Required'), findsOneWidget);

    await tester.enterText(find.byType(EditableText), 'Ada');
    expect(formKey.currentState!.validate(), isTrue);
  });

  testWidgets('A CnField with an error marks its input', (tester) async {
    await tester.pumpWidget(
      _app(const CnField(errorText: 'Taken', child: CnInput())),
    );

    expect(find.text('Taken'), findsOneWidget);
    final decorator = tester.widget<InputDecorator>(
      find.byType(InputDecorator),
    );
    expect(decorator.decoration.errorText, isNotNull);
  });
}
