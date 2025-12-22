import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cn_ui/src/components/cn_button_group.dart';
import 'package:cn_ui/src/components/cn_button.dart';

import '../../helpers/golden_test_helper.dart';

void main() {
  testWidgets('CnButtonGroup - default', (tester) async {
    await goldenTest(
      tester,
      goldenColumn(
        children: [
          for (int i = 0; i <= 4; i++)
            CnButtonGroup(
              children: [
                for (int j = 0; j < i; j++)
                  CnButton(onPressed: () {}, child: Text('Btn ${j + 1}')),
              ],
            ),
        ],
      ),
      'goldens/button_group/default.png',
      width: 1600,
      height: 700,
    );
  });
}
