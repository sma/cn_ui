import 'package:flutter_test/flutter_test.dart';
import 'package:cn_ui/src/components/cn_avatar.dart';
import 'package:cn_ui/src/components/cn_avatar_group.dart';

import '../../helpers/golden_test_helper.dart';

void main() {
  testWidgets('CnAvatarGroup - default', (tester) async {
    await goldenTest(
      tester,
      const CnAvatarGroup(
        children: [
          CnAvatar(initials: 'A'),
          CnAvatar(initials: 'B'),
          CnAvatar(initials: 'C'),
        ],
      ),
      'goldens/avatar_group/default.png',
      height: 150,
    );
  });
}
