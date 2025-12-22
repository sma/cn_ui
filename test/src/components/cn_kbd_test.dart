import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cn_ui/src/components/cn_kbd.dart';

import '../../helpers/golden_test_helper.dart';

void main() {
  testWidgets('CnKbd - default', (tester) async {
    await goldenTest(
      tester,
      goldenRow(
        children: const [
          CnKbd(child: Text('Ctrl')),
          CnKbd(child: Text('Shift')),
          CnKbd(child: Text('K')),
        ],
        spacing: 8,
      ),
      'goldens/kbd/default.png',
      height: 100,
    );
  });
}
