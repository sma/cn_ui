import 'dart:math' as math;

import 'package:cn_ui/previews.dart';
import 'package:flutter/material.dart';

import '../theme/cn_theme.dart';
import 'cn_context_menu.dart';
import 'cn_dropdown_menu.dart';

/// A breadcrumb navigation component for displaying hierarchical page paths.
///
/// Provides a series of linked items separated by visual dividers to show navigation hierarchy.
///
/// See also:
///
///  * [CnPagination], for page-based navigation.
///  * [CnTabs], for tab navigation.
class CnBreadcrumb extends StatelessWidget {
  const CnBreadcrumb({
    super.key,
    required this.items,
    this.separator,
    this.spacing = 4,
    this.runSpacing = 6,
    this.collapse = false,
  });

  final List<CnBreadcrumbItem> items;
  final Widget? separator;
  final double spacing;
  final double runSpacing;
  final bool collapse;

  @override
  Widget build(BuildContext context) {
    final effectiveSeparator = separator ?? const Icon(Icons.chevron_right);
    final length = items.length;
    final effectiveItems = collapse && length > 4
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
    return IconTheme.merge(
      data: IconThemeData(size: 16),
      child: Wrap(
        spacing: spacing,
        runSpacing: runSpacing,
        crossAxisAlignment: .center,
        children: [
          for (var index = 0; index < effectiveItems.length; index++) ...[
            if (index > 0) effectiveSeparator,
            effectiveItems[index],
          ],
        ],
      ),
    );
  }

  @Preview()
  static Widget preview1() {
    return PreviewVariants([
      for (var i = 1; i <= 4; i++)
        CnBreadcrumb(
          items: [
            CnBreadcrumbItem(label: Text('Home'), leading: Icon(Icons.home)),
            CnBreadcrumbItem(label: Text('Pages')),
            CnBreadcrumbItem(label: Text('About')),
            CnBreadcrumbItem(label: Text('Imprint')),
          ].sublist(0, i),
        ),
    ]);
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

/// An item in a [CnBreadcrumb].
class CnBreadcrumbItem {
  final Widget label;
  final VoidCallback? onTap;
  final bool enabled;
  final Widget? leading;

  const CnBreadcrumbItem({
    required this.label,
    this.onTap,
    this.enabled = true,
    this.leading,
  });
}

class _BreadcrumbItem extends StatelessWidget {
  const _BreadcrumbItem(this.item, {this.isCurrent = false});

  final CnBreadcrumbItem item;
  final bool isCurrent;

  @override
  Widget build(BuildContext context) {
    final scheme = CnTheme.colorSchemeOf(context);
    final cnTheme = CnTheme.of(context);
    final isInteractive = item.onTap != null && item.enabled;

    final baseStyle = CnTheme.textThemeOf(context).bodyMedium;
    final color = isCurrent ? scheme.onSurface : scheme.onSurfaceVariant;
    final resolvedColor = item.enabled ? color : color.withValues(alpha: 0.5);

    final labelStyle = baseStyle?.copyWith(
      color: resolvedColor,
      fontWeight: isCurrent ? .w600 : .w500,
      decoration: isInteractive ? TextDecoration.underline : null,
    );

    final content = Row(
      mainAxisSize: .min,
      spacing: 6,
      children: [
        if (item.leading != null) item.leading!,
        DefaultTextStyle(
          style: labelStyle ?? TextStyle(color: resolvedColor),
          child: item.label,
        ),
      ],
    );

    if (!isInteractive) {
      return content;
    }

    return InkWell(
      borderRadius: .circular(math.max(0, cnTheme.radius - 6)),
      onTap: item.onTap,
      child: Padding(
        padding: const .symmetric(horizontal: 2, vertical: 2),
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
          CnDropdownMenuAction(
            child: item.label,
            leading: item.leading,
            onSelected: item.enabled ? item.onTap : null,
          ),
      ],
      child: Icon(Icons.more_horiz),
    );
  }
}
