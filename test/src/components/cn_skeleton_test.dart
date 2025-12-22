import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cn_ui/src/components/cn_skeleton.dart';

import '../../helpers/golden_test_helper.dart';

void main() {
  testWidgets('CnSkeleton - shapes', (tester) async {
    await goldenTest(
      tester,
      goldenColumn(
        children: const [
          SizedBox(width: 200, height: 20, child: CnSkeleton(animate: false)),
          // XXX: Consider using 'shape: BoxShape.circle' instead of 'isCircle: true' for consistency with Flutter
          SizedBox(
            width: 100,
            height: 100,
            child: CnSkeleton(isCircle: true, animate: false),
          ),
        ],
        spacing: 16,
      ),
      'goldens/skeleton/shapes.png',
      height: 250,
    );
  });
}
