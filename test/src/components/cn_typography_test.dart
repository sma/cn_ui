import 'package:cn_ui/src/components/cn_typography.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/golden_test_helper.dart';

void main() {
  // XXX: Consider adding named constructors like CnText.h1(), CnText.h2(), etc. for convenience
  testWidgets('CnTypography - variants', (tester) async {
    await goldenTest(
      tester,
      goldenColumn(
        children: const [
          CnText.h1('Heading 1'),
          CnText.h2('Heading 2'),
          CnText.h3('Heading 3'),
          CnText.p('Paragraph text'),
        ],
        spacing: 16,
      ),
      'goldens/typography/variants.png',
      height: 400,
    );
  });
}
