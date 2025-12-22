import 'package:flutter/material.dart';

import '../cn_ui.dart';
import 'component_catalog.dart';

class ComponentIndexPage extends StatefulWidget {
  final List<ComponentEntry> entries;
  final ValueChanged<int>? onSelect;

  const ComponentIndexPage({super.key, required this.entries, this.onSelect});

  @override
  State<ComponentIndexPage> createState() => _ComponentIndexPageState();
}

class _ComponentIndexPageState extends State<ComponentIndexPage> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocus = FocusNode();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocus.dispose();
    super.dispose();
  }

  void _clearSearch() {
    setState(() {
      _query = '';
      _searchController.clear();
    });
    _searchFocus.requestFocus();
  }

  List<int> _filteredIndices() {
    if (_query.trim().isEmpty) {
      return List.generate(widget.entries.length, (index) => index);
    }
    final query = _query.toLowerCase();
    final matches = <int>[];
    for (var index = 0; index < widget.entries.length; index++) {
      final entry = widget.entries[index];
      final matchesName = entry.name.toLowerCase().contains(query);
      final matchesDescription = entry.description.toLowerCase().contains(
        query,
      );
      if (matchesName || matchesDescription) {
        matches.add(index);
      }
    }
    return matches;
  }

  @override
  Widget build(BuildContext context) {
    final indices = _filteredIndices();
    final hasQuery = _query.trim().isNotEmpty;

    return SingleChildScrollView(
      padding: const .symmetric(horizontal: 28, vertical: 24),
      child: Column(
        crossAxisAlignment: .start,
        spacing: 8,
        children: [
          Text(
            'Components',
            style: CnTheme.textThemeOf(context).headlineMedium,
          ),
          Text(
            'A curated list of chadcn/ui ports implemented in Flutter.',
            style: CnTheme.textThemeOf(context).bodyLarge,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: SizedBox(
              width: 360,
              child: CnInput(
                controller: _searchController,
                placeholder: 'Search components',
                onChanged: (value) => setState(() => _query = value),
                prefixIcon: const Icon(Icons.search),
                suffixIcon: hasQuery
                    ? IconButton(
                        tooltip: 'Clear search',
                        onPressed: _clearSearch,
                        icon: const Icon(Icons.close),
                      )
                    : null,
              ),
            ),
          ),
          if (hasQuery)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                '${indices.length} result${indices.length == 1 ? '' : 's'}',
                style: CnTheme.textThemeOf(context).bodySmall,
              ),
            ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: indices.isEmpty
                ? CnEmpty(
                    title: const CnEmptyTitle(
                      child: Text('No components found'),
                    ),
                    description: const CnEmptyDescription(
                      child: Text(
                        'Try a different keyword or clear the search.',
                      ),
                    ),
                    actions: CnButton(
                      variant: .outline,
                      onPressed: _clearSearch,
                      child: const Text('Clear search'),
                    ),
                  )
                : Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: [
                      for (final index in indices)
                        _ComponentCard(
                          entry: widget.entries[index],
                          onTap: widget.onSelect == null
                              ? null
                              : () => widget.onSelect!(index),
                        ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}

class _ComponentCard extends StatelessWidget {
  final ComponentEntry entry;
  final VoidCallback? onTap;

  const _ComponentCard({required this.entry, this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: InkWell(
        borderRadius: .circular(CnTheme.of(context).radius),
        onTap: onTap,
        child: CnCard(
          header: Row(
            children: [
              Expanded(
                child: Text(
                  entry.name,
                  style: CnTheme.textThemeOf(context).titleMedium,
                ),
              ),
              const CnBadge(child: Text('Ported')),
            ],
          ),
          content: Text(
            entry.description,
            style: CnTheme.textThemeOf(context).bodyMedium,
          ),
        ),
      ),
    );
  }
}
