import 'package:flutter_test/flutter_test.dart';

import '../../helpers/golden_test_helper.dart';
import '../../helpers/test_component_states.dart';

void main() {
  testWidgets('CnAlert - all variants', (tester) async {
    await goldenTest(
      tester,
      goldenColumn(children: ComponentStateGenerator.allAlertVariants()),
      'goldens/alert/variants.png',
    );
  });
}
