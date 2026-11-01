import 'package:material_ui/material_ui.dart';

import '../theme/cn_theme.dart';

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
  const CnInputGroup({
    super.key,
    required this.children,
    this.direction = .horizontal,
  });
  final List<Widget> children;
  final Axis direction;

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
    final colors = CnTheme.of(context).colors;
    final cnTheme = CnTheme.of(context);
    final borderColor = _hasFocus ? colors.ring : colors.input;

    final children = _buildChildren(widget.children, colors.border);

    final content = widget.direction == .horizontal
        ? Row(crossAxisAlignment: .center, children: children)
        : Column(crossAxisAlignment: .stretch, children: children);

    return FocusScope(
      node: _scopeNode,
      onFocusChange: (hasFocus) => setState(() => _hasFocus = hasFocus),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          borderRadius: .circular(cnTheme.radii.md),
          border: Border.all(color: borderColor),
        ),
        clipBehavior: Clip.antiAlias,
        child: _CnInputGroupScope(direction: widget.direction, child: content),
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
            direction: widget.direction,
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
  const CnInputGroupAddon({
    super.key,
    required this.child,
    this.align = .center,
  });
  final Widget child;
  final CnInputGroupAddonAlign align;

  @override
  Widget build(BuildContext context) {
    final colors = CnTheme.of(context).colors;

    return Align(
      alignment: switch (align) {
        .start => Alignment.topCenter,
        .end => Alignment.bottomCenter,
        .center => Alignment.center,
      },
      child: Container(
        padding: const .symmetric(horizontal: 12, vertical: 8),
        child: DefaultTextStyle.merge(
          style: CnTheme.of(context).text.xs
              .copyWith(color: colors.mutedForeground),
          child: IconTheme(
            data: IconThemeData(color: colors.mutedForeground, size: 16),
            child: child,
          ),
        ),
      ),
    );
  }
}

/// A button within a [CnInputGroup].
class CnInputGroupButton extends StatelessWidget {
  const CnInputGroupButton({
    super.key,
    required this.child,
    this.expand = false,
  });
  final Widget child;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final scope = _CnInputGroupScope.of(context);
    final resolved = Padding(padding: const .all(4), child: child);
    if (expand && scope != null) {
      return Expanded(child: resolved);
    }
    return resolved;
  }
}

/// A text input within a [CnInputGroup].
class CnInputGroupInput extends StatelessWidget {
  const CnInputGroupInput({
    super.key,
    this.controller,
    this.placeholder,
    this.enabled = true,
    this.obscureText = false,
    this.keyboardType,
    this.onChanged,
    this.expand = true,
    this.leading,
    this.trailing,
  });
  final TextEditingController? controller;
  final String? placeholder;
  final bool enabled;
  final bool obscureText;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final bool expand;
  final Widget? leading;
  final Widget? trailing;

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
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
        prefixIcon: leading,
        suffixIcon: trailing,
      ),
    );

    return _wrapExpanded(context, field, expand);
  }
}

/// A multiline text input within a [CnInputGroup].
class CnInputGroupTextarea extends StatelessWidget {
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
  final TextEditingController? controller;
  final String? placeholder;
  final bool enabled;
  final ValueChanged<String>? onChanged;
  final int minLines;
  final int maxLines;
  final bool expand;

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
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
      ),
    );

    return _wrapExpanded(context, field, expand);
  }
}

class _CnInputGroupDivider extends StatelessWidget {
  const _CnInputGroupDivider({required this.direction, required this.color});
  final Axis direction;
  final Color color;

  @override
  Widget build(BuildContext context) {
    if (direction == .vertical) {
      return Divider(height: 1, thickness: 1, color: color);
    }
    return VerticalDivider(width: 1, thickness: 1, color: color);
  }
}

class _CnInputGroupScope extends InheritedWidget {
  const _CnInputGroupScope({required this.direction, required super.child});
  final Axis direction;

  static _CnInputGroupScope? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_CnInputGroupScope>();
  }

  @override
  bool updateShouldNotify(_CnInputGroupScope oldWidget) {
    return oldWidget.direction != direction;
  }
}

Widget _wrapExpanded(BuildContext context, Widget child, bool expand) {
  final scope = _CnInputGroupScope.of(context);
  if (expand && scope != null && scope.direction == .horizontal) {
    return Expanded(child: child);
  }
  return child;
}
