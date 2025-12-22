import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cn_ui/src/components/cn_hover_card.dart';
import 'package:cn_ui/src/components/cn_button.dart';

import '../../helpers/golden_test_helper.dart';

void main() {
  testWidgets('CnHoverCard - default', (tester) async {
    await goldenTest(
      tester,
      CnHoverCard(
        content: const Padding(
          padding: EdgeInsets.all(16),
          child: Text('Hover card content'),
        ),
        child: CnButton(onPressed: () {}, child: const Text('Hover me')),
      ),
      'goldens/hover_card/default.png',
      height: 150,
    );
  });
}
