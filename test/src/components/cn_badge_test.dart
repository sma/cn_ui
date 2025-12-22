import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cn_ui/src/components/cn_badge.dart';

import '../../helpers/golden_test_helper.dart';
import '../../helpers/test_component_states.dart';

void main() {
  testWidgets('CnBadge - all variants', (tester) async {
    await goldenTest(
      tester,
      goldenColumn(
        children: ComponentStateGenerator.allBadgeVariants(),
        spacing: 16,
      ),
      'goldens/badge/variants.png',
      height: 300,
    );
  });

  testWidgets('CnBadge - with different text lengths', (tester) async {
    await goldenTest(
      tester,
      goldenColumn(
        children: const [
          CnBadge(child: Text('New')),
          CnBadge(variant: CnBadgeVariant.secondary, child: Text('99+')),
          CnBadge(
            variant: CnBadgeVariant.outline,
            child: Text('Long Badge Text'),
          ),
        ],
        spacing: 16,
      ),
      'goldens/badge/text_lengths.png',
      height: 250,
    );
  });
}
