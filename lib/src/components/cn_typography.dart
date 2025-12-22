import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/cn_theme.dart';

/// Text style variants for [CnText].
enum CnTextVariant { h1, h2, h3, h4, lead, p, large, small, muted }

/// A text component with predefined typographic styles.
///
/// Provides heading, paragraph, and specialty text variants with consistent styling.
///
/// See also:
///
///  * [CnInlineCode], for inline code snippets.
///  * [CnBlockquote], for quoted text.
///  * [CnList], for bulleted lists.
class CnText extends StatelessWidget {
  final CnTextVariant variant;
  final String? text;
  final Widget? child;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final bool selectable;

  const CnText({
    super.key,
    required this.variant,
    this.text,
    this.child,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.selectable = false,
  }) : assert(text != null || child != null, 'Provide text or child.');

  @override
  Widget build(BuildContext context) {
    final resolvedStyle = _styleForVariant(
      CnTheme.textThemeOf(context),
      CnTheme.colorSchemeOf(context),
    ).merge(style);

    final content = child ?? Text(text!);

    if (selectable) {
      return SelectableText.rich(
        TextSpan(
          style: resolvedStyle,
          children: [WidgetSpan(child: content)],
        ),
        textAlign: textAlign,
      );
    }

    return DefaultTextStyle(
      style: resolvedStyle,
      maxLines: maxLines,
      overflow: overflow ?? TextOverflow.clip,
      child: Align(alignment: _alignmentFor(textAlign), child: content),
    );
  }

  Alignment _alignmentFor(TextAlign? align) {
    return switch (align) {
      .center => Alignment.center,
      .right => Alignment.centerRight,
      .end => Alignment.centerRight,
      .left => Alignment.centerLeft,
      .start => Alignment.centerLeft,
      .justify => Alignment.centerLeft,
      null => Alignment.centerLeft,
    };
  }

  TextStyle _styleForVariant(TextTheme theme, ColorScheme scheme) {
    return switch (variant) {
      .h1 => (theme.displaySmall ?? theme.headlineMedium)!.copyWith(
        fontWeight: .w700,
        letterSpacing: -0.8,
      ),
      .h2 => (theme.headlineMedium ?? theme.titleLarge)!.copyWith(
        fontWeight: .w700,
        letterSpacing: -0.6,
      ),
      .h3 => (theme.titleLarge ?? theme.titleMedium)!.copyWith(
        fontWeight: .w600,
      ),
      .h4 => (theme.titleMedium ?? theme.titleSmall)!.copyWith(
        fontWeight: .w600,
      ),
      .lead => (theme.titleMedium ?? theme.bodyLarge)!.copyWith(
        color: scheme.onSurfaceVariant,
        fontWeight: .w500,
      ),
      .large => (theme.titleSmall ?? theme.bodyLarge)!.copyWith(
        fontWeight: .w600,
      ),
      .small => (theme.bodySmall ?? theme.labelMedium)!.copyWith(
        fontWeight: .w500,
      ),
      .muted => (theme.bodySmall ?? theme.labelSmall)!.copyWith(
        color: scheme.onSurfaceVariant,
      ),
      .p => (theme.bodyMedium ?? theme.bodyLarge)!.copyWith(height: 1.6),
    };
  }
}

/// An inline code snippet component for displaying code within text.
class CnInlineCode extends StatelessWidget {
  final String code;
  final TextStyle? style;

  const CnInlineCode({super.key, required this.code, this.style});

  @override
  Widget build(BuildContext context) {
    final scheme = CnTheme.colorSchemeOf(context);
    final cnTheme = CnTheme.of(context);

    return Container(
      padding: const .symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        borderRadius: .circular(math.max(0, cnTheme.radius - 6)),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Text(
        code,
        style:
            style ??
            CnTheme.textThemeOf(context).bodySmall?.copyWith(
              fontFamily: 'IBM Plex Mono',
              fontWeight: .w600,
              color: scheme.onSurface,
            ),
      ),
    );
  }
}

/// A blockquote component for displaying quoted text.
class CnBlockquote extends StatelessWidget {
  final Widget child;

  const CnBlockquote({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final scheme = CnTheme.colorSchemeOf(context);

    return Container(
      padding: const .only(left: 16),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(color: scheme.outlineVariant, width: 3),
        ),
      ),
      child: DefaultTextStyle(
        style:
            CnTheme.textThemeOf(context).bodyMedium?.copyWith(
              fontStyle: FontStyle.italic,
              color: scheme.onSurface,
            ) ??
            TextStyle(color: scheme.onSurface),
        child: child,
      ),
    );
  }
}

/// A bulleted list component for displaying items with markers.
class CnList extends StatelessWidget {
  final List<Widget> items;
  final Widget? marker;
  final double spacing;
  final double indent;

  const CnList({
    super.key,
    required this.items,
    this.marker,
    this.spacing = 8,
    this.indent = 8,
  });

  @override
  Widget build(BuildContext context) {
    final resolvedMarker = marker ?? const Text('•');

    return Column(
      crossAxisAlignment: .start,
      children: [
        for (final item in items)
          Padding(
            padding: .only(bottom: spacing),
            child: Row(
              crossAxisAlignment: .start,
              spacing: indent,
              children: [
                resolvedMarker,
                Expanded(child: item),
              ],
            ),
          ),
      ],
    );
  }
}
