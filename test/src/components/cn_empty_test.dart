import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cn_ui/src/components/cn_empty.dart';

import '../../helpers/golden_test_helper.dart';

void main() {
  testWidgets('CnEmpty - default', (tester) async {
    await goldenTest(
      tester,
      const SizedBox(
        width: 300,
        child: CnEmpty(
          title: Text('No data'),
          description: Text('There is no data to display'),
        ),
      ),
      'goldens/empty/default.png',
      height: 300,
    );
  });
}
