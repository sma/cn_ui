import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cn_ui/src/components/cn_button.dart';

import '../../helpers/golden_test_helper.dart';
import '../../helpers/test_component_states.dart';

void main() {
  testWidgets('CnButton - all variants enabled', (tester) async {
    await goldenTest(
      tester,
      goldenColumn(
        children: ComponentStateGenerator.allButtonVariants(),
        spacing: 12,
      ),
      'goldens/button/variants_enabled.png',
      height: 450,
    );
  });

  testWidgets('CnButton - all variants disabled', (tester) async {
    await goldenTest(
      tester,
      goldenColumn(
        children: ComponentStateGenerator.allButtonVariantsDisabled(),
        spacing: 12,
      ),
      'goldens/button/variants_disabled.png',
      height: 450,
    );
  });

  testWidgets('CnButton - all sizes', (tester) async {
    await goldenTest(
      tester,
      goldenColumn(
        children: ComponentStateGenerator.allButtonSizes(),
        spacing: 12,
      ),
      'goldens/button/sizes.png',
      height: 350,
    );
  });

  testWidgets('CnButton - with icons', (tester) async {
    await goldenTest(
      tester,
      goldenColumn(
        children: [
          CnButton(
            onPressed: () {},
            leading: const Icon(Icons.send),
            child: const Text('Send'),
          ),
          CnButton(
            onPressed: () {},
            trailing: const Icon(Icons.arrow_forward),
            child: const Text('Next'),
          ),
          CnButton(
            variant: CnButtonVariant.outline,
            onPressed: () {},
            leading: const Icon(Icons.download),
            child: const Text('Download'),
          ),
          CnButton(
            size: CnButtonSize.icon,
            onPressed: () {},
            child: const Icon(Icons.settings),
          ),
        ],
        spacing: 12,
      ),
      'goldens/button/with_icons.png',
      height: 300,
    );
  });
}
