import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cn_ui/src/components/cn_field.dart';
import 'package:cn_ui/src/components/cn_input.dart';

import '../../helpers/golden_test_helper.dart';

void main() {
  testWidgets('CnField - with label and description', (tester) async {
    await goldenTest(
      tester,
      const SizedBox(
        width: 300,
        child: CnField(
          label: Text('Email'),
          description: Text('Enter your email address'),
          child: CnInput(placeholder: 'email@example.com'),
        ),
      ),
      'goldens/field/with_label.png',
      height: 250,
    );
  });
}
