import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/cn_theme.dart';

/// Orientation variants for [CnInputGroup].
enum CnInputGroupOrientation { horizontal, vertical }

/// Alignment variants for [CnInputGroupAddon].
enum CnInputGroupAddonAlign { center, start, end }

/// A container that groups multiple input elements with shared borders.
///
/// Combines inputs, buttons, and addons into a cohesive visual group with focus handling.
///
/// See also:
///
///  * [CnInputGroupInput], for text inputs within a group.
///  * [CnInputGroupAddon], for decorative addons like labels or icons.
///  * [CnInputGroupButton], for buttons within a group.
class CnInputGroup extends StatefulWidget {
  final List<Widget> children;
  final CnInputGroupOrientation orientation;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;
  final Color? backgroundColor;

  const CnInputGroup({
    super.key,
    required this.children,
    this.orientation = .horizontal,
    this.padding,
    this.borderRadius,
    this.backgroundColor,
  });

  @override
  State<CnInputGroup> createState() => _CnInputGroupState();
}

class _CnInputGroupState extends State<CnInputGroup> {
  final FocusScopeNode _scopeNode = FocusScopeNode();
  bool _hasFocus = false;

  @override
  void dispose() {
    _scopeNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = CnTheme.colorSchemeOf(context);
    final cnTheme = CnTheme.of(context);
    final resolvedRadius =
        widget.borderRadius ??
        BorderRadius.circular(math.max(0, cnTheme.radius - 4));
    final resolvedBackground = widget.backgroundColor ?? scheme.surface;
    final borderColor = _hasFocus ? scheme.primary : scheme.outlineVariant;

    final children = _buildChildren(widget.children, scheme.outlineVariant);

    final content = widget.orientation == .horizontal
        ? Row(crossAxisAlignment: .center, children: children)
        : Column(crossAxisAlignment: .stretch, children: children);

    return FocusScope(
      node: _scopeNode,
      onFocusChange: (hasFocus) => setState(() => _hasFocus = hasFocus),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          color: resolvedBackground,
          borderRadius: resolvedRadius,
          border: Border.all(color: borderColor),
        ),
        clipBehavior: Clip.antiAlias,
        padding: widget.padding ?? EdgeInsets.zero,
        child: _CnInputGroupScope(
          orientation: widget.orientation,
          child: content,
        ),
      ),
    );
  }

  List<Widget> _buildChildren(List<Widget> items, Color dividerColor) {
    final children = <Widget>[];
    for (var index = 0; index < items.length; index++) {
      children.add(items[index]);
      if (index != items.length - 1) {
        children.add(
          _CnInputGroupDivider(
            orientation: widget.orientation,
            color: dividerColor,
          ),
        );
      }
    }
    return children;
  }
}

/// A decorative addon within a [CnInputGroup] for labels, icons, or other content.
class CnInputGroupAddon extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final CnInputGroupAddonAlign align;

  const CnInputGroupAddon({
    super.key,
    required this.child,
    this.padding,
    this.backgroundColor,
    this.align = .center,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = CnTheme.colorSchemeOf(context);
    final resolvedPadding =
        padding ?? const EdgeInsets.symmetric(horizontal: 12, vertical: 10);
    final resolvedBackground =
        backgroundColor ?? scheme.surfaceContainerHighest;

    return Align(
      alignment: switch (align) {
        .start => Alignment.topCenter,
        .end => Alignment.bottomCenter,
        .center => Alignment.center,
      },
      child: Container(
        padding: resolvedPadding,
        color: resolvedBackground,
        child: DefaultTextStyle(
          style:
              CnTheme.textThemeOf(context).bodySmall?.copyWith(
                color: scheme.onSurfaceVariant,
                fontWeight: .w600,
              ) ??
              TextStyle(color: scheme.onSurfaceVariant),
          child: IconTheme(
            data: IconThemeData(color: scheme.onSurfaceVariant, size: 18),
            child: child,
          ),
        ),
      ),
    );
  }
}

/// A text addon within a [CnInputGroup].
class CnInputGroupText extends StatelessWidget {
  final String text;

  const CnInputGroupText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return CnInputGroupAddon(child: Text(text));
  }
}

/// A button within a [CnInputGroup].
class CnInputGroupButton extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final bool expand;

  const CnInputGroupButton({
    super.key,
    required this.child,
    this.padding,
    this.expand = false,
  });

  @override
  Widget build(BuildContext context) {
    final scope = _CnInputGroupScope.of(context);
    final resolved = padding == null
        ? child
        : Padding(padding: padding!, child: child);
    if (expand && scope != null) {
      return Expanded(child: resolved);
    }
    return resolved;
  }
}

/// A text input within a [CnInputGroup].
class CnInputGroupInput extends StatelessWidget {
  final TextEditingController? controller;
  final String? placeholder;
  final bool enabled;
  final bool obscureText;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final bool expand;
  final EdgeInsetsGeometry? contentPadding;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  const CnInputGroupInput({
    super.key,
    this.controller,
    this.placeholder,
    this.enabled = true,
    this.obscureText = false,
    this.keyboardType,
    this.onChanged,
    this.expand = true,
    this.contentPadding,
    this.prefixIcon,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    final field = TextField(
      controller: controller,
      enabled: enabled,
      obscureText: obscureText,
      keyboardType: keyboardType,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: placeholder,
        filled: false,
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        contentPadding:
            contentPadding ??
            const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
    );

    return _wrapExpanded(context, field, expand);
  }
}

/// A multiline text input within a [CnInputGroup].
class CnInputGroupTextarea extends StatelessWidget {
  final TextEditingController? controller;
  final String? placeholder;
  final bool enabled;
  final ValueChanged<String>? onChanged;
  final int minLines;
  final int maxLines;
  final bool expand;

  const CnInputGroupTextarea({
    super.key,
    this.controller,
    this.placeholder,
    this.enabled = true,
    this.onChanged,
    this.minLines = 3,
    this.maxLines = 5,
    this.expand = true,
  });

  @override
  Widget build(BuildContext context) {
    final field = TextField(
      controller: controller,
      enabled: enabled,
      onChanged: onChanged,
      minLines: minLines,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: placeholder,
        filled: false,
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 12,
        ),
      ),
    );

    return _wrapExpanded(context, field, expand);
  }
}

class _CnInputGroupDivider extends StatelessWidget {
  final CnInputGroupOrientation orientation;
  final Color color;

  const _CnInputGroupDivider({required this.orientation, required this.color});

  @override
  Widget build(BuildContext context) {
    if (orientation == .vertical) {
      return Divider(height: 1, thickness: 1, color: color);
    }
    return VerticalDivider(width: 1, thickness: 1, color: color);
  }
}

class _CnInputGroupScope extends InheritedWidget {
  final CnInputGroupOrientation orientation;

  const _CnInputGroupScope({required this.orientation, required super.child});

  static _CnInputGroupScope? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_CnInputGroupScope>();
  }

  @override
  bool updateShouldNotify(_CnInputGroupScope oldWidget) {
    return oldWidget.orientation != orientation;
  }
}

Widget _wrapExpanded(BuildContext context, Widget child, bool expand) {
  final scope = _CnInputGroupScope.of(context);
  if (expand && scope != null && scope.orientation == .horizontal) {
    return Expanded(child: child);
  }
  return child;
}
