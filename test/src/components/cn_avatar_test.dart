import 'package:flutter_test/flutter_test.dart';
import 'package:cn_ui/src/components/cn_avatar.dart';

import '../../helpers/golden_test_helper.dart';

void main() {
  testWidgets('CnAvatar - sizes', (tester) async {
    await goldenTest(
      tester,
      goldenRow(
        children: const [
          CnAvatar(size: 32, initials: 'SM'),
          CnAvatar(size: 40, initials: 'MD'),
          CnAvatar(size: 56, initials: 'LG'),
        ],
        spacing: 16,
      ),
      'goldens/avatar/sizes.png',
      height: 150,
    );
  });
}
