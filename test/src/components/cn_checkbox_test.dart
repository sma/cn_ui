import 'package:flutter_test/flutter_test.dart';
import 'package:cn_ui/src/components/cn_checkbox.dart';

import '../../helpers/golden_test_helper.dart';

void main() {
  testWidgets('CnCheckbox - states', (tester) async {
    await goldenTest(
      tester,
      goldenColumn(
        children: [
          CnCheckbox(value: false, onChanged: (_) {}),
          CnCheckbox(value: true, onChanged: (_) {}),
          const CnCheckbox(value: false),
          const CnCheckbox(value: true),
        ],
      ),
      'goldens/checkbox/states.png',
      height: 400,
    );
  });
}
