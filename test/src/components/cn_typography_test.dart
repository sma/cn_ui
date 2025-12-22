import 'package:flutter_test/flutter_test.dart';
import 'package:cn_ui/src/components/cn_typography.dart';

import '../../helpers/golden_test_helper.dart';

void main() {
  // XXX: Consider adding named constructors like CnText.h1(), CnText.h2(), etc. for convenience
  testWidgets('CnTypography - variants', (tester) async {
    await goldenTest(
      tester,
      goldenColumn(
        children: const [
          CnText(variant: CnTextVariant.h1, text: 'Heading 1'),
          CnText(variant: CnTextVariant.h2, text: 'Heading 2'),
          CnText(variant: CnTextVariant.h3, text: 'Heading 3'),
          CnText(variant: CnTextVariant.p, text: 'Paragraph text'),
        ],
        spacing: 16,
      ),
      'goldens/typography/variants.png',
      height: 400,
    );
  });
}
