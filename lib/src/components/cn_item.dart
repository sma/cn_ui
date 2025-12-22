import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/cn_theme.dart';

/// Media display variants for [CnItemMedia].
enum CnItemMediaVariant { standard, icon, image }

/// A container for grouping multiple [CnItem] components with optional dividers.
class CnItemGroup extends StatelessWidget {
  final List<Widget> children;
  final bool showDividers;
  final double spacing;
  final Widget? divider;

  const CnItemGroup({
    super.key,
    required this.children,
    this.showDividers = true,
    this.spacing = 0,
    this.divider,
  });

  @override
  Widget build(BuildContext context) {
    final separator = divider ?? const CnItemSeparator();
    final items = <Widget>[];
    for (var index = 0; index < children.length; index++) {
      items.add(children[index]);
      if (showDividers && index != children.length - 1) {
        items.add(separator);
      }
    }

    return Column(
      crossAxisAlignment: .stretch,
      spacing: spacing,
      children: items,
    );
  }
}

/// A divider component for separating items in a [CnItemGroup].
class CnItemSeparator extends StatelessWidget {
  const CnItemSeparator({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      thickness: 1,
      color: CnTheme.colorSchemeOf(context).outlineVariant,
    );
  }
}

/// A list item component for displaying structured content with media, text, and actions.
///
/// Provides a flexible layout for list items with optional media, title, description, and action buttons.
///
/// See also:
///
///  * [CnItemGroup], for grouping multiple items.
///  * [CnItemMedia], for item media (icons or images).
class CnItem extends StatelessWidget {
  final Widget? media;
  final Widget? title;
  final Widget? description;
  final Widget? actions;
  final Widget? child;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;
  final bool selected;

  const CnItem({
    super.key,
    this.media,
    this.title,
    this.description,
    this.actions,
    this.child,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    this.onTap,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = CnTheme.colorSchemeOf(context);
    final cnTheme = CnTheme.of(context);

    final content =
        child ??
        Row(
          crossAxisAlignment: .start,
          spacing: 12,
          children: [
            if (media != null) media!,
            Expanded(
              child: Column(
                crossAxisAlignment: .start,
                spacing: 6,
                children: [
                  if (title != null) title!,
                  if (description != null) description!,
                ],
              ),
            ),
            if (actions != null) actions!,
          ],
        );

    final body = Padding(padding: padding, child: content);

    return Material(
      color: selected
          ? scheme.secondaryContainer.withValues(alpha: 0.5)
          : Colors.transparent,
      borderRadius: BorderRadius.circular(math.max(0, cnTheme.radius - 4)),
      child: InkWell(
        borderRadius: BorderRadius.circular(math.max(0, cnTheme.radius - 4)),
        onTap: onTap,
        child: body,
      ),
    );
  }
}

/// A media component for [CnItem] displaying icons or images.
class CnItemMedia extends StatelessWidget {
  final Widget child;
  final CnItemMediaVariant variant;
  final double size;

  const CnItemMedia({
    super.key,
    required this.child,
    this.variant = .standard,
    this.size = 44,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = CnTheme.colorSchemeOf(context);
    final cnTheme = CnTheme.of(context);

    if (variant == .image) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(math.max(0, cnTheme.radius - 4)),
        child: SizedBox(width: size, height: size, child: child),
      );
    }

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        shape: variant == .icon ? BoxShape.circle : BoxShape.rectangle,
        borderRadius: variant == .icon
            ? null
            : BorderRadius.circular(math.max(0, cnTheme.radius - 6)),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: IconTheme(
        data: IconThemeData(color: scheme.onSurfaceVariant, size: 20),
        child: Center(child: child),
      ),
    );
  }
}

/// A content wrapper for [CnItem].
class CnItemContent extends StatelessWidget {
  final List<Widget> children;

  const CnItemContent({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: .start, spacing: 6, children: children);
  }
}

/// A title component for [CnItem].
class CnItemTitle extends StatelessWidget {
  final Widget child;

  const CnItemTitle({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style:
          CnTheme.textThemeOf(
            context,
          ).titleSmall?.copyWith(fontWeight: .w600) ??
          const TextStyle(fontWeight: FontWeight.w600),
      child: child,
    );
  }
}

/// A description component for [CnItem].
class CnItemDescription extends StatelessWidget {
  final Widget child;

  const CnItemDescription({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final scheme = CnTheme.colorSchemeOf(context);
    return DefaultTextStyle(
      style:
          CnTheme.textThemeOf(
            context,
          ).bodySmall?.copyWith(color: scheme.onSurfaceVariant) ??
          TextStyle(color: scheme.onSurfaceVariant),
      child: child,
    );
  }
}

/// An actions wrapper for [CnItem].
class CnItemActions extends StatelessWidget {
  final Widget child;

  const CnItemActions({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return child;
  }
}

/// A header section for [CnItem].
class CnItemHeader extends StatelessWidget {
  final List<Widget> children;

  const CnItemHeader({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: .start, spacing: 4, children: children);
  }
}

/// A footer section for [CnItem].
class CnItemFooter extends StatelessWidget {
  final List<Widget> children;

  const CnItemFooter({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisSize: .min, spacing: 8, children: children);
  }
}
