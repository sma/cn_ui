import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cn_ui/src/components/cn_scroll_area.dart';

import '../../helpers/golden_test_helper.dart';

void main() {
  testWidgets('CnScrollArea - default', (tester) async {
    await goldenTest(
      tester,
      SizedBox(
        width: 300,
        height: 200,
        child: CnScrollArea(
          child: Column(
            children: List.generate(
              10,
              (i) => Padding(
                padding: const EdgeInsets.all(8),
                child: Text('Item $i'),
              ),
            ),
          ),
        ),
      ),
      'goldens/scroll_area/default.png',
      height: 300,
    );
  });
}
