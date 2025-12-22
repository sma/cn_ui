import 'package:flutter/material.dart';

import '../cn_ui.dart';

class ThemePlayground extends StatelessWidget {
  final CnTheme theme;
  final ValueChanged<CnTheme> onChanged;

  const ThemePlayground({
    super.key,
    required this.theme,
    required this.onChanged,
  });

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
            style: CnTheme.textThemeOf(context).headlineMedium,
          ),
          Text(
            'Tune the tokens used by every component. This mirrors the '
            'shadcn/ui create flow, but as Flutter-native config.',
            style: CnTheme.textThemeOf(context).bodyLarge,
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
                              title: 'Style',
                              child: SegmentedButton<CnStyle>(
                                segments: const [
                                  ButtonSegment(
                                    value: .classic,
                                    label: Text('Classic'),
                                  ),
                                  ButtonSegment(
                                    value: .newYork,
                                    label: Text('New York'),
                                  ),
                                ],
                                selected: {theme.style},
                                onSelectionChanged: (value) {
                                  onChanged(theme.copyWith(style: value.first));
                                },
                              ),
                            ),
                            _TokenCard(
                              title: 'Base Color',
                              child: _ColorSelect(
                                value: theme.baseColor,
                                options: _baseColors,
                                onChanged: (value) =>
                                    onChanged(theme.copyWith(baseColor: value)),
                              ),
                            ),
                            _TokenCard(
                              title: 'Theme Color',
                              child: _ColorSelect(
                                value: theme.themeColor,
                                options: _accentColors,
                                onChanged: (value) => onChanged(
                                  theme.copyWith(themeColor: value),
                                ),
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
                                  Slider(
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
                            _TokenCard(
                              title: 'Menu Color',
                              child: _ColorSelect(
                                value: theme.menuColor,
                                options: _menuColors,
                                onChanged: (value) =>
                                    onChanged(theme.copyWith(menuColor: value)),
                              ),
                            ),
                            _TokenCard(
                              title: 'Menu Accent',
                              child: _ColorSelect(
                                value: theme.menuAccent,
                                options: _accentColors,
                                onChanged: (value) => onChanged(
                                  theme.copyWith(menuAccent: value),
                                ),
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
  final String title;
  final Widget child;

  const _Section({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      spacing: 12,
      children: [
        Text(title, style: CnTheme.textThemeOf(context).titleLarge),
        child,
      ],
    );
  }
}

class _TokenCard extends StatelessWidget {
  final String title;
  final Widget child;

  const _TokenCard({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      child: CnCard(
        header: Text(title, style: CnTheme.textThemeOf(context).titleMedium),
        content: child,
      ),
    );
  }
}

class _ColorOption {
  final String label;
  final Color color;

  const _ColorOption(this.label, this.color);
}

class _ColorSelect extends StatelessWidget {
  final Color value;
  final List<_ColorOption> options;
  final ValueChanged<Color> onChanged;

  const _ColorSelect({
    required this.value,
    required this.options,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CnSelect<Color>(
      value: value,
      items: [
        for (final option in options)
          DropdownMenuItem(
            value: option.color,
            child: Row(
              spacing: 8,
              children: [
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: option.color,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: CnTheme.colorSchemeOf(context).outlineVariant,
                    ),
                  ),
                ),
                Text(option.label),
              ],
            ),
          ),
      ],
      onChanged: (value) {
        if (value != null) {
          onChanged(value);
        }
      },
    );
  }
}

class _FontSelect extends StatelessWidget {
  final String value;
  final ValueChanged<String> onChanged;

  const _FontSelect({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return CnSelect<String>(
      value: value,
      items: [
        for (final font in _fonts)
          DropdownMenuItem(value: font, child: Text(font)),
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
  final String title;
  final Widget child;

  const _TokenPreviewCard({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: CnCard(
        header: Text(title, style: CnTheme.textThemeOf(context).titleMedium),
        content: child,
      ),
    );
  }
}

class _TokenSurfacePreview extends StatelessWidget {
  const _TokenSurfacePreview();

  @override
  Widget build(BuildContext context) {
    final scheme = CnTheme.colorSchemeOf(context);

    return _TokenPreviewCard(
      title: 'Type & surface',
      child: Column(
        crossAxisAlignment: .start,
        spacing: 12,
        children: [
          Text('Design System', style: CnTheme.textThemeOf(context).titleLarge),
          Text(
            'Blend typography, color, and tone from a single theme.',
            style: CnTheme.textThemeOf(
              context,
            ).bodySmall?.copyWith(color: scheme.onSurfaceVariant),
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
            prefixIcon: Icon(Icons.search),
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
  late final CnSidebarController controller = CnSidebarController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _TokenPreviewCard(
      title: 'Menu tokens',
      child: SizedBox(
        height: 220,
        child: CnSidebarProvider(
          controller: controller,
          child: CnSidebar(
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
                      icon: Icon(Icons.dashboard_outlined),
                      label: Text('Overview'),
                      selected: true,
                    ),
                    CnSidebarItem(
                      icon: Icon(Icons.bar_chart_outlined),
                      label: Text('Reports'),
                    ),
                    CnSidebarItem(
                      icon: Icon(Icons.settings_outlined),
                      label: Text('Settings'),
                    ),
                  ],
                ),
              ],
            ),
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
    final scheme = CnTheme.colorSchemeOf(context);
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
              style: CnTheme.textThemeOf(
                context,
              ).bodySmall?.copyWith(color: scheme.onSurfaceVariant),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(CnTheme.of(context).radius),
              border: Border.all(color: scheme.outlineVariant),
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
  final Widget leading;
  final Widget trailing;

  const _TokenTableRow({required this.leading, required this.trailing});

  @override
  Widget build(BuildContext context) {
    final scheme = CnTheme.colorSchemeOf(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          DefaultTextStyle(
            style: CnTheme.textThemeOf(context).bodySmall ?? const TextStyle(),
            child: leading,
          ),
          DefaultTextStyle(
            style:
                CnTheme.textThemeOf(
                  context,
                ).bodySmall?.copyWith(color: scheme.onSurfaceVariant) ??
                TextStyle(color: scheme.onSurfaceVariant),
            child: trailing,
          ),
        ],
      ),
    );
  }
}

const _fonts = ['Space Grotesk', 'Sora', 'Fraunces', 'Plus Jakarta Sans'];

const _baseColors = [
  _ColorOption('Paper', Color(0xFFF7F4EF)),
  _ColorOption('Mist', Color(0xFFF2F4F8)),
  _ColorOption('Snow', Color(0xFFFFFFFF)),
  _ColorOption('Sand', Color(0xFFF8F1E8)),
];

const _accentColors = [
  _ColorOption('Indigo', Color(0xFF1D4ED8)),
  _ColorOption('Emerald', Color(0xFF047857)),
  _ColorOption('Coral', Color(0xFFF97316)),
  _ColorOption('Amber', Color(0xFFB45309)),
  _ColorOption('Rose', Color(0xFFBE123C)),
];

const _menuColors = [
  _ColorOption('Paper', Color(0xFFFDFBF7)),
  _ColorOption('Slate', Color(0xFFF8FAFC)),
  _ColorOption('Ice', Color(0xFFF3F4F6)),
];
