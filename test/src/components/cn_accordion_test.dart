import 'package:cn_ui/src/components/cn_accordion.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../../helpers/golden_test_helper.dart';

void main() {
  testWidgets('CnAccordion - collapsed', (tester) async {
    await goldenTest(
      tester,
      const SizedBox(
        width: 400,
        child: CnAccordion<int>(
          value: {},
          items: [
            CnAccordionItem<int>(
              value: 0,
              title: Text('Section 1'),
              content: Text('Content 1'),
            ),
            CnAccordionItem<int>(
              value: 1,
              title: Text('Section 2'),
              content: Text('Content 2'),
            ),
          ],
        ),
      ),
      'goldens/accordion/collapsed.png',
      height: 250,
    );
  });

  testWidgets('CnAccordion - expanded', (tester) async {
    await goldenTest(
      tester,
      const SizedBox(
        width: 400,
        child: CnAccordion<int>(
          value: {0},
          items: [
            CnAccordionItem<int>(
              value: 2,
              title: Text('Section 1'),
              content: Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Text('Expanded content for section 1'),
              ),
            ),
            CnAccordionItem<int>(
              value: 3,
              title: Text('Section 2'),
              content: Text('Content 2'),
            ),
          ],
        ),
      ),
      'goldens/accordion/expanded.png',
      height: 300,
    );
  });
}
