import 'package:flutter_test/flutter_test.dart';
import 'package:cn_ui/src/components/cn_calendar.dart';

import '../../helpers/golden_test_helper.dart';

void main() {
  testWidgets('CnCalendar - default', (tester) async {
    await goldenTest(
      tester,
      withDimensions(
        CnCalendar(
          focusedMonth: DateTime(2024, 1, 1),
          selectionMode: CnCalendarSelectionMode.single,
          selectedDate: DateTime(2024, 1, 15),
        ),
        width: 350,
      ),
      'goldens/calendar/default.png',
      height: 450,
    );
  });
}
