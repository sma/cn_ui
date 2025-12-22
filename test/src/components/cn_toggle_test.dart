import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cn_ui/src/components/cn_toggle.dart';

import '../../helpers/golden_test_helper.dart';

void main() {
  testWidgets('CnToggle - variants and states', (tester) async {
    await goldenTest(
      tester,
      goldenColumn(
        children: [
          for (final variant in CnToggleVariant.values) ...[
            CnToggle(
              value: false,
              onChanged: (_) {},
              variant: variant,
              child: Text(variant.name),
            ),
            CnToggle(
              value: true,
              onChanged: (_) {},
              variant: variant,
              child: Text('${variant.name} (on)'),
            ),
          ],
        ],
        spacing: 12,
      ),
      'goldens/toggle/variants.png',
      height: 300,
    );
  });

  testWidgets('CnToggle - sizes', (tester) async {
    await goldenTest(
      tester,
      goldenColumn(
        children: [
          for (final size in CnToggleSize.values)
            CnToggle(
              value: true,
              onChanged: (_) {},
              size: size,
              child: Text(size.name.toUpperCase()),
            ),
        ],
        spacing: 12,
      ),
      'goldens/toggle/sizes.png',
      height: 250,
    );
  });
}
