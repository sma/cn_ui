import 'package:material_ui/material_ui.dart';

import '../theme/cn_theme.dart';
import 'cn_input.dart';

/// A command palette component for searchable actions and navigation.
///
/// Provides a searchable list of grouped commands with keyboard navigation support.
///
/// See also:
///
///  * [CnCombobox], for searchable dropdown selection.
class CnCommand extends StatefulWidget {
  const CnCommand({
    super.key,
    required this.groups,
    this.placeholder = 'Type a command or search...',
    this.emptyText = 'No results found.',
    this.controller,
    this.onQueryChanged,
    this.maxHeight = 280,
  });
  final List<CnCommandGroup> groups;
  final String placeholder;
  final String emptyText;
  final TextEditingController? controller;
  final ValueChanged<String>? onQueryChanged;
  final double maxHeight;

  @override
  State<CnCommand> createState() => _CnCommandState();
}

class _CnCommandState extends State<CnCommand> {
  late TextEditingController _controller;
  late bool _ownsController;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _ownsController = widget.controller == null;
    _controller.addListener(_handleQueryChanged);
  }

  @override
  void didUpdateWidget(CnCommand oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      _controller.removeListener(_handleQueryChanged);
      if (_ownsController) {
        _controller.dispose();
      }
      _controller = widget.controller ?? TextEditingController();
      _ownsController = widget.controller == null;
      _controller.addListener(_handleQueryChanged);
    }
  }

  void _handleQueryChanged() {
    widget.onQueryChanged?.call(_controller.text);
    setState(() {});
  }

  @override
  void dispose() {
    _controller.removeListener(_handleQueryChanged);
    if (_ownsController) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cnTheme = CnTheme.of(context);
    final colors = CnTheme.of(context).colors;
    final query = _controller.text.trim().toLowerCase();

    final filteredGroups = widget.groups
        .map((group) => group.filter(query))
        .where((group) => group.items.isNotEmpty)
        .toList();

    final hasResults = filteredGroups.isNotEmpty;

    return Container(
      padding: const .all(8),
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: .circular(cnTheme.radius),
        border: Border.all(color: colors.border),
      ),
      child: Column(
        mainAxisSize: .min,
        crossAxisAlignment: .start,
        spacing: 12,
        children: [
          CnInput(
            controller: _controller,
            placeholder: widget.placeholder,
            leading: const Icon(Icons.search, size: 16),
          ),
          SizedBox(
            height: widget.maxHeight,
            child: hasResults
                ? ListView.builder(
                    itemCount: filteredGroups.length,
                    itemBuilder: (context, groupIndex) {
                      final group = filteredGroups[groupIndex];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: _CommandGroupList(group: group),
                      );
                    },
                  )
                : Center(
                    child: Text(
                      widget.emptyText,
                      style: CnTheme.of(context).text.xs
                          .copyWith(color: colors.mutedForeground),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

/// A group of command items in [CnCommand].
class const CnCommandGroup({
  final Widget? label,
  required final List<CnCommandItem> items,
}) {
  CnCommandGroup filter(String query) {
    if (query.isEmpty) {
      return this;
    }
    final filteredItems = items.where((item) => item.matches(query)).toList();
    return CnCommandGroup(label: label, items: filteredItems);
  }
}

/// An individual command item in [CnCommandGroup].
class const CnCommandItem({
  required final String label,
  final String? description,
  final List<String> keywords = const [],
  final VoidCallback? onSelected,
  final Widget? leading,
  final Widget? trailing,
}) {
  bool matches(String query) {
    final searchSpace = [
      label,
      description,
      ...keywords,
    ].whereType<String>().join(' ').toLowerCase();
    return searchSpace.contains(query);
  }
}

class _CommandGroupList extends StatelessWidget {
  const _CommandGroupList({required this.group});
  final CnCommandGroup group;

  @override
  Widget build(BuildContext context) {
    final colors = CnTheme.of(context).colors;

    return Column(
      crossAxisAlignment: .start,
      children: [
        if (group.label != null)
          Padding(
            padding: const .fromLTRB(6, 6, 6, 4),
            child: DefaultTextStyle.merge(
              style: CnTheme.of(context).text.xs.medium
                  .copyWith(color: colors.mutedForeground),
              child: group.label!,
            ),
          ),
        for (final item in group.items) _CommandItemTile(item: item),
      ],
    );
  }
}

class _CommandItemTile extends StatelessWidget {
  const _CommandItemTile({required this.item});
  final CnCommandItem item;

  @override
  Widget build(BuildContext context) {
    final colors = CnTheme.of(context).colors;
    final cnTheme = CnTheme.of(context);
    final enabled = item.onSelected != null;

    return InkWell(
      borderRadius: .circular(cnTheme.radii.sm),
      onTap: enabled ? item.onSelected : null,
      child: Padding(
        padding: const .symmetric(horizontal: 8, vertical: 10),
        child: Row(
          crossAxisAlignment: .start,
          spacing: 10,
          children: [
            if (item.leading != null) ...[
              IconTheme(
                data: IconThemeData(
                  color: enabled
                      ? colors.mutedForeground
                      : colors.mutedForeground.resolve(const {.disabled}),
                  size: 18,
                ),
                child: item.leading!,
              ),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: .start,
                spacing: 4,
                children: [
                  Text(
                    item.label,
                    style: CnTheme.of(context).text.sm.copyWith(
                      color: enabled
                          ? colors.foreground
                          : colors.foreground.resolve(const {.disabled}),
                    ),
                  ),
                  if (item.description != null)
                    Text(
                      item.description!,
                      style: CnTheme.of(context).text.xs.copyWith(
                        color: enabled
                            ? colors.mutedForeground
                            : colors.mutedForeground.resolve(const {.disabled}),
                      ),
                    ),
                ],
              ),
            ),
            if (item.trailing != null) ...[item.trailing!],
          ],
        ),
      ),
    );
  }
}
