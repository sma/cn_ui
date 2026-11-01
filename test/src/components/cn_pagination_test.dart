import 'package:cn_ui/src/components/cn_pagination.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/golden_test_helper.dart';

void main() {
  testWidgets('CnPagination - default', (tester) async {
    await goldenTest(
      tester,
      CnPagination(value: 3, pageCount: 10, onChanged: (_) {}),
      'goldens/pagination/default.png',
      height: 150,
    );
  });
}
