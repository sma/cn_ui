import 'package:flutter_test/flutter_test.dart';
import 'package:cn_ui/src/components/cn_menubar.dart';

import '../../helpers/golden_test_helper.dart';

void main() {
  testWidgets('CnMenubar - default', (tester) async {
    await goldenTest(
      tester,
      CnMenubar(
        menus: [
          CnMenu(
            label: 'File',
            entries: [
              CnMenuAction(label: 'New', onSelected: () {}),
              CnMenuAction(label: 'Open', onSelected: () {}),
            ],
          ),
          CnMenu(
            label: 'Edit',
            entries: [
              CnMenuAction(label: 'Cut', onSelected: () {}),
              CnMenuAction(label: 'Copy', onSelected: () {}),
            ],
          ),
        ],
      ),
      'goldens/menubar/default.png',
      height: 150,
    );
  });
}
