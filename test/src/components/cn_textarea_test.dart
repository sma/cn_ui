import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cn_ui/src/components/cn_textarea.dart';

import '../../helpers/golden_test_helper.dart';

void main() {
  testWidgets('CnTextarea - states', (tester) async {
    await goldenTest(
      tester,
      goldenColumn(
        children: const [
          SizedBox(width: 300, child: CnTextarea(placeholder: 'Enter text...')),
          SizedBox(
            width: 300,
            child: CnTextarea(placeholder: 'Disabled', enabled: false),
          ),
        ],
        spacing: 16,
      ),
      'goldens/textarea/states.png',
      height: 350,
    );
  });
}
