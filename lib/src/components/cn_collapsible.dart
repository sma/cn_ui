import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

import '../theme/cn_theme.dart';

/// An expandable/collapsible container with animated height transitions.
///
/// Provides a header that toggles the visibility of content with smooth animations.
///
/// See also:
///
///  * [CnAccordion], for a group of collapsible panels.
class CnCollapsible extends StatefulWidget {
  final Widget Function(BuildContext context, bool isOpen)? headerBuilder;
  final Widget? title;
  final Widget? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final Widget child;
  final bool initiallyExpanded;
  final ValueChanged<bool>? onChanged;
  final Duration duration;
  final Curve curve;
  final EdgeInsetsGeometry? headerPadding;
  final EdgeInsetsGeometry? contentPadding;
  final bool enabled;
  final bool showBorder;
  final bool showDivider;
  final Color? backgroundColor;
  final double? radius;

  const CnCollapsible({
    super.key,
    this.headerBuilder,
    this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    required this.child,
    this.initiallyExpanded = false,
    this.onChanged,
    this.duration = const Duration(milliseconds: 220),
    this.curve = Curves.easeOut,
    this.headerPadding,
    this.contentPadding,
    this.enabled = true,
    this.showBorder = true,
    this.showDivider = true,
    this.backgroundColor,
    this.radius,
  }) : assert(
         headerBuilder != null || title != null,
         'Provide a headerBuilder or a title.',
       );

  @override
  State<CnCollapsible> createState() => _CnCollapsibleState();

  @Preview()
  static Widget preview() {
    return Column(
      spacing: 16,
      children: [
        for (final e in [false, true])
          CnCollapsible(
            title: Text('Title'),
            subtitle: Text('Subtitle'),
            initiallyExpanded: e,
            child: Padding(padding: .only(top: 16), child: Text('Content')),
          ),
      ],
    );
  }
}

class _CnCollapsibleState extends State<CnCollapsible>
    with SingleTickerProviderStateMixin {
  late bool _isOpen;

  @override
  void initState() {
    super.initState();
    _isOpen = widget.initiallyExpanded;
  }

  void _toggle() {
    if (!widget.enabled) {
      return;
    }
    setState(() => _isOpen = !_isOpen);
    widget.onChanged?.call(_isOpen);
  }

  @override
  Widget build(BuildContext context) {
    final scheme = CnTheme.colorSchemeOf(context);
    final cnTheme = CnTheme.of(context);
    final radius = widget.radius ?? cnTheme.radius;
    final headerPadding =
        widget.headerPadding ?? const .symmetric(horizontal: 16, vertical: 12);
    final contentPadding =
        widget.contentPadding ?? const .fromLTRB(16, 0, 16, 16);
    final background =
        widget.backgroundColor ?? (widget.showBorder ? scheme.surface : null);

    Widget header =
        widget.headerBuilder?.call(context, _isOpen) ??
        _DefaultCollapsibleHeader(
          title: widget.title!,
          subtitle: widget.subtitle,
          leading: widget.leading,
          trailing: widget.trailing,
          isOpen: _isOpen,
          enabled: widget.enabled,
          duration: widget.duration,
        );

    header = Padding(padding: headerPadding, child: header);

    final body = Column(
      crossAxisAlignment: .start,
      children: [
        InkWell(
          borderRadius: .circular(radius),
          onTap: widget.enabled ? _toggle : null,
          child: header,
        ),
        if (widget.showDivider)
          Divider(height: 1, color: scheme.outlineVariant),
        AnimatedAlign(
          duration: widget.duration,
          curve: widget.curve,
          alignment: .topStart,
          heightFactor: _isOpen ? 1 : 0,
          child: Padding(padding: contentPadding, child: widget.child),
        ),
      ],
    );

    final decorated = background == null && !widget.showBorder
        ? body
        : DecoratedBox(
            decoration: BoxDecoration(
              color: background,
              borderRadius: .circular(radius),
              border: widget.showBorder
                  ? Border.all(color: scheme.outlineVariant)
                  : null,
            ),
            child: body,
          );

    return ClipRRect(
      borderRadius: .circular(radius),
      child: AnimatedOpacity(
        opacity: widget.enabled ? 1 : 0.6,
        duration: widget.duration,
        child: decorated,
      ),
    );
  }
}

class _DefaultCollapsibleHeader extends StatelessWidget {
  final Widget title;
  final Widget? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final bool isOpen;
  final bool enabled;
  final Duration duration;

  const _DefaultCollapsibleHeader({
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    required this.isOpen,
    required this.enabled,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = CnTheme.colorSchemeOf(context);
    final titleStyle = CnTheme.textThemeOf(context).titleSmall?.copyWith(
      color: enabled
          ? scheme.onSurface
          : scheme.onSurfaceVariant.withValues(alpha: 0.6),
      fontWeight: .w600,
    );
    final subtitleStyle = CnTheme.textThemeOf(context).bodySmall?.copyWith(
      color: enabled
          ? scheme.onSurfaceVariant
          : scheme.onSurfaceVariant.withValues(alpha: 0.5),
    );

    return Row(
      spacing: 8,
      children: [
        if (leading != null)
          Padding(padding: const EdgeInsets.only(right: 4), child: leading!),
        Expanded(
          child: Column(
            crossAxisAlignment: .start,
            spacing: 4,
            children: [
              DefaultTextStyle(
                style: titleStyle ?? const TextStyle(),
                child: title,
              ),
              if (subtitle != null)
                DefaultTextStyle(
                  style: subtitleStyle ?? const TextStyle(),
                  child: subtitle!,
                ),
            ],
          ),
        ),
        trailing ??
            AnimatedRotation(
              turns: isOpen ? 0.5 : 0,
              duration: duration,
              child: Icon(Icons.expand_more, color: scheme.onSurfaceVariant),
            ),
      ],
    );
  }
}
