import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cn_ui/src/components/cn_slider.dart';

import '../../helpers/golden_test_helper.dart';

void main() {
  testWidgets('CnSlider - default', (tester) async {
    await goldenTest(
      tester,
      SizedBox(width: 300, child: CnSlider(value: 0.5, onChanged: (_) {})),
      'goldens/slider/default.png',
      height: 150,
    );
  });
}
