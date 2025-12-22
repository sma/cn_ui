import 'package:flutter_test/flutter_test.dart';
import 'package:cn_ui/src/components/cn_command.dart';

import '../../helpers/golden_test_helper.dart';

void main() {
  testWidgets('CnCommand - default', (tester) async {
    await goldenTest(
      tester,
      CnCommand(
        groups: [
          CnCommandGroup(
            label: 'Commands',
            items: [
              CnCommandItem(label: 'Command 1', onSelected: () {}),
              CnCommandItem(label: 'Command 2', onSelected: () {}),
              CnCommandItem(label: 'Command 3', onSelected: () {}),
            ],
          ),
        ],
      ),
      'goldens/command/default.png',
      height: 500,
    );
  });
}
