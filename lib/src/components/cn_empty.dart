import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/cn_theme.dart';

/// Media display variants for [CnEmptyMedia].
enum CnEmptyMediaVariant { icon, image, defaultStyle }

/// An empty state component for displaying messages when no content is available.
///
/// Provides a structured layout for media, title, description, and action buttons in empty states.
///
/// See also:
///
///  * [CnEmptyMedia], for empty state media (icons or images).
///  * [CnEmptyTitle], for empty state titles.
///  * [CnEmptyDescription], for empty state descriptions.
class CnEmpty extends StatelessWidget {
  final Widget? media;
  final Widget? title;
  final Widget? description;
  final Widget? content;
  final Widget? actions;
  final EdgeInsetsGeometry padding;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisAlignment mainAxisAlignment;
  final Widget? child;

  const CnEmpty({
    super.key,
    this.media,
    this.title,
    this.description,
    this.content,
    this.actions,
    this.padding = const EdgeInsets.all(24),
    this.crossAxisAlignment = .center,
    this.mainAxisAlignment = .start,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    final body =
        child ??
        Column(
          crossAxisAlignment: crossAxisAlignment,
          mainAxisAlignment: mainAxisAlignment,
          spacing: 12,
          children: [
            if (media != null) media!,
            if (title != null) title!,
            if (description != null) description!,
            if (content != null) content!,
            if (actions != null) actions!,
          ],
        );

    return Padding(padding: padding, child: body);
  }
}

/// A header section for [CnEmpty] combining title and description.
class CnEmptyHeader extends StatelessWidget {
  final List<Widget> children;

  const CnEmptyHeader({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: .center, spacing: 8, children: children);
  }
}

/// A media component for [CnEmpty] displaying icons or images.
class CnEmptyMedia extends StatelessWidget {
  final Widget child;
  final CnEmptyMediaVariant variant;
  final double size;
  final EdgeInsetsGeometry? padding;

  const CnEmptyMedia({
    super.key,
    required this.child,
    this.variant = .icon,
    this.size = 64,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = CnTheme.colorSchemeOf(context);
    final cnTheme = CnTheme.of(context);

    if (variant == .image) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(math.max(0, cnTheme.radius - 2)),
        child: SizedBox(width: size, height: size, child: child),
      );
    }

    final background = scheme.surfaceContainerHighest;
    final resolvedPadding =
        padding ?? EdgeInsets.all(variant == .icon ? 16 : 12);

    return Container(
      width: size,
      height: size,
      padding: resolvedPadding,
      decoration: BoxDecoration(
        color: background,
        shape: BoxShape.circle,
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: IconTheme(
        data: IconThemeData(color: scheme.onSurfaceVariant, size: 22),
        child: Center(child: child),
      ),
    );
  }
}

/// A title component for [CnEmpty].
class CnEmptyTitle extends StatelessWidget {
  final Widget child;

  const CnEmptyTitle({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style:
          CnTheme.textThemeOf(
            context,
          ).titleMedium?.copyWith(fontWeight: .w600) ??
          const TextStyle(fontWeight: FontWeight.w600),
      textAlign: TextAlign.center,
      child: child,
    );
  }
}

/// A description component for [CnEmpty].
class CnEmptyDescription extends StatelessWidget {
  final Widget child;

  const CnEmptyDescription({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final scheme = CnTheme.colorSchemeOf(context);
    return DefaultTextStyle(
      style:
          CnTheme.textThemeOf(
            context,
          ).bodySmall?.copyWith(color: scheme.onSurfaceVariant) ??
          TextStyle(color: scheme.onSurfaceVariant),
      textAlign: TextAlign.center,
      child: child,
    );
  }
}

/// A content wrapper for [CnEmpty].
class CnEmptyContent extends StatelessWidget {
  final Widget child;

  const CnEmptyContent({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
