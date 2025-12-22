import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cn_ui/src/components/cn_separator.dart';

import '../../helpers/golden_test_helper.dart';

void main() {
  testWidgets('CnSeparator - horizontal', (tester) async {
    await goldenTest(
      tester,
      const SizedBox(width: 300, child: CnSeparator()),
      'goldens/separator/horizontal.png',
      height: 100,
    );
  });
}
