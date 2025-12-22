import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cn_ui/src/components/cn_combobox.dart';

import '../../helpers/golden_test_helper.dart';

void main() {
  testWidgets('CnCombobox - default', (tester) async {
    await goldenTest(
      tester,
      SizedBox(
        width: 300,
        child: CnCombobox<String>(
          value: 'option1',
          items: const [
            CnComboboxItem(value: 'option1', label: 'Option 1'),
            CnComboboxItem(value: 'option2', label: 'Option 2'),
            CnComboboxItem(value: 'option3', label: 'Option 3'),
          ],
          onChanged: (_) {},
        ),
      ),
      'goldens/combobox/default.png',
      height: 150,
    );
  });
}
