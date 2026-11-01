import 'package:material_ui/material_ui.dart';

import '../theme/cn_theme.dart';

/// Text style variants for [CnText].
enum CnTextVariant { h1, h2, h3, h4, lead, p, large, small, muted }

/// Text in one of the styles of the type scale.
///
/// See also:
///
///  * [CnInlineCode], for inline code snippets.
///  * [CnBlockquote], for quoted text.
///  * [CnList], for bulleted lists.
class CnText extends StatelessWidget {
  const CnText.h1(
    this.text, {
    super.key,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.selectable = false,
  }) : variant = .h1;

  const CnText.h2(
    this.text, {
    super.key,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.selectable = false,
  }) : variant = .h2;

  const CnText.h3(
    this.text, {
    super.key,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.selectable = false,
  }) : variant = .h3;

  const CnText.h4(
    this.text, {
    super.key,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.selectable = false,
  }) : variant = .h4;

  const CnText.lead(
    this.text, {
    super.key,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.selectable = false,
  }) : variant = .lead;

  const CnText.p(
    this.text, {
    super.key,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.selectable = false,
  }) : variant = .p;

  const CnText.large(
    this.text, {
    super.key,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.selectable = false,
  }) : variant = .large;

  const CnText.small(
    this.text, {
    super.key,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.selectable = false,
  }) : variant = .small;

  const CnText.muted(
    this.text, {
    super.key,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.selectable = false,
  }) : variant = .muted;

  final CnTextVariant variant;
  final String text;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final bool selectable;

  @override
  Widget build(BuildContext context) {
    final theme = CnTheme.of(context);
    final style = _style(theme);

    if (selectable) {
      return SelectableText(
        text,
        style: style,
        textAlign: textAlign,
        maxLines: maxLines,
      );
    }
    return Text(
      text,
      style: style,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }

  TextStyle _style(CnTheme theme) {
    final text = theme.text;
    final heading = theme.heading;
    final colors = theme.colors;
    return switch (variant) {
      .h1 => heading.xl4.weight(.w800).copyWith(letterSpacing: -0.9),
      .h2 => heading.xl3.semibold.copyWith(letterSpacing: -0.75),
      .h3 => heading.xl2.semibold.copyWith(letterSpacing: -0.6),
      .h4 => heading.xl.semibold.copyWith(letterSpacing: -0.5),
      .lead => text.xl.copyWith(color: colors.mutedForeground),
      .large => text.lg.semibold,
      .small => text.sm.medium,
      .muted => text.sm.copyWith(color: colors.mutedForeground),
      .p => text.base.copyWith(height: 1.75),
    };
  }
}

/// An inline code snippet.
class const CnInlineCode({super.key, required final String code})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = CnTheme.of(context);

    return Container(
      padding: const .symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: theme.colors.muted,
        borderRadius: .circular(theme.radii.sm),
      ),
      child: Text(code, style: theme.mono.sm.medium),
    );
  }
}

/// A quoted text.
class const CnBlockquote({super.key, required final Widget child})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = CnTheme.of(context);

    return Container(
      padding: const EdgeInsetsDirectional.only(start: 24),
      decoration: BoxDecoration(
        border: BorderDirectional(
          start: BorderSide(color: theme.colors.border, width: 2),
        ),
      ),
      child: DefaultTextStyle.merge(
        style: theme.text.base.copyWith(fontStyle: FontStyle.italic),
        child: child,
      ),
    );
  }
}

/// A bulleted list.
class const CnList({
  super.key,
  required final List<Widget> items,
  final Widget? marker,
  final double spacing = 8,
  final double indent = 8,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      spacing: spacing,
      children: [
        for (final item in items)
          Row(
            crossAxisAlignment: .start,
            spacing: indent,
            children: [
              marker ?? const Text('•'),
              Expanded(child: item),
            ],
          ),
      ],
    );
  }
}
