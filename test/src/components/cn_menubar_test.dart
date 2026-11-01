import 'package:cn_ui/src/components/cn_menu_entry.dart';
import 'package:cn_ui/src/components/cn_menubar.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../../helpers/golden_test_helper.dart';

void main() {
  testWidgets('CnMenubar - default', (tester) async {
    await goldenTest(
      tester,
      CnMenubar(
        menus: [
          CnMenu(
            label: Text('File'),
            entries: [
              CnMenuAction(label: Text('New'), onSelected: () {}),
              CnMenuAction(label: Text('Open'), onSelected: () {}),
            ],
          ),
          CnMenu(
            label: Text('Edit'),
            entries: [
              CnMenuAction(label: Text('Cut'), onSelected: () {}),
              CnMenuAction(label: Text('Copy'), onSelected: () {}),
            ],
          ),
        ],
      ),
      'goldens/menubar/default.png',
      height: 150,
    );
  });
}
