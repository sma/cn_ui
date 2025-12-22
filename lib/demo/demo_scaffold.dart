import 'package:flutter/material.dart';

import '../cn_ui.dart';

class DemoDestination {
  final String label;
  final IconData icon;
  final Widget page;

  const DemoDestination({
    required this.label,
    required this.icon,
    required this.page,
  });
}

class CnDemoScaffold extends StatelessWidget {
  final List<DemoDestination> destinations;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  const CnDemoScaffold({
    super.key,
    required this.destinations,
    required this.selectedIndex,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 980;
        final body = destinations[selectedIndex].page;

        if (!isWide) {
          return Scaffold(
            appBar: AppBar(title: Text(destinations[selectedIndex].label)),
            drawer: Drawer(
              child: SafeArea(
                child: _SidebarList(
                  destinations: destinations,
                  selectedIndex: selectedIndex,
                  onSelected: (index) {
                    onSelected(index);
                    Navigator.of(context).maybePop();
                  },
                ),
              ),
            ),
            body: body,
          );
        }

        return Scaffold(
          body: SafeArea(
            child: Row(
              crossAxisAlignment: .start,
              children: [
                _SidebarList(
                  destinations: destinations,
                  selectedIndex: selectedIndex,
                  onSelected: onSelected,
                ),
                Expanded(child: body),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _SidebarList extends StatelessWidget {
  final List<DemoDestination> destinations;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  const _SidebarList({
    required this.destinations,
    required this.selectedIndex,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final cnTheme = CnTheme.of(context);
    final scheme = CnTheme.colorSchemeOf(context);

    return Container(
      width: 260,
      decoration: BoxDecoration(
        color: cnTheme.menuColor,
        border: Border(right: BorderSide(color: scheme.outlineVariant)),
      ),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Padding(
            padding: const .fromLTRB(20, 20, 20, 12),
            child: Column(
              crossAxisAlignment: .start,
              spacing: 4,
              children: [
                Text('CN UI', style: CnTheme.textThemeOf(context).titleLarge),
                Text(
                  'Flutter port of chadcn/ui',
                  style: CnTheme.textThemeOf(context).bodySmall,
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: ListView.builder(
              padding: const .symmetric(vertical: 12),
              itemCount: destinations.length,
              itemBuilder: (context, index) {
                final destination = destinations[index];
                final isSelected = index == selectedIndex;
                return Padding(
                  padding: const .symmetric(horizontal: 12, vertical: 4),
                  child: InkWell(
                    borderRadius: .circular(cnTheme.radius),
                    onTap: () => onSelected(index),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const .symmetric(horizontal: 14, vertical: 10),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? cnTheme.menuAccent.withValues(alpha: 0.12)
                            : Colors.transparent,
                        borderRadius: .circular(cnTheme.radius),
                        border: Border.all(
                          color: isSelected
                              ? cnTheme.menuAccent.withValues(alpha: 0.3)
                              : Colors.transparent,
                        ),
                      ),
                      child: Row(
                        spacing: 10,
                        children: [
                          Icon(
                            destination.icon,
                            size: 18,
                            color: isSelected
                                ? cnTheme.menuAccent
                                : scheme.onSurfaceVariant,
                          ),
                          Expanded(
                            child: Text(
                              destination.label,
                              style: CnTheme.textThemeOf(context).bodyMedium
                                  ?.copyWith(
                                    color: isSelected
                                        ? cnTheme.menuAccent
                                        : scheme.onSurface,
                                    fontWeight: isSelected ? .w600 : null,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
