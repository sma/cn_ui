import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cn_ui/src/components/cn_alert_dialog.dart';
import 'package:cn_ui/src/components/cn_button.dart';

import '../../helpers/golden_test_helper.dart';

void main() {
  testWidgets('CnAlertDialog - default', (tester) async {
    await goldenTest(
      tester,
      CnAlertDialog(
        title: const Text('Delete Item'),
        content: const Text('This action cannot be undone.'),
        actions: [
          CnButton(
            variant: CnButtonVariant.outline,
            onPressed: () {},
            child: const Text('Cancel'),
          ),
          CnButton(
            variant: CnButtonVariant.destructive,
            onPressed: () {},
            child: const Text('Delete'),
          ),
        ],
      ),
      'goldens/alert_dialog/default.png',
      height: 400,
    );
  });
}
