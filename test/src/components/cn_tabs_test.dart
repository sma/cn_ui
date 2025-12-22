import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cn_ui/src/components/cn_tabs.dart';

import '../../helpers/golden_test_helper.dart';

void main() {
  testWidgets('CnTabs - default', (tester) async {
    await goldenTest(
      tester,
      const SizedBox(
        width: 400,
        child: CnTabs(
          tabs: [
            CnTab(
              label: 'Tab 1',
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text('Content 1'),
              ),
            ),
            CnTab(
              label: 'Tab 2',
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text('Content 2'),
              ),
            ),
            CnTab(
              label: 'Tab 3',
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text('Content 3'),
              ),
            ),
          ],
        ),
      ),
      'goldens/tabs/default.png',
      height: 300,
    );
  });
}
