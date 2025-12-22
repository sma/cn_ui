import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cn_ui/src/components/cn_input_group.dart';

import '../../helpers/golden_test_helper.dart';

void main() {
  testWidgets('CnInputGroup - default', (tester) async {
    await goldenTest(
      tester,
      SizedBox(
        width: 400,
        child: const CnInputGroup(
          children: [
            CnInputGroupInput(placeholder: 'First'),
            CnInputGroupInput(placeholder: 'Last'),
          ],
        ),
      ),
      'goldens/input_group/default.png',
      height: 150,
    );
  });
}
