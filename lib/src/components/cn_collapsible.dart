import 'package:flutter/widget_previews.dart';
import 'package:material_ui/material_ui.dart';

import '../theme/cn_theme.dart';

/// A panel whose [content] expands and collapses below a header.
///
/// [value] says whether it is open. A `null` [onChanged] disables it.
///
/// See also:
///
///  * [CnAccordion], for a group of collapsible panels.
class const CnCollapsible({
  super.key,
  required final bool value,
  final ValueChanged<bool>? onChanged,
  required final Widget title,
  final Widget? description,
  final Widget? leading,
  final Widget? trailing,
  required final Widget content,
}) extends StatelessWidget {
  static const _duration = Duration(milliseconds: 220);

  @override
  Widget build(BuildContext context) {
    final theme = CnTheme.of(context);
    final colors = theme.colors;
    final enabled = onChanged != null;
    const disabled = {WidgetState.disabled};

    return Material(
      type: MaterialType.transparency,
      child: Column(
        crossAxisAlignment: .stretch,
        children: [
          InkWell(
            borderRadius: .circular(theme.radii.md),
            onTap: enabled ? () => onChanged!(!value) : null,
            child: Padding(
              padding: const .symmetric(horizontal: 12, vertical: 8),
              child: Row(
                spacing: 12,
                children: [
                  ?leading,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: .start,
                      spacing: 4,
                      children: [
                        DefaultTextStyle.merge(
                          style: theme.text.sm.medium.copyWith(
                            color: enabled
                                ? colors.foreground
                                : colors.foreground.resolve(disabled),
                          ),
                          child: title,
                        ),
                        if (description != null)
                          DefaultTextStyle.merge(
                            style: theme.text.xs.copyWith(
                              color: enabled
                                  ? colors.mutedForeground
                                  : colors.mutedForeground.resolve(disabled),
                            ),
                            child: description!,
                          ),
                      ],
                    ),
                  ),
                  trailing ??
                      AnimatedRotation(
                        turns: value ? 0.5 : 0,
                        duration: _duration,
                        child: Icon(
                          Icons.expand_more,
                          size: 16,
                          color: colors.mutedForeground,
                        ),
                      ),
                ],
              ),
            ),
          ),
          ClipRect(
            child: AnimatedAlign(
              duration: _duration,
              curve: Curves.easeOut,
              alignment: .topStart,
              heightFactor: value ? 1 : 0,
              child: Padding(
                padding: const .symmetric(horizontal: 12, vertical: 8),
                child: DefaultTextStyle.merge(
                  style: theme.text.sm,
                  child: content,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @Preview(size: Size(260, 260))
  static Widget preview() {
    return Column(
      spacing: 16,
      children: [
        for (final open in [false, true])
          CnCollapsible(
            value: open,
            onChanged: (_) {},
            title: Text('Title'),
            description: Text('Description'),
            content: Text('Content'),
          ),
      ],
    );
  }
}
