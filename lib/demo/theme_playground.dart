import 'package:material_ui/material_ui.dart';

import '../cn_ui.dart';

/// The choices of the theme playground.
class const ThemeSelection({
  final Brightness brightness = .light,
  final CnBaseColor base = .neutral,
  final CnAccentColor accent = .base,
  final CnAccentColor? chart,
  final String font = 'Geist',
  final String? headingFont,
  final String monoFont = 'Geist Mono',
  final double radius = 10,
}) {
  CnTheme toTheme() {
    return CnTheme(
      colors: CnColors.palette(
        base: base,
        theme: accent,
        chart: chart,
        brightness: brightness,
      ),
      font: font,
      headingFont: headingFont,
      monoFont: monoFont,
      radius: radius,
    );
  }

  ThemeSelection _with({
    Brightness? brightness,
    CnBaseColor? base,
    CnAccentColor? accent,
    CnAccentColor? chart,
    String? font,
    String? headingFont,
    bool inheritHeadingFont = false,
    String? monoFont,
    double? radius,
  }) {
    return ThemeSelection(
      brightness: brightness ?? this.brightness,
      base: base ?? this.base,
      accent: accent ?? this.accent,
      chart: chart ?? this.chart,
      font: font ?? this.font,
      headingFont: inheritHeadingFont ? null : headingFont ?? this.headingFont,
      monoFont: monoFont ?? this.monoFont,
      radius: radius ?? this.radius,
    );
  }
}

class ThemePlayground extends StatelessWidget {
  const ThemePlayground({
    super.key,
    required this.selection,
    required this.onChanged,
  });
  final ThemeSelection selection;
  final ValueChanged<ThemeSelection> onChanged;

  String _accentLabel(CnAccentColor accent) {
    return accent == .base ? _capitalize(selection.base) : _capitalize(accent);
  }

  Color _accentSwatch(CnAccentColor accent) {
    return CnColors.palette(
      base: selection.base,
      theme: accent,
      brightness: selection.brightness,
    ).primary;
  }

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
            style: CnTheme.of(context).heading.xl2.semibold,
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
                              child: CnToggleGroup<Brightness>(
                                spacing: 0,
                                required: true,
                                variant: .outline,
                                size: .sm,
                                value: {selection.brightness},
                                onChanged: (value) {
                                  if (value.isNotEmpty) {
                                    onChanged(
                                      selection._with(brightness: value.first),
                                    );
                                  }
                                },
                                items: const [
                                  CnToggleGroupItem(
                                    value: .light,
                                    child: Text('Light'),
                                  ),
                                  CnToggleGroupItem(
                                    value: .dark,
                                    child: Text('Dark'),
                                  ),
                                ],
                              ),
                            ),
                            _TokenCard(
                              title: 'Base Color',
                              child: _ChoiceSelect<CnBaseColor>(
                                value: selection.base,
                                options: CnBaseColor.values,
                                label: _capitalize,
                                swatch: (base) => CnColors.palette(
                                  base: base,
                                  brightness: selection.brightness,
                                ).mutedForeground,
                                onChanged: (value) =>
                                    onChanged(selection._with(base: value)),
                              ),
                            ),
                            _TokenCard(
                              title: 'Theme',
                              child: _ChoiceSelect<CnAccentColor>(
                                value: selection.accent,
                                options: CnAccentColor.values,
                                label: (accent) => _accentLabel(accent),
                                swatch: _accentSwatch,
                                onChanged: (value) =>
                                    onChanged(selection._with(accent: value)),
                              ),
                            ),
                            _TokenCard(
                              title: 'Chart Color',
                              child: _ChoiceSelect<CnAccentColor>(
                                value: selection.chart ?? selection.accent,
                                options: CnAccentColor.values,
                                label: (accent) => _accentLabel(accent),
                                swatch: _accentSwatch,
                                onChanged: (value) =>
                                    onChanged(selection._with(chart: value)),
                              ),
                            ),
                            _TokenCard(
                              title: 'Heading',
                              child: _ChoiceSelect<String>(
                                value: selection.headingFont ?? _inheritFont,
                                options: const [_inheritFont, ..._fonts],
                                label: (font) => font,
                                onChanged: (value) => onChanged(
                                  value == _inheritFont
                                      ? selection._with(
                                          inheritHeadingFont: true,
                                        )
                                      : selection._with(headingFont: value),
                                ),
                              ),
                            ),
                            _TokenCard(
                              title: 'Font',
                              child: _ChoiceSelect<String>(
                                value: selection.font,
                                options: _fonts,
                                label: (font) => font,
                                onChanged: (value) =>
                                    onChanged(selection._with(font: value)),
                              ),
                            ),
                            _TokenCard(
                              title: 'Mono',
                              child: _ChoiceSelect<String>(
                                value: selection.monoFont,
                                options: _monoFonts,
                                label: (font) => font,
                                onChanged: (value) =>
                                    onChanged(selection._with(monoFont: value)),
                              ),
                            ),
                            _TokenCard(
                              title: 'Border Radius',
                              child: Column(
                                crossAxisAlignment: .start,
                                spacing: 8,
                                children: [
                                  Text(
                                    '${selection.radius.toStringAsFixed(0)} px',
                                  ),
                                  CnSlider(
                                    value: selection.radius,
                                    min: 0,
                                    max: 20,
                                    divisions: 20,
                                    onChanged: (value) => onChanged(
                                      selection._with(radius: value),
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
        Text(title, style: CnTheme.of(context).heading.lg.semibold),
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
        title: Text(title, style: CnTheme.of(context).heading.base.semibold),
        content: child,
      ),
    );
  }
}

String _capitalize(Enum value) {
  return value.name[0].toUpperCase() + value.name.substring(1);
}

class const _ChoiceSelect<T>({
  required final T value,
  required final List<T> options,
  required final String Function(T option) label,
  final Color Function(T option)? swatch,
  required final ValueChanged<T> onChanged,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = CnTheme.of(context).colors;

    return CnSelect<T>(
      value: value,
      items: [
        for (final option in options)
          CnSelectItem(
            value: option,
            child: swatch == null
                ? Text(label(option))
                : Row(
                    spacing: 8,
                    children: [
                      Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          color: swatch!(option),
                          shape: .circle,
                          border: Border.all(color: colors.border),
                        ),
                      ),
                      Text(label(option)),
                    ],
                  ),
          ),
      ],
      onChanged: (next) {
        if (next != null) {
          onChanged(next);
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
      width: .infinity,
      child: CnCard(
        title: Text(title, style: CnTheme.of(context).heading.base.semibold),
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
          Text('Design System', style: CnTheme.of(context).heading.lg.semibold),
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

const _inheritFont = 'Inherit';

// The fonts of https://ui.shadcn.com/create.
const _fonts = [
  'Geist',
  'Inter',
  'Noto Sans',
  'Nunito Sans',
  'Figtree',
  'Roboto',
  'Raleway',
  'DM Sans',
  'Public Sans',
  'Outfit',
  'Oxanium',
  'Manrope',
  'Space Grotesk',
  'Montserrat',
  'IBM Plex Sans',
  'Source Sans 3',
  'Instrument Sans',
  'Geist Mono',
  'JetBrains Mono',
  'Noto Serif',
  'Roboto Slab',
  'Merriweather',
  'Lora',
  'Playfair Display',
  'EB Garamond',
  'Instrument Serif',
];

// Two with serifs, two without.
const _monoFonts = [
  'Courier Prime',
  'IBM Plex Mono',
  'Geist Mono',
  'JetBrains Mono',
];
