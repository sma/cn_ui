import 'package:cn_ui/src/components/cn_item.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../../helpers/golden_test_helper.dart';

void main() {
  testWidgets('CnItem - default', (tester) async {
    await goldenTest(
      tester,
      CnItem(onTap: () {}, title: const Text('Item')),
      'goldens/item/default.png',
      height: 100,
    );
  });
}
