import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cn_ui/src/components/cn_popover.dart';
import 'package:cn_ui/src/components/cn_button.dart';

import '../../helpers/golden_test_helper.dart';

void main() {
  testWidgets('CnPopover - default', (tester) async {
    await goldenTest(
      tester,
      CnPopover(
        content: const Text('Popover content'),
        // XXX: 'trigger' could be renamed to 'child' for consistency with other components
        trigger: CnButton(onPressed: () {}, child: const Text('Click me')),
      ),
      'goldens/popover/default.png',
      height: 150,
    );
  });
}
