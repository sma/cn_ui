import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cn_ui/src/components/cn_resizable.dart';

import '../../helpers/golden_test_helper.dart';

void main() {
  // XXX: Consider using 'children' parameter (List<Widget>) instead of 'primary'/'secondary' for better API consistency
  testWidgets('CnResizable - default', (tester) async {
    await goldenTest(
      tester,
      SizedBox(
        width: 600,
        height: 300,
        child: CnResizable(
          primary: Container(
            color: Colors.red,
            child: const Center(child: Text('Panel 1')),
          ),
          secondary: Container(
            color: Colors.blue,
            child: const Center(child: Text('Panel 2')),
          ),
        ),
      ),
      'goldens/resizable/default.png',
      height: 400,
    );
  });
}
