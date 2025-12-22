import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cn_ui/src/components/cn_label.dart';

import '../../helpers/golden_test_helper.dart';

void main() {
  testWidgets('CnLabel - default and required', (tester) async {
    await goldenTest(
      tester,
      goldenColumn(
        children: const [
          CnLabel(child: Text('Label Text')),
          CnLabel(required: true, child: Text('Required Label')),
        ],
        spacing: 16,
      ),
      'goldens/label/default.png',
      height: 150,
    );
  });
}
