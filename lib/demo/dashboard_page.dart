import 'package:flutter/material.dart';

import '../cn_ui.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String _range = '3m';
  String _section = 'outline';
  int _rowsPerPage = 10;

  @override
  Widget build(BuildContext context) {
    final scheme = CnTheme.colorSchemeOf(context);
    final cnTheme = CnTheme.of(context);

    return Container(
      color: scheme.surface,
      child: Row(
        crossAxisAlignment: .start,
        children: [
          SizedBox(
            width: 240,
            child: CnSidebar(
              expandedWidth: 240,
              collapsedWidth: 240,
              padding: const EdgeInsets.all(16),
              backgroundColor: scheme.surface,
              borderColor: scheme.outlineVariant,
              child: Column(
                crossAxisAlignment: .stretch,
                spacing: 12,
                children: [
                  CnSidebarHeader(
                    child: Row(
                      mainAxisAlignment: .spaceBetween,
                      children: [
                        Row(
                          spacing: 8,
                          children: [
                            Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                color: scheme.onSurface,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.circle,
                                size: 12,
                                color: scheme.surface,
                              ),
                            ),
                            Text(
                              'Acme Inc.',
                              style: CnTheme.textThemeOf(context).titleSmall,
                            ),
                          ],
                        ),
                        Icon(
                          Icons.mail_outline,
                          size: 18,
                          color: scheme.onSurfaceVariant,
                        ),
                      ],
                    ),
                  ),
                  CnButton(
                    variant: .secondary,
                    fullWidth: true,
                    size: .sm,
                    onPressed: () {},
                    leading: const Icon(Icons.add, size: 16),
                    child: const Text('Quick Create'),
                  ),
                  CnSidebarContent(
                    children: [
                      CnSidebarGroup(
                        children: const [
                          CnSidebarItem(
                            icon: Icon(Icons.dashboard_outlined),
                            label: Text('Dashboard'),
                            selected: true,
                          ),
                          CnSidebarItem(
                            icon: Icon(Icons.timer_outlined),
                            label: Text('Lifecycle'),
                          ),
                          CnSidebarItem(
                            icon: Icon(Icons.insights_outlined),
                            label: Text('Analytics'),
                          ),
                          CnSidebarItem(
                            icon: Icon(Icons.folder_outlined),
                            label: Text('Projects'),
                          ),
                          CnSidebarItem(
                            icon: Icon(Icons.people_outline),
                            label: Text('Team'),
                          ),
                        ],
                      ),
                      const CnSidebarSeparator(),
                      CnSidebarGroup(
                        title: 'Documents',
                        children: [
                          Column(
                            crossAxisAlignment: .stretch,
                            spacing: 4,
                            children: const [
                              CnSidebarItem(
                                icon: Icon(Icons.layers_outlined),
                                label: Text('Data Library'),
                              ),
                              CnSidebarItem(
                                icon: Icon(Icons.insert_chart_outlined),
                                label: Text('Reports'),
                              ),
                              CnSidebarItem(
                                icon: Icon(Icons.auto_awesome_outlined),
                                label: Text('Word Assistant'),
                              ),
                              CnSidebarItem(
                                icon: Icon(Icons.more_horiz),
                                label: Text('More'),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const CnSidebarSeparator(),
                      CnSidebarGroup(
                        children: const [
                          CnSidebarItem(
                            icon: Icon(Icons.settings_outlined),
                            label: Text('Settings'),
                          ),
                          CnSidebarItem(
                            icon: Icon(Icons.help_outline),
                            label: Text('Get Help'),
                          ),
                          CnSidebarItem(
                            icon: Icon(Icons.search),
                            label: Text('Search'),
                          ),
                        ],
                      ),
                    ],
                  ),
                  CnSidebarFooter(
                    child: CnContextMenu(
                      entries: [
                        CnDropdownMenuAction(
                          label: 'Account',
                          onSelected: () {},
                        ),
                        CnDropdownMenuAction(
                          label: 'Billing',
                          onSelected: () {},
                        ),
                        CnDropdownMenuAction(
                          label: 'Notifications',
                          onSelected: () {},
                        ),
                        const CnDropdownMenuSeparator(),
                        CnDropdownMenuAction(
                          label: 'Log out',
                          role: .destructive,
                          onSelected: () {},
                        ),
                      ],
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: scheme.surface,
                          borderRadius: BorderRadius.circular(cnTheme.radius),
                          border: Border.all(color: scheme.outlineVariant),
                        ),
                        child: Row(
                          spacing: 10,
                          children: [
                            const CnAvatar(initials: 'SD', size: 32),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: .start,
                                spacing: 2,
                                children: [
                                  Text(
                                    'shadcn',
                                    style: CnTheme.textThemeOf(
                                      context,
                                    ).titleSmall,
                                  ),
                                  Text(
                                    'me@acme.com',
                                    style: CnTheme.textThemeOf(context)
                                        .bodySmall
                                        ?.copyWith(
                                          color: scheme.onSurfaceVariant,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            CnContextMenu(
                              entries: [
                                CnDropdownMenuAction(
                                  label: 'Account',
                                  onSelected: () {},
                                ),
                                CnDropdownMenuAction(
                                  label: 'Billing',
                                  onSelected: () {},
                                ),
                                CnDropdownMenuAction(
                                  label: 'Notifications',
                                  onSelected: () {},
                                ),
                                const CnDropdownMenuSeparator(),
                                CnDropdownMenuAction(
                                  label: 'Log out',
                                  role: .destructive,
                                  onSelected: () {},
                                ),
                              ],
                              child: Icon(
                                Icons.more_vert,
                                color: scheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(32, 24, 32, 48),
              child: Column(
                crossAxisAlignment: .start,
                spacing: 24,
                children: [
                  Row(
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      Row(
                        spacing: 12,
                        children: [
                          Icon(
                            Icons.folder_open_outlined,
                            size: 18,
                            color: scheme.onSurfaceVariant,
                          ),
                          const CnSeparator(direction: .vertical, length: 16),
                          Text(
                            'Documents',
                            style: CnTheme.textThemeOf(context).titleMedium,
                          ),
                        ],
                      ),
                      CnButton(
                        variant: .ghost,
                        size: .sm,
                        onPressed: () {},
                        child: const Text('GitHub'),
                      ),
                    ],
                  ),
                  const _SummaryRow(),
                  _VisitorsChart(
                    range: _range,
                    onRangeChanged: (value) => setState(() => _range = value),
                  ),
                  _SectionTable(
                    selectedTab: _section,
                    onTabChanged: (value) => setState(() => _section = value),
                    rowsPerPage: _rowsPerPage,
                    onRowsPerPageChanged: (value) {
                      setState(() => _rowsPerPage = value);
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
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow();

  @override
  Widget build(BuildContext context) {
    final scheme = CnTheme.colorSchemeOf(context);

    return IntrinsicHeight(
      child: Row(
        spacing: 16,
        children: [
          Expanded(
            child: _MetricCard(
              title: 'Total Revenue',
              value: r'$1,250.00',
              delta: '+12.5%',
              deltaColor: scheme.primary,
              headline: 'Trending up this month',
              subtext: 'Visitors for the last 6 months',
            ),
          ),
          Expanded(
            child: _MetricCard(
              title: 'New Customers',
              value: '1,234',
              delta: '-20%',
              deltaColor: scheme.error,
              headline: 'Down 20% this period',
              subtext: 'Acquisition needs attention',
            ),
          ),
          Expanded(
            child: _MetricCard(
              title: 'Active Accounts',
              value: '45,678',
              delta: '+12.5%',
              deltaColor: scheme.primary,
              headline: 'Strong user retention',
              subtext: 'Engagement exceeds targets',
            ),
          ),
          Expanded(
            child: _MetricCard(
              title: 'Growth Rate',
              value: '4.5%',
              delta: '+4.5%',
              deltaColor: scheme.primary,
              headline: 'Steady performance increase',
              subtext: 'Meets growth projections',
            ),
          ),
        ],
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  final String title;
  final String value;
  final String delta;
  final Color deltaColor;
  final String headline;
  final String subtext;

  const _MetricCard({
    required this.title,
    required this.value,
    required this.delta,
    required this.deltaColor,
    required this.headline,
    required this.subtext,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = CnTheme.colorSchemeOf(context);

    return CnCard(
      padding: const EdgeInsets.all(16),
      header: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          Expanded(
            child: Text(
              title,
              style: CnTheme.textThemeOf(
                context,
              ).bodySmall?.copyWith(color: scheme.onSurfaceVariant),
            ),
          ),
          CnBadge(
            variant: .outline,
            child: Row(
              mainAxisSize: .min,
              spacing: 4,
              children: [
                Icon(
                  delta.startsWith('-')
                      ? Icons.arrow_downward
                      : Icons.arrow_upward,
                  size: 12,
                  color: deltaColor,
                ),
                Text(
                  delta,
                  style: CnTheme.textThemeOf(
                    context,
                  ).labelSmall?.copyWith(color: deltaColor),
                ),
              ],
            ),
          ),
        ],
      ),
      content: Column(
        crossAxisAlignment: .start,
        spacing: 10,
        children: [
          Text(value, style: CnTheme.textThemeOf(context).headlineSmall),
          Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              Flexible(
                child: Text(
                  headline,
                  style: CnTheme.textThemeOf(
                    context,
                  ).bodySmall?.copyWith(fontWeight: .w600),
                ),
              ),
              Icon(
                delta.startsWith('-') ? Icons.trending_down : Icons.trending_up,
                size: 14,
                color: scheme.onSurfaceVariant,
              ),
            ],
          ),
          Text(
            subtext,
            style: CnTheme.textThemeOf(
              context,
            ).bodySmall?.copyWith(color: scheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}

class _VisitorsChart extends StatelessWidget {
  final String range;
  final ValueChanged<String> onRangeChanged;

  const _VisitorsChart({required this.range, required this.onRangeChanged});

  @override
  Widget build(BuildContext context) {
    final scheme = CnTheme.colorSchemeOf(context);

    return CnCard(
      padding: const EdgeInsets.all(16),
      header: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          Column(
            crossAxisAlignment: .start,
            spacing: 4,
            children: [
              Text(
                'Total Visitors',
                style: CnTheme.textThemeOf(context).titleMedium,
              ),
              Text(
                'Total for the last 3 months',
                style: CnTheme.textThemeOf(context).bodySmall,
              ),
            ],
          ),
          CnToggleGroup(
            joined: true,
            allowEmpty: false,
            size: .sm,
            variant: .outline,
            selectedValues: {range},
            onChanged: (value) {
              if (value.isNotEmpty) {
                onRangeChanged(value.first.toString());
              }
            },
            items: const [
              CnToggleGroupItem(value: '3m', child: Text('Last 3 months')),
              CnToggleGroupItem(value: '30d', child: Text('Last 30 days')),
              CnToggleGroupItem(value: '7d', child: Text('Last 7 days')),
            ],
          ),
        ],
      ),
      content: CnChart(
        height: 240,
        showLegend: false,
        series: [
          CnChartSeries(
            name: 'Total',
            type: .area,
            showPoints: false,
            color: scheme.onSurfaceVariant,
            fillColor: scheme.onSurfaceVariant.withValues(alpha: 0.22),
            data: const [
              CnChartPoint('Apr 5', 22),
              CnChartPoint('Apr 12', 38),
              CnChartPoint('Apr 19', 26),
              CnChartPoint('Apr 26', 44),
              CnChartPoint('May 3', 28),
              CnChartPoint('May 10', 50),
              CnChartPoint('May 17', 34),
              CnChartPoint('May 24', 47),
              CnChartPoint('May 31', 32),
              CnChartPoint('Jun 7', 53),
              CnChartPoint('Jun 14', 36),
              CnChartPoint('Jun 21', 48),
              CnChartPoint('Jun 30', 42),
            ],
          ),
          CnChartSeries(
            name: 'Returning',
            type: .line,
            showPoints: false,
            color: scheme.onSurface,
            data: const [
              CnChartPoint('Apr 5', 10),
              CnChartPoint('Apr 12', 16),
              CnChartPoint('Apr 19', 12),
              CnChartPoint('Apr 26', 18),
              CnChartPoint('May 3', 14),
              CnChartPoint('May 10', 20),
              CnChartPoint('May 17', 15),
              CnChartPoint('May 24', 19),
              CnChartPoint('May 31', 16),
              CnChartPoint('Jun 7', 22),
              CnChartPoint('Jun 14', 17),
              CnChartPoint('Jun 21', 21),
              CnChartPoint('Jun 30', 18),
            ],
          ),
        ],
      ),
    );
  }
}

class _SectionTable extends StatelessWidget {
  final String selectedTab;
  final ValueChanged<String> onTabChanged;
  final int rowsPerPage;
  final ValueChanged<int> onRowsPerPageChanged;

  const _SectionTable({
    required this.selectedTab,
    required this.onTabChanged,
    required this.rowsPerPage,
    required this.onRowsPerPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = CnTheme.colorSchemeOf(context);
    return Column(
      crossAxisAlignment: .start,
      spacing: 12,
      children: [
        Row(
          mainAxisAlignment: .spaceBetween,
          crossAxisAlignment: .center,
          children: [
            CnToggleGroup(
              joined: true,
              allowEmpty: false,
              size: .sm,
              variant: .outline,
              selectedValues: {selectedTab},
              onChanged: (value) {
                if (value.isNotEmpty) {
                  onTabChanged(value.first.toString());
                }
              },
              items: const [
                CnToggleGroupItem(value: 'outline', child: Text('Outline')),
                CnToggleGroupItem(
                  value: 'performance',
                  child: Row(
                    mainAxisSize: .min,
                    spacing: 4,
                    children: [
                      Text('Past Performance'),
                      CnBadge(variant: .secondary, child: Text('3')),
                    ],
                  ),
                ),
                CnToggleGroupItem(
                  value: 'personnel',
                  child: Row(
                    mainAxisSize: .min,
                    spacing: 4,
                    children: [
                      Text('Key Personnel'),
                      CnBadge(variant: .secondary, child: Text('2')),
                    ],
                  ),
                ),
                CnToggleGroupItem(
                  value: 'focus',
                  child: Text('Focus Documents'),
                ),
              ],
            ),
            Row(
              spacing: 8,
              children: [
                CnButton(
                  variant: .outline,
                  size: .sm,
                  onPressed: () {},
                  child: const Row(
                    mainAxisSize: .min,
                    spacing: 4,
                    children: [
                      Icon(Icons.tune, size: 16),
                      Text('Customize Columns'),
                      Icon(Icons.expand_more, size: 16),
                    ],
                  ),
                ),
                CnButton(
                  size: .sm,
                  onPressed: () {},
                  child: const Row(
                    mainAxisSize: .min,
                    spacing: 4,
                    children: [Icon(Icons.add, size: 16), Text('Add Section')],
                  ),
                ),
              ],
            ),
          ],
        ),
        CnCard(
          padding: .zero,
          content: CnDataTable<_DocumentRow>(
            columns: [
              CnDataTableColumn<_DocumentRow>(
                id: 'section',
                label: const Text('Section'),
                cellBuilder: (context, row) => Text(row.section),
              ),
              CnDataTableColumn<_DocumentRow>(
                id: 'type',
                label: const Text('Section Type'),
                cellBuilder: (context, row) =>
                    CnBadge(variant: .outline, child: Text(row.type)),
              ),
              CnDataTableColumn<_DocumentRow>(
                id: 'limit',
                label: const Text('Limit'),
                numeric: true,
                cellBuilder: (context, row) => Text(row.limit.toString()),
              ),
              CnDataTableColumn<_DocumentRow>(
                id: 'owner',
                label: const Text('Owner'),
                alignment: Alignment.centerRight,
                cellBuilder: (context, row) => Text(row.owner),
              ),
            ],
            rows: _documentRows,
            rowId: (row) => row.id,
            enableSelection: true,
            rowsPerPage: rowsPerPage,
            rowsPerPageOptions: const [10, 20, 30],
            onRowsPerPageChanged: onRowsPerPageChanged,
            rowActionsBuilder: (context, row) => Align(
              alignment: Alignment.centerRight,
              child: CnDropdownMenu(
                entries: [
                  CnDropdownMenuAction(label: 'Open', onSelected: () {}),
                  CnDropdownMenuAction(label: 'Rename', onSelected: () {}),
                  CnDropdownMenuAction(label: 'Duplicate', onSelected: () {}),
                  const CnDropdownMenuSeparator(),
                  CnDropdownMenuAction(
                    label: 'Delete',
                    role: .destructive,
                    onSelected: () {},
                  ),
                ],
                trigger: Icon(
                  Icons.more_horiz,
                  size: 18,
                  color: scheme.onSurfaceVariant,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _DocumentRow {
  final String id;
  final String section;
  final String type;
  final int limit;
  final String owner;

  const _DocumentRow({
    required this.id,
    required this.section,
    required this.type,
    required this.limit,
    required this.owner,
  });
}

final List<_DocumentRow> _documentRows = List.generate(68, (index) {
  const sections = [
    "Overview of EMR's Innovative Solutions",
    'Advanced Algorithms and Machine Learning',
    'Strategic Research Initiatives',
    'Customer Success Playbook',
    'Product Launch Checklist',
    'Cloud Migration Plan',
    'Market Expansion Brief',
    'Competitive Analysis',
    'Operational Review',
    'Technical Architecture',
  ];
  const types = [
    'Technical content',
    'Narrative',
    'Outline',
    'Cover page',
    'Brief',
  ];
  const owners = ['shadcn', 'team', 'design', 'growth', 'ops'];

  return _DocumentRow(
    id: 'doc_$index',
    section: sections[index % sections.length],
    type: types[index % types.length],
    limit: 8 + (index % 24),
    owner: owners[index % owners.length],
  );
});
