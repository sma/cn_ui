import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cn_ui/src/components/cn_drawer.dart';

import '../../helpers/golden_test_helper.dart';

void main() {
  testWidgets('CnDrawer - default', (tester) async {
    await goldenTest(
      tester,
      const SizedBox(
        width: 300,
        child: CnDrawer(
          content: Padding(
            padding: EdgeInsets.all(24),
            child: Text('Drawer content'),
          ),
        ),
      ),
      'goldens/drawer/default.png',
      height: 400,
    );
  });
}
