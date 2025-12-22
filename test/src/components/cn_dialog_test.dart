import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cn_ui/src/components/cn_dialog.dart';
import 'package:cn_ui/src/components/cn_button.dart';

import '../../helpers/golden_test_helper.dart';

void main() {
  testWidgets('CnDialog - basic', (tester) async {
    await goldenTest(
      tester,
      CnDialog(
        title: const Text('Confirm Action'),
        description: const Text('Are you sure you want to proceed?'),
        actions: [
          CnButton(
            variant: CnButtonVariant.outline,
            onPressed: () {},
            child: const Text('Cancel'),
          ),
          CnButton(onPressed: () {}, child: const Text('Confirm')),
        ],
      ),
      'goldens/dialog/basic.png',
      height: 400,
    );
  });
}
