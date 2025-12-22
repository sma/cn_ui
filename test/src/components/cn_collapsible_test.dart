import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cn_ui/src/components/cn_collapsible.dart';

import '../../helpers/golden_test_helper.dart';

void main() {
  testWidgets('CnCollapsible - expanded', (tester) async {
    await goldenTest(
      tester,
      CnCollapsible(
        initiallyExpanded: false,
        title: Text('Collapsible Title'),
        child: Text('Collapsible content'),
      ),
      'goldens/collapsible/expanded.png',
      height: 200,
    );
  });
}
