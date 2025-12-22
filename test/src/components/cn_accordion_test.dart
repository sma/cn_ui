import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cn_ui/src/components/cn_accordion.dart';

import '../../helpers/golden_test_helper.dart';

void main() {
  testWidgets('CnAccordion - collapsed', (tester) async {
    await goldenTest(
      tester,
      const SizedBox(
        width: 400,
        child: CnAccordion(
          items: [
            CnAccordionItem(
              title: Text('Section 1'),
              content: Text('Content 1'),
            ),
            CnAccordionItem(
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
        child: CnAccordion(
          initialOpenIndices: {0},
          items: [
            CnAccordionItem(
              title: Text('Section 1'),
              content: Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Text('Expanded content for section 1'),
              ),
            ),
            CnAccordionItem(
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
