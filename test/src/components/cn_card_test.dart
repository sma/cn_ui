import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cn_ui/src/components/cn_card.dart';

import '../../helpers/golden_test_helper.dart';

void main() {
  testWidgets('CnCard - basic', (tester) async {
    await goldenTest(
      tester,
      const SizedBox(
        width: 300,
        child: CnCard(child: Text('Simple card content')),
      ),
      'goldens/card/basic.png',
      height: 150,
    );
  });

  testWidgets('CnCard - with header and content', (tester) async {
    await goldenTest(
      tester,
      const SizedBox(
        width: 300,
        child: CnCard(
          header: Text(
            'Card Header',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          content: Text('This is the card content area.'),
        ),
      ),
      'goldens/card/with_header.png',
      height: 200,
    );
  });

  testWidgets('CnCard - with header, content, and footer', (tester) async {
    await goldenTest(
      tester,
      SizedBox(
        width: 300,
        child: CnCard(
          header: const Text(
            'Complete Card',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          content: const Text('Card content with all sections.'),
          footer: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(onPressed: () {}, child: const Text('Action')),
            ],
          ),
        ),
      ),
      'goldens/card/complete.png',
      height: 250,
    );
  });
}
