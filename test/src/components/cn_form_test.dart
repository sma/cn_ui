import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cn_ui/src/components/cn_form.dart';
import 'package:cn_ui/src/components/cn_field.dart';
import 'package:cn_ui/src/components/cn_input.dart';

import '../../helpers/golden_test_helper.dart';

void main() {
  testWidgets('CnForm - default', (tester) async {
    await goldenTest(
      tester,
      SizedBox(
        width: 300,
        child: CnForm(
          child: Column(
            children: const [
              CnField(
                label: Text('Name'),
                child: CnInput(placeholder: 'Enter name'),
              ),
              SizedBox(height: 16),
              CnField(
                label: Text('Email'),
                child: CnInput(placeholder: 'Enter email'),
              ),
            ],
          ),
        ),
      ),
      'goldens/form/default.png',
      height: 350,
    );
  });
}
