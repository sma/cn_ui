import 'package:material_ui/material_ui.dart';

import '../theme/cn_theme.dart';

/// A list of sections that expand and collapse.
///
/// [value] holds the open items. With [multiple], several can be open at once.
///
/// See also:
///
///  * [CnCollapsible], for a single collapsible panel.
class const CnAccordion<T>({
  super.key,
  required final List<CnAccordionItem<T>> items,
  required final Set<T> value,
  final ValueChanged<Set<T>>? onChanged,
  final bool multiple = false,
}) extends StatelessWidget {
  static const _duration = Duration(milliseconds: 220);

  void _toggle(T item) {
    onChanged?.call(
      value.contains(item)
          ? ({...value}..remove(item))
          : (multiple ? {...value, item} : {item}),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: .transparency,
      child: Column(
        mainAxisSize: .min,
        crossAxisAlignment: .stretch,
        children: [
          for (var index = 0; index < items.length; index++) ...[
            _buildItem(context, items[index]),
            if (index != items.length - 1) const Divider(height: 1),
          ],
        ],
      ),
    );
  }

  Widget _buildItem(BuildContext context, CnAccordionItem<T> item) {
    final theme = CnTheme.of(context);
    final colors = theme.colors;
    final enabled = item.enabled && onChanged != null;
    final open = value.contains(item.value);

    return Column(
      crossAxisAlignment: .stretch,
      children: [
        InkWell(
          hoverColor: Colors.transparent,
          onTap: enabled ? () => _toggle(item.value) : null,
          child: Padding(
            padding: const .symmetric(vertical: 16),
            child: Row(
              spacing: 16,
              children: [
                Expanded(
                  child: DefaultTextStyle.merge(
                    style: theme.text.sm.medium.copyWith(
                      color: enabled
                          ? colors.foreground
                          : colors.foreground.resolve(const {.disabled}),
                    ),
                    child: item.title,
                  ),
                ),
                item.trailing ??
                    AnimatedRotation(
                      turns: open ? 0.5 : 0,
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
            heightFactor: open ? 1 : 0,
            child: Padding(
              padding: const .only(bottom: 16),
              child: DefaultTextStyle.merge(
                style: theme.text.sm,
                child: item.content,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// An item in a [CnAccordion], identified by its [value].
class const CnAccordionItem<T>({
  required final T value,
  required final Widget title,
  required final Widget content,
  final Widget? trailing,
  final bool enabled = true,
});
