import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cn_ui/src/components/cn_chart.dart';

import '../../helpers/golden_test_helper.dart';

void main() {
  testWidgets('CnChart - bar', (tester) async {
    await goldenTest(
      tester,
      SizedBox(
        width: 400,
        height: 300,
        child: CnChart(
          series: [
            CnChartSeries(
              name: 'Sales',
              type: CnChartType.bar,
              data: [
                CnChartPoint('Jan', 10),
                CnChartPoint('Feb', 20),
                CnChartPoint('Mar', 15),
              ],
            ),
          ],
        ),
      ),
      'goldens/chart/bar.png',
      height: 400,
    );
  });
}
