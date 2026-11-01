import 'package:material_ui/material_ui.dart';

import 'cn_button.dart';

/// A pagination component for navigating through multiple pages of content.
///
/// Provides numbered page buttons with ellipsis and optional previous/next controls.
///
/// See also:
///
///  * [CnBreadcrumb], for hierarchical navigation.
///  * [CnTable], which often uses pagination.
class CnPagination extends StatelessWidget {
  const CnPagination({
    super.key,
    required this.value,
    required this.pageCount,
    required this.onChanged,
    this.maxButtons = 5,
    this.showPrevNext = true,
  });
  final int value;
  final int pageCount;
  final ValueChanged<int> onChanged;
  final int maxButtons;
  final bool showPrevNext;

  @override
  Widget build(BuildContext context) {
    final pages = _buildPages();

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        if (showPrevNext)
          CnButton(
            variant: .outline,
            size: .sm,
            onPressed: value > 1 ? () => onChanged(value - 1) : null,
            leading: const Icon(Icons.chevron_left, size: 16),
            child: const Text('Prev'),
          ),
        for (final page in pages) _buildPageButton(page),
        if (showPrevNext)
          CnButton(
            variant: .outline,
            size: .sm,
            onPressed: value < pageCount ? () => onChanged(value + 1) : null,
            trailing: const Icon(Icons.chevron_right, size: 16),
            child: const Text('Next'),
          ),
      ],
    );
  }

  Widget _buildPageButton(_PageEntry entry) {
    if (entry.isEllipsis) {
      return const Padding(
        padding: .symmetric(horizontal: 4),
        child: Text('...'),
      );
    }

    final page = entry.page;
    final isCurrent = page == value;

    return CnButton(
      variant: isCurrent ? .primary : .outline,
      size: .sm,
      onPressed: isCurrent ? null : () => onChanged(page),
      child: Text(page.toString()),
    );
  }

  List<_PageEntry> _buildPages() {
    if (pageCount <= 0) {
      return const [];
    }

    if (pageCount <= maxButtons) {
      return [for (var i = 1; i <= pageCount; i++) _PageEntry.page(i)];
    }

    final window = (maxButtons - 2).clamp(1, maxButtons);
    var start = value - (window ~/ 2);
    var end = value + (window ~/ 2);

    if (start < 2) {
      start = 2;
      end = start + window - 1;
    }

    if (end > pageCount - 1) {
      end = pageCount - 1;
      start = end - window + 1;
    }

    final entries = <_PageEntry>[_PageEntry.page(1)];

    if (start > 2) {
      entries.add(const _PageEntry.ellipsis());
    }

    for (var page = start; page <= end; page++) {
      entries.add(_PageEntry.page(page));
    }

    if (end < pageCount - 1) {
      entries.add(const _PageEntry.ellipsis());
    }

    entries.add(_PageEntry.page(pageCount));

    return entries;
  }
}

class _PageEntry {
  const _PageEntry.page(this.page) : isEllipsis = false;

  const _PageEntry.ellipsis() : page = 0, isEllipsis = true;
  final int page;
  final bool isEllipsis;
}
