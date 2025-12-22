import 'package:flutter/material.dart';

import '../theme/cn_theme.dart';

/// A popover component that displays content in a floating panel anchored to a trigger.
///
/// Provides a positioned overlay for displaying contextual content near a trigger widget.
///
/// See also:
///
///  * [CnTooltip], for simple text tooltips.
///  * [CnHoverCard], for hover-triggered popovers.
///  * [CnDropdownMenu], for menu-style popovers.
class CnPopover extends StatelessWidget {
  final Widget content;
  final Widget? trigger;
  final Widget Function(BuildContext context, MenuController controller)?
  triggerBuilder;
  final EdgeInsetsGeometry? padding;
  final MenuStyle? style;
  final double? width;
  final Offset? alignmentOffset;

  const CnPopover({
    super.key,
    required this.content,
    this.trigger,
    this.triggerBuilder,
    this.padding,
    this.style,
    this.width,
    this.alignmentOffset,
  }) : assert(
         trigger != null || triggerBuilder != null,
         'Provide a trigger or triggerBuilder.',
       );

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      alignmentOffset: alignmentOffset ?? const Offset(0, 8),
      style: style ?? _defaultStyle(context, width),
      menuChildren: [
        Padding(padding: padding ?? const .all(16), child: content),
      ],
      builder: (context, controller, child) {
        if (triggerBuilder != null) {
          return triggerBuilder!(context, controller);
        }
        return GestureDetector(
          onTap: () {
            if (controller.isOpen) {
              controller.close();
            } else {
              controller.open();
            }
          },
          child: AbsorbPointer(child: child),
        );
      },
      child: trigger,
    );
  }

  MenuStyle _defaultStyle(BuildContext context, double? width) {
    final cnTheme = CnTheme.of(context);
    final scheme = CnTheme.colorSchemeOf(context);

    return MenuStyle(
      backgroundColor: WidgetStateProperty.all(scheme.surface),
      surfaceTintColor: WidgetStateProperty.all(Colors.transparent),
      elevation: WidgetStateProperty.all(0),
      side: WidgetStateProperty.all(BorderSide(color: scheme.outlineVariant)),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: .circular(cnTheme.radius)),
      ),
      fixedSize: width == null
          ? null
          : WidgetStateProperty.all(Size.fromWidth(width)),
      padding: WidgetStateProperty.all(.zero),
    );
  }
}
