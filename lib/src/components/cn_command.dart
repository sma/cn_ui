import 'dart:math' as math;

import 'package:flutter/material.dart';

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
  final List<CnCommandGroup> groups;
  final String placeholder;
  final String emptyText;
  final TextEditingController? controller;
  final ValueChanged<String>? onQueryChanged;
  final double maxHeight;
  final EdgeInsetsGeometry? padding;

  const CnCommand({
    super.key,
    required this.groups,
    this.placeholder = 'Type a command or search...',
    this.emptyText = 'No results found.',
    this.controller,
    this.onQueryChanged,
    this.maxHeight = 280,
    this.padding,
  });

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
    final scheme = CnTheme.colorSchemeOf(context);
    final query = _controller.text.trim().toLowerCase();

    final filteredGroups = widget.groups
        .map((group) => group.filter(query))
        .where((group) => group.items.isNotEmpty)
        .toList();

    final hasResults = filteredGroups.isNotEmpty;

    return Container(
      padding: widget.padding ?? const .all(12),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: .circular(cnTheme.radius),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Column(
        mainAxisSize: .min,
        crossAxisAlignment: .start,
        spacing: 12,
        children: [
          CnInput(
            controller: _controller,
            placeholder: widget.placeholder,
            prefixIcon: const Icon(Icons.search),
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
                      style: CnTheme.textThemeOf(
                        context,
                      ).bodySmall?.copyWith(color: scheme.onSurfaceVariant),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

/// A group of command items in [CnCommand].
class CnCommandGroup {
  final String? label;
  final List<CnCommandItem> items;

  const CnCommandGroup({this.label, required this.items});

  CnCommandGroup filter(String query) {
    if (query.isEmpty) {
      return this;
    }
    final filteredItems = items.where((item) => item.matches(query)).toList();
    return CnCommandGroup(label: label, items: filteredItems);
  }
}

/// An individual command item in [CnCommandGroup].
class CnCommandItem {
  final String label;
  final String? description;
  final List<String> keywords;
  final VoidCallback? onSelected;
  final Widget? leading;
  final Widget? trailing;
  final bool disabled;

  const CnCommandItem({
    required this.label,
    this.description,
    this.keywords = const [],
    this.onSelected,
    this.leading,
    this.trailing,
    this.disabled = false,
  });

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
  final CnCommandGroup group;

  const _CommandGroupList({required this.group});

  @override
  Widget build(BuildContext context) {
    final scheme = CnTheme.colorSchemeOf(context);

    return Column(
      crossAxisAlignment: .start,
      children: [
        if (group.label != null)
          Padding(
            padding: const .fromLTRB(6, 6, 6, 4),
            child: Text(
              group.label!,
              style: CnTheme.textThemeOf(
                context,
              ).labelMedium?.copyWith(color: scheme.onSurfaceVariant),
            ),
          ),
        for (final item in group.items) _CommandItemTile(item: item),
      ],
    );
  }
}

class _CommandItemTile extends StatelessWidget {
  final CnCommandItem item;

  const _CommandItemTile({required this.item});

  @override
  Widget build(BuildContext context) {
    final scheme = CnTheme.colorSchemeOf(context);
    final cnTheme = CnTheme.of(context);
    final enabled = item.onSelected != null && !item.disabled;

    return InkWell(
      borderRadius: .circular(math.max(0, cnTheme.radius - 4)),
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
                      ? scheme.onSurfaceVariant
                      : scheme.onSurfaceVariant.withValues(alpha: 0.4),
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
                    style: CnTheme.textThemeOf(context).bodyMedium?.copyWith(
                      color: enabled
                          ? scheme.onSurface
                          : scheme.onSurfaceVariant.withValues(alpha: 0.5),
                      fontWeight: .w600,
                    ),
                  ),
                  if (item.description != null)
                    Text(
                      item.description!,
                      style: CnTheme.textThemeOf(context).bodySmall?.copyWith(
                        color: enabled
                            ? scheme.onSurfaceVariant
                            : scheme.onSurfaceVariant.withValues(alpha: 0.4),
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
