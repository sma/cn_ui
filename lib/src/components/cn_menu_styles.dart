import 'package:flutter/material.dart';

import '../theme/cn_theme.dart';

MenuStyle cnMenuStyle(
  BuildContext context, {
  double? width,
  EdgeInsetsGeometry padding = const EdgeInsets.symmetric(
    horizontal: 10,
    vertical: 8,
  ),
}) {
  final cnTheme = CnTheme.of(context);
  final scheme = CnTheme.colorSchemeOf(context);

  return MenuStyle(
    backgroundColor: WidgetStateProperty.all(cnTheme.menuColor),
    surfaceTintColor: WidgetStateProperty.all(Colors.transparent),
    elevation: WidgetStateProperty.all(0),
    side: WidgetStateProperty.all(BorderSide(color: scheme.outlineVariant)),
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(borderRadius: .circular(cnTheme.radius)),
    ),
    fixedSize: width == null
        ? null
        : WidgetStateProperty.all(Size.fromWidth(width)),
    padding: WidgetStateProperty.all(padding),
  );
}

ButtonStyle cnMenuItemStyle(
  BuildContext context, {
  EdgeInsetsGeometry padding = const EdgeInsets.symmetric(
    horizontal: 12,
    vertical: 10,
  ),
  FontWeight fontWeight = .w500,
}) {
  final cnTheme = CnTheme.of(context);
  final scheme = CnTheme.colorSchemeOf(context);
  final itemRadius = cnTheme.radius > 4 ? cnTheme.radius - 4 : 0.0;
  final hoverColor = cnTheme.menuAccent.withValues(alpha: 0.2);
  final pressedColor = cnTheme.menuAccent.withValues(alpha: 0.3);

  return ButtonStyle(
    padding: WidgetStateProperty.all(padding),
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(borderRadius: .circular(itemRadius)),
    ),
    backgroundColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.pressed)) {
        return pressedColor;
      }
      if (states.contains(WidgetState.hovered) ||
          states.contains(WidgetState.focused)) {
        return hoverColor;
      }
      return Colors.transparent;
    }),
    foregroundColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.disabled)) {
        return scheme.onSurfaceVariant.withValues(alpha: 0.6);
      }
      return scheme.onSurface;
    }),
    iconColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.disabled)) {
        return scheme.onSurfaceVariant.withValues(alpha: 0.6);
      }
      return scheme.onSurfaceVariant;
    }),
    overlayColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.pressed)) {
        return cnTheme.menuAccent.withValues(alpha: 0.35);
      }
      return null;
    }),
    textStyle: WidgetStateProperty.all(
      CnTheme.textThemeOf(context).bodyMedium?.copyWith(fontWeight: fontWeight),
    ),
  );
}

WidgetStateProperty<Widget?> cnSubmenuIcon(
  BuildContext context, {
  double size = 18,
}) {
  final scheme = CnTheme.colorSchemeOf(context);
  return WidgetStateProperty.resolveWith((states) {
    final color = states.contains(WidgetState.disabled)
        ? scheme.onSurfaceVariant.withValues(alpha: 0.6)
        : scheme.onSurfaceVariant;
    return Icon(Icons.chevron_right, size: size, color: color);
  });
}
