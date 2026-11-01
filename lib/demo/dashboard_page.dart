import 'package:material_ui/material_ui.dart';

import '../cn_ui.dart';
import 'dashboard_data.dart';

/// A rebuild of the shadcn/ui block dashboard-01.
class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  bool _sidebarVisible = true;
  int _range = 90;
  String _tab = 'outline';
  int _rowsPerPage = 10;
  int _page = 1;
  Set<String> _selection = {};
  Set<String> _hiddenColumns = {};

  @override
  Widget build(BuildContext context) {
    final colors = CnTheme.of(context).colors;

    Widget page(double inset) {
      return CnSidebarInset(
        child: Column(
          crossAxisAlignment: .stretch,
          children: [
            _SiteHeader(
              inset: inset,
              onToggleSidebar: () {
                setState(() => _sidebarVisible = !_sidebarVisible);
              },
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: inset, vertical: 24),
                child: Column(
                  crossAxisAlignment: .stretch,
                  spacing: 24,
                  children: [
                    const _SectionCards(),
                    _VisitorsChart(
                      range: _range,
                      onRangeChanged: (value) {
                        setState(() => _range = value);
                      },
                    ),
                    _DocumentsTable(
                      tab: _tab,
                      onTabChanged: (value) => setState(() => _tab = value),
                      rowsPerPage: _rowsPerPage,
                      onRowsPerPageChanged: (value) {
                        setState(() => _rowsPerPage = value);
                      },
                      page: _page,
                      onPageChanged: (value) => setState(() => _page = value),
                      selection: _selection,
                      onSelectionChanged: (value) {
                        setState(() => _selection = value);
                      },
                      hiddenColumns: _hiddenColumns,
                      onHiddenColumnsChanged: (value) {
                        setState(() => _hiddenColumns = value);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    return ColoredBox(
      color: colors.sidebar,
      child: CnResponsive(
        small: (context, _) => page(16),
        medium: (context, _) => Row(
          crossAxisAlignment: .stretch,
          children: [
            if (_sidebarVisible) const _AppSidebar(),
            Expanded(child: page(24)),
          ],
        ),
      ),
    );
  }
}

class _AppSidebar extends StatelessWidget {
  const _AppSidebar();

  @override
  Widget build(BuildContext context) {
    final theme = CnTheme.of(context);

    return CnSidebar(
      variant: .inset,
      expandedWidth: 240,
      child: Column(
        crossAxisAlignment: .stretch,
        spacing: 8,
        children: [
          CnSidebarHeader(
            child: Padding(
              padding: const .symmetric(horizontal: 8),
              child: Row(
                spacing: 8,
                children: [
                  const Icon(Icons.adjust, size: 20),
                  Text('Acme Inc.', style: theme.heading.base.semibold),
                ],
              ),
            ),
          ),
          Row(
            spacing: 8,
            children: [
              Expanded(
                child: CnButton(
                  size: .sm,
                  expand: true,
                  onPressed: () {},
                  leading: const Icon(Icons.add_circle),
                  child: const Text('Quick Create'),
                ),
              ),
              CnButton.icon(
                variant: .outline,
                size: .sm,
                onPressed: () {},
                icon: const Icon(Icons.mail_outline),
              ),
            ],
          ),
          const CnSidebarContent(
            spacing: 16,
            children: [
              CnSidebarGroup(
                children: [
                  CnSidebarItem(
                    leading: Icon(Icons.dashboard_outlined),
                    label: Text('Dashboard'),
                  ),
                  CnSidebarItem(
                    leading: Icon(Icons.list_alt),
                    label: Text('Lifecycle'),
                  ),
                  CnSidebarItem(
                    leading: Icon(Icons.bar_chart),
                    label: Text('Analytics'),
                  ),
                  CnSidebarItem(
                    leading: Icon(Icons.folder_outlined),
                    label: Text('Projects'),
                  ),
                  CnSidebarItem(
                    leading: Icon(Icons.people_outline),
                    label: Text('Team'),
                  ),
                ],
              ),
              CnSidebarGroup(
                title: Text('Documents'),
                children: [
                  CnSidebarItem(
                    leading: Icon(Icons.storage),
                    label: Text('Data Library'),
                  ),
                  CnSidebarItem(
                    leading: Icon(Icons.description_outlined),
                    label: Text('Reports'),
                  ),
                  CnSidebarItem(
                    leading: Icon(Icons.article_outlined),
                    label: Text('Word Assistant'),
                  ),
                  CnSidebarItem(
                    leading: Icon(Icons.more_horiz),
                    label: Text('More'),
                  ),
                ],
              ),
            ],
          ),
          const CnSidebarGroup(
            children: [
              CnSidebarItem(
                leading: Icon(Icons.settings_outlined),
                label: Text('Settings'),
              ),
              CnSidebarItem(
                leading: Icon(Icons.help_outline),
                label: Text('Get Help'),
              ),
              CnSidebarItem(leading: Icon(Icons.search), label: Text('Search')),
            ],
          ),
          CnSidebarFooter(
            child: CnItem(
              leading: const CnAvatar(child: Text('CN')),
              title: const Text('shadcn'),
              description: Text('m@example.com', style: theme.text.xs),
              trailing: CnDropdownMenu.builder(
                entries: [
                  CnMenuAction(label: const Text('Account'), onSelected: () {}),
                  CnMenuAction(label: const Text('Billing'), onSelected: () {}),
                  CnMenuAction(
                    label: const Text('Notifications'),
                    onSelected: () {},
                  ),
                  const CnMenuSeparator(),
                  CnMenuAction(label: const Text('Log out'), onSelected: () {}),
                ],
                builder: (context, toggle) => CnButton.icon(
                  variant: .ghost,
                  size: .xs,
                  onPressed: toggle,
                  icon: const Icon(Icons.more_vert),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SiteHeader extends StatelessWidget {
  const _SiteHeader({required this.inset, required this.onToggleSidebar});
  final double inset;
  final VoidCallback onToggleSidebar;

  @override
  Widget build(BuildContext context) {
    final theme = CnTheme.of(context);

    return Container(
      height: 48,
      padding: EdgeInsets.symmetric(horizontal: inset),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: theme.colors.border)),
      ),
      child: Row(
        spacing: 8,
        children: [
          CnButton.icon(
            variant: .ghost,
            size: .xs,
            onPressed: onToggleSidebar,
            icon: const Icon(Icons.view_sidebar_outlined),
          ),
          const CnSeparator(direction: .vertical, length: 16),
          Text('Documents', style: theme.heading.base.medium),
          const Spacer(),
          CnButton(
            variant: .ghost,
            size: .sm,
            onPressed: () {},
            child: const Text('GitHub'),
          ),
        ],
      ),
    );
  }
}

class _SectionCards extends StatelessWidget {
  const _SectionCards();

  static const _cards = [
    _MetricCard(
      title: 'Total Revenue',
      value: r'$1,250.00',
      delta: '+12.5%',
      headline: 'Trending up this month',
      subtext: 'Visitors for the last 6 months',
    ),
    _MetricCard(
      title: 'New Customers',
      value: '1,234',
      delta: '-20%',
      headline: 'Down 20% this period',
      subtext: 'Acquisition needs attention',
    ),
    _MetricCard(
      title: 'Active Accounts',
      value: '45,678',
      delta: '+12.5%',
      headline: 'Strong user retention',
      subtext: 'Engagement exceed targets',
    ),
    _MetricCard(
      title: 'Growth Rate',
      value: '4.5%',
      delta: '+4.5%',
      headline: 'Steady performance increase',
      subtext: 'Meets growth projections',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return CnResponsive(
      small: (context, _) => const _CardGrid(columns: 1, children: _cards),
      medium: (context, _) => const _CardGrid(columns: 2, children: _cards),
      large: (context, _) => const _CardGrid(columns: 4, children: _cards),
    );
  }
}

/// Equally wide and, per row, equally high children.
class const _CardGrid({
  required final int columns,
  required final List<Widget> children,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .stretch,
      spacing: 16,
      children: [
        for (var i = 0; i < children.length; i += columns)
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: .stretch,
              spacing: 16,
              children: [
                for (final child in children.skip(i).take(columns))
                  Expanded(child: child),
              ],
            ),
          ),
      ],
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.title,
    required this.value,
    required this.delta,
    required this.headline,
    required this.subtext,
  });
  final String title;
  final String value;
  final String delta;
  final String headline;
  final String subtext;

  @override
  Widget build(BuildContext context) {
    final theme = CnTheme.of(context);
    final colors = theme.colors;
    final trend = Icon(
      delta.startsWith('-') ? Icons.trending_down : Icons.trending_up,
    );

    return CnCard(
      title: Column(
        crossAxisAlignment: .start,
        spacing: 6,
        children: [
          Text(
            title,
            style: theme.text.sm.copyWith(color: colors.mutedForeground),
          ),
          Text(value, style: theme.heading.xl3.semibold),
        ],
      ),
      action: CnBadge(variant: .outline, leading: trend, child: Text(delta)),
      footer: Column(
        crossAxisAlignment: .start,
        spacing: 6,
        children: [
          Row(
            spacing: 8,
            children: [
              Flexible(child: Text(headline, style: theme.text.sm.medium)),
              IconTheme.merge(
                data: IconThemeData(size: 16, color: colors.foreground),
                child: trend,
              ),
            ],
          ),
          Text(
            subtext,
            style: theme.text.sm.copyWith(color: colors.mutedForeground),
          ),
        ],
      ),
    );
  }
}

class _VisitorsChart extends StatelessWidget {
  const _VisitorsChart({required this.range, required this.onRangeChanged});
  final int range;
  final ValueChanged<int> onRangeChanged;

  static const _ranges = {
    90: 'Last 3 months',
    30: 'Last 30 days',
    7: 'Last 7 days',
  };

  @override
  Widget build(BuildContext context) {
    final colors = CnTheme.of(context).colors;
    final data = visitorData.sublist(visitorData.length - range);

    Widget card(Widget action) => CnCard(
      title: const Text('Total Visitors'),
      description: Text('Total for the ${_ranges[range]!.toLowerCase()}'),
      action: action,
      content: CnChart(
        height: 250,
        showLegend: false,
        stacked: true,
        curved: true,
        series: [
          CnChartSeries(
            name: 'Mobile',
            type: .area,
            showPoints: false,
            lineWidth: 1,
            color: colors.primary,
            data: [
              for (final (label, _, mobile) in data)
                CnChartPoint(label, mobile),
            ],
          ),
          CnChartSeries(
            name: 'Desktop',
            type: .area,
            showPoints: false,
            lineWidth: 1,
            color: colors.primary,
            data: [
              for (final (label, desktop, _) in data)
                CnChartPoint(label, desktop),
            ],
          ),
        ],
      ),
    );

    return CnResponsive(
      small: (context, _) => card(
        SizedBox(
          width: 160,
          child: CnSelect<int>(
            size: .sm,
            value: range,
            items: [
              for (final MapEntry(:key, :value) in _ranges.entries)
                CnSelectItem(value: key, child: Text(value)),
            ],
            onChanged: (value) {
              if (value != null) {
                onRangeChanged(value);
              }
            },
          ),
        ),
      ),
      medium: (context, _) => card(
        _RangeSelect(value: range, ranges: _ranges, onChanged: onRangeChanged),
      ),
    );
  }
}

class const _RangeSelect({
  required final int value,
  required final Map<int, String> ranges,
  required final ValueChanged<int> onChanged,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CnToggleGroup<int>(
      spacing: 0,
      required: true,
      variant: .outline,
      value: {value},
      onChanged: (next) {
        if (next.isNotEmpty) {
          onChanged(next.first);
        }
      },
      items: [
        for (final MapEntry(:key, value: label) in ranges.entries)
          CnToggleGroupItem(value: key, child: Text(label)),
      ],
    );
  }
}

class _DocumentsTable extends StatelessWidget {
  const _DocumentsTable({
    required this.tab,
    required this.onTabChanged,
    required this.rowsPerPage,
    required this.onRowsPerPageChanged,
    required this.page,
    required this.onPageChanged,
    required this.selection,
    required this.onSelectionChanged,
    required this.hiddenColumns,
    required this.onHiddenColumnsChanged,
  });
  final String tab;
  final ValueChanged<String> onTabChanged;
  final int rowsPerPage;
  final ValueChanged<int> onRowsPerPageChanged;
  final int page;
  final ValueChanged<int> onPageChanged;
  final Set<String> selection;
  final ValueChanged<Set<String>> onSelectionChanged;
  final Set<String> hiddenColumns;
  final ValueChanged<Set<String>> onHiddenColumnsChanged;

  static const _hideable = {
    'type': 'Section Type',
    'status': 'Status',
    'target': 'Target',
    'limit': 'Limit',
    'reviewer': 'Reviewer',
  };

  @override
  Widget build(BuildContext context) {
    return CnResponsive(
      small: (context, _) => _build(context, compact: true),
      large: (context, _) => _build(context, compact: false),
    );
  }

  Widget _build(BuildContext context, {required bool compact}) {
    Widget label(String text, int count) {
      return Row(
        mainAxisSize: .min,
        spacing: 6,
        children: [
          Text(text),
          CnBadge(variant: .secondary, child: Text('$count')),
        ],
      );
    }

    return CnTabs<String>(
      value: tab,
      onChanged: onTabChanged,
      trailing: Row(
        mainAxisSize: .min,
        spacing: 8,
        children: [
          CnDropdownMenu.builder(
            width: 224,
            entries: [
              for (final MapEntry(:key, :value) in _hideable.entries)
                CnMenuCheckboxItem(
                  label: Text(value),
                  value: !hiddenColumns.contains(key),
                  onChanged: (visible) => onHiddenColumnsChanged(
                    visible
                        ? ({...hiddenColumns}..remove(key))
                        : {...hiddenColumns, key},
                  ),
                ),
            ],
            builder: (context, toggle) => CnButton(
              variant: .outline,
              size: .sm,
              onPressed: toggle,
              leading: const Icon(Icons.view_column_outlined),
              trailing: const Icon(Icons.expand_more),
              child: Text(compact ? 'Columns' : 'Customize Columns'),
            ),
          ),
          CnButton(
            variant: .outline,
            size: .sm,
            onPressed: () {},
            leading: const Icon(Icons.add),
            child: const Text('Add Section'),
          ),
        ],
      ),
      tabs: [
        CnTab(
          value: 'outline',
          label: const Text('Outline'),
          content: _buildTable(),
        ),
        CnTab(
          value: 'performance',
          label: label('Past Performance', 3),
          content: const _Placeholder(),
        ),
        CnTab(
          value: 'personnel',
          label: label('Key Personnel', 2),
          content: const _Placeholder(),
        ),
        CnTab(
          value: 'focus',
          label: const Text('Focus Documents'),
          content: const _Placeholder(),
        ),
      ],
    );
  }

  Widget _buildTable() {
    return CnDataTable<DocumentRow>(
      rows: documentRows,
      rowId: (row) => row.id,
      mutedHeader: true,
      selection: selection,
      onSelectionChanged: onSelectionChanged,
      hiddenColumns: hiddenColumns,
      page: page,
      onPageChanged: onPageChanged,
      rowsPerPage: rowsPerPage,
      rowsPerPageOptions: const [10, 20, 30, 40, 50],
      onRowsPerPageChanged: onRowsPerPageChanged,
      actionsColumnWidth: const FixedColumnWidth(48),
      rowActionsBuilder: (context, row) => CnDropdownMenu.builder(
        width: 144,
        entries: [
          CnMenuAction(label: const Text('Edit'), onSelected: () {}),
          CnMenuAction(label: const Text('Make a copy'), onSelected: () {}),
          CnMenuAction(label: const Text('Favorite'), onSelected: () {}),
          const CnMenuSeparator(),
          CnMenuAction(
            label: const Text('Delete'),
            role: .destructive,
            onSelected: () {},
          ),
        ],
        builder: (context, toggle) => CnButton.icon(
          variant: .ghost,
          size: .sm,
          onPressed: toggle,
          icon: const Icon(Icons.more_vert),
        ),
      ),
      columns: [
        CnDataTableColumn(
          id: 'header',
          label: const Text('Header'),
          cellBuilder: (context, row) =>
              Text(row.header, style: CnTheme.of(context).text.sm.medium),
        ),
        CnDataTableColumn(
          id: 'type',
          label: const Text('Section Type'),
          cellBuilder: (context, row) =>
              CnBadge(variant: .outline, child: Text(row.type)),
        ),
        CnDataTableColumn(
          id: 'status',
          label: const Text('Status'),
          cellBuilder: (context, row) => _StatusBadge(status: row.status),
        ),
        CnDataTableColumn(
          id: 'target',
          label: const Text('Target'),
          numeric: true,
          cellBuilder: (context, row) => Text(row.target),
        ),
        CnDataTableColumn(
          id: 'limit',
          label: const Text('Limit'),
          numeric: true,
          cellBuilder: (context, row) => Text(row.limit),
        ),
        CnDataTableColumn(
          id: 'reviewer',
          label: const Text('Reviewer'),
          cellBuilder: (context, row) => row.reviewer == 'Assign reviewer'
              ? const _ReviewerSelect()
              : Text(row.reviewer),
        ),
      ],
    );
  }
}

class const _StatusBadge({required final String status})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = CnTheme.of(context).colors;

    return CnBadge(
      variant: .outline,
      leading: status == 'Done'
          ? Icon(Icons.check_circle, color: colors.success)
          : Icon(Icons.autorenew, color: colors.mutedForeground),
      child: Text(status),
    );
  }
}

class _ReviewerSelect extends StatefulWidget {
  const _ReviewerSelect();

  @override
  State<_ReviewerSelect> createState() => _ReviewerSelectState();
}

class _ReviewerSelectState extends State<_ReviewerSelect> {
  String? reviewer;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 176,
      child: CnSelect<String>(
        size: .sm,
        value: reviewer,
        placeholder: 'Assign reviewer',
        items: const [
          CnSelectItem(value: 'Eddie Lake', child: Text('Eddie Lake')),
          CnSelectItem(
            value: 'Jamik Tashpulatov',
            child: Text('Jamik Tashpulatov'),
          ),
        ],
        onChanged: (value) => setState(() => reviewer = value),
      ),
    );
  }
}

class const _Placeholder() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = CnTheme.of(context);

    return Container(
      height: 320,
      decoration: BoxDecoration(
        color: theme.colors.muted.withValues(alpha: 0.3),
        borderRadius: .circular(theme.radii.lg),
        border: Border.all(color: theme.colors.border),
      ),
    );
  }
}
