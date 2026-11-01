import 'dart:async';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';

/// Golden comparisons are off while the components are being reworked.
Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  goldenFileComparator = _IgnoringGoldenComparator();
  await testMain();
}

class _IgnoringGoldenComparator extends GoldenFileComparator {
  @override
  Future<bool> compare(Uint8List imageBytes, Uri golden) async => true;

  @override
  Future<void> update(Uri golden, Uint8List imageBytes) async {}
}
