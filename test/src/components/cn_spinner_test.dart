import 'package:flutter_test/flutter_test.dart';
import 'package:cn_ui/src/components/cn_spinner.dart';

import '../../helpers/golden_test_helper.dart';

void main() {
  // XXX: Consider adding an 'animate' parameter to allow disabling animation for testing
  testWidgets('CnSpinner - default', (tester) async {
    // Using pumpGoldenTest instead of goldenTest to handle infinite animation
    await pumpGoldenTest(tester, const CnSpinner(), height: 150);
    await tester.pump(const Duration(milliseconds: 100));
    await expectGoldenMatches(tester, 'goldens/spinner/default.png');
  });
}
