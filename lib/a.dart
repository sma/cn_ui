import 'package:flutter/material.dart';

final c = Column(children: [Text('Hallo')].vgap(10));

extension on Widget {
  Widget pad({double top = 0, double bottom = 0}) {
    return Padding(
      padding: .only(top: top, bottom: bottom),
      child: this,
    );
  }
}

extension on List<Widget> {
  List<Widget> vgap(double size) {
    return length < 2
        ? this
        : [first, ...skip(1).map((child) => child.pad(top: size))];
  }
}
