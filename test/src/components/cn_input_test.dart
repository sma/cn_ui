import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cn_ui/src/components/cn_input.dart';

import '../../helpers/golden_test_helper.dart';

void main() {
  testWidgets('CnInput - states', (tester) async {
    await goldenTest(
      tester,
      goldenColumn(
        children: const [
          SizedBox(width: 300, child: CnInput(placeholder: 'Enter text...')),
          SizedBox(
            width: 300,
            child: CnInput(placeholder: 'Disabled', enabled: false),
          ),
        ],
        spacing: 16,
      ),
      'goldens/input/states.png',
      height: 250,
    );
  });
}
