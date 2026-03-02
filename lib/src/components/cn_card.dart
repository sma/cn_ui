import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

/// A container component that displays content with optional header and footer.
///
/// Wraps Flutter's [Card] widget with consistent theming and layout structure.
///
/// See also:
///
///  * [Card], the underlying Material widget.
class CnCard extends StatelessWidget {
  const CnCard({
    super.key,
    this.header,
    this.content,
    this.footer,
    this.padding = const .all(20),
    this.child,
  });
  final Widget? header;
  final Widget? content;
  final Widget? footer;
  final EdgeInsetsGeometry padding;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final hasBody = header != null || content != null;
    final body =
        child ??
        Column(
          crossAxisAlignment: .start,
          spacing: 12,
          children: [
            ?header,
            ?content,
            if (footer != null)
              hasBody
                  ? Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: footer!,
                    )
                  : footer!,
          ],
        );

    return Card(
      child: Padding(padding: padding, child: body),
    );
  }

  @Preview()
  static Widget preview1() {
    return CnCard(
      header: Text('Header'),
      content: Text('The content of the card, multiple lines.'),
      footer: Text('Footer'),
    );
  }

  @Preview()
  static Widget preview2() {
    return CnCard(
      child: Column(
        children: [Text('A custom child'), Icon(Icons.qr_code, size: 48)],
      ),
    );
  }
}
