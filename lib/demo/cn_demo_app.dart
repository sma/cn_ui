import 'package:flutter/material.dart';

import '../cn_ui.dart';
import 'component_catalog.dart';
import 'component_index_page.dart';
import 'dashboard_page.dart';
import 'component_page.dart';
import 'demo_scaffold.dart';
import 'home_page.dart';
import 'theme_playground.dart';

class CnDemoApp extends StatefulWidget {
  const CnDemoApp({super.key});

  @override
  State<CnDemoApp> createState() => _CnDemoAppState();
}

class _CnDemoAppState extends State<CnDemoApp> {
  int selectedIndex = 0;
  CnTheme theme = const CnTheme();

  @override
  Widget build(BuildContext context) {
    final destinations = _buildDestinations();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme.toThemeData(),
      home: CnDemoScaffold(
        destinations: destinations,
        selectedIndex: selectedIndex,
        onSelected: (index) => setState(() => selectedIndex = index),
      ),
    );
  }

  List<DemoDestination> _buildDestinations() {
    final componentOffset = 4;
    return [
      DemoDestination(
        label: 'Overview',
        icon: Icons.auto_awesome_mosaic_outlined,
        page: HomePage(
          onBrowseComponents: () => setState(() => selectedIndex = 2),
          onViewThemeTokens: () => setState(() => selectedIndex = 1),
        ),
      ),
      DemoDestination(
        label: 'Theme',
        icon: Icons.palette_outlined,
        page: ThemePlayground(
          theme: theme,
          onChanged: (next) => setState(() => theme = next),
        ),
      ),
      DemoDestination(
        label: 'Components',
        icon: Icons.widgets_outlined,
        page: ComponentIndexPage(
          entries: componentCatalog,
          onSelect: (index) =>
              setState(() => selectedIndex = componentOffset + index),
        ),
      ),
      const DemoDestination(
        label: 'Dashboard',
        icon: Icons.space_dashboard_outlined,
        page: DashboardPage(),
      ),
      ...componentCatalog.map(
        (entry) => DemoDestination(
          label: entry.name,
          icon: Icons.circle_outlined,
          page: ComponentPage(entry: entry),
        ),
      ),
    ];
  }
}
