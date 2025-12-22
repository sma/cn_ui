import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cn_ui/src/components/cn_navigation_menu.dart';

import '../../helpers/golden_test_helper.dart';

void main() {
  testWidgets('CnNavigationMenu - default', (tester) async {
    await goldenTest(
      tester,
      SizedBox(
        width: 300,
        child: CnNavigationMenu(
          items: [
            CnNavigationMenuItem(label: 'Home', onTap: () {}),
            CnNavigationMenuItem(label: 'About', onTap: () {}),
            CnNavigationMenuItem(label: 'Contact', onTap: () {}),
          ],
        ),
      ),
      'goldens/navigation_menu/default.png',
      height: 250,
    );
  });
}
