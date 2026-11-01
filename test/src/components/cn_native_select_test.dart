import 'package:cn_ui/src/components/cn_native_select.dart';
import 'package:cn_ui/src/components/cn_select.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../../helpers/golden_test_helper.dart';

void main() {
  testWidgets('CnNativeSelect - default', (tester) async {
    await goldenTest(
      tester,
      SizedBox(
        width: 300,
        child: CnNativeSelect<String>(
          value: 'option1',
          items: const [
            CnSelectItem(value: 'option1', child: Text('Option 1')),
            CnSelectItem(value: 'option2', child: Text('Option 2')),
            CnSelectItem(value: 'option3', child: Text('Option 3')),
          ],
          onChanged: (_) {},
        ),
      ),
      'goldens/native_select/default.png',
      height: 150,
    );
  });
}
