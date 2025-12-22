import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cn_ui/src/components/cn_aspect_ratio.dart';

import '../../helpers/golden_test_helper.dart';

void main() {
  testWidgets('CnAspectRatio - 16:9', (tester) async {
    await goldenTest(
      tester,
      const SizedBox(
        width: 300,
        child: CnAspectRatio(
          aspectRatio: 16 / 9,
          child: ColoredBox(
            color: Colors.blue,
            child: Center(child: Text('16:9')),
          ),
        ),
      ),
      'goldens/aspect_ratio/16_9.png',
      height: 300,
    );
  });
}
