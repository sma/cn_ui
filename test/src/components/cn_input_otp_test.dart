import 'package:flutter_test/flutter_test.dart';
import 'package:cn_ui/src/components/cn_input_otp.dart';

import '../../helpers/golden_test_helper.dart';

void main() {
  testWidgets('CnInputOtp - default', (tester) async {
    await goldenTest(
      tester,
      CnInputOtp(length: 6, onChanged: (_) {}),
      'goldens/input_otp/default.png',
      height: 150,
    );
  });
}
