import 'package:flutter_test/flutter_test.dart';
import 'package:cn_ui/src/components/cn_switch.dart';

import '../../helpers/golden_test_helper.dart';

void main() {
  testWidgets('CnSwitch - states', (tester) async {
    await goldenTest(
      tester,
      goldenColumn(
        children: [
          CnSwitch(value: false, onChanged: (_) {}),
          CnSwitch(value: true, onChanged: (_) {}),
          const CnSwitch(value: false),
          const CnSwitch(value: true),
        ],
      ),
      'goldens/switch/states.png',
      height: 400,
    );
  });
}
