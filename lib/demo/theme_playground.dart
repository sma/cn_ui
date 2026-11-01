import 'package:material_ui/material_ui.dart';

import '../cn_ui.dart';

class ThemePlayground extends StatelessWidget {
  const ThemePlayground({
    super.key,
    required this.theme,
    required this.onChanged,
  });
  final CnTheme theme;
  final ValueChanged<CnTheme> onChanged;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const .symmetric(horizontal: 28, vertical: 24),
      child: Column(
        crossAxisAlignment: .start,
        spacing: 8,
        children: [
          Text(
            'Theme Playground',
            style: CnTheme.of(context).text.xl2.semibold,
          ),
          Text(
            'Tune the tokens used by every component. This mirrors the '
            'shadcn/ui create flow, but as Flutter-native config.',
            style: CnTheme.of(context).text.base,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              crossAxisAlignment: .start,
              spacing: 24,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: .start,
                    spacing: 16,
                    children: const [
                      _TokenSurfacePreview(),
                      _TokenControlsPreview(),
                      _TokenMenuPreview(),
                      _TokenDataPreview(),
                      _TokenOverlayPreview(),
                    ],
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: .start,
                    spacing: 16,
                    children: [
                      _Section(
                        title: 'Tokens',
                        child: Column(
                          crossAxisAlignment: .start,
                          spacing: 16,
                          children: [
                            _TokenCard(
                              title: 'Mode',
                              child: SegmentedButton<Brightness>(
                                segments: const [
                                  ButtonSegment(
                                    value: .light,
                                    label: Text('Light'),
                                  ),
                                  ButtonSegment(
                                    value: .dark,
                                    label: Text('Dark'),
                                  ),
                                ],
                                selected: {theme.colors.brightness},
                                onSelectionChanged: (value) {
                                  onChanged(
                                    theme.copyWith(
                                      colors: value.first == .dark
                                          ? CnColors.dark
                                          : CnColors.light,
                                    ),
                                  );
                                },
                              ),
                            ),
                            _TokenCard(
                              title: 'Primary Color',
                              child: _PrimarySelect(
                                colors: theme.colors,
                                onChanged: (colors) =>
                                    onChanged(theme.copyWith(colors: colors)),
                              ),
                            ),
                            _TokenCard(
                              title: 'Font Family',
                              child: _FontSelect(
                                value: theme.fontFamily,
                                onChanged: (value) => onChanged(
                                  theme.copyWith(fontFamily: value),
                                ),
                              ),
                            ),
                            _TokenCard(
                              title: 'Border Radius',
                              child: Column(
                                crossAxisAlignment: .start,
                                spacing: 8,
                                children: [
                                  Text('${theme.radius.toStringAsFixed(0)} px'),
                                  CnSlider(
                                    value: theme.radius,
                                    min: 0,
                                    max: 20,
                                    divisions: 20,
                                    onChanged: (value) => onChanged(
                                      theme.copyWith(radius: value),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.child});
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      spacing: 12,
      children: [
        Text(title, style: CnTheme.of(context).text.lg.semibold),
        child,
      ],
    );
  }
}

class _TokenCard extends StatelessWidget {
  const _TokenCard({required this.title, required this.child});
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      child: CnCard(
        title: Text(title, style: CnTheme.of(context).text.base.semibold),
        content: child,
      ),
    );
  }
}

class _ColorOption {
  const _ColorOption(this.label, this.color);
  final String label;
  final Color color;
}

class _PrimarySelect extends StatelessWidget {
  const _PrimarySelect({required this.colors, required this.onChanged});
  final CnColors colors;
  final ValueChanged<CnColors> onChanged;

  @override
  Widget build(BuildContext context) {
    final base = colors.brightness == .dark ? CnColors.dark : CnColors.light;
    final options = [_ColorOption('Neutral', base.primary), ..._primaryColors];

    return CnSelect<int>(
      value: colors.primary.toARGB32(),
      items: [
        for (final option in options)
          CnSelectItem(
            value: option.color.toARGB32(),
            child: Row(
              spacing: 8,
              children: [
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: option.color,
                    shape: BoxShape.circle,
                    border: Border.all(color: colors.border),
                  ),
                ),
                Text(option.label),
              ],
            ),
          ),
      ],
      onChanged: (value) {
        if (value == null) {
          return;
        }
        onChanged(
          value == base.primary.toARGB32()
              ? base
              : base.copyWith(
                  primary: Color(value),
                  primaryForeground: const Color(0xFFFFFFFF),
                ),
        );
      },
    );
  }
}

class _FontSelect extends StatelessWidget {
  const _FontSelect({required this.value, required this.onChanged});
  final String value;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return CnSelect<String>(
      value: value,
      items: [
        for (final font in _fonts) CnSelectItem(value: font, child: Text(font)),
      ],
      onChanged: (value) {
        if (value != null) {
          onChanged(value);
        }
      },
    );
  }
}

class _TokenPreviewCard extends StatelessWidget {
  const _TokenPreviewCard({required this.title, required this.child});
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: CnCard(
        title: Text(title, style: CnTheme.of(context).text.base.semibold),
        content: child,
      ),
    );
  }
}

class _TokenSurfacePreview extends StatelessWidget {
  const _TokenSurfacePreview();

  @override
  Widget build(BuildContext context) {
    final colors = CnTheme.of(context).colors;

    return _TokenPreviewCard(
      title: 'Type & surface',
      child: Column(
        crossAxisAlignment: .start,
        spacing: 12,
        children: [
          Text('Design System', style: CnTheme.of(context).text.lg.semibold),
          Text(
            'Blend typography, color, and tone from a single theme.',
            style: CnTheme.of(context).text.xs
                .copyWith(color: colors.mutedForeground),
          ),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: const [
              CnBadge(child: Text('Primary')),
              CnBadge(variant: .outline, child: Text('Outline')),
              CnBadge(variant: .secondary, child: Text('Secondary')),
            ],
          ),
          Row(
            spacing: 8,
            children: [
              CnButton(
                size: .sm,
                onPressed: () {},
                child: const Text('Publish'),
              ),
              CnButton(
                size: .sm,
                variant: .outline,
                onPressed: () {},
                child: const Text('Preview'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TokenControlsPreview extends StatefulWidget {
  const _TokenControlsPreview();

  @override
  State<_TokenControlsPreview> createState() => _TokenControlsPreviewState();
}

class _TokenControlsPreviewState extends State<_TokenControlsPreview> {
  bool notifications = true;
  bool compact = false;
  double volume = 64;

  @override
  Widget build(BuildContext context) {
    return _TokenPreviewCard(
      title: 'Controls',
      child: Column(
        crossAxisAlignment: .start,
        spacing: 12,
        children: [
          const CnInput(
            placeholder: 'Search tokens',
            leading: Icon(Icons.search),
          ),
          Row(
            spacing: 12,
            children: [
              CnSwitch(
                value: notifications,
                onChanged: (value) => setState(() => notifications = value),
                label: const Text('Alerts'),
              ),
              CnToggle(
                value: compact,
                onChanged: (value) => setState(() => compact = value),
                child: const Icon(Icons.view_agenda_outlined),
              ),
            ],
          ),
          CnProgress(value: volume / 100),
          CnSlider(
            value: volume,
            min: 0,
            max: 100,
            onChanged: (value) => setState(() => volume = value),
          ),
        ],
      ),
    );
  }
}

class _TokenMenuPreview extends StatefulWidget {
  const _TokenMenuPreview();

  @override
  State<_TokenMenuPreview> createState() => _TokenMenuPreviewState();
}

class _TokenMenuPreviewState extends State<_TokenMenuPreview> {
  bool collapsed = false;

  @override
  Widget build(BuildContext context) {
    return _TokenPreviewCard(
      title: 'Menu tokens',
      child: SizedBox(
        height: 250,
        child: CnSidebar(
          collapsed: collapsed,
          onCollapsedChanged: (value) => setState(() => collapsed = value),
          expandedWidth: 220,
          collapsedWidth: 220,
          child: Column(
            crossAxisAlignment: .stretch,
            spacing: 8,
            children: [
              const CnSidebarHeader(child: Text('Workspace')),
              const CnSidebarSearch(placeholder: 'Search'),
              const CnSidebarSeparator(),
              CnSidebarContent(
                children: const [
                  CnSidebarItem(
                    leading: Icon(Icons.dashboard_outlined),
                    label: Text('Overview'),
                    selected: true,
                  ),
                  CnSidebarItem(
                    leading: Icon(Icons.bar_chart_outlined),
                    label: Text('Reports'),
                  ),
                  CnSidebarItem(
                    leading: Icon(Icons.settings_outlined),
                    label: Text('Settings'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TokenDataPreview extends StatelessWidget {
  const _TokenDataPreview();

  @override
  Widget build(BuildContext context) {
    final colors = CnTheme.of(context).colors;
    return _TokenPreviewCard(
      title: 'Data & status',
      child: Column(
        crossAxisAlignment: .start,
        spacing: 12,
        children: [
          Row(
            spacing: 8,
            children: const [
              CnBadge(child: Text('Active')),
              CnBadge(variant: .secondary, child: Text('Queued')),
              CnBadge(variant: .outline, child: Text('Paused')),
            ],
          ),
          CnAlert(
            title: const Text('Heads up'),
            description: Text(
              'Your theme tokens now apply to alerts and data tables.',
              style: CnTheme.of(context).text.xs
                  .copyWith(color: colors.mutedForeground),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(CnTheme.of(context).radius),
              border: Border.all(color: colors.border),
            ),
            child: Column(
              children: [
                _TokenTableRow(
                  leading: const Text('Release'),
                  trailing: Row(
                    mainAxisSize: .min,
                    spacing: 6,
                    children: const [
                      Icon(Icons.circle, size: 10),
                      Text('In review'),
                    ],
                  ),
                ),
                _TokenTableRow(
                  leading: const Text('Design kit'),
                  trailing: Row(
                    mainAxisSize: .min,
                    spacing: 6,
                    children: const [
                      Icon(Icons.circle, size: 10),
                      Text('Published'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TokenOverlayPreview extends StatelessWidget {
  const _TokenOverlayPreview();

  @override
  Widget build(BuildContext context) {
    return _TokenPreviewCard(
      title: 'Overlays',
      child: Column(
        crossAxisAlignment: .start,
        spacing: 12,
        children: [
          CnAlert(
            variant: .info,
            title: const Text('Theme tokens'),
            description: const Text(
              'Hover cards and dialogs share the same radius.',
            ),
          ),
          Row(
            spacing: 8,
            children: [
              CnTooltip(
                message: 'Tooltip preview',
                child: const Icon(Icons.info_outline),
              ),
              CnButton(
                variant: .outline,
                size: .sm,
                onPressed: () {},
                child: const Text('Open dialog'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TokenTableRow extends StatelessWidget {
  const _TokenTableRow({required this.leading, required this.trailing});
  final Widget leading;
  final Widget trailing;

  @override
  Widget build(BuildContext context) {
    final colors = CnTheme.of(context).colors;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          DefaultTextStyle.merge(
            style: CnTheme.of(context).text.xs,
            child: leading,
          ),
          DefaultTextStyle.merge(
            style: CnTheme.of(context).text.xs
                .copyWith(color: colors.mutedForeground),
            child: trailing,
          ),
        ],
      ),
    );
  }
}

const _fonts = [
  'Geist',
  'Figtree',
  'Space Grotesk',
  'Sora',
  'Fraunces',
  'IBM Plex Sans',
  'IBM Plex Serif',
  'IBM Plex Mono',
];

const _primaryColors = [
  _ColorOption('Indigo', Color(0xFF1D4ED8)),
  _ColorOption('Emerald', Color(0xFF047857)),
  _ColorOption('Coral', Color(0xFFF97316)),
  _ColorOption('Amber', Color(0xFFB45309)),
  _ColorOption('Rose', Color(0xFFBE123C)),
];
