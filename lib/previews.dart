import 'package:flutter/material.dart';

export 'package:flutter/widget_previews.dart';

/// Displays [children] in their natural sizes as a grid with [columns] columns
/// and enough rows to fit them. Set [expanded] to make them fill the available
/// space. Odd rows have a slightly different background. The grid is bordered.
class PreviewVariants extends StatelessWidget {
  const PreviewVariants(
    this.children, {
    super.key,
    this.columns = 1,
    this.expanded = false,
  }) : assert(columns > 0);

  final List<Widget> children;
  final int columns;
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    Widget child(int index) {
      final child = index < children.length
          ? children[index]
          : const SizedBox();
      return expanded ? child : Center(child: child);
    }

    final rows = (children.length + columns - 1) ~/ columns;
    return Table(
      defaultVerticalAlignment: .middle,
      border: TableBorder.all(color: Colors.white10),
      children: [
        for (var row = 0; row < rows; row++)
          TableRow(
            children: [
              for (var column = 0; column < columns; column++)
                child(row * columns + column),
            ],
          ),
      ],
    );
  }
}
