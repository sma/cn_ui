import 'package:flutter/material.dart';

/// A container component that displays content with optional header and footer.
///
/// Wraps Flutter's [Card] widget with consistent theming and layout structure.
///
/// See also:
///
///  * [Card], the underlying Material widget.
class CnCard extends StatelessWidget {
  final Widget? header;
  final Widget? content;
  final Widget? footer;
  final EdgeInsetsGeometry padding;
  final Widget? child;

  const CnCard({
    super.key,
    this.header,
    this.content,
    this.footer,
    this.padding = const .all(20),
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    final hasBody = header != null || content != null;
    final body =
        child ??
        Column(
          crossAxisAlignment: .start,
          spacing: 12,
          children: [
            if (header != null) header!,
            if (content != null) content!,
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
}
