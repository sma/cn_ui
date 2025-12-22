import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cn_ui/src/components/cn_radio.dart';

import '../../helpers/golden_test_helper.dart';

void main() {
  testWidgets('CnRadio - states', (tester) async {
    await goldenTest(
      tester,
      goldenColumn(
        children: [
          CnRadioGroup<int>(
            groupValue: 1,
            onChanged: (_) {},
            child: const Column(
              children: [
                CnRadio(value: 1, enabled: true),
                CnRadio(value: 2, enabled: true),
              ],
            ),
          ),
          CnRadioGroup<int>(
            groupValue: null,
            onChanged: (_) {},
            child: const Column(
              children: [
                CnRadio(value: 1, enabled: false),
                CnRadio(value: 2, enabled: false),
              ],
            ),
          ),
        ],
        spacing: 16,
      ),
      'goldens/radio/states.png',
      height: 300,
    );
  });
}
