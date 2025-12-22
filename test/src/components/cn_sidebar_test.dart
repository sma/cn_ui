import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cn_ui/src/components/cn_sidebar.dart';

import '../../helpers/golden_test_helper.dart';

void main() {
  testWidgets('CnSidebar - default', (tester) async {
    await goldenTest(
      tester,
      const SizedBox(
        width: 250,
        height: 400,
        child: CnSidebar(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Text('Sidebar content'),
          ),
        ),
      ),
      'goldens/sidebar/default.png',
      height: 500,
    );
  });
}
