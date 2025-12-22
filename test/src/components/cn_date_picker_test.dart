import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cn_ui/src/components/cn_date_picker.dart';

import '../../helpers/golden_test_helper.dart';

void main() {
  testWidgets('CnDatePickerField - default', (tester) async {
    await goldenTest(
      tester,
      SizedBox(
        width: 300,
        child: CnDatePickerField(
          value: DateTime(2024, 1, 15),
          onChanged: (_) {},
        ),
      ),
      'goldens/date_picker/default.png',
      height: 150,
    );
  });
}
