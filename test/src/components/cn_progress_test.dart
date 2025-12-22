import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cn_ui/src/components/cn_progress.dart';

import '../../helpers/golden_test_helper.dart';

void main() {
  testWidgets('CnProgress - values', (tester) async {
    await goldenTest(
      tester,
      goldenColumn(
        children: const [
          SizedBox(width: 300, child: CnProgress(value: 0.0)),
          SizedBox(width: 300, child: CnProgress(value: 0.5)),
          SizedBox(width: 300, child: CnProgress(value: 1.0)),
        ],
        spacing: 16,
      ),
      'goldens/progress/values.png',
      height: 250,
    );
  });
}
