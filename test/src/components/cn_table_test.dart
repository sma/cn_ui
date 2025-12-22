import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cn_ui/src/components/cn_table.dart';

import '../../helpers/golden_test_helper.dart';

void main() {
  testWidgets('CnTable - default', (tester) async {
    await goldenTest(
      tester,
      SizedBox(
        width: 600,
        child: CnTable(
          columns: const [
            CnTableColumn(label: Text('Name')),
            CnTableColumn(label: Text('Age')),
            CnTableColumn(label: Text('City')),
          ],
          rows: const [
            CnTableRow(cells: [Text('John'), Text('30'), Text('NYC')]),
            CnTableRow(cells: [Text('Jane'), Text('25'), Text('LA')]),
          ],
        ),
      ),
      'goldens/table/default.png',
      height: 300,
    );
  });
}
