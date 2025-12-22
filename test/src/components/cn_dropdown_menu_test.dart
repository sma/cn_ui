import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cn_ui/src/components/cn_dropdown_menu.dart';
import 'package:cn_ui/src/components/cn_button.dart';

import '../../helpers/golden_test_helper.dart';

void main() {
  // XXX: Consider using 'child' instead of 'trigger' for consistency with other components
  testWidgets('CnDropdownMenu - default', (tester) async {
    await goldenTest(
      tester,
      CnDropdownMenu(
        entries: [
          CnDropdownMenuAction(label: 'Item 1', onSelected: () {}),
          CnDropdownMenuAction(label: 'Item 2', onSelected: () {}),
          CnDropdownMenuAction(label: 'Item 3', onSelected: () {}),
        ],
        trigger: CnButton(onPressed: () {}, child: const Text('Menu')),
      ),
      'goldens/dropdown_menu/default.png',
      height: 150,
    );
  });
}
