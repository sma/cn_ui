import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cn_ui/src/components/cn_select.dart';

import '../../helpers/golden_test_helper.dart';

void main() {
  testWidgets('CnSelect - default', (tester) async {
    await goldenTest(
      tester,
      SizedBox(
        width: 300,
        child: CnSelect<String>(
          value: 'option1',
          items: const [
            DropdownMenuItem(value: 'option1', child: Text('Option 1')),
            DropdownMenuItem(value: 'option2', child: Text('Option 2')),
            DropdownMenuItem(value: 'option3', child: Text('Option 3')),
          ],
          onChanged: (_) {},
        ),
      ),
      'goldens/select/default.png',
      height: 150,
    );
  });
}
