import 'package:cn_ui/src/components/cn_avatar.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../../helpers/golden_test_helper.dart';

void main() {
  testWidgets('CnAvatar - sizes', (tester) async {
    await goldenTest(
      tester,
      goldenRow(
        children: const [
          CnAvatar(size: .md, child: Text('SM')),
          CnAvatar(size: .lg, child: Text('MD')),
          CnAvatar(size: .lg, child: Text('LG')),
        ],
        spacing: 16,
      ),
      'goldens/avatar/sizes.png',
      height: 150,
    );
  });
}
