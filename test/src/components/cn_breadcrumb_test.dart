import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cn_ui/src/components/cn_breadcrumb.dart';

import '../../helpers/golden_test_helper.dart';

void main() {
  testWidgets('CnBreadcrumb - default', (tester) async {
    await goldenTest(
      tester,
      CnBreadcrumb(
        items: [
          CnBreadcrumbItem(label: const Text('Home'), onTap: () {}),
          CnBreadcrumbItem(label: const Text('Products'), onTap: () {}),
          const CnBreadcrumbItem(label: Text('Details')),
        ],
      ),
      'goldens/breadcrumb/default.png',
      height: 100,
    );
  });
}
