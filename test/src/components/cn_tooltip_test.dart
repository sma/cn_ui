import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cn_ui/src/components/cn_tooltip.dart';
import 'package:cn_ui/src/components/cn_button.dart';

import '../../helpers/golden_test_helper.dart';

void main() {
  testWidgets('CnTooltip - default', (tester) async {
    await goldenTest(
      tester,
      CnTooltip(
        message: 'This is a tooltip',
        child: CnButton(onPressed: () {}, child: const Text('Hover me')),
      ),
      'goldens/tooltip/default.png',
      height: 150,
    );
  });
}
