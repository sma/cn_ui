import 'package:material_ui/material_ui.dart';

import '../cn_ui.dart';

class DemoDestination {
  const DemoDestination({
    required this.label,
    required this.icon,
    required this.page,
  });
  final String label;
  final IconData icon;
  final Widget page;
}

class CnDemoScaffold extends StatelessWidget {
  const CnDemoScaffold({
    super.key,
    required this.destinations,
    required this.selectedIndex,
    required this.onSelected,
  });
  final List<DemoDestination> destinations;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 980;
        final colors = CnTheme.of(context).colors;
        // The scaffold would animate its color and text on its own and lag
        // behind the theme, so both are set here.
        final body = DefaultTextStyle.merge(
          style: TextStyle(color: colors.foreground),
          child: destinations[selectedIndex].page,
        );

        if (!isWide) {
          return Scaffold(
            backgroundColor: colors.background,
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

        return ColoredBox(
          color: colors.background,
          child: Scaffold(
            backgroundColor: Colors.transparent,
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
          ),
        );
      },
    );
  }
}

class _SidebarList extends StatelessWidget {
  const _SidebarList({
    required this.destinations,
    required this.selectedIndex,
    required this.onSelected,
  });
  final List<DemoDestination> destinations;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    final cnTheme = CnTheme.of(context);
    final colors = CnTheme.of(context).colors;

    return Container(
      width: 260,
      decoration: BoxDecoration(
        color: colors.sidebar,
        border: BorderDirectional(end: BorderSide(color: colors.sidebarBorder)),
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
                Text('CN UI', style: CnTheme.of(context).heading.lg.semibold),
                Text(
                  'Flutter port of chadcn/ui',
                  style: CnTheme.of(context).text.xs,
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
                    borderRadius: .circular(cnTheme.radii.md),
                    onTap: () => onSelected(index),
                    child: Container(
                      padding: const .symmetric(horizontal: 14, vertical: 10),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? colors.sidebarAccent
                            : colors.sidebar,
                        borderRadius: .circular(cnTheme.radii.md),
                      ),
                      child: Row(
                        spacing: 10,
                        children: [
                          Icon(
                            destination.icon,
                            size: 18,
                            color: isSelected
                                ? colors.sidebarAccentForeground
                                : colors.mutedForeground,
                          ),
                          Expanded(
                            child: Text(
                              destination.label,
                              style: CnTheme.of(context).text.sm.copyWith(
                                color: isSelected
                                    ? colors.sidebarAccentForeground
                                    : colors.sidebarForeground,
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
