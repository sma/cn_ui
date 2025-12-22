import 'package:flutter_test/flutter_test.dart';
import 'package:cn_ui/src/components/cn_pagination.dart';

import '../../helpers/golden_test_helper.dart';

void main() {
  testWidgets('CnPagination - default', (tester) async {
    await goldenTest(
      tester,
      CnPagination(currentPage: 3, totalPages: 10, onPageChanged: (_) {}),
      'goldens/pagination/default.png',
      height: 150,
    );
  });
}
