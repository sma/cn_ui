import 'package:flutter/material.dart';

import '../cn_ui.dart';
import 'component_page.dart';

class HomePage extends StatelessWidget {
  final VoidCallback? onBrowseComponents;
  final VoidCallback? onViewThemeTokens;

  const HomePage({super.key, this.onBrowseComponents, this.onViewThemeTokens});

  @override
  Widget build(BuildContext context) {
    final scheme = CnTheme.colorSchemeOf(context);
    final cnTheme = CnTheme.of(context);

    return SingleChildScrollView(
      padding: const .symmetric(horizontal: 28, vertical: 24),
      child: Column(
        crossAxisAlignment: .start,
        spacing: 28,
        children: [
          Container(
            padding: const .all(28),
            decoration: BoxDecoration(
              borderRadius: .circular(cnTheme.radius + 8),
              gradient: LinearGradient(
                colors: [
                  scheme.primaryContainer,
                  scheme.secondaryContainer,
                  scheme.surface,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              border: Border.all(color: scheme.outlineVariant),
            ),
            child: _HeroCopy(
              onBrowseComponents: onBrowseComponents,
              onViewThemeTokens: onViewThemeTokens,
            ),
          ),
          _Section(
            title: 'Quick Start',
            child: const CnCodeBlock(
              code: '''final cnTheme = CnTheme(
  style: .classic,
  baseColor: Color(0xFFF7F4EF),
  themeColor: Color(0xFF1D4ED8),
  fontFamily: 'Space Grotesk',
  radius: 12,
  menuColor: Color(0xFFFDFBF7),
  menuAccent: Color(0xFF1D4ED8),
);

MaterialApp(
  theme: cnTheme.toThemeData(),
  home: const CnDemoApp(),
);''',
            ),
          ),
          _Section(
            title: 'Why this library',
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth >= 960;
                final cards = const [
                  _FeatureCard(
                    icon: Icons.palette_outlined,
                    title: 'Theme tokens',
                    description:
                        'Swap base, accent, and menu colors from a single CnTheme.',
                  ),
                  _FeatureCard(
                    icon: Icons.widgets_outlined,
                    title: 'Material-native',
                    description:
                        'Pure Flutter widgets with Material 3 defaults and shadcn flavor.',
                  ),
                  _FeatureCard(
                    icon: Icons.code_rounded,
                    title: 'Copy-ready samples',
                    description:
                        'Each component page includes the exact Dart snippet.',
                  ),
                ];

                if (!isWide) {
                  return Column(
                    crossAxisAlignment: .start,
                    spacing: 16,
                    children: cards,
                  );
                }

                return IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: .stretch,
                    spacing: 16,
                    children: [for (final card in cards) Expanded(child: card)],
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

class _HeroCopy extends StatelessWidget {
  final VoidCallback? onBrowseComponents;
  final VoidCallback? onViewThemeTokens;

  const _HeroCopy({
    required this.onBrowseComponents,
    required this.onViewThemeTokens,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      spacing: 12,
      children: [
        Text(
          'CN UI for Flutter',
          style: CnTheme.textThemeOf(context).displaySmall,
        ),
        Text(
          'A chadcn/ui-inspired component library with themeable tokens, '
          'Flutter-native widgets, and live code samples.',
          style: CnTheme.textThemeOf(context).titleMedium,
        ),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: const [
            CnBadge(child: Text('Themeable')),
            CnBadge(variant: .outline, child: Text('Material 3')),
            CnBadge(variant: .secondary, child: Text('Web demo')),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              CnButton(
                onPressed: onBrowseComponents,
                child: const Text('Browse components'),
              ),
              CnButton(
                variant: .outline,
                onPressed: onViewThemeTokens,
                child: const Text('View theme tokens'),
              ),
            ],
          ),
        ),
      ],
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

class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _FeatureCard({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = CnTheme.colorSchemeOf(context);

    return SizedBox(
      width: 280,
      child: CnCard(
        header: Row(
          spacing: 10,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: scheme.surfaceContainerHighest,
                borderRadius: .circular(CnTheme.of(context).radius),
                border: Border.all(color: scheme.outlineVariant),
              ),
              child: Icon(icon, size: 18, color: scheme.onSurfaceVariant),
            ),
            Expanded(
              child: Text(
                title,
                style: CnTheme.textThemeOf(context).titleMedium,
              ),
            ),
          ],
        ),
        content: Text(
          description,
          style: CnTheme.textThemeOf(context).bodyMedium,
        ),
      ),
    );
  }
}
