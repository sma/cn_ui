import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/cn_theme.dart';

/// A controller for managing sidebar collapse state.
class CnSidebarController extends ChangeNotifier {
  bool _collapsed;

  CnSidebarController({bool collapsed = false}) : _collapsed = collapsed;

  bool get collapsed => _collapsed;

  set collapsed(bool value) {
    if (_collapsed == value) {
      return;
    }
    _collapsed = value;
    notifyListeners();
  }

  void toggleCollapsed() {
    collapsed = !_collapsed;
  }
}

/// An inherited widget for providing [CnSidebarController] to descendants.
class CnSidebarProvider extends InheritedNotifier<CnSidebarController> {
  const CnSidebarProvider({
    super.key,
    required CnSidebarController controller,
    required super.child,
  }) : super(notifier: controller);

  static CnSidebarController? maybeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<CnSidebarProvider>()
        ?.notifier;
  }
}

/// A collapsible sidebar navigation component.
///
/// Provides a vertical navigation panel with collapse/expand functionality and support for items, groups, and search.
///
/// See also:
///
///  * [CnSidebarItem], for individual sidebar items.
///  * [CnSidebarGroup], for grouping sidebar items.
///  * [CnNavigationMenu], for horizontal navigation.
class CnSidebar extends StatefulWidget {
  final CnSidebarController? controller;
  final Widget child;
  final double expandedWidth;
  final double collapsedWidth;
  final Duration duration;
  final Curve curve;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final Color? borderColor;
  final BorderRadiusGeometry? borderRadius;

  const CnSidebar({
    super.key,
    this.controller,
    required this.child,
    this.expandedWidth = 260,
    this.collapsedWidth = 72,
    this.duration = const Duration(milliseconds: 220),
    this.curve = Curves.easeOut,
    this.padding,
    this.backgroundColor,
    this.borderColor,
    this.borderRadius,
  });

  @override
  State<CnSidebar> createState() => _CnSidebarState();
}

class _CnSidebarState extends State<CnSidebar> {
  CnSidebarController? _controller;
  bool _ownsController = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _resolveController();
  }

  @override
  void didUpdateWidget(covariant CnSidebar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      _resolveController(force: true);
    }
  }

  @override
  void dispose() {
    if (_ownsController) {
      _controller?.dispose();
    }
    super.dispose();
  }

  void _resolveController({bool force = false}) {
    final provided = CnSidebarProvider.maybeOf(context);
    final resolved = widget.controller ?? provided;
    if (resolved == null) {
      if (!_ownsController || _controller == null) {
        _controller = CnSidebarController();
        _ownsController = true;
      }
      return;
    }
    if (!force && resolved == _controller) {
      return;
    }
    if (_ownsController) {
      _controller?.dispose();
      _ownsController = false;
    }
    _controller = resolved;
  }

  @override
  Widget build(BuildContext context) {
    final controller = _controller;
    if (controller == null) {
      return const SizedBox.shrink();
    }
    final scheme = CnTheme.colorSchemeOf(context);
    final cnTheme = CnTheme.of(context);
    final resolvedBackground = widget.backgroundColor ?? cnTheme.menuColor;
    final resolvedBorder = widget.borderColor ?? scheme.outlineVariant;
    final resolvedRadius =
        widget.borderRadius ??
        BorderRadius.circular(math.max(0, cnTheme.radius - 4));

    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final width = controller.collapsed
            ? widget.collapsedWidth
            : widget.expandedWidth;

        return _CnSidebarScope(
          controller: controller,
          collapsed: controller.collapsed,
          child: AnimatedContainer(
            duration: widget.duration,
            curve: widget.curve,
            width: width,
            decoration: BoxDecoration(
              color: resolvedBackground,
              borderRadius: resolvedRadius,
              border: Border.all(color: resolvedBorder),
            ),
            clipBehavior: Clip.antiAlias,
            padding: widget.padding ?? const EdgeInsets.all(12),
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
}

/// A button for toggling sidebar collapse state.
class CnSidebarTrigger extends StatelessWidget {
  final Widget? icon;
  final String? tooltip;

  const CnSidebarTrigger({super.key, this.icon, this.tooltip});

  @override
  Widget build(BuildContext context) {
    final controller = _CnSidebarScope.of(context)?.controller;
    final collapsed = controller?.collapsed ?? false;

    return IconButton(
      onPressed: controller?.toggleCollapsed,
      tooltip: tooltip ?? (collapsed ? 'Expand sidebar' : 'Collapse sidebar'),
      icon: icon ?? Icon(collapsed ? Icons.menu_open : Icons.menu),
    );
  }
}

/// A header section for [CnSidebar].
class CnSidebarHeader extends StatelessWidget {
  final Widget child;

  const CnSidebarHeader({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: child,
    );
  }
}

/// A scrollable content section for [CnSidebar].
class CnSidebarContent extends StatelessWidget {
  final List<Widget> children;
  final double spacing;

  const CnSidebarContent({super.key, required this.children, this.spacing = 6});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.loose,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: .stretch,
          spacing: spacing,
          children: children,
        ),
      ),
    );
  }
}

/// A footer section for [CnSidebar].
class CnSidebarFooter extends StatelessWidget {
  final Widget child;

  const CnSidebarFooter({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: child,
    );
  }
}

/// A group of sidebar items with an optional title.
class CnSidebarGroup extends StatelessWidget {
  final String? title;
  final List<Widget> children;
  final double spacing;

  const CnSidebarGroup({
    super.key,
    this.title,
    required this.children,
    this.spacing = 4,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = CnTheme.colorSchemeOf(context);
    final collapsed = _CnSidebarScope.of(context)?.collapsed ?? false;

    return Column(
      crossAxisAlignment: .stretch,
      spacing: spacing,
      children: [
        if (title != null && !collapsed)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: Text(
              title!,
              style: CnTheme.textThemeOf(context).labelSmall?.copyWith(
                color: scheme.onSurfaceVariant,
                fontWeight: .w600,
              ),
            ),
          ),
        ...children,
      ],
    );
  }
}

/// A visual separator for [CnSidebar].
class CnSidebarSeparator extends StatelessWidget {
  final EdgeInsetsGeometry? padding;

  const CnSidebarSeparator({super.key, this.padding});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(vertical: 8),
      child: Divider(
        height: 1,
        thickness: 1,
        color: CnTheme.colorSchemeOf(context).outlineVariant,
      ),
    );
  }
}

/// A search input for [CnSidebar].
class CnSidebarSearch extends StatelessWidget {
  final TextEditingController? controller;
  final String? placeholder;
  final ValueChanged<String>? onChanged;
  final Widget? leading;
  final Widget? trailing;
  final bool enabled;
  final bool hideWhenCollapsed;

  const CnSidebarSearch({
    super.key,
    this.controller,
    this.placeholder,
    this.onChanged,
    this.leading,
    this.trailing,
    this.enabled = true,
    this.hideWhenCollapsed = true,
  });

  @override
  Widget build(BuildContext context) {
    final collapsed = _CnSidebarScope.of(context)?.collapsed ?? false;
    if (collapsed && hideWhenCollapsed) {
      return const SizedBox.shrink();
    }

    final scheme = CnTheme.colorSchemeOf(context);
    final cnTheme = CnTheme.of(context);

    return TextField(
      controller: controller,
      enabled: enabled,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: placeholder ?? 'Search',
        isDense: true,
        prefixIcon: leading ?? const Icon(Icons.search, size: 18),
        suffixIcon: trailing,
        filled: true,
        fillColor: scheme.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(math.max(0, cnTheme.radius - 6)),
          borderSide: BorderSide(color: scheme.outlineVariant),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(math.max(0, cnTheme.radius - 6)),
          borderSide: BorderSide(color: scheme.outlineVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(math.max(0, cnTheme.radius - 6)),
          borderSide: BorderSide(color: scheme.primary, width: 1.5),
        ),
      ),
    );
  }
}

/// A sub-item within a [CnSidebar], typically indented under a parent item.
class CnSidebarSubItem extends StatelessWidget {
  final Widget label;
  final bool selected;
  final VoidCallback? onTap;
  final double indent;
  final bool hideWhenCollapsed;
  final Widget? trailing;

  const CnSidebarSubItem({
    super.key,
    required this.label,
    this.selected = false,
    this.onTap,
    this.indent = 24,
    this.hideWhenCollapsed = true,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final collapsed = _CnSidebarScope.of(context)?.collapsed ?? false;
    if (collapsed && hideWhenCollapsed) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: EdgeInsets.only(left: indent),
      child: CnSidebarItem(
        label: label,
        selected: selected,
        onTap: onTap,
        trailing: trailing,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
    );
  }
}

/// A clickable navigation item in a [CnSidebar].
class CnSidebarItem extends StatelessWidget {
  final Widget label;
  final Widget? icon;
  final Widget? trailing;
  final bool selected;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;

  const CnSidebarItem({
    super.key,
    required this.label,
    this.icon,
    this.trailing,
    this.selected = false,
    this.onTap,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final scope = _CnSidebarScope.of(context);
    final collapsed = scope?.collapsed ?? false;
    final scheme = CnTheme.colorSchemeOf(context);
    final cnTheme = CnTheme.of(context);
    final radius = BorderRadius.circular(math.max(0, cnTheme.radius - 6));

    final background = selected
        ? cnTheme.menuAccent.withValues(alpha: 0.12)
        : Colors.transparent;
    final foreground = selected ? cnTheme.menuAccent : scheme.onSurfaceVariant;

    final content = collapsed
        ? Center(child: icon ?? label)
        : Row(
            spacing: 10,
            children: [
              if (icon != null)
                IconTheme(
                  data: IconThemeData(color: foreground, size: 18),
                  child: icon!,
                ),
              Expanded(
                child: DefaultTextStyle(
                  style:
                      CnTheme.textThemeOf(context).bodySmall?.copyWith(
                        color: foreground,
                        fontWeight: selected ? .w600 : .w500,
                      ) ??
                      TextStyle(color: foreground),
                  child: label,
                ),
              ),
              if (trailing != null)
                IconTheme(
                  data: IconThemeData(color: foreground, size: 16),
                  child: trailing!,
                ),
            ],
          );

    final item = Container(
      padding:
          padding ??
          EdgeInsets.symmetric(horizontal: collapsed ? 10 : 12, vertical: 10),
      decoration: BoxDecoration(color: background, borderRadius: radius),
      child: content,
    );

    final tooltip = collapsed ? _labelText(label) : null;
    final inkWell = Material(
      color: Colors.transparent,
      child: InkWell(borderRadius: radius, onTap: onTap, child: item),
    );

    if (tooltip == null || tooltip.trim().isEmpty) {
      return inkWell;
    }

    return Tooltip(message: tooltip, child: inkWell);
  }

  String? _labelText(Widget label) {
    if (label is Text) {
      return label.data;
    }
    return null;
  }
}

class _CnSidebarScope extends InheritedWidget {
  final CnSidebarController controller;
  final bool collapsed;

  const _CnSidebarScope({
    required this.controller,
    required this.collapsed,
    required super.child,
  });

  static _CnSidebarScope? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_CnSidebarScope>();
  }

  @override
  bool updateShouldNotify(_CnSidebarScope oldWidget) {
    return oldWidget.collapsed != collapsed ||
        oldWidget.controller != controller;
  }
}
