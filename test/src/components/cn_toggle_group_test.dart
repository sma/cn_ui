import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cn_ui/src/components/cn_toggle_group.dart';

import '../../helpers/golden_test_helper.dart';

void main() {
  testWidgets('CnToggleGroup - single selection', (tester) async {
    await goldenTest(
      tester,
      CnToggleGroup(
        items: const [
          CnToggleGroupItem(value: 'left', child: Text('Left')),
          CnToggleGroupItem(value: 'center', child: Text('Center')),
          CnToggleGroupItem(value: 'right', child: Text('Right')),
        ],
        selectedValues: const {'center'},
        onChanged: (_) {},
      ),
      'goldens/toggle_group/single.png',
      height: 150,
    );
  });

  testWidgets('CnToggleGroup - joined', (tester) async {
    await goldenTest(
      tester,
      CnToggleGroup(
        joined: true,
        items: const [
          CnToggleGroupItem(value: 'bold', child: Text('B')),
          CnToggleGroupItem(value: 'italic', child: Text('I')),
          CnToggleGroupItem(value: 'underline', child: Text('U')),
        ],
        selectedValues: const {'bold', 'italic'},
        allowMultiple: true,
        onChanged: (_) {},
      ),
      'goldens/toggle_group/joined.png',
      height: 150,
    );
  });
}
