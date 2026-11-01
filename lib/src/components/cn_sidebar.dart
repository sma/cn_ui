import 'package:material_ui/material_ui.dart';

import '../theme/cn_theme.dart';
import 'cn_input.dart';

/// Visual style variants for [CnSidebar].
enum CnSidebarVariant { standard, inset }

/// A vertical navigation panel that can collapse to its icons.
///
/// The surrounding code owns the [collapsed] state. A [CnSidebarTrigger] inside
/// the sidebar asks to change it through [onCollapsedChanged].
///
/// See also:
///
///  * [CnSidebarItem], for individual sidebar items.
///  * [CnSidebarGroup], for grouping sidebar items.
///  * [CnNavigationMenu], for horizontal navigation.
///  * [CnSidebarInset], for the page next to an inset sidebar.
class const CnSidebar({
  super.key,
  final CnSidebarVariant variant = .standard,
  final bool collapsed = false,
  final ValueChanged<bool>? onCollapsedChanged,
  required final Widget child,
  final double expandedWidth = 256,
  final double collapsedWidth = 56,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = CnTheme.of(context);
    final colors = theme.colors;

    return _CnSidebarScope(
      collapsed: collapsed,
      onCollapsedChanged: onCollapsedChanged,
      child: DecoratedBox(
        decoration: variant == .inset
            ? const BoxDecoration()
            : BoxDecoration(
                color: colors.sidebar,
                borderRadius: .circular(theme.radii.md),
                border: Border.all(color: colors.sidebarBorder),
              ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOut,
          width: collapsed ? collapsedWidth : expandedWidth,
          padding: const .all(8),
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(),
          child: DefaultTextStyle.merge(
            style: theme.text.sm.copyWith(color: colors.sidebarForeground),
            child: child,
          ),
        ),
      ),
    );
  }
}

/// The page next to an inset [CnSidebar]. Both sit on the sidebar color.
class const CnSidebarInset({super.key, required final Widget child})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = CnTheme.of(context);
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 8, 8),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: theme.colors.background,
          borderRadius: .circular(theme.radii.xl),
          border: Border.all(color: theme.colors.sidebarBorder),
        ),
        child: child,
      ),
    );
  }
}

/// A button that collapses and expands the enclosing [CnSidebar].
class const CnSidebarTrigger({
  super.key,
  final Widget? icon,
  final String? tooltip,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final scope = _CnSidebarScope.of(context);
    final collapsed = scope?.collapsed ?? false;
    final onChanged = scope?.onCollapsedChanged;

    return IconButton(
      onPressed: onChanged == null ? null : () => onChanged(!collapsed),
      iconSize: 16,
      tooltip: tooltip ?? (collapsed ? 'Expand sidebar' : 'Collapse sidebar'),
      icon: icon ?? Icon(collapsed ? Icons.menu_open : Icons.menu),
    );
  }
}

/// A header section for [CnSidebar].
class const CnSidebarHeader({super.key, required final Widget child})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(padding: const .symmetric(vertical: 4), child: child);
  }
}

/// A scrollable content section for [CnSidebar] that takes the free height.
class const CnSidebarContent({
  super.key,
  required final List<Widget> children,
  final double spacing = 4,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
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
class const CnSidebarFooter({super.key, required final Widget child})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(padding: const .symmetric(vertical: 4), child: child);
  }
}

/// A group of sidebar items with an optional title.
class const CnSidebarGroup({
  super.key,
  final Widget? title,
  required final List<Widget> children,
  final double spacing = 4,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = CnTheme.of(context);
    final collapsed = _CnSidebarScope.of(context)?.collapsed ?? false;

    return Column(
      crossAxisAlignment: .stretch,
      spacing: spacing,
      children: [
        if (title != null && !collapsed)
          Padding(
            padding: const .symmetric(horizontal: 8, vertical: 6),
            child: DefaultTextStyle.merge(
              style: theme.text.xs.medium.copyWith(
                color: theme.colors.sidebarForeground.withValues(alpha: 0.7),
              ),
              child: title!,
            ),
          ),
        ...children,
      ],
    );
  }
}

/// A visual separator for [CnSidebar].
class const CnSidebarSeparator({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const .symmetric(vertical: 8),
      child: Divider(
        height: 1,
        thickness: 1,
        color: CnTheme.of(context).colors.sidebarBorder,
      ),
    );
  }
}

/// A search input for [CnSidebar]. It hides while the sidebar is collapsed.
class const CnSidebarSearch({
  super.key,
  final TextEditingController? controller,
  final String? placeholder,
  final ValueChanged<String>? onChanged,
  final Widget? leading,
  final Widget? trailing,
  final bool enabled = true,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (_CnSidebarScope.of(context)?.collapsed ?? false) {
      return const SizedBox.shrink();
    }
    return CnInput(
      controller: controller,
      enabled: enabled,
      onChanged: onChanged,
      placeholder: placeholder ?? 'Search',
      leading: leading ?? const Icon(Icons.search, size: 16),
      trailing: trailing,
    );
  }
}

/// A sub-item indented under a [CnSidebarItem].
///
/// It hides while the sidebar is collapsed.
class const CnSidebarSubItem({
  super.key,
  required final Widget label,
  final bool selected = false,
  final VoidCallback? onTap,
  final double indent = 24,
  final Widget? trailing,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (_CnSidebarScope.of(context)?.collapsed ?? false) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: EdgeInsetsDirectional.only(start: indent),
      child: CnSidebarItem(
        label: label,
        selected: selected,
        onTap: onTap,
        trailing: trailing,
      ),
    );
  }
}

/// A clickable navigation item in a [CnSidebar].
class const CnSidebarItem({
  super.key,
  required final Widget label,
  final Widget? leading,
  final Widget? trailing,
  final bool selected = false,
  final VoidCallback? onTap,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final collapsed = _CnSidebarScope.of(context)?.collapsed ?? false;
    final theme = CnTheme.of(context);
    final colors = theme.colors;
    final radius = BorderRadius.circular(theme.radii.md);
    final foreground = selected
        ? colors.sidebarAccentForeground
        : colors.sidebarForeground;

    final item = Container(
      padding: const .all(8),
      decoration: BoxDecoration(
        color: selected ? colors.sidebarAccent : null,
        borderRadius: radius,
      ),
      child: IconTheme.merge(
        data: IconThemeData(color: foreground, size: 16),
        child: DefaultTextStyle.merge(
          style: theme.text.sm
              .weight(selected ? .w500 : .w400)
              .copyWith(color: foreground),
          child: collapsed
              ? Center(child: leading ?? label)
              : Row(
                  spacing: 8,
                  children: [
                    ?leading,
                    Expanded(child: label),
                    ?trailing,
                  ],
                ),
        ),
      ),
    );

    final button = Material(
      type: MaterialType.transparency,
      child: InkWell(
        borderRadius: radius,
        hoverColor: colors.sidebarAccent,
        onTap: onTap,
        child: item,
      ),
    );

    final tooltip = collapsed && label is Text ? (label as Text).data : null;
    return tooltip == null ? button : Tooltip(message: tooltip, child: button);
  }
}

class const _CnSidebarScope({
  required final bool collapsed,
  required final ValueChanged<bool>? onCollapsedChanged,
  required super.child,
}) extends InheritedWidget {
  static _CnSidebarScope? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_CnSidebarScope>();
  }

  @override
  bool updateShouldNotify(_CnSidebarScope oldWidget) {
    return oldWidget.collapsed != collapsed ||
        oldWidget.onCollapsedChanged != onCollapsedChanged;
  }
}
