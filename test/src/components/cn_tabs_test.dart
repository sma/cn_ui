import 'package:cn_ui/src/components/cn_tabs.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../../helpers/golden_test_helper.dart';

void main() {
  testWidgets('CnTabs - default', (tester) async {
    await goldenTest(
      tester,
      const SizedBox(
        width: 400,
        child: CnTabs<int>(
          value: 0,
          tabs: [
            CnTab<int>(
              value: 0,
              label: Text('Tab 1'),
              content: Padding(
                padding: EdgeInsets.all(16),
                child: Text('Content 1'),
              ),
            ),
            CnTab<int>(
              value: 1,
              label: Text('Tab 2'),
              content: Padding(
                padding: EdgeInsets.all(16),
                child: Text('Content 2'),
              ),
            ),
            CnTab<int>(
              value: 2,
              label: Text('Tab 3'),
              content: Padding(
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
