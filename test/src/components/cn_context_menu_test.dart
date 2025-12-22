import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cn_ui/src/components/cn_context_menu.dart';
import 'package:cn_ui/src/components/cn_dropdown_menu.dart';
import 'package:cn_ui/src/components/cn_button.dart';

import '../../helpers/golden_test_helper.dart';

void main() {
  testWidgets('CnContextMenu - default', (tester) async {
    await goldenTest(
      tester,
      CnContextMenu(
        entries: [
          CnDropdownMenuAction(label: 'Copy', onSelected: () {}),
          CnDropdownMenuAction(label: 'Paste', onSelected: () {}),
          CnDropdownMenuAction(label: 'Delete', onSelected: () {}),
        ],
        child: CnButton(onPressed: () {}, child: const Text('Right click')),
      ),
      'goldens/context_menu/default.png',
      height: 150,
    );
  });
}
