import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cn_ui/src/components/cn_native_select.dart';

import '../../helpers/golden_test_helper.dart';

void main() {
  testWidgets('CnNativeSelect - default', (tester) async {
    await goldenTest(
      tester,
      SizedBox(
        width: 300,
        child: CnNativeSelect<String>(
          value: 'option1',
          entries: const [
            CnNativeSelectOption(value: 'option1', label: 'Option 1'),
            CnNativeSelectOption(value: 'option2', label: 'Option 2'),
            CnNativeSelectOption(value: 'option3', label: 'Option 3'),
          ],
          onChanged: (_) {},
        ),
      ),
      'goldens/native_select/default.png',
      height: 150,
    );
  });
}
