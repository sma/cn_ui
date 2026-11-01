import 'package:flutter/widget_previews.dart';
import 'package:material_ui/material_ui.dart';

import '../theme/cn_theme.dart';

/// A container with a title, description, action, content and footer.
class const CnCard({
  super.key,
  final Widget? title,
  final Widget? description,
  final Widget? action,
  final Widget? content,
  final Widget? footer,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = CnTheme.of(context);
    final colors = theme.colors;
    final hasHeader = title != null || description != null || action != null;

    return Container(
      padding: const .all(24),
      decoration: BoxDecoration(
        color: colors.card,
        borderRadius: .circular(theme.radius),
        border: Border.all(color: colors.border),
      ),
      child: DefaultTextStyle.merge(
        style: theme.text.sm.copyWith(color: colors.cardForeground),
        child: Column(
          crossAxisAlignment: .stretch,
          mainAxisSize: .min,
          spacing: 24,
          children: [
            if (hasHeader)
              Row(
                crossAxisAlignment: .start,
                spacing: 16,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: .start,
                      spacing: 6,
                      children: [
                        if (title != null)
                          DefaultTextStyle.merge(
                            style: theme.heading.base.semibold,
                            child: title!,
                          ),
                        if (description != null)
                          DefaultTextStyle.merge(
                            style: theme.text.sm.copyWith(
                              color: colors.mutedForeground,
                            ),
                            child: description!,
                          ),
                      ],
                    ),
                  ),
                  ?action,
                ],
              ),
            ?content,
            ?footer,
          ],
        ),
      ),
    );
  }

  @Preview(size: Size(320, 240))
  static Widget preview() {
    return CnCard(
      title: Text('Title'),
      description: Text('The description of the card.'),
      action: Icon(Icons.more_horiz),
      content: Text('The content of the card, multiple lines.'),
      footer: Text('Footer'),
    );
  }
}
