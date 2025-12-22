import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cn_ui/src/components/cn_item.dart';

import '../../helpers/golden_test_helper.dart';

void main() {
  testWidgets('CnItem - default', (tester) async {
    await goldenTest(
      tester,
      CnItem(onTap: () {}, child: const Text('Item')),
      'goldens/item/default.png',
      height: 100,
    );
  });
}
