import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cn_ui/src/components/cn_sheet.dart';

import '../../helpers/golden_test_helper.dart';

void main() {
  // XXX: Consider adding a 'child' parameter as a shorthand for 'content' for consistency with other components
  testWidgets('CnSheet - default', (tester) async {
    await goldenTest(
      tester,
      const SizedBox(
        width: 400,
        child: CnSheet(
          content: Padding(
            padding: EdgeInsets.all(24),
            child: Text('Sheet content'),
          ),
        ),
      ),
      'goldens/sheet/default.png',
      height: 300,
    );
  });
}
