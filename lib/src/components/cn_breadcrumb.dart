import 'package:flutter/widget_previews.dart';
import 'package:material_ui/material_ui.dart';

import '../theme/cn_theme.dart';
import 'cn_context_menu.dart';
import 'cn_menu_entry.dart';

/// The path to the current page, with a link for each level.
///
/// With [collapse], the middle of a long path moves into a menu.
///
/// See also:
///
///  * [CnPagination], for page-based navigation.
///  * [CnTabs], for tab navigation.
class const CnBreadcrumb({
  super.key,
  required final List<CnBreadcrumbItem> items,
  final Widget? separator,
  final double spacing = 6,
  final bool collapse = false,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final length = items.length;
    final entries = collapse && length > 4
        ? [
            _BreadcrumbItem(items[0]),
            _BreadcrumbItemMenu(items.sublist(1, length - 2)),
            _BreadcrumbItem(items[length - 2]),
            _BreadcrumbItem(items[length - 1], isCurrent: true),
          ]
        : [
            for (var index = 0; index < length; index++)
              _BreadcrumbItem(items[index], isCurrent: index == length - 1),
          ];
    final colors = CnTheme.of(context).colors;

    return IconTheme.merge(
      data: IconThemeData(size: 16, color: colors.mutedForeground),
      child: Wrap(
        spacing: spacing,
        runSpacing: spacing,
        crossAxisAlignment: .center,
        children: [
          for (var index = 0; index < entries.length; index++) ...[
            if (index > 0) separator ?? const Icon(Icons.chevron_right),
            entries[index],
          ],
        ],
      ),
    );
  }

  @Preview()
  static Widget preview1() {
    return Column(
      spacing: 16,
      children: [
        for (var i = 1; i <= 4; i++)
          CnBreadcrumb(
            items: [
              CnBreadcrumbItem(label: Text('Home'), leading: Icon(Icons.home)),
              CnBreadcrumbItem(label: Text('Pages')),
              CnBreadcrumbItem(label: Text('About')),
              CnBreadcrumbItem(label: Text('Imprint')),
            ].sublist(0, i),
          ),
      ],
    );
  }

  @Preview()
  static Widget preview2() {
    return CnBreadcrumb(
      collapse: true,
      items: [
        for (var i = 1; i <= 6; i++) CnBreadcrumbItem(label: Text('Item $i')),
      ],
    );
  }
}

/// An item in a [CnBreadcrumb]. Without [onTap], it is not a link.
class const CnBreadcrumbItem({
  required final Widget label,
  final VoidCallback? onTap,
  final Widget? leading,
});

class _BreadcrumbItem extends StatelessWidget {
  const _BreadcrumbItem(this.item, {this.isCurrent = false});

  final CnBreadcrumbItem item;
  final bool isCurrent;

  @override
  Widget build(BuildContext context) {
    final theme = CnTheme.of(context);
    final colors = theme.colors;

    final content = Row(
      mainAxisSize: .min,
      spacing: 6,
      children: [
        ?item.leading,
        DefaultTextStyle.merge(
          style: theme.text.sm.copyWith(
            color: isCurrent ? colors.foreground : colors.mutedForeground,
          ),
          child: item.label,
        ),
      ],
    );

    if (item.onTap == null) {
      return content;
    }

    return Material(
      type: .transparency,
      child: InkWell(
        borderRadius: .circular(theme.radii.sm),
        hoverColor: Colors.transparent,
        onTap: item.onTap,
        child: content,
      ),
    );
  }
}

class _BreadcrumbItemMenu extends StatelessWidget {
  const _BreadcrumbItemMenu(this.items);

  final List<CnBreadcrumbItem> items;

  @override
  Widget build(BuildContext context) {
    return CnContextMenu(
      openOnTap: true,
      entries: [
        for (final item in items)
          CnMenuAction(
            label: item.label,
            leading: item.leading,
            onSelected: item.onTap,
          ),
      ],
      child: const Icon(Icons.more_horiz),
    );
  }
}
