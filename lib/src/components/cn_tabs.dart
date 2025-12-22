import 'package:flutter/material.dart';

/// A tabbed navigation component for switching between different content views.
///
/// Wraps Flutter's TabBar and TabBarView with a simple interface for tab navigation.
///
/// See also:
///
///  * [CnToggleGroup], for toggle-based selection.
///  * [CnNavigationMenu], for menu-based navigation.
class CnTabs extends StatelessWidget {
  final List<CnTab> tabs;
  final int initialIndex;
  final bool isScrollable;
  final double? contentHeight;

  const CnTabs({
    super.key,
    required this.tabs,
    this.initialIndex = 0,
    this.isScrollable = false,
    this.contentHeight,
  });

  @override
  Widget build(BuildContext context) {
    final tabBar = TabBar(
      isScrollable: isScrollable,
      tabs: [for (final tab in tabs) Tab(text: tab.label)],
    );

    final tabView = TabBarView(children: [for (final tab in tabs) tab.child]);
    final height = contentHeight ?? 160;

    return DefaultTabController(
      length: tabs.length,
      initialIndex: initialIndex,
      child: Column(
        crossAxisAlignment: .start,
        spacing: 12,
        children: [
          tabBar,
          SizedBox(height: height, child: tabView),
        ],
      ),
    );
  }
}

/// A tab entry in [CnTabs].
class CnTab {
  final String label;
  final Widget child;

  const CnTab({required this.label, required this.child});
}
