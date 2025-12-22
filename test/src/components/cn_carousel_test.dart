import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cn_ui/src/components/cn_carousel.dart';

import '../../helpers/golden_test_helper.dart';

void main() {
  testWidgets('CnCarousel - default', (tester) async {
    await goldenTest(
      tester,
      SizedBox(
        width: 400,
        height: 250,
        child: CnCarousel(
          items: [
            Container(
              color: Colors.red,
              child: const Center(child: Text('Slide 1')),
            ),
            Container(
              color: Colors.blue,
              child: const Center(child: Text('Slide 2')),
            ),
            Container(
              color: Colors.green,
              child: const Center(child: Text('Slide 3')),
            ),
          ],
        ),
      ),
      'goldens/carousel/default.png',
      height: 350,
    );
  });
}
