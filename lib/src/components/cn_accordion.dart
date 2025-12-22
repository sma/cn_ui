import 'package:flutter/material.dart';

import '../theme/cn_theme.dart';

/// An accordion component for collapsible content panels.
///
/// Provides expandable/collapsible sections with single or multiple panel expansion support.
///
/// See also:
///
///  * [CnCollapsible], for a single collapsible panel.
class CnAccordion extends StatefulWidget {
  final List<CnAccordionItem> items;
  final bool allowMultiple;
  final Set<int> initialOpenIndices;
  final ValueChanged<Set<int>>? onChanged;
  final EdgeInsetsGeometry? headerPadding;
  final EdgeInsetsGeometry? contentPadding;

  const CnAccordion({
    super.key,
    required this.items,
    this.allowMultiple = false,
    this.initialOpenIndices = const {},
    this.onChanged,
    this.headerPadding,
    this.contentPadding,
  });

  @override
  State<CnAccordion> createState() => _CnAccordionState();
}

class _CnAccordionState extends State<CnAccordion> {
  late Set<int> _openIndices;
  static const _animationDuration = Duration(milliseconds: 220);

  @override
  void initState() {
    super.initState();
    _openIndices = _sanitizeOpenIndices(widget.initialOpenIndices);
  }

  @override
  void didUpdateWidget(covariant CnAccordion oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.items.length != widget.items.length ||
        oldWidget.allowMultiple != widget.allowMultiple ||
        oldWidget.initialOpenIndices != widget.initialOpenIndices) {
      _openIndices = _sanitizeOpenIndices(widget.initialOpenIndices);
    }
  }

  Set<int> _sanitizeOpenIndices(Set<int> indices) {
    final sanitized = indices.where((index) => index < widget.items.length);
    if (widget.allowMultiple || sanitized.isEmpty) {
      return {...sanitized};
    }
    return {sanitized.first};
  }

  void _toggle(int index, bool isExpanded) {
    setState(() {
      if (isExpanded) {
        _openIndices.remove(index);
      } else {
        if (!widget.allowMultiple) {
          _openIndices.clear();
        }
        _openIndices.add(index);
      }
    });
    widget.onChanged?.call({..._openIndices});
  }

  @override
  Widget build(BuildContext context) {
    final cnTheme = CnTheme.of(context);
    final scheme = CnTheme.colorSchemeOf(context);
    final headerPadding =
        widget.headerPadding ?? const .symmetric(horizontal: 16, vertical: 8);
    final contentPadding =
        widget.contentPadding ?? const .fromLTRB(16, 0, 16, 16);

    return Material(
      color: scheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: .circular(cnTheme.radius),
        side: BorderSide(color: scheme.outlineVariant),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (var index = 0; index < widget.items.length; index++) ...[
            _buildPanel(
              context,
              widget.items[index],
              index,
              _openIndices.contains(index),
              headerPadding,
              contentPadding,
            ),
            if (index != widget.items.length - 1)
              Divider(height: 1, color: scheme.outlineVariant),
          ],
        ],
      ),
    );
  }

  Widget _buildPanel(
    BuildContext context,
    CnAccordionItem item,
    int index,
    bool isExpanded,
    EdgeInsetsGeometry headerPadding,
    EdgeInsetsGeometry contentPadding,
  ) {
    final scheme = CnTheme.colorSchemeOf(context);
    final disabled = item.isDisabled;
    final titleStyle = CnTheme.textThemeOf(context).titleSmall?.copyWith(
      color: disabled
          ? scheme.onSurfaceVariant.withValues(alpha: 0.5)
          : scheme.onSurface,
    );
    final trailingColor = disabled
        ? scheme.onSurfaceVariant.withValues(alpha: 0.4)
        : scheme.onSurfaceVariant;

    final header = Padding(
      padding: headerPadding,
      child: Row(
        spacing: 8,
        children: [
          Expanded(
            child: DefaultTextStyle(
              style: titleStyle ?? const TextStyle(),
              child: item.title,
            ),
          ),
          item.trailing ??
              AnimatedRotation(
                turns: isExpanded ? 0.5 : 0,
                duration: _animationDuration,
                child: Icon(Icons.expand_more, color: trailingColor),
              ),
        ],
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        InkWell(
          onTap: disabled ? null : () => _toggle(index, isExpanded),
          child: header,
        ),
        ClipRect(
          child: AnimatedAlign(
            duration: _animationDuration,
            alignment: .topStart,
            heightFactor: isExpanded ? 1 : 0,
            child: Padding(padding: contentPadding, child: item.content),
          ),
        ),
      ],
    );
  }
}

/// An item in a [CnAccordion].
class CnAccordionItem {
  final Widget title;
  final Widget content;
  final Widget? trailing;
  final bool isDisabled;

  const CnAccordionItem({
    required this.title,
    required this.content,
    this.trailing,
    this.isDisabled = false,
  });
}
